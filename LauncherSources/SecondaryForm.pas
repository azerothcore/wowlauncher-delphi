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


unit SecondaryForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, RichEdit, ShellApi;

type
  TForm2 = class(TForm)
    TextWnd: TRichEdit;
    Ok: TButton;
    Credits: TRichEdit;
    Credits2: TRichEdit;
    Thanks: TLabel;
    VersionPanel: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure InitRichEditURLDetection(RE: TRichEdit);
    procedure WndProc(var Msg: TMessage); override;
    procedure VersionPanelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleVersionPanel;
  end;

var
  Form2: TForm2;

implementation

uses Main,Engine;

{$R *.dfm}

procedure TForm2.WndProc(var Msg: TMessage);
var
  p: TENLink;
  sURL: string;
  CE : TRichEdit;
begin
 if (Msg.Msg = WM_NOTIFY) then
 begin
  if (PNMHDR(Msg.lParam).code = EN_LINK) then
  begin
   p := TENLink(Pointer(TWMNotify(Msg).NMHdr)^);
   if (p.Msg = WM_LBUTTONDOWN) then
   begin
    try
     CE := TRichEdit(Form2.ActiveControl);
     SendMessage(CE.Handle, EM_EXSETSEL, 0, Longint(@(p.chrg)));
     sURL := CE.SelText;
     ShellExecute(Handle, 'open', PChar(sURL), nil, nil, SW_SHOWNORMAL);
    except
    end;
   end;
  end;
 end;

 inherited;
end; (* TForm1.WndProc *)

procedure TForm2.InitRichEditURLDetection(RE: TRichEdit);
var
  mask: Word;
begin
  mask := SendMessage(RE.Handle, EM_GETEVENTMASK, 0, 0);
  SendMessage(RE.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
  SendMessage(RE.Handle, EM_AUTOURLDETECT, Integer(True), 0);
end;

procedure Tform2.HandleVersionPanel;
var temp2,state:string;
begin
   temp2:=VersioneApplicazione(AppPath + ExtractFilename(Application.ExeName));
  if (def_LauncherXTVer<>'1') AND (temp2<def_LauncherXTVer) then
  begin
    state:='Out of date with UDW core,  for '+def_LauncherXTVer+' [CLICK HERE]';
    VersionPanel.Font.Color:=clWhite;
    VersionPanel.Color:=clRed;
  end
  else
  begin
    state:=' [Updated] with UDW';
    VersionPanel.Font.Color:=clWhite;
    VersionPanel.Color:=clGreen;
  end;

   VersionPanel.Caption:='Launcher-XT v.'+temp2+' is '+state;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  FrmMain.Enabled:=false;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmMain.Enabled:=true;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 InitRichEditURLDetection(TextWnd);
 InitRichEditURLDetection(Credits);
 InitRichEditURLDetection(Credits2);
 Credits2.Lines.Text:=Credits2.Lines.Text;  // necessario per l'urldetection
 Credits.Lines.Add(FrmMain.Caption+#13#10+'FreeWare Software created by HW2-Yéhonal'+#13#10+'From UDW-Community (United Developers World)'+#13#10+'www.udw.altervista.org');
end;

procedure TForm2.OkClick(Sender: TObject);
begin
 Form2.Close;
end;

procedure TForm2.VersionPanelClick(Sender: TObject);
begin
 ExecuteFile(originalNav_URL+Redirect+'launcher_download', '', '', 0);  
end;

end.
