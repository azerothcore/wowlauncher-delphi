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

unit Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons,  IniFiles, Grids;


type
  TForm1 = class(TForm)
    ConfTab: TPageControl;
    TabSheet1: TTabSheet;
    Defaultbtn: TBitBtn;
    TrasparenzaLabel: TGroupBox;
    IntTraspLabel: TLabel;
    TrasparenzaBox: TCheckBox;
    TrackBar1: TTrackBar;
    Extra: TGroupBox;
    CacheLabel: TLabel;
    XTCheckLabel: TLabel;
    help3: TSpeedButton;
    help4: TSpeedButton;
    HamachiLabel: TLabel;
    Help6: TSpeedButton;
    shoutoplabel: TLabel;
    Help7: TSpeedButton;
    TimerOp: TLabel;
    Help8: TSpeedButton;
    CacheBox: TCheckBox;
    XTCheckBox: TCheckBox;
    HamachiBox: TCheckBox;
    ShoutOpBox: TCheckBox;
    StTimerBox: TCheckBox;
    Lingua: TGroupBox;
    Help1: TSpeedButton;
    TabSheet2: TTabSheet;
    LangBox1: TComboBox;
    PathsGroup: TGroupBox;
    CachePEdit: TLabeledEdit;
    RealmListPEdit: TLabeledEdit;
    WoWExePEdit: TLabeledEdit;
    WoWDataPEdit: TLabeledEdit;
    RepairPEdit: TLabeledEdit;
    LauncherPEdit: TLabeledEdit;
    ConfWtfPEdit: TLabeledEdit;
    ConnGroup: TGroupBox;
    ConnDelayEdit: TLabeledEdit;
    help9: TSpeedButton;
    help10: TSpeedButton;
    StatusDelay: TLabeledEdit;
    Okbtn: TBitBtn;
    Annullabtn: TBitBtn;
    RealmChose: TRadioGroup;
    GeneralSet: TRadioGroup;
    TabSheet3: TTabSheet;
    GraphicBox: TGroupBox;
    graphic_windowmode: TCheckBox;
    graphic_HighLights: TCheckBox;
    graphic_trilinearFilter: TCheckBox;
    SoundBox: TGroupBox;
    sound_enable: TCheckBox;
    sound_channels: TTrackBar;
    Sound_ChannelLabel: TLabel;
    Game_Restore: TBitBtn;
    sound_hdAcceleration: TCheckBox;
    DefaultBtn2: TBitBtn;
    pbox1: TCheckBox;
    pbox2: TCheckBox;
    pbox3: TCheckBox;
    pbox4: TCheckBox;
    pbox5: TCheckBox;
    pbox6: TCheckBox;
    pbox7: TCheckBox;
    graphic_resolution: TLabeledEdit;
    GroupBox1: TGroupBox;
    Del: TBitBtn;
    Realmlist: TComboBox;
    Add: TBitBtn;
    Edit: TBitBtn;
    Button1: TBitBtn;
    Crealmlist: TLabeledEdit;
    help2: TSpeedButton;
    LangBox2: TComboBox;
    TabSheet4: TTabSheet;
    NavUrlEdit: TComboBox;
    NavUrlEditLabel: TLabel;
    SiteGrid: TStringGrid;
    NavUrlEdit2: TEdit;
    Label1: TLabel;
    SLinfo: TLabel;
    Help11: TSpeedButton;
    OffyRealmBox: TComboBox;
    RealmBox: TComboBox;
    Rpatch2: TStaticText;
    Rpatch: TComboBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure TrasparenzaBoxClick(Sender: TObject);
    procedure OkbtnClick(Sender: TObject);
    procedure DefaultbtnClick(Sender: TObject);
    procedure AnnullabtnClick(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure help2Click(Sender: TObject);
    procedure help3Click(Sender: TObject);
    procedure help4Click(Sender: TObject);
    procedure help5Click(Sender: TObject);
    procedure help6Click(Sender: TObject);
    procedure help7Click(Sender: TObject);
    procedure help8Click(Sender: TObject);
    procedure help9Click(Sender: TObject);
    procedure help10Click(Sender: TObject);
    procedure XTCheckBoxClick(Sender: TObject);
    procedure LangBox1Select(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GeneralSetClick(Sender: TObject);
    procedure DefaultBtn2Click(Sender: TObject);
    procedure pbox1Click(Sender: TObject);
    procedure Game_RestoreClick(Sender: TObject);
    procedure DelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure RealmlistSelect(Sender: TObject);
    procedure EditClick(Sender: TObject);
    procedure RealmlistChange(Sender: TObject);
    procedure CoreOriginVerClick(Sender: TObject);
    procedure RealmBoxChange(Sender: TObject);
    procedure RpatchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SiteGridClick(Sender: TObject);
    procedure SLinfoClick(Sender: TObject);
    procedure Help11Click(Sender: TObject);
    procedure SiteGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    helpstr:array [1..11] of string;
    temptrasp:integer;
    temptrasp2:boolean;
  public
    RpatchStr: string;
    Procedure PreparaForm1;
    procedure Sortgrid(Grid : TStringGrid; SortCol:integer);
    procedure HandleClientPage(write,RunOnce:boolean);
    procedure seteditpath(apply:boolean);
    procedure CheckEnablePath;
    procedure SetVisibleRelation;
    procedure SetTimerRelation;
    procedure FillSiteGrid;
    { Public declarations }
  end;

var
  Form1: TForm1;
  Reami: TextFile;
  TempConf:integer;

implementation

uses Main, Tools, Engine, RlmForm;
{$R *.dfm}


//#############################################################################
//
// FUNZIONI DI SUPPORTO
//
//#############################################################################


Procedure TForm1.PreparaForm1;
var temp:string;
    I:integer;
begin

   ConfTab.TabIndex:=0; // setta ogni volta la general page di default

   temp:=AppPath+'XT-Realms.txt';

   AssignFile(Reami,temp);
   Realmlist.Items.Clear;

   if FileExists(temp) then
      Realmlist.Items.LoadFromFile(temp)
   else
   begin
      Rewrite(reami);
      CloseFile(reami);
   end;

   with TIniFile.Create(AppPath+F_Folder+'lang.ini') do
    begin
     ReadSections(LangBox2.Items);
     LangBox1.Clear;
     For I:=0 to LangBox2.Items.Count-1 do
     LangBox1.Items.Add(ReadString(Langbox2.Items.Strings[I],'LanguageName',Langbox2.Items.Strings[I]));
     Free;
    end;
   LangBox2.Text:=Language;
   LangBox1.ItemIndex:=LangBox2.Items.IndexOf(Language);
   LangBox1select(nil);

   if Reame=-1 then
   begin
     RealmBox.ItemIndex:=0;
     Reame:=0;
   end
   else
    RealmBox.ItemIndex:=Reame;

   Rpatch.ItemIndex:=RealmBox.ItemIndex;
   if Rpatch.ItemIndex>=0 then
     ClientVer:=Rpatch.Items.strings[Rpatch.ItemIndex];

   GeneralSet.ItemIndex:=TipoConf-1;
   GeneralSetclick(nil);
   SetVisibleRelation;


   if FrmMain.Timer1.Enabled then StTimerBox.Checked:=true
   else StTimerBox.Checked:=false;

   XTCheckBox.Checked:=XTChecks;

   SetTimerRelation;

   HamachiBox.Checked:=HamachiChecks;

   CacheBox.Checked:=EmptyCache;

   ShoutOpBox.Checked:=ShoutCheck;


   TrasparenzaBox.Checked:=FrmMain.AlphaBlendValue<trackbar1.Max;

   TrasparenzaBoxClick(nil);

   Realmlist.Text:=RealmURL.addr;

   NavUrlEdit.text:=Nav_URL;
   ConnDelayEdit.text:=inttostr(ConnDelay);
   StatusDelay.text:=inttostr(TimerDelay);

   seteditpath(true);
   CheckEnablePath;

   temptrasp:=FrmMain.AlphaBlendValue;
   temptrasp2:=FrmMain.AlphaBlend;

end;


procedure TForm1.SetTimerRelation;
begin
  if XTCheckBox.Checked then
          StTimerBox.Enabled:=true
        else
        begin
          StTimerBox.Enabled:=false;
          StTimerBox.Checked:=false;
        end;
end;

procedure TForm1.SetVisibleRelation;
var visible:boolean;
begin

visible:=true;

if GeneralSet.itemindex=0 then
   begin
    visible:=true;
    OffyRealmBox.Visible:=false;
    RealmBox.Visible:=true;
    Rpatch.Visible:=true;
    Rpatch2.Visible:=true;
   end
   else if GeneralSet.ItemIndex=1 then
   begin
    visible:=true;
    OffyRealmBox.Visible:=true;
    RealmBox.Visible:=false;
    Rpatch.Visible:=false;
    Rpatch2.Visible:=false;
   end
   else if GeneralSet.ItemIndex=2 then
   begin
    visible:=false;
    OffyRealmBox.Visible:=false;
    RealmBox.Visible:=false;
    Rpatch.Visible:=false;
    Rpatch2.Visible:=false;
   end;

   RealmChose.Visible:=visible;

end;

procedure TForm1.CheckEnablePath;
begin
 CachePEdit.Enabled:=pbox1.Checked;
 RealmListPEdit.Enabled:=pbox2.Checked;
 WoWExePEdit.Enabled:=pbox3.Checked;
 WoWDataPEdit.Enabled:=pbox4.Checked;
 RepairPEdit.Enabled:=pbox5.Checked;
 LauncherPEdit.Enabled:=pbox6.Checked;
 ConfWtfPEdit.Enabled:=pbox7.Checked;
end;

procedure TForm1.HandleClientPage(write,RunOnce:boolean);
begin
 if write then
  begin
   WriteBoolConfig('SET gxWindow',graphic_windowmode.Checked,RunOnce);
   WriteBoolConfig('SET specular',graphic_HighLights.Checked,RunOnce);
   WriteBoolConfig('SET gxTripleBuffer',graphic_trilinearFilter.Checked,RunOnce);
   WriteConfig('SET gxResolution',graphic_resolution.Text,RunOnce);
   WriteBoolConfig('SET Sound_EnableAllSound',sound_enable.Checked,RunOnce);
   WriteBoolConfig('SET Sound_EnableHardware',sound_hdAcceleration.Checked,RunOnce);
   WriteIntConfig('SET Sound_NumChannels', sound_channels.Position,RunOnce);
  end
 else
  begin
   graphic_windowmode.Checked:=ReadBoolConfig('SET gxWindow',false,RunOnce);
   graphic_HighLights.Checked:=ReadBoolConfig('SET specular',false,RunOnce);
   graphic_trilinearFilter.Checked:=ReadBoolConfig('SET gxTripleBuffer',false,RunOnce);
   graphic_resolution.Text:=readconfig('SET gxResolution','800x600',RunOnce);
   sound_enable.Checked:=ReadBoolConfig('SET Sound_EnableAllSound',true,RunOnce);
   sound_hdAcceleration.Checked:=ReadBoolConfig('SET Sound_EnableHardware',false,RunOnce);
   sound_channels.Position:=ReadIntConfig('SET Sound_NumChannels',0,RunOnce);
  end;

end;



procedure TForm1.seteditpath(apply:boolean);
begin

  if apply then
  begin
   SetDefaultAdvances(1);
   HandleRealmListPath(WoWExeVersion);
  end;



  CachePEdit.text:=AdvancedSetPath(apply,false,pbox1,CachePEdit.text,CachePath);
  RealmListPEdit.text:=AdvancedSetPath(apply,false,pbox2,RealmListPEdit.text,RealmListPath);
  WoWExePedit.text:=AdvancedSetPath(apply,false,pbox3,WoWExePedit.text,WoWExePath);
  WoWDataPEdit.text:=AdvancedSetPath(apply,true,pbox4,WoWDataPEdit.text,WoWDataPath);
  RepairPEdit.text:=AdvancedSetPath(apply,false,pbox5,RepairPEdit.text,RepairPath);
  LauncherPEdit.text:=AdvancedSetPath(apply,false,pbox6,LauncherPEdit.text,LnchrOffyPath);
  ConfwtfPEdit.text:=AdvancedSetPath(apply,false,pbox7,ConfwtfPEdit.text,ConfigwtfPath);

  if apply then
  begin
   CachePath:= CachePEdit.text;
   RealmListPath:=  RealmListPEdit.text;
   WoWExePath:=  WoWExePedit.text;
   WoWDataPath:= WoWDataPEdit.text;
   RepairPath:= RepairPEdit.text;
   LnchrOffyPath:= LauncherPEdit.text;
   ConfigwtfPath:= ConfwtfPEdit.text;
  end;

end;


procedure TForm1.FillSiteGrid;
var i:integer;
    site:siteinf;
begin
     for i:=0 to NavUrlEdit.Items.Count-1 do
     begin
       site.full:=NavUrlEdit.Items.Strings[i];
       HandleSiteListSyntax(site);
       SiteGrid.RowCount:=i+2;
       SiteGrid.Cells[Sname,i+1]:=site.name;
       SiteGrid.Cells[Sweb,i+1]:=site.web;
       SiteGrid.Cells[Saddr,i+1]:=site.addr;
       SiteGrid.Cells[Sdescr,i+1]:=site.descr;
       SiteGrid.Cells[Stype,i+1]:=site.rType;
       SiteGrid.Cells[Slang,i+1]:=site.lang;
       SiteGrid.Cells[Srealmlist,i+1]:=site.realmlist;
     end;
end;


procedure TForm1.Sortgrid(Grid : TStringGrid; SortCol:integer);
{A simple exchange sort of grid rows}
var
   i,j : integer;
   temp:tstringlist;
begin
  temp:=tstringlist.create;
  with Grid do
  for i := FixedRows to RowCount - 2 do  {because last row has no next row}
  for j:= i+1 to rowcount-1 do {from next row to end}
  if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) > 0
  then
  begin
    temp.assign(rows[j]);
    rows[j].assign(rows[i]);
    rows[i].assign(temp);
  end;
  temp.free;
end;


//#############################################################################
//
// FUNZIONI DI INTERFACCIA
//
//#############################################################################


procedure TForm1.FormCreate(Sender: TObject);
begin
  SiteGrid.Cells[Sname,0]      :='Name';
  SiteGrid.Cells[Sweb,0]       :='Web';
  SiteGrid.Cells[Stype,0]      :='Type';
  SiteGrid.Cells[Slang,0]      :='Language';
  SiteGrid.Cells[Sdescr,0]     :='Description';
  SiteGrid.Cells[Saddr,0]      :='LauncherPage';
  SiteGrid.Cells[Srealmlist,0] :='RealmList';
end;


procedure TForm1.FormShow(Sender: TObject);
begin
 frmMain.Enabled:=false;
 HandleClientPage(false,true);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 frmMain.Enabled:=true;
end;



procedure TForm1.OkbtnClick(Sender: TObject);
var ID:integer;
    temp:rlminf;
begin

 if (NavUrlEdit2.text<>Gnull) and (NavUrlEdit2.text<>'') and (NavUrlEdit2.text<>NAV_URL) then
 begin
  ID:=MessageDlg(GetText('NavUrlApply',[]),mtWarning,[mbYes,mbNo] ,0);
   if ID=IDYES then
     NAV_URL:=NavUrlEdit2.Text
   else
    begin
     NavUrlEdit2.Text:=NAV_URL;
     exit;
    end;
 end;

 seteditpath(true);


 if (Form1.ConnDelayEdit.text<>'0') then
   ConnDelay:=strtointdef(Form1.ConnDelayEdit.text,ConnDelay)
 else
   SetDefaultAdvances(2);

 if (Form1.StatusDelay.text<>'0') then
   TimerDelay:=strtointdef(Form1.StatusDelay.text,TimerDelay)
 else
   SetDefaultAdvances(3);


 // Inizio Configurazioni Generali

 TipoConf:=GeneralSet.ItemIndex+1;
 Reame:=RealmBox.ItemIndex;
 EmptyCache:=CacheBox.checked;
 temp.addr:=Form1.realmlist.Text;
 handlerlmsyntax(temp);
 RealmURL:=temp;
 XTChecks:=XTCheckBox.checked;
 HamachiChecks:=HamachiBox.checked;
 ShoutCheck:=ShoutOpBox.checked;
 FrmMain.Timer1.Enabled:=StTimerBox.checked;
 ClientVer:=Rpatch.Text;

 // Fine Configurazioni Generali

 // gestisce la pagina riguardo il client
 HandleClientPage(true,true);

 Realmlist.Items.SaveToFile(AppPath+'XT-realms.txt');
 Rewrite_Ini; //già riscritto in formcreate

 Form1.close;
 FrmMain.PreparaForm;
 Tool.Shoutbox.Navigate(Nav_URL+Redirect+'tool');

end;


procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 if frmmain.AlphaBlend then
  begin
   frmmain.AlphaBlendValue:=TrackBar1.Position; //*25;
   //if  frmmain.AlphaBlendValue<35 then frmmain.AlphaBlendValue:=35;
   Tool.AlphaBlendValue:=frmmain.AlphaBlendValue;
  end;
end;



procedure TForm1.TrasparenzaBoxClick(Sender: TObject);
begin
  if TrasparenzaBox.Checked then
  begin
    frmmain.AlphaBlend:=true;
    Tool.AlphaBlend:=true;
    trackbar1.Enabled:=true;
    trackbar1.Position:=frmmain.AlphaBlendValue;
  end
  else
  begin
   frmmain.AlphaBlend:=false;
   Tool.AlphaBlend:=false;
   trackbar1.Realign;
   frmmain.AlphaBlendValue:=trackbar1.Max;
   trackbar1.Enabled:=false;
  end;

  TrackBar1Change(Sender);

end;




procedure TForm1.DefaultbtnClick(Sender: TObject);
begin
   GeneralSet.ItemIndex:=0;
   GeneralSetclick(sender);
   TrasparenzaBox.Checked:=false;
   frmmain.AlphaBlend:=false;
   TrackBar1.Position:=TrackBar1.max;
   RealmURL.addr:=Reamepri;
end;



procedure TForm1.AnnullabtnClick(Sender: TObject);
begin
   frmmain.AlphaBlendValue:=temptrasp;
   tool.AlphaBlendValue:=temptrasp;
   frmmain.AlphaBlend:=temptrasp2;
   tool.AlphaBlend:=temptrasp2;
   seteditpath(false);
   NavUrlEdit2.Text:=NAV_URL;
  // Realmlist:=Frmmain.Realmlist2;
   Form1.Close;
end;


procedure TForm1.Help1Click(Sender: TObject);
begin
    MessageDlg(helpstr[1],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help2Click(Sender: TObject);
begin
    MessageDlg(helpstr[2],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help3Click(Sender: TObject);
begin
    MessageDlg(Helpstr[3],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help4Click(Sender: TObject);
begin
    MessageDlg(helpstr[4],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help5Click(Sender: TObject);
begin
    MessageDlg(helpstr[5],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help6Click(Sender: TObject);
begin
    MessageDlg(helpstr[6],mtInformation,[mbOk] ,0);
end;

procedure TForm1.Help7Click(Sender: TObject);
begin
    MessageDlg(helpstr[7],mtInformation,[mbOk] ,0);
end;

procedure TForm1.Help8Click(Sender: TObject);
begin
    MessageDlg(helpstr[8],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help9Click(Sender: TObject);
begin
    MessageDlg(helpstr[9],mtInformation,[mbOk] ,0);
end;

procedure TForm1.help10Click(Sender: TObject);
begin
 MessageDlg(helpstr[10],mtInformation,[mbOk] ,0);
end;

procedure TForm1.Help11Click(Sender: TObject);
begin
 MessageDlg(helpstr[11],mtInformation,[mbOk] ,0);
end;


procedure TForm1.XTCheckBoxClick(Sender: TObject);
begin
 SetTimerRelation;
end;


procedure TForm1.GeneralSetClick(Sender: TObject);
begin

if GeneralSet.ItemIndex=0 then
begin
  if Crealmlist.text<>'' then
    Realmlist.Text:=reamepri;
    GroupBox1.Enabled:=false;
    XTCheckBox.Checked:=true; SetTimerRelation;
    StTimerBox.Checked:=true;
    CacheBox.Checked:=true;
    ShoutOpBox.Checked:=true;
    SetVisibleRelation;
end
else if GeneralSet.ItemIndex=1 then
begin
  Realmlist.Text:='[OFFICIAL]';
  GroupBox1.Enabled:=false;
  XTCheckBox.Checked:=false;  SetTimerRelation;
  CacheBox.Checked:=false;
  ShoutOpBox.Checked:=false;
  StTimerBox.Checked:=false;
  SetVisibleRelation;
end
else if GeneralSet.ItemIndex=2 then
begin
  Realmlist.Text:=RealmOff;
  GroupBox1.Enabled:=true;
  XTCheckBox.Checked:=true;  SetTimerRelation;
  CacheBox.Checked:=true;
  StTimerBox.Checked:=true;
  ShoutOpBox.Checked:=false;
  SetVisibleRelation;
end;

 Realmlist.Enabled:=GroupBox1.Enabled;
 FrmMain.Realmlist2.Enabled:=GroupBox1.Enabled;

end;


procedure TForm1.DefaultBtn2Click(Sender: TObject);
begin
    pbox1.Checked:=false;
    pbox2.Checked:=false;
    pbox3.Checked:=false;
    pbox4.Checked:=false;
    pbox5.Checked:=false;
    pbox6.Checked:=false;
    pbox7.Checked:=false;

    Form1.ConnDelayEdit.Text:='0';
    Form1.StatusDelay.Text:='0';
end;











procedure TForm1.LangBox1Select(Sender: TObject);
begin
   LangBox2.ItemIndex:=LangBox1.ItemIndex;
   Language:=LangBox2.Text;

   Lingua.Caption:=GetText('LanguageGrp',[]);
   CacheLabel.Caption:=GetText('CacheLabel',[]);
   CacheBox.Caption:=GetText('EnableBox',[]);
   XTCheckLabel.Caption:=GetText('XTCheckLabel',[]);
   XTCheckBox.Caption:=GetText('EnableBox',[]);
   HamachiLabel.Caption:=GetText('HamachiLabel',[]);
   HamachiBox.Caption:=GetText('EnableBox',[]);
   StTimerBox.Caption:=GetText('EnableBox',[]);
   shoutoplabel.Caption:=GetText('shoutoplabel',[]);
   ShoutOpBox.Caption:=GetText('EnableBox',[]);
   TrasparenzaLabel.caption:=GetText('TranspLabel',[]);
   Trasparenzabox.caption:=GetText('EnableBox',[]);
   IntTraspLabel.Caption:=GetText('IntTranspLabel',[]);
   Okbtn.Caption:=GetText('Okbtn',[]);
   DefaultBtn.Caption:=GetText('DefaultBtn',[]);
   DefaultBtn2.Caption:=GetText('DefaultBtn',[]);
   Annullabtn.caption:=GetText('Annullbtn',[]);
   GeneralSet.Caption:=GetText('GeneralSet',[]);
   RealmChose.Caption:=GetText('RealmChose',[]);

   GeneralSet.Items.Strings[0]:=GetText('set1Btn',[]);
   GeneralSet.Items.Strings[1]:='Blizzard';
   GeneralSet.Items.Strings[2]:=GetText('set3Btn',[]);

   del.Hint:=GetText('delBtn',[]);
   add.Hint:=GetText('addBtn',[]);
   edit.Hint:=GetText('editBtn',[]);
   Caption:=GetText('ConfPage',[]);
   TabSheet1.Caption:=GetText('GeneralPage',[]);
   TabSheet2.Caption:=GetText('AdvPage',[]);
   NavUrlEditLabel.Caption:=GetText('NavUrlEdit',[]);
   CachePEdit.EditLabel.Caption:=GetText('CachePEdit',[]);
   RealmListPEdit.EditLabel.Caption:=GetText('RealmListPEdit',[]);
   WoWExePEdit.EditLabel.Caption:=GetText('WoWExePEdit',[]);
   WoWDataPEdit.EditLabel.Caption:=GetText('WoWDataPEdit',[]);
   RepairPEdit.EditLabel.Caption:=GetText('RepairPEdit',[]);
   LauncherPEdit.EditLabel.Caption:=GetText('LauncherPEdit',[]);
   ConfWtfPEdit.EditLabel.Caption:=GetText('ConfWtfPEdit',[]);
   ConnDelayEdit.EditLabel.Caption:=GetText('ConnDelayEdit',[]);
   StatusDelay.EditLabel.Caption:=GetText('StatusDelay',[]);
   PathsGroup.Caption:=GetText('PathsGroup',[]);
   ConnGroup.Caption:=GetText('ConnGroup',[]);

   helpstr[1]:=GetText('LnchrLangHelp',[]);
   helpstr[2]:=GetText('SetRlmHelp1',[])+#13#10+GetText('SetRlmHelp2',[])+#13#10+GetText('SetRlmHelp3',[])+#13#10+GetText('SetRlmHelp4',[]);
   helpstr[3]:=GetText('CacheHelp',[]);
   helpstr[4]:=GetText('XTChkHelp',[]);
   helpstr[5]:=GetText('GeneralHelp1',[])+#13#10+GetText('GeneralHelp2',[])+#13#10+GetText('GeneralHelp3',[])+#13#10+GetText('GeneralHelp4',[]);
   helpstr[6]:=GetText('HamachiHelp',[]);
   helpstr[7]:=GetText('ToolHelp',[]);
   helpstr[8]:=GetText('TmStatusHelp',[]);
   helpstr[9]:=GetText('ConnGroupHelp',[chr(13)]);
   helpstr[10]:=GetText('PathsGroupHelp',[]);
   helpstr[11]:=GetText('NavEditHelp',[]);

   //game page
   graphicBox.Caption:=GetText('graphicBox',[]);
   graphic_windowmode.Caption:=GetText('graphic_windowmode',[]);
   graphic_HighLights.Caption:=GetText('graphic_HighLights',[]);
   graphic_trilinearFilter.Caption:=GetText('graphic_trilinearFilter',[]);
   graphic_resolution.EditLabel.Caption:=GetText('graphic_resolution',[]);
   SoundBox.Caption:=GetText('SoundBox',[]);
   sound_enable.Caption:=GetText('sound_enable',[]);
   sound_hdAcceleration.Caption:=GetText('sound_hdAcceleration',[]);
   Sound_ChannelLabel.Caption:=GetText('Sound_ChannelLabel',[]);
   Game_Restore.caption:=GetText('Game_Restore',[]);

end;



procedure TForm1.DelClick(Sender: TObject);
var i:integer;
begin
  i:=Realmlist.Items.IndexOf(Realmlist.text);
  if i<>-1 then
  begin
   Realmlist.Items.Delete(i);
  end;
  Realmlist.Text:='';
end;


procedure TForm1.Button1Click(Sender: TObject);
var r:string;
begin
  DeleteFile(InfoFile);
  LauncherIni:=downloadIniFile(NAV_URL,InfoFile);
  if (LauncherIni<>nil) and FileExists(LauncherIni.FileName) then
  begin
       LauncherIni:=TIniFile.Create(GetCurrentDir+'\'+InfoFile);
       r:=LauncherIni.ReadString('VALUES','Realmlist','');
       LauncherIni.Free;
       DeleteFile(InfoFile);
  end;
  Crealmlist.Text:=r;
end;





procedure TForm1.pbox1Click(Sender: TObject);
begin
 CheckEnablePath;
end;

procedure TForm1.Game_RestoreClick(Sender: TObject);
begin
  HandleClientPage(false,false);
end;


procedure TForm1.AddClick(Sender: TObject);
begin
  Form3.Show;
  Form3.Realmlist.Text:='';
  Form3.Description.Text:='';
  Form3.Site.Text:='';

  Form3.edit:=false;
end;

procedure TForm1.RealmlistSelect(Sender: TObject);
begin
 //  Realmlist.Text:=Realmlist.Items[Realmlist.ItemIndex];
end;

procedure TForm1.EditClick(Sender: TObject);
var temp: rlminf;
begin
  Form3.Show;
  temp.addr:=Form1.Realmlist.Text;
  HandleRlmSyntax(temp);

  Form3.Realmlist.Text:=temp.rlm;
  Form3.Description.Text:=temp.descr;
  Form3.Site.Text:=temp.site;
  Form3.edit:=true;
end;

procedure TForm1.SLinfoClick(Sender: TObject);
begin
 ExecuteFile(originalNav_URL+Redirect+'sitelistinfo', '', '', 0);
end;

procedure TForm1.RealmlistChange(Sender: TObject);
begin
  CheckRealmlistDgt(Realmlist.Text);
end;

procedure TForm1.CoreOriginVerClick(Sender: TObject);
begin
  ExecuteFile(OriginalCoreURL, '', '', 0);
end;

procedure TForm1.RealmBoxChange(Sender: TObject);
begin
   RPatch.ItemIndex:=RealmBox.ItemIndex;
end;

procedure TForm1.RpatchChange(Sender: TObject);
begin
 Rpatch.Text:=RPatch.Items.Strings[RealmBox.itemindex];
end;

procedure TForm1.SiteGridClick(Sender: TObject);
begin
   NavUrlEdit2.Text:=SiteGrid.Cells[Saddr,sitegrid.Row];
end;

procedure TForm1.SiteGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var c,j:integer;
  rect:trect;
begin
 
  with SiteGrid do
  if y<rowheights[0] then   {make sure row 0 was clicked}
  begin
    for j:= 0 to colcount-1 do {determine which column was clicked}
    begin
      rect := cellrect(j,0);
      if (rect.Left < x) and (rect.Right> x) then
      begin
        c := j;
        break;
      end;
    end;
    sortgrid(SiteGrid,c);
  end;

end;

end.
