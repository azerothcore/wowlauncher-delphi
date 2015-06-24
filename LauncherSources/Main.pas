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


unit Main;

interface


uses
  Messages ,ShellApi, Windows,IniFiles,SJ_BitmapButton, SysUtils,Forms, Dialogs,
  XPMan, IdIcmpClient, WinSock, IdTCPClient,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, jpeg, Sockets,
  ExtCtrls, Menus, Controls, StdCtrls, Buttons, OleCtrls, SHDocVw, Classes;

 const
  WM_MYICON = WM_USER + 1;

  type

   TfrmMain = class(TForm)
    BtnExtra: TBitmapButton;
    imgBottomPanel: TImage;
    Image2: TImage;
    Image1: TImage;
    Realmlist2: TComboBox;
    statuslabel: TLabel;
    WebBrowser: TWebBrowser;
    PopupMenu1: TPopupMenu;
    Configurazioni: TMenuItem;
    Aggiorna: TMenuItem;
    Ripara: TMenuItem;
    Scarica: TMenuItem;
    Lista: TMenuItem;
    Downloader: TMenuItem;
    ResetBTN: TMenuItem;
    WebRefresh1: TMenuItem;
    Loading: TLabel;
    CancellaCache1: TMenuItem;
    Client1: TMenuItem;
    HamachiOp: TMenuItem;
    InstallHamachi: TMenuItem;
    ConfigHelp: TMenuItem;
    Launcher1: TMenuItem;
    Informazioni1: TMenuItem;
    viewtool: TButton;
    Timer1: TTimer;
    Chat: TButton;
    TcpClient1: TTcpClient;
    ServerStatus: TGroupBox;
    TimerLabel: TLabel;
    PingBtn: TButton;
    RealmLabel1: TLabel;
    Versione: TLabel;
    StatBrowser: TWebBrowser;
    statusbox: TRadioButton;
    SetRlm: TSpeedButton;
    XPManifest1: TXPManifest;
    rlmsite: TLabel;
    Pinglabel: TLabel;
    IdIcmpClient1: TIdIcmpClient;
    Refresh: TSpeedButton;
    btnOptions: TLabel;
    BtnSupport: TLabel;
    BtnPublicTest: TLabel;
    BtnPlay: TLabel;
    PlayMenu: TMenuItem;
    Exit: TMenuItem;
    OnlineMenu: TMenuItem;
    ShoutboxMenu: TMenuItem;
    ChatMenu: TMenuItem;
    TitleBar: TImage;
    TrayBtn: TLabel;
    MinimizeBtn: TLabel;
    CloseBtn: TLabel;
    WindowTitle: TLabel;
    HelpBugSection1: TMenuItem;
    About1: TMenuItem;
    Edit: TBitBtn;
    Documentation1: TMenuItem;
    procedure btnSupportclick(Sender: TObject);
    procedure WebBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ConfigurazioniClick(Sender: TObject);
    procedure RiparaClick(Sender: TObject);
    procedure ScaricaClick(Sender: TObject);
    procedure ListaClick(Sender: TObject);
    procedure DownloaderClick(Sender: TObject);
    procedure WebBrowserNavigateComplete2(Sender: TObject;
    const pDisp: IDispatch; var URL: OleVariant);
    procedure ResetBTNClick(Sender: TObject);
    procedure WebRefresh1Click(Sender: TObject);
    procedure CancellaCache1Click(Sender: TObject);
    procedure InstallHamachiClick(Sender: TObject);
    procedure ConfigHelpClick(Sender: TObject);
    procedure viewtoolClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure statusboxClick(Sender: TObject);
    procedure ChatClick(Sender: TObject);
    procedure PingBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnExtraclick(Sender: TObject);
    procedure Realmlist2Select(Sender: TObject);
    procedure SetRlmClick(Sender: TObject);
    procedure Realmlist2Change(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnPublicTestClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure rlmsiteClick(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure TrayBtnClick(Sender: TObject);
    procedure MinimizeBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure TitleBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WindowTitleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure About1Click(Sender: TObject);
    procedure HelpBugSection1Click(Sender: TObject);
    procedure Documentation1Click(Sender: TObject);

  private
    function MessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
    { Private declarations }
  public
   FIconData: TNotifyIconData;
   Reply:TReplyStatus;

   procedure PreparaForm;
   procedure ChangeRlmInfoBox;
   procedure AppMinimize(Sender: TObject);
   procedure WMMYIcon(var Message: TMessage); message WM_MYICON;
   procedure AddIcon;
   procedure PingStatus;
   function SetPing(host:string; port:integer):TReplyStatus;
   function SetStatus:boolean;

    { Public declarations }
  published

  protected
  procedure CreateParams (var Params: TCreateParams); override;

  end;

var
  frmMain: TfrmMain;


implementation

uses Config, Tools, Engine, SecondaryForm, RlmForm;


{$R *.dfm}

//#############################################################################
//
// FUNZIONI DI SUPPORTO
//
//#############################################################################


function CheckPDefBtn(closepath:boolean;defpath,section,ident:string; Inifile: TIniFile;var box:TCheckBox):string;
var temp:string;
begin
    temp:=Inifile.ReadString(section,ident,defpath);
    box.Checked:=temp<>defpath;
    result:=AdvancedSetPath(true,closepath,box,temp,defpath);
end;

procedure SetPopupMenuVisual(bool:boolean);
begin
  Frmmain.PlayMenu.Visible:=bool;
  Frmmain.Exit.Visible:=bool;
  Frmmain.OnlineMenu.Visible:=bool;
  FrmMain.ShoutboxMenu.Visible:=bool;
  FrmMain.ChatMenu.Visible:=bool;
 // FrmMain.PlayMenu.Default:=bool;
 // FrmMain.Configurazioni.Default:=not bool;
end;

procedure TfrmMain.PingStatus;
begin
   if Reply.ReplyStatusType=rsEcho then
   begin
     pinglabel.Caption:='ping: ' + IntToStr(reply.MsRoundTripTime) + 'ms';
     If PingMsg then MessageDlg(GetText('PingDlg',[RealmUrl.Host]),mtinformation,[mbok],0)
    end
   else
   begin
     pinglabel.Caption:='ping: ?';
     If PingMsg then MessageDlg(GetText('NoPingDlg',[RealmUrl.Host]),mtinformation,[mbok],0);
   end;
end;

function TFrmMain.MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
  Frmmain.BringToFront;
end;

procedure TFrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style AND NOT WS_CAPTION;
end;

procedure TFrmMain.AddIcon;
begin
    with FIconData do
    begin
      cbSize := SizeOf(FIconData);
      Wnd := Self.Handle;
      uID := $DEDB;
      uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
      hIcon := Forms.Application.Icon.Handle;
      uCallbackMessage := WM_MYICON;
      StrCopy(szTip, PChar(Caption));
    end;
    Shell_NotifyIcon(NIM_Add, @FIconData);
end;

procedure TFrmMain.WMMYIcon(var Message: TMessage);
var
  p : TPoint;
begin
  case Message.lParam of
    WM_LBUTTONDOWN:
    begin
    if visible then
    begin
        //Application.OnMinimize:=AppMinimize;
        //Application.OnRestore:=AppMinimize;
        Application.Minimize;
        AppMinimize(@Self);
        Visible:=false;
     end else
     begin
        application.Restore;
        Visible:=true;
        self.SelectFirst;
        BringToFront;
     end;
    end;
    WM_RBUTTONDOWN:
    begin
       SetPopupMenuVisual(true);
       SetForegroundWindow(Handle);
       GetCursorPos(p);
       PopUpMenu1.Popup(p.x, p.y);
       PostMessage(Handle, WM_NULL, 0, 0);
    end;
  end;

end;


procedure TFrmMain.PreparaForm;
begin
  SetDefaultAdvances(4);


  if FileExists(AppPath+F_Folder+'VALUES') then
     with TIniFile.Create(AppPath+F_Folder+'VALUES') do
     begin
      modversion:=ReadString('VALUES','modversion','0');
     end
   else
    begin
     MessageDlg(gettext('FileNotFound',['VALUES']), mtError, [mbOk], 0);
     Application.Terminate;
    end;

 // devono restare nella formshow perchè è una procedura usata nella conf
  if FileExists(AppPath+'LauncherXT.ini') then
  begin
    LauncherIni:=TIniFile.Create(AppPath+'LauncherXT.ini');

    Nav_URL:=SetClosePath(true,LauncherIni.ReadString('Advanced','Nav_URL',Nav_URL));
   // if Form1.NavUrlEdit.Items.IndexOf(NAV_URL) = -1 then
   //  Form1.NavUrlEdit.Items.Add(NAV_URL);
    Form1.NavUrlEdit2.Text:=NAV_URL;

    if AppPath=LauncherIni.ReadString('Advanced','LnchrXTpath',application.GetNamePath) then
    begin
    CachePath:=CheckPDefBtn(false,CachePath,'Advanced','CachePath',LauncherIni,Form1.pbox1);
    RealmListPath:=CheckPDefBtn(false,RealmListPath,'Advanced','RealmListPath',LauncherIni,Form1.pbox2 );
    WoWExePath:=CheckPDefBtn(false,WoWExePath,'Advanced','WoWExePath',LauncherIni,Form1.pbox3);
    WoWDataPath:=CheckPDefBtn(true,WoWDataPath,'Advanced','WoWDataPath',LauncherIni,Form1.pbox4);
    RepairPath:=CheckPDefBtn(false,RepairPath,'Advanced','RepairPath',LauncherIni,Form1.pbox5);
    LnchrOffyPath:=CheckPDefBtn(false,LnchrOffyPath,'Advanced','LnchrOffyPath',LauncherIni,Form1.pbox6);
    ConfigwtfPath:=CheckPDefBtn(false,ConfigwtfPath,'Advanced','ConfigwtfPath',LauncherIni,Form1.pbox7);
    Form1.seteditpath(false); // utilizzato per impostare i path nel conf
    end;

    WoWExeVersion:=''; // reinizializza
    WoWExeVersion:=VersioneApplicazione(WowExePath); //ricontrolla  la versione

    ConnDelay:=LauncherIni.ReadInteger('Advanced','ConnDelay',ConnDelay);
    TimerDelay:=LauncherIni.ReadInteger('Advanced','TimerDelay',TimerDelay);

    TipoConf:=LauncherIni.ReadInteger('Options','Setting',TipoConf);
    Reame:=LauncherIni.ReadInteger('Options','Realm',Reame);
    RealmURL.addr:=LauncherIni.ReadString('Options','RealmURL',RealmURL.addr);
    Language:=HandleLanguage(LauncherIni.ReadString('Options','Language',Language),AppPath+F_Folder+Langfile);
    EmptyCache:=LauncherIni.ReadBool('Options','EmptyCache',EmptyCache);
    XTChecks:=LauncherIni.ReadBool('Options','XTChecks',XTChecks);
    HamachiChecks:=LauncherIni.ReadBool('Options','HamachiChecks',HamachiChecks);
    ShoutCheck:=LauncherIni.ReadBool('Options','ShoutCheck',ShoutCheck);
    Timer1.Enabled:=LauncherIni.ReadBool('Options','StatusTimer',Timer1.Enabled);
    AlphaBlendValue:=LauncherIni.ReadInteger('Options','Transparency',AlphaBlendValue);
    BtnExtra.HotTrack:=LauncherIni.ReadBool('Options','MiniPannel',BtnExtra.HotTrack);
    LauncherIni.Free;
  end
  else
    MessageDlg('LauncherXT.ini not founded! Try to reinstall this software'+#13#10+'LauncherXT.ini non trovato! provare a reinstallare l''applicazione', mtWarning, [mbOk], 0);

    // sistema il minipannello come l'ultima conf conosciuta
   BtnExtra.Down:=BtnExtra.HotTrack;
   BtnExtraclick(nil);
   BtnExtraclick(nil);


  // all'avvio imposta il realmlist di default o precedentemente utilizzato
  // poi nel thread2 esegue il controllo con il reame associato
  handlerealmlist(true);

  Client1.Caption:=GetText('ClientMenu',[]);
  aggiorna.Caption:=GetText('ClientUpdate',[]);
  ripara.Caption:=GetText('RepairBtn',[]);
  downloader.Caption:=GetText('OffyLnchBtn',[]);
  Configurazioni.Caption:=GetText('ConfigBtn',[]);
  Edit.Hint:=Configurazioni.Caption;
  Scarica.Caption:=GetText('LnchDwnlBtn',[]);
  lista.Caption:=GetText('PatchesListBtn',[]);
  CancellaCache1.Caption:=GetText('CacheCleanBtn',[]);
  InstallHamachi.Caption:=GetText('HamachiBtn',[]);
  ConfigHelp.Caption:=GetText('HamachiConfBtn',[]);
  Loading.Caption:=GetText('LoadingLabel',[]);
  ResetBTN.Caption:=GetText('ResetBtn',[]);
  Informazioni1.Caption:=GetText('MainInfoBtn',[]);
  ServerStatus.Caption:=GetText('ServerStatus',[]);
  refresh.Hint:=GetText('StatusRefreshBtn',[]);
  Versione.Caption:=GetText('VersionCheck',[]);
  SetRlm.Hint:=GetText('Okbtn',[]);

  HamachiOp.Enabled:=HamachiChecks;

  NoWebClick:=True;


  if (Reame=-2) then
  begin
  Reame:=0;
  Form1.PreparaForm1;    //ricrea la form secondaria
   Form1.Show;
     messagedlg(GetText('FirstStartDlg',[chr(13),chr(13)]), mtinformation,[mbok],0);
  end
  else
   ThreadCreate(false,2);
end;


procedure TFrmMain.ChangeRlmInfoBox;
var temp:RlmInf;
begin
    temp.addr:=Realmlist2.Text;
    HandleRlmSyntax(temp);
    ServerStatus.Hint:='Realmlist = '+temp.rlm+#13#10+'Description = '+temp.descr+#13#10+'Site = '+temp.site;
    rlmsite.Caption:=temp.site;
    rlmsite.Hint:=temp.site;
end;


function TFrmMain.SetStatus:boolean;
begin

 OnlineMenu.Caption:='Connecting..';
 TimerLabel.Caption:=OnlineMenu.Caption;
 TimerLabel.Update;  // aggiorna il label per visualizzare il caption
 if Connect(RealmUrl.Host,RealmUrl.porta) then
   begin
     statusbl:=true;
     statusbox.Checked:=true;
     statuslabel.Caption:='Online';
     result:=true;
   end
   else
   begin
     statusbl:=false;
     statusbox.Checked:=false;
     statuslabel.Caption:='Offline';
     TimerLabel.Caption:='';
     result:=false;
   end;

  TimerLabel.Caption:='';

end;


function TFrmMain.SetPing(host:string;port:integer):TReplyStatus;
var error:boolean;
begin
   error:=false;
   PingBtn.Enabled:=false;
   Reply.ReplyStatusType:=rsError;

   IdIcmpClient1.Host:=host;
   if port<>0 then
    IdIcmpClient1.Port:=port;
  // FrmMain.IdIcmpClient1.ReceiveTimeout := ConnDelay; //5 seconds  default

   // Application.ProcessMessages;

   try
    if FrmMain.Enabled then IdIcmpClient1.Ping;
   except
     error:=true;
   end;

   if error then
    result:=Reply
   else
    result:=IdIcmpClient1.ReplyStatus;

   PingBtn.Enabled:=true;
end;



//#############################################################################
//
// FUNZIONI DI INTERFACCIA
//
//#############################################################################

procedure  TfrmMain.AppMinimize(Sender: TObject);
begin
 ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{ inizializzazioni precautive }
  WindowTitle.Caption:=LauncherTitle;
  Timer1.Enabled:=false;
  Application.Title:=LauncherTitle;
  frmMain.Caption:=LauncherTitle;
  ThdMsgOff:=false;
  ClientLang:=ReadConfig('SET locale','',false); // controlla la lingua
  // initializing tray icon
  AddIcon;
end;


procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    rewrite_ini;
    Shell_NotifyIcon(NIM_DELETE, @FIconData);
end;



procedure TfrmMain.FormDestroy(Sender: TObject);
begin
//  Application.ProcessMessages;
  //ThreadList.Terminate;    da riscrivere? genera errore
  //ThreadList2.Terminate;
  Shell_NotifyIcon(NIM_DELETE, @FIconData);
end;



procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
  if Key = #1 then //backspace
    begin
    Key := #0;
    btnPlayclick(sender);
  end;
end;

procedure TfrmMain.WebBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  if not (NoWebClick) then
  begin
     ExecuteFile(URL, '', '', 0);
     Cancel:=True;   // se decommentato non esegue il navigate complete
  end
end;

// questa procedura viene eseguita in un thread separato
procedure TfrmMain.WebBrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
  var p,r,cl,temp,modver:string;
      connesso:boolean;
      ID:integer;
begin

  temp:=GetText('NoClient',[]);
  connesso:=false;
  r:='';
  cl:=ClientLang;

  if WoWExeVersion='' then
  begin
   WoWExeVersion:=temp;
   cl:='';
  end;

  Versione.Caption:='Client: v. ' + WoWExeVersion +' '+ cl + ' | Launcher: v. ' + VersioneApplicazione(AppPath + ExtractFilename(Application.ExeName)) +' | Mods: v. '+ modversion;

  { controllo versioni dal web}
  ClientVer:='1'; LauncherVer:='1'; modver:='off';

  LauncherIni:=downloadIniFile(NAV_URL,InfoFile);
  if (LauncherIni<>nil) and FileExists(LauncherIni.FileName) then
  begin
       LauncherVer:=LauncherIni.ReadString('VERSION','LauncherXTVer',LauncherVer);
       modver:=LauncherIni.ReadString('VERSION','modsver',modver);
       r:=LauncherIni.ReadString('VALUES','Realmlist',Reamepri);
     //  def_hamachi:=Launcherini.ReadBool('VALUES','def_hamachi',false);

    // algoritmo per lettura dei reami
    ReadSectionInBox(Form1.RealmBox,LauncherIni,'REALMS');
    ReadSectionInBox(Form1.Rpatch,LauncherIni,'CLIENTSVER');
    DeleteFile(LauncherIni.filename);
    LauncherIni.Free;
    connesso:=true;
  end
  else
   ClientVer:=WoWExeVersion;

  if r<>'' then begin Form1.Crealmlist.Text:=r; reamepri:=r; end;

  // not connesso: in caso non c'e' connessione non imposta immediatamente al Realmurl il localhost 
  handlerealmlist(not connesso);

  Rewrite_Ini;  // RISCRIVE IL FILE INI

  Form1.PreparaForm1;    //ricrea la form secondaria

  if (TipoConf=1) and (XTChecks) and (ClientVer<>'1') and (WoWExeVersion<>temp) and NOT (Form1.Showing) then
   if WoWExeVersion<ClientVer then
      MessageDlg(GetText('UpdateClient',[ClientVer,Form1.RealmBox.Text]), mtInformation, [mbOk], 0)
   else
    if (WoWExeVersion>ClientVer) then
      MessageDlg(GetText('DowngradeClient',[ClientVer,Form1.RealmBox.Text]), mtInformation, [mbOk], 0);

  if ((LauncherVer<>'1') AND (VersioneApplicazione(AppPath + ExtractFilename(Application.ExeName))<LauncherVer)) or
     ( (modver<>'off') and (modversion<>modver)) then
  begin
   p:='';
   p:=GetText('NewLauncherVer',[LauncherVer+' Mod v.'+ modver]);

   if Application.MessageBox(pAnsiChar(p),'UPDATE',MB_YESNO + MB_DEFBUTTON1) <> IDNO then
   begin
     ScaricaClick(Sender);
     Application.Terminate;  // chiude il launcher
   end;
  end;

// INIZIO HAMACHI CHECKS
  if (HamachiChecks) and NOT (Form1.Showing) then
   if not IsApplicationRunning('hamachi.exe') then
    begin
        //chr(13) sostituisce il #13#10
        ID:=MessageDlg(GetText('HamachiNotRun',[chr(13)]),mtWarning,[mbYes,mbRetry,mbCancel] ,0);

      if ID = IDRETRY then
           ResetBTNClick(sender);
      if ID = IDYES then
           InstallHamachiClick(sender);
    end;
// FINE HAMACHI CHECKS

   // EXTRA CHECK
   if (XTChecks) and NOT (Form1.Showing) then
   begin
    ThreadCreate(false,1);
   end;

   viewtool.enabled:=true;
   if (ShoutCheck) and (WebBrowser.Height=0) then viewtoolclick(sender);

   if (connesso) then
     begin
       WebBrowser.Height:=Image1.Height;
       WebBrowser.Top:=Image1.Top;
       Loading.Visible:=false;
       NoWebClick:=false;
       Loading.Caption:='';
     end
   else
     begin
       WebBrowser.Height:=0;
       Loading.Visible:=true;
       NoWebClick:=true;
       Loading.Caption:=GetText('ConnFailed',[]);
     end;

   Loading.update;

   StatBrowser.Navigate(StatURL+RealmURL.rlm+'_'+VersioneApplicazione(AppPath + ExtractFilename(Application.ExeName))+'_'+WoWExeVersion+'_'+NAV_URL);

end;



procedure TfrmMain.ResetBTNClick(Sender: TObject);
  var FullProgPath: PChar;
begin
  FullProgPath := PChar(Application.ExeName);
  WinExec(FullProgPath, SW_SHOW);
  Application.Terminate;
end;


procedure TfrmMain.ConfigurazioniClick(Sender: TObject);
begin
  Form1.PreparaForm1;
  Form1.Show;
  Form1.Annullabtn.Visible:=true;
end;



procedure TfrmMain.RiparaClick(Sender: TObject);
begin
  if FileExists(RepairPath) then
  begin
     MessageDlg(GetText('RepairDlg',[]), mtInformation, [mbOk], 0);
     CreateProcessSimple(RepairPath);
  end
  else
     MessageDlg(GetText('NoRepairDlg',[]), mtError, [mbOk], 0);
end;



procedure TfrmMain.ScaricaClick(Sender: TObject);
begin
  ExecuteFile(NAV_URL+Redirect+'launcher_download', '', '', 0);
end;



procedure TfrmMain.ListaClick(Sender: TObject);
begin
  ExecuteFile(NAV_URL+Redirect+'patch_mirrors', '', '', 0);
end;




procedure TfrmMain.DownloaderClick(Sender: TObject);
begin
  if FileExists(LnchrOffyPath) then
   begin
    MessageDlg(GetText('WowUpdateDlg',[]), mtInformation, [mbOk], 0);
    WriteRealmlist(2);
    CreateProcessSimple(LnchrOffyPath);
    Application.Terminate; // termina l'applicazione dopo aver lanciato il launcher
   end
    else
      MessageDlg(GetText('NoLnchrDlg',[]), mtError, [mbOk], 0);
end;



procedure TfrmMain.WebRefresh1Click(Sender: TObject);
begin
   WebBrowser.Refresh;
end;

procedure TfrmMain.CancellaCache1Click(Sender: TObject);
begin
 if DelTree(CachePath) then
  MessageDlg(GetText('CacheClnDlg',[]), mtInformation, [mbOk], 0)
 else
  MessageDlg(GetText('CacheNoClnDlg',[CachePath]), mtWarning, [mbOk], 0);
end;

procedure TfrmMain.viewtoolClick(Sender: TObject);
begin
   Tool.FormShow(Sender);
end;


procedure TfrmMain.InstallHamachiClick(Sender: TObject);
var ID:integer;
begin

         ID:=MessageDlg(GetText('HamachiDwnlDlg',[]),mtInformation,[mbYes,mbNo] ,0);
         if ID=IDYES then ExecuteFile(NAV_URL+Redirect+'hamachi_site', '', '', 0);
{
  if LangITA then
      begin
         ID:=MessageDlg('Vuoi installare la versione Italiana di Hamachi fornita dal Launcher-XT? '+#13#10+' altrimenti puoi scaricare altre versioni in altre lingue dal sito   http://www.hamachi.it/    oppure     https://secure.logmein.com/products/hamachi/ ',mtInformation,[mbYes,mbNo] ,0);
         if ID=IDYES then CreateProcessSimple('LauncherXT_Files\HamachiSetup-1.0.3.0-it.exe');
      end
  else
      begin
         ID:=MessageDlg('Do you want to install the English version of Hamachi provided by Launcher-XT? '+#13#10+' otherwise you can download other versions in other languages on the website      https://secure.logmein.com/products/hamachi/',mtInformation,[mbYes,mbNo] ,0);
         if ID=IDYES then CreateProcessSimple('LauncherXT_Files\HamachiSetup-1.0.3.0-en.exe');
      end;
}

end;


procedure TfrmMain.ConfigHelpClick(Sender: TObject);
begin
     Form2.TextWnd.Height:=345;
     Form2.Thanks.Visible:=false;
     Form2.Credits2.Visible:=false;
     Form2.VersionPanel.Visible:=false;
     GetLangFile(Form2.TextWnd,AppPath+F_Folder, Language ,'_hamachi.txt');
end;


procedure TfrmMain.Timer1Timer(Sender: TObject);
begin

if FrmMain.Enabled then
begin
if (viewtool.enabled) and ( BtnExtra.HotTrack=true) then
begin
  if TimerSec>0 then
  begin
    TimerSec:=TimerSec-1;
   TimerLabel.Caption:='Nextcheck: '+inttostr(TimerSec);
  end;

  if TimerSec=0 then
  begin
   ThdMsgOff  := true;
   ThreadCreate(false,1);
  end;

end;
end;

end;

procedure TfrmMain.statusboxClick(Sender: TObject);
begin
   statusbox.Checked:=statusbl;
end;

procedure TfrmMain.ChatClick(Sender: TObject);
begin
  ExecuteFile(NAV_URL+Redirect+'chat', '', '', 0);
end;

procedure TfrmMain.PingBtnClick(Sender: TObject);
begin
   PingMsg:=true;
   Reply:=SetPing(RealmUrl.Host,0);
   PingStatus;
   PingMsg:=false;
end;

procedure TfrmMain.BtnExtraclick(Sender: TObject);
  var max,min:integer;
begin
 min:=512;
 max:=616;

 if  BtnExtra.HotTrack=false then
 begin
         frmmain.height:=max;
         BtnExtra.HotTrack:=true;
 end
    else
    begin
         BtnExtra.HotTrack:=false;
         frmmain.height:=min;
    end;
end;



procedure TfrmMain.Realmlist2Select(Sender: TObject);
begin
    SetRlm.Enabled:=true;
    ChangeRlmInfoBox;
end;

{
procedure TfrmMain.Realmlist2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// non permette il selezionamento tramite freccette o rotellina mouse
//   Realmlist2.ClearSelection;
end;

procedure TfrmMain.Realmlist2Change(Sender: TObject);
begin
 Realmlist2.Text:=RealmURL;
end;
}


procedure TfrmMain.SetRlmClick(Sender: TObject);
begin
   RealmUrl.addr:=Realmlist2.Text;
   HandleRealmList(false);
   SetRlm.Enabled:=false;
   ThdMsgOff:=false;
   ThreadCreate(false,1);  // true per una corretta visualizzazione del msgbox
end;

procedure TfrmMain.Realmlist2Change(Sender: TObject);
begin
    CheckRealmlistDgt(Realmlist2.Text);
    SetRlm.Enabled:=true;
end;

procedure TfrmMain.btnPlayclick(Sender: TObject);
var
  TmpRlm,TmpFile:string;
begin
 TmpRlm:=RealmURL.addr;


 { controlla il realmlist e l'opzione per cancellare la cache prima di fare il play }
  if UpperCase(TmpRlm)<>'[OFFICIAL]' then
    WriteRealmlist(1)
  else
    WriteRealmlist(2);

  //pulizia cache
  DelTree(CachePath);

  // legge dal file runonce e scrive sul config.wtf
  if WoWExeVersion<'3.0.0' then
   begin
    Form1.HandleClientPage(false,true);
    TmpFile:=ExtractFilePath(ConfigWtfPath)+RunOnceFile;
    if FileExists(TmpFile) then
     DeleteFile(TmpFile);
    Form1.HandleClientPage(true,false);
   end;

  if tipoconf=1 then
   WriteConfig('SET realmName',Form1.RealmBox.Text,false);


   if Not DirectoryExists(ExtractFilePath(WoWExePath)) then
      MessageDlg(GetText('ClientFolder',[]), mtError, [mbOk], 0)
   else
   if FileExists(WoWExePath) then
   begin
      CreateProcessSimple(WoWExePath);
      if visible then ExitClick(sender)
   end
   else
      MessageDlg(GetText('WowExeDlg',[]), mtError, [mbOk], 0);

end;

procedure TfrmMain.BtnSupportClick(Sender: TObject);
begin
  ExecuteFile(NAV_URL+Redirect+'support', '', '', 0);
end;

procedure TfrmMain.btnPublicTestClick(Sender: TObject);
begin
   ExecuteFile(NAV_URL+Redirect+'site', '', '', 0);
end;

procedure TfrmMain.btnOptionsClick(Sender: TObject);
var MausPos: TPoint;
begin
  SetPopupMenuVisual(false);
  GetCursorPos(MausPos);
  Popupmenu1.Popup(MausPos.x,MausPos.y);

end;

procedure TfrmMain.rlmsiteClick(Sender: TObject);
begin
if rlmsite.caption<>'' then
  ExecuteFile(rlmsite.Caption, '', '', 0);
end;

procedure TfrmMain.RefreshClick(Sender: TObject);
begin
    ThdMsgOff:=true;
    ThreadCreate(false,1);
end;

procedure TfrmMain.ExitClick(Sender: TObject);
begin
  Frmmain.Close;
  Application.Terminate;
end;

procedure TfrmMain.TrayBtnClick(Sender: TObject);
begin
  Application.Minimize;
  AppMinimize(@Self);
  Visible:=false;
end;

procedure TfrmMain.MinimizeBtnClick(Sender: TObject);
begin
 Application.Minimize;
end;

procedure TfrmMain.CloseBtnClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TfrmMain.TitleBarMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ReleaseCapture;
   SendMessage(FrmMain.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

procedure TfrmMain.WindowTitleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ReleaseCapture;
   SendMessage(FrmMain.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
   Form2.TextWnd.Height:=161;
   Form2.Thanks.Visible:=true;
   Form2.Credits2.Visible:=true;
   Form2.VersionPanel.Visible:=true;
   GetLangFile(Form2.TextWnd,AppPath+F_Folder , Language , '_info.txt');
end;

procedure TfrmMain.HelpBugSection1Click(Sender: TObject);
begin
  ExecuteFile(originalNav_URL+Redirect+'bug_section', '', '', 0);
end;

procedure TfrmMain.Documentation1Click(Sender: TObject);
begin
  ExecuteFile(LauncherBtnURL, '', '', 0);
end;

end.



