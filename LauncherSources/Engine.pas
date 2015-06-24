{
 *
 * Copyright (C) 2005-2009 UDW-SOFTWARE <http://udw.altervista.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
}


unit Engine;

interface

uses
  IniFiles, Main, Tools, Config, SecondaryForm, RlmForm, ShellApi,
  Wininet, TlHelp32, Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, ExtCtrls, OleCtrls,  StdCtrls ,OleServer, Sockets, Buttons, ComCtrls;

 type RlmInf = record
    rlm,
    addr,
    descr,
    site,
    Host,
    Porta:string;
   end;

 type SiteInf = record
    full,
    name,
    rType,
    descr,
    addr,
    web,
    lang,
    realmlist:string;
   end;

// dichiarazioni costanti
const
    Sname=0;
    Sweb=1;
    SType=2;
    Slang=3;
    Saddr=4;
    Sdescr=5;
    Srealmlist=6;

    RunOnceFile='RunOnce_Launcher.wtf';
    GNull='[?]';

// fine costanti

 
 const
  MaxThreads        =  1;

 Type thread = class(TThread)
  protected
     // Protected declarations
  public
   procedure      Execute; override;
   constructor Create(susp:boolean);
   procedure HandleStatusMsg;
  end;

  Type thread2 = class(TThread)
  protected
     // Protected declarations
  public
   procedure      Execute; override;
   constructor Create(susp:boolean);
   procedure handleSitesList;
  end;

  procedure HandleSiteListSyntax(var Site: SiteInf);
  procedure ThreadCreate(susp:boolean;thd:integer);
  procedure HandleCachePath(version:string);
  function downloadIniFile(url,Finf:string):TiniFile;
  procedure ReadSectionInBox(combo:Tcombobox;IniFile:TIniFile;section:string);
  Procedure SetDefaultAdvances(opt:byte);
  function AdvancedSetPath(Apply,ClosePath:boolean;box:TCheckBox;EditText,text:string):string;
  function ReadIntConfig(row:string;Default:integer;RunOnce:boolean):integer;
  procedure WriteIntConfig(row:string;value:integer;RunOnce:boolean);
  procedure WriteBoolConfig(row:string;value,RunOnce:boolean);
  function ReadBoolConfig(row:string;Default,RunOnce:boolean):boolean;
  function SetClosePath(www:boolean;path:string):string;
  procedure WriteConfig(row,value:string;RunOnce:boolean);
  function ReadConfig(row,default:string;RunOnce:boolean):string;
  procedure HandleRichText(handle:TRichEdit;s:string;svuota:boolean);
  procedure HandleRealmListPath(version:string);
  procedure WriteRealmlist(opt:byte);
  procedure CheckRealmlistDgt(s:string);
  procedure HandleRealmList(start:boolean);
  procedure TrovaTCPinfo(RealmList:string; var host,porta:string);
  procedure GetLangFile(handle:TRichEdit;Path,LanguagePrefix,FileName:string);
  function CheckIntFile(const fileURL, FileName: String ; onlyCheck:boolean):boolean;
  function CreateProcessSimple(FileName: string): string;
  Function DelTree(DirName : string): Boolean;
  function IsApplicationRunning(applicationName: String): boolean;
  function VersioneApplicazione(const PathApplicazione: string): string;
  function ExecuteFile(const FileName,Params,DefaultDir: String; ShowCmd: Integer): THandle;
  function HandleLanguage(lang: string; filename:string):string;
  procedure Rewrite_Ini;
  function GetText(key:string;const Args: array of const):string;
  procedure HandleRlmSyntax(var Realmlist: RlmInf);
  function Connect(host,port:string):boolean;
  function TestoFile(handle:TRichEdit;filename:string):boolean;

var
  LauncherIni,IniThread: TIniFile;

  TipoConf,Reame,TimerSec: integer;
  ThreadCounter: array [1..2] of integer;
  NoWebClick,statusbl,LangStatus,EmptyCache,XTChecks,ShoutCheck,HamachiChecks,
  ThdMsgOff,TimerFirst,PingMsg: boolean;

  Redirect,
  InfoFile,
  langfile,
  F_Folder,
  LauncherBtnURL,
  StatURL,
  LauncherTitle,
  Language,
  DefLang,
  LauncherVer,
  ClientVer,
  WoWExeVersion,
  ClientLang,
  RealmName,
  AppPath,
  RealmOff,
  RlmFileName,
  Reamepri,
  Nav_URL,
  originalNav_URL,
  modversion,
  def_LauncherXTVer,
  OriginalCoreURL: string;
//percorsi e avanzate
  TimerDelay,ConnDelay:integer;

  CachePath,
  RealmListPath,
  WoWExePath,
  WoWDataPath,
  RepairPath,
  LnchrOffyPath,
  ConfigwtfPath:string;

  RealmURL: RlmInf;

  ThreadList,ThreadList2:TThread;

// FINE PUBLIC


implementation




//#############################################################################
//
// FUNZIONI DEL THREAD         (SHARED)
//
//#############################################################################


procedure thread.HandleStatusMsg;
var ID:integer;
begin
   If not ThdMsgOff then
     if (HamachiChecks)then
     begin
     id:=MessageDlg(GetText('HamachiNotConf',[RealmUrl.Host,chr(13)]),mtWarning,[mbYes,mbNo,mbRetry] ,0);
       if ID = IDRETRY then
           FrmMain.ResetBTNClick(self)
       else if ID = IDYES then
           FrmMain.ConfigHelpClick(self);
     end
     else
     begin
      if FrmMain.Enabled then
       MessageDlg(GetText('NoHostConn',[RealmUrl.Host]),mtWarning,[mbOK] ,0);
     end;
end;


procedure ThreadCreate(susp:boolean;thd: integer);
 var dwThreads:     Integer;
begin
   // Increase the thread counter
   try
   InterlockedIncrement(ThreadCounter[thd])
   finally
    dwThreads:=InterlockedDecrement(ThreadCounter[thd]);
   end;

   if (dwThreads < MaxThreads) then
   if thd=1 then
    ThreadList:=Thread.Create(susp)
   else
    ThreadList2:=Thread2.Create(susp);
     // Perform inherited (don't suspend)
end;


procedure Thread.Execute;
var temp:boolean;
begin
   TimerSec:=-1; // blocca i processi del timer;
   try

    temp:=FrmMain.SetStatus;

    if not ThdMsgOff then
      ThdMsgOff:=temp
    else
      ThdMsgOff:=true;

    Synchronize(self,HandleStatusMsg);
    FrmMain.reply:=FrmMain.SetPing(RealmUrl.Host,strtoint(RealmUrl.porta));
    Synchronize(self,FrmMain.PingStatus);
   finally
    InterlockedDecrement(ThreadCounter[1]);
    TimerSec:=TimerDelay;
    FrmMain.OnlineMenu.Checked:=ThdMsgOff;
    Frmmain.OnlineMenu.Caption:=Frmmain.statuslabel.Caption+' ('+FrmMain.Pinglabel.Caption+')';
   end;
end;


constructor Thread.Create(susp:boolean);
begin
    inherited Create(susp);
    // Set thread props
    InterlockedIncrement(ThreadCounter[1]);
    FreeOnTerminate:=True;
    Priority:=tpLower;
end;

procedure Thread2.handleSitesList;
begin
   def_LauncherXTVer:='1';
   if (IniThread<>nil) and FileExists(IniThread.FileName) then
   begin
     ReadSectionInBox(Form1.NavUrlEdit,IniThread,'SITELIST');
     Form1.FillSiteGrid;
     def_LauncherXTVer:=IniThread.ReadString('VERSION','LauncherXTVer',def_LauncherXTVer);
     DeleteFile(IniThread.filename);
     IniThread.Free;
     Form2.HandleVersionPanel;
   end;
end;


procedure Thread2.Execute;
begin
   try

   IniThread:=downloadIniFile(originalNav_URL,InfoFile);
   Synchronize(self,handleSitesList);

   FrmMain.WebBrowser.Navigate(NAV_URL);
   finally
    InterlockedDecrement(ThreadCounter[2]);
   end;
end;


constructor Thread2.Create(susp:boolean);
begin
    inherited Create(susp);
    // Set thread props
    InterlockedIncrement(ThreadCounter[2]);
    FreeOnTerminate:=True;
    Priority:=tpLower;
end;




//#############################################################################
//
// FUNZIONI DI SUPPORTO         (SHARED)
//
//#############################################################################


function AdvancedSetPath(Apply,ClosePath:boolean;box:TCheckBox;edittext,text:string):string;
var temp:string;
begin

 // questo specifica se si tratta di una funzione richiamata durante la creazione della form o all'applicazione
 if edittext=text then box.Checked:=true;

 if (apply) and (Edittext<>'') and (box.Checked) then
 begin
  box.Checked:=edittext<>text;

  if  ClosePath then
    temp:=SetClosePath(false,Edittext)
  else
    temp:=Edittext;  
 end
 else
  temp:=text;

  result:=temp;

end;



function GetNumber(stringa: string):integer;
var
numero : integer;
begin

numero:=0;

if stringa <> '' then
begin
try
 numero := StrToInt(stringa);
except on e : exception do
 numero := 0;
end;
end;
// controllo numero
// inttostr(strtointdef(ConnDelay , 0)

result:=numero;
end;

function SetClosePath(www:boolean;path:string):string;
begin
if www then
begin
  if path[length(path)]<>'/' then
   path:=path+'/';
 result:=path;
end
else
begin
  if path[length(path)]<>'\' then
   path:=path+'\';
 result:=path;
end;

end;


function GetConfigFile(var conf:TextFile;RunOnce:boolean):boolean;
var risultato:boolean;
    fileP,temppath:string;
begin

temppath:=ExtractFilePath(ConfigWtfPath);

risultato:=false;
if RunOnce then
    FileP:=temppath+RunOnceFile
  else
    FileP:=ConfigWtfPath;


    if DirectoryExists(temppath) then
    begin
      AssignFile(conf,FileP);
      if FileExists(FileP) then
       Reset(conf)
      else
       rewrite(conf);

      risultato:=true;
    end
    else
    if  CreateDirectory(PAnsiChar(temppath),nil) then
    begin
     AssignFile(conf,FileP);
     Rewrite(conf);

     risultato:=true;
    end;

    result:=risultato;

end;

function ReadIntConfig(row:string;Default:integer;RunOnce:boolean):integer;
begin
 result:=GetNumber(ReadConfig(row,inttostr(Default),RunOnce));
end;


procedure WriteIntConfig(row:string;value:integer;RunOnce:boolean);
begin
 WriteConfig(row,inttostr(value),RunOnce);
end;



function ReadBoolConfig(row:string;Default,RunOnce:boolean):boolean;
var def2:string;
begin

 if Default then
  def2:='1'
 else
  def2:='0';

 result:=ReadConfig(row,def2,RunOnce) = '1';
end;

procedure WriteBoolConfig(row:string;value,RunOnce:boolean);
var val2:string;
begin
 if value then
   val2:='1'
 else
   val2:='0';

 WriteConfig(row,val2,RunOnce);
end;



procedure WriteConfig(row,value:string;RunOnce:boolean);
 var
   fileData : TStringList;
   filep : String;
   lines, i : Integer;
   trovato:boolean;
 begin
   fileData := TStringList.Create;

   if RunOnce then
    FileP:=ExtractFilePath(ConfigWtfPath)+RunOnceFile
   else
    FileP:=ConfigWtfPath;

if not FileExists(Filep) then
 Exit;

   fileData.LoadFromFile(FileP);

   lines := fileData.Count;

   trovato:=false;
   i:=0;

   while (i < lines) and not (trovato) do
   begin
     if copy(filedata[i],1,length(row))=row  then
             begin
              trovato:=true;
              filedata[i]:=row+' "'+value+'"';
             end;
     inc(i);
   end;

   if NOT trovato then
         filedata.Add(row+' "'+value+'"');

   fileData.SaveToFile(FileP);
 end;



function ReadConfig(row,default:string;RunOnce:boolean):string;
 var conf:TextFile;
 trovato:boolean;
 x,risultato:string;
 I:integer;
begin

trovato:=false;
risultato:=default;

if GetConfigFile(conf,RunOnce) then
  begin
     reset(conf);
      while NOT Eof(conf) and (trovato<>true) do
      begin
         ReadLn(conf,x);
         I:=1;
         if copy(x,1,length(row))=row  then
         begin
          while x[I]<>'"' do inc(I);
            Risultato:=copy(x,I+1,length(x)-I-1);
          trovato:=true;
         end;
      end;

    closefile(conf);
  end;

 if (not trovato) and (RunOnce) then
  result:=ReadConfig(row,default,false) //ricorsione quando si legge dal runonce
 else
 begin
  result:=risultato;
 end;

end;


function FindRealmlist(const Path,Spath: String;Attr: Integer):string;
var risultato:string;
var
   Res: TSearchRec;
   EOFound: Boolean;
begin
   risultato:='';
   EOFound:= False;
   if FindFirst(Path, Attr, Res) < 0 then
     exit
   else
     while not EOFound do begin
       if (length(Res.Name)=4) and (FileExists(sPath+Res.Name+'\'+RlmFileName)) then
       begin
        risultato:=sPath+Res.Name+'\'+RlmFileName;
        ClientLang:=Res.Name; // recupera la client lang dalla cartella selezionata
        EOFound:=true;
       end
       else
        EOFound:= FindNext(Res) <> 0;
     end;
   FindClose(Res);

   result:=risultato;
end;


procedure HandleCachePath(version:string);
begin
// support for 1.12
  if version>='3.0.0' then
   CachePath:=AppPath+'Cache\WDB'
  else
   CachePath:=AppPath+'WDB';
end;

procedure HandleRealmListPath(version:string);
begin

// se non esiste la versione il realmlistpath rimane quello di default o quello
// impostato nelle advanced conf
if (RealmListPath='') then
 begin

 RealmListPath:=AppPath+RlmFileName; // in caso la versione sia minore resta questa dichiarazione

 if version>='3.0.0' then
  if ClientLang<>'' then
    RealmListPath:=WoWDataPath+ClientLang+'\'+RlmFileName
  else
    RealmListPath:=FindRealmlist(WoWDataPath+'*',WoWDataPath,faAnyFile);
 end;

end;

procedure HandleRichText(handle:TRichEdit;s:string;svuota:boolean);
begin

 if svuota then
   handle.Lines.Clear;

 handle.Lines.Add(s);

 handle.ScrollBy(1,1);
end;


procedure HandleRealmList(start:boolean);
var temp:rlminf;
begin
  temp.addr:=reamepri;
  HandleRlmSyntax(temp);
  HandleRlmSyntax(RealmURL);

   // queste operazioni devono essere eseguite imperativamente percui prestare attenzione alla procedura
  if not (start) and (tipoconf=1) and (RealmURL.addr<>temp.addr)  then
     RealmURL:=temp
  else
  begin

    if (RealmUrl.rlm='') or (RealmUrl.addr=RealmOff) then
    begin
       MessageDlg(GetText('RealmlistNotSetted',[]),mtError,[mbOk] ,0);
       RealmUrl.Addr:=Reamepri;
    end;
    
  end;

  HandleRlmSyntax(RealmURL);
  TrovaTCPInfo(RealmURL.addr,RealmUrl.Host,RealmUrl.Porta);

  Frmmain.Realmlist2.Items:=Form1.Realmlist.Items;
  Frmmain.Realmlist2.Text:='';
  Frmmain.Realmlist2.Text:=RealmUrl.Addr;
  Frmmain.ChangeRlmInfoBox;
  FrmMain.PlayMenu.Caption:='Play: '+RealmUrl.rlm;
end;

Procedure WriteRealmlist(opt:byte);
 var RealmList: TextFile;
begin


if DirectoryExists(ExtractFilePath(RealmListPath)) then
 begin
  AssignFile(RealmList,RealmListPath);
  Rewrite(RealmList);

  case opt of
  1:
  begin
    WriteLn(RealmList, '#current realmlist');              // - realmlist corrente: ');
    WriteLn(RealmList, 'set realmlist ' + RealmUrl.rlm);
    WriteLn(RealmList, 'set patchlist ' + RealmUrl.rlm);
    WriteLn(RealmList, '');
  end;
  2:
  begin
      if  Form1.OffyRealmBox.text='US-American' then
                begin
                 WriteLn(RealmList, 'set realmlist us.logon.worldofwarcraft.com ');
                 WriteLn(RealmList, 'set patchlist us.version.worldofwarcraft.com ');
                 WriteLn(Realmlist, 'set portal us');
                end
              else
                begin
                 WriteLn(RealmList, 'set realmlist eu.logon.worldofwarcraft.com ');
                 WriteLn(RealmList, 'set patchlist eu.version.worldofwarcraft.com ');
                 WriteLn(Realmlist, 'set portal eu');
                end;
  end;

  end;

  CloseFile(RealmList);
 end;


end;



Procedure CheckRealmlistDgt(s:string);
var temp: PAnsiChar;
begin
   temp:=strupper(PAnsiChar(s));
  // controllo durante la digitazione del realmlist
   if (copy(temp,1,13)='SET REALMLIST') then
     MessageDlg(GetText('RlmErr2Dlg',[copy(temp,1,13)]),mtWarning ,[mbOk] ,0)
   else if (copy(temp,1,12)='SETREALMLIST') then
     MessageDlg(GetText('RlmErr2Dlg',[copy(temp,1,12)]),mtWarning ,[mbOk] ,0);
end;


function GetIniString(Section, Identifier, DefaultValue,FileName: String): String;
begin
 if FileExists(FileName) then
 with TIniFile.Create(FileName) do
 begin
  Result := ReadString(Section, Identifier, DefaultValue);
  Free;
 end
 else result:=DefaultValue;

end;


function HandleLanguage(lang: string; filename:string):string;
var temp:TiniFile;
begin
  temp:=TIniFile.Create(FileName);
  if temp.SectionExists(lang) then
   result:=lang
  else
   result:=deflang;
end;



function GetDefText(key,filename:string):string;
var text:string;
begin
text:=GetIniString(DefLang,key,'INI_ERROR',filename);

if text='INI_ERROR' then
   begin
    MessageDlg('Error with Language, Reinstall the application!' ,mtError,[mbOk] ,0);
    ExitProcess(0); // application.terminate non chiude subito
   end
  else
   if LangStatus then
   begin
     LangStatus:=false;   // prima questo imperativamente
     MessageDlg(GetText('LangIssuesDlg',[]),mtWarning,[mbOk] ,0);
   end;

 result:=text;

end;


function GetText(key:string;const Args: array of const):string;
var text:string;
begin
 text:=GetIniString(Language,key,'INI_ERROR',AppPath+F_Folder+langfile);
 if text='INI_ERROR' then
  text:=GetDefText(key,AppPath+F_Folder+'lang.ini');
 result:=Format(text,Args);
end;


procedure Rewrite_Ini;
var LauncherIni: TIniFile;
begin
 LauncherIni:=TIniFile.Create(AppPath+'LauncherXT.ini');

 LauncherIni.WriteString('Advanced','Nav_URL',Nav_URL);

 LauncherIni.WriteString('Advanced','LnchrXTPath',AppPath);
 LauncherIni.WriteString('Advanced','CachePath',CachePath);
 LauncherIni.WriteString('Advanced','RealmListPath',RealmListPath);
 LauncherIni.WriteString('Advanced','WoWExePath',WoWExePath);
 LauncherIni.WriteString('Advanced','WoWDataPath',WoWDataPath);
 LauncherIni.WriteString('Advanced','RepairPath',RepairPath);
 LauncherIni.WriteString('Advanced','LnchrOffyPath',LnchrOffyPath);
 LauncherIni.WriteString('Advanced','ConfigwtfPath',ConfigwtfPath);
 LauncherIni.WriteString('Advanced','ConnDelay',inttostr(conndelay));
 LauncherIni.WriteString('Advanced','TimerDelay',inttostr(TimerDelay));

 LauncherIni.WriteInteger('Options','Setting',TipoConf);
 LauncherIni.WriteInteger('Options','Realm',Reame);
 LauncherIni.WriteString('Options','RealmUrl',RealmUrl.Addr);
 LauncherIni.WriteString('Options','Language',Language);
 LauncherIni.WriteBool('Options','EmptyCache',EmptyCache);
 LauncherIni.WriteBool('Options','XTChecks',XTChecks);
 LauncherIni.WriteBool('Options','HamachiChecks',HamachiChecks);
 LauncherIni.WriteBool('Options','ShoutCheck',ShoutCheck);
 LauncherIni.WriteBool('Options','StatusTimer',FrmMain.Timer1.Enabled);
 LauncherIni.WriteInteger('Options','Transparency',Frmmain.AlphaBlendValue);
 LauncherIni.WriteBool('Options','MiniPannel',FrmMain.BtnExtra.HotTrack);
 LauncherIni.Free;


end;


function TestoFile(handle:TRichEdit;filename:string):boolean;
var
    S: TStringList;
begin
if FileExists(filename) then
  begin
    S := TStringList.Create;
    try
      S.LoadFromFile(filename);
      HandleRichText(handle,s.Text,true);
      Form2.Show;
    finally
     S.Free;
    end;
     result:=true;
  end
 else
 begin
    result:=false;
 end;
end;

procedure GetLangFile(handle:TRichEdit;Path,LanguagePrefix,FileName:string);
begin
   if not TestoFile(handle,Path+LanguagePrefix+FileName) then
   begin
      MessageDlg(GetText('LangIssuesDlg',[]),mtWarning,[mbOk] ,0);
      if not TestoFile(handle,Path+DefLang+FileName) then
            MessageDlg( GetText('FileNotFound',[FileName]) ,mtWarning,[mbOk] ,0);
   end;
end;

procedure HandleSiteListSyntax(var Site: SiteInf);
var  i,j:integer;
     fieldlist,temp: array [0..6] of string;
     temp2:string;
begin
     fieldlist[0]      :='Name';
     fieldlist[1]      :='Web';
     fieldlist[2]      :='Addr';
     fieldlist[3]      :='RealmL';
     fieldlist[4]      :='Type';
     fieldlist[5]      :='Lang';
     fieldlist[6]      :='Descr';

     Site.name  :='';
     Site.web   :='';
     Site.addr  :='';
     Site.descr :='';
     Site.rType :='';

     i:=1;
     j:=0;

     while (j<=length(fieldlist)) and (i<>length(Site.full)+1) do
     begin

      temp2:= copy(Site.full,i,length(fieldlist[j])+2);
      if copy(Site.full,i,length(fieldlist[j])+2)='#'+fieldlist[j]+'=' then
      begin
       i:=i+length(fieldlist[j])+2;
       while (i<>length(Site.full)+1) and (Site.full[i]<>'#')  do
       begin

       // j>3 poiche' descrizione e tipo possono avere spazi
        if (j<3) then
        begin
         if (Site.full[i]<>' ') then
          temp[j]:=temp[j]+Site.full[i];
        end
        else
          temp[j]:=temp[j]+Site.full[i];

        inc(i);

       end;

       inc(j);
      end
      else
       inc(i);

     //if Site.full<>'#' then inc(i);

     end;

    Site.name      := temp[0];
    Site.web       := temp[1];
    Site.addr      := temp[2];
    Site.realmlist := temp[3];
    Site.rType     := temp[4];
    Site.lang      := temp[5];
    Site.descr     := temp[6];
end;




procedure HandleRlmSyntax(var Realmlist: RlmInf);
var  temp,temp2: string;
     i:integer;
begin
     //By artemis
     temp:='';
     temp2:='';
     RealmList.descr:='';
     RealmList.site:='';
     Realmlist.rlm:='';
     i:=1;
     while (i<>length(Realmlist.addr)+1) and (Realmlist.addr[i]<>'#')  do
     begin

      if Realmlist.addr[i]<>' ' then
        temp:=temp+Realmlist.addr[i];

      inc(i);

     end;

    Realmlist.rlm:=temp;  // trova e assegna il realmlist

    if Realmlist.addr='' then exit;  // controllo di sicurezza

    if Realmlist.addr[i]='#' then
    begin
     temp:=temp+' '+copy(Realmlist.addr,i,length(Realmlist.addr)-i+1);   // assegna la stringa completa
     temp2:=copy(Realmlist.addr,i+1,length(Realmlist.addr)-i+1);
     i:=1;

     while (i<>length(temp2)+1) and (copy(temp2,i,9)<>'&RlmSite=')  do
     begin
        RealmList.descr:=RealmList.descr+temp2[i]; // trova e assegna la descrizione
        inc(i);

     end;

    end;

     if copy(temp2,i,9)='&RlmSite=' then
       Realmlist.site:=copy(temp2,i+9,length(temp2)-i+10);  // trova e assegna il sito

       if length(Temp)<>length(Realmlist.addr) then
          MessageDlg( GetText('NormalizedRealm',[]),mtInformation,[mbOk] ,0);


     Realmlist.addr:=temp; // prima il controllo e poi la modifica

end;


procedure TrovaTCPinfo(RealmList:string; var host,porta:string);
var s:string;
    i,j,port:integer;
begin
  i:=1;
  s:='';
  Porta:='3724';
  
  while (i<>length(Realmlist)) and ((Realmlist[i]<>':') and (Realmlist[i]<>'#')) do
    inc(i);

  if (Realmlist[i]='#') then
   host:=copy(RealmList,1,i-2)
  else
  if (Realmlist[i]=':') then
   host:=copy(RealmList,1,i-1)
  else
   host:=copy(RealmList,1,i);

  if (Realmlist[i]=':') and (Realmlist[i]<>'#') then
  begin
   j:=i+1;

   while (i<>length(Realmlist)+1) and (Realmlist[j]<>'#') do
    inc(j);

   if Realmlist[j]='#' then
    j:=j-2; // perche' prima dell'# c'e' uno spazio

   s:=copy(RealmList,i+1,j-i);

   port:=strtointdef(s,strtoint(porta));
   if inttostr(port)<>s then
     MessageDlg(GetText('InvalidPort',[s,Porta]),mtWarning,[mbOk] ,0)
   else
    if s<>'' then porta:=s;

  end;

end;

function Connect(host,port:string):boolean;
var
        bConnected: Boolean;
begin
        FrmMain.TcpClient1.RemoteHost:= host;
        FrmMain.TcpClient1.RemotePort:= port;
        FrmMain.TcpClient1.Open;
        FrmMain.TcpClient1.BlockMode := bmNonBlocking;
        if FrmMain.TcpClient1.Active and (not FrmMain.TcpClient1.Connected) then
        begin
            bConnected := False;
            FrmMain.TcpClient1.Select(nil, @bConnected, nil, ConnDelay);  // millesimi di secondo
            if not bConnected then
            begin
                result:=false;
                FrmMain.TcpClient1.Close;
            end
            else
               result:=true;
        end
        else result:=false;
end;

function CheckIntFile(const fileURL, FileName: String ; onlyCheck:boolean):boolean;
const
  BufferSize=1024;

var
  hSession, hURL:HInternet;
  sAppName: string;
   sc:pchar;
  ss,sr:cardinal;
  f:File;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
begin
  hURL:=nil;
  sAppName := ExtractFileName(Application.ExeName);
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  result:=false;

  if hSession<>nil then
  begin
    hURL:= InternetOpenURL(hSession, PChar(fileURL), nil, 0, INTERNET_FLAG_NO_AUTO_REDIRECT, 0);

    ss:=4;
    sr:=0;
    getmem(sc, 4);
    try
     if HttpQueryInfo(hURL, HTTP_QUERY_STATUS_CODE, sc, ss, sr) then
      if sc<>'200' then
       hURL:=nil;
    finally
     freemem(sc);
    end;

    if hURL<>nil then
    begin
    if not OnlyCheck then
     try
       AssignFile(f, FileName);
       Rewrite(f, 1);
     repeat
       InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
       BlockWrite(f, Buffer, BufferLen)
     until BufferLen = 0;
       CloseFile(f);
       result := true;
     finally
     end;

     result := true;
   end
    else result:=false;

    InternetCloseHandle(hURL);
  end
  else
   result:=false;
  InternetCloseHandle(hSession);
end;



function VersioneApplicazione(const PathApplicazione: string): string;
var
    DimVariabile1: dword;
    DimVariabile2: dword;
    Puntatore1: Pointer;
    Puntatore2: Pointer;
begin
    Result := '';
    DimVariabile1 := GetFileVersionInfoSize(PChar(PathApplicazione), DimVariabile2);
    if DimVariabile1 > 0 then
    begin
        GetMem(Puntatore1, DimVariabile1);
        try
        GetFileVersionInfo(PChar(PathApplicazione), 0, DimVariabile1, Puntatore1); // ottengo i dati della versione
        VerQueryValue(Puntatore1, '\', Puntatore2, DimVariabile2);
        with TVSFixedFileInfo(Puntatore2^) do
        Result := Result + // Costruisco la stringa di versione
        IntToStr(HiWord(dwFileVersionMS)) + '.' +
        IntToStr(LoWord(dwFileVersionMS)) + '.' +
        IntToStr(HiWord(dwFileVersionLS)) + '.' +
        IntToStr(LoWord(dwFileVersionLS));
        finally
        FreeMem(Puntatore1);
        end;
    end;
end;


function ExecuteFile(const FileName,Params,DefaultDir: String; ShowCmd: Integer): THandle;
begin
  Result:=ShellExecute(Application.Handle,nil,PChar(FileName),PChar(Params),PChar(DefaultDir),ShowCmd);
end;

Function DelTree(DirName : string): Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end;
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;



function CreateProcessSimple(FileName: string): string;
var
  PInfo: TProcessInformation;
  SInfo: TStartupInfo;
begin
  FillMemory(@SInfo, SizeOf(SInfo), 0);
  SInfo.CB:=SizeOf(SInfo);
  CreateProcess(nil, PChar(FileName), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, SInfo, PInfo);
  CloseHandle(PInfo.hProcess);
  CloseHandle(PInfo.hThread);
end;




function IsApplicationRunning(applicationName: String): boolean;
var
handler: THandle;
data: TProcessEntry32;
bRet: boolean;

function GetName: string;
  var i:byte;
  begin
   Result := '';
   i := 0;
   while data.szExeFile[i] <> '' do
    begin
     Result := Result + data.szExeFile[i];
     Inc(i);
    end;
end;

begin
 bRet:= false;
 try
  handler := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  data.dwSize := SizeOf(TPROCESSENTRY32);
  if Process32First(handler, data) then
  begin
   while Process32Next(handler, data) do
   begin
    if(GetName() = applicationName) then
     bRet:= true
   end;
  end;
  except
  end;
 result:= bRet;
end;


function downloadIniFile(url,Finf:string):TiniFile;
var Inifile:TIniFile;
begin

  Inifile:=nil;

  DeleteFile(Finf);
  if CheckIntFile(url+Finf,Finf,false) then //and GetInetFile(url+Finf, Finf) then
  if FileExists(Finf) then
  begin
       Inifile:=TIniFile.Create(GetCurrentDir+'\'+Finf);
  end;

  result:=Inifile;

end;

procedure ReadSectionInBox(combo:Tcombobox;IniFile:TIniFile;section:string);
var i:integer;
begin
       // algoritmo per lettura dei siti disponibili
       IniFile.ReadSection(section,combo.Items);  //legge prima le chiavi
       for i := 0 to combo.Items.Count - 1 do   //poi ne recupera i valori
        combo.Items[i]:=IniFile.ReadString(section,combo.Items[i],'');
       combo.ItemIndex:=Reame;
end;




Procedure SetDefaultAdvances(opt:byte);
begin
 case opt of
 1:
 begin
  WoWExePath:=AppPath +'wow.exe';
 end;

 2: ConnDelay:=3000;

 3: TimerDelay:=160;

 4: Nav_URL:='http://udw.altervista.org/Launcherhtml/';

 5:
 begin
  WoWDataPath:=AppPath+'data\';
  RepairPath:=AppPath+'repair.exe';
  LnchrOffyPath:=AppPath+'Launcher.exe';
  Configwtfpath:=AppPath+'WTF\Config.wtf';
  HandleCachePath(WoWexeversion);
  RealmListPath:='';
 end;

 end;


end;

initialization
//inizializzazioni

  AppPath:=ExtractFilePath(Application.ExeName);
  statusbl:=false;
  XTChecks:=true;
  TimerFirst:=true;
  EmptyCache:=true;
  ShoutCheck:=true;
  EmptyCache:=true;
  HamachiChecks:=false;
  Language:='ENGLISH';
  DefLang:=Language;
  RealmUrl.Addr:='';
  ClientLang:='';
  TipoConf:=1;
  Reame:=-2;
  Reamepri:='localhost';
  RlmFileName:='Realmlist.wtf';
  PingMsg:=false;
 // def_hamachi:=false;

  LangStatus:=true;

  RealmOff:='# Insert a RealmList';
  InfoFile:='inform.ini';
  LangFile:='lang.ini';
  F_Folder:='LauncherXT_Files\';

  SetDefaultAdvances(1);
  SetDefaultAdvances(2);
  SetDefaultAdvances(3);

  // questa dichiarazione serve per le stats poichè dopo viene cambiata
  SetDefaultAdvances(4);

  StatURL:=Nav_URL+'stats.html?I=';   // necessita del navurl primario
  Redirect:='redirects.php?selection=';
  originalNav_URL:=Nav_URL;
  LauncherBtnURL:=Nav_URL+Redirect+'launcher_btn';
  OriginalCoreURL:=Nav_URL+Redirect+'launcher_download';

  WoWExeVersion:=VersioneApplicazione(WowExePath);
  SetDefaultAdvances(5);

  LauncherTitle:='Launcher-XT on '+WoWExeVersion+' World of Warcraft ';

end.
