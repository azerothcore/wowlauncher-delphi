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

unit Tools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls;

type
  TTool = class(TForm)
    Shoutbox: TWebBrowser;
    procedure FormShow(Sender: TObject);
    Procedure CreateParams( Var params: TCreateParams ); override;
  private
     // procedura per evitare la simultanea minimizzazione delle forms tramite la form principale
     // senza creare nuove gestioni di applicazione
     // Procedure WMSyscommand(Var msg: TWmSysCommand); message WM_SYSCOMMAND;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tool: TTool;
  Completed: boolean;

implementation

uses Config, Main,Engine;

{
// procedura per evitare la simultanea minimizzazione delle forms tramite la form principale
// senza creare nuove gestioni di applicazione

Procedure TTool.WMSyscommand(Var msg: TWmSysCommand);
  Begin
    Case (msg.cmdtype and $FFF0) of
      SC_MINIMIZE: Begin
          ShowWindow( handle, SW_MINIMIZE );
          msg.result := 0;
        End;
      SC_RESTORE: Begin
          ShowWindow( handle, SW_RESTORE );
          msg.result := 0;
        End;
      Else
        inherited;
    End;
  End;
}

{$R *.dfm}
// crea una finestra a parte per evitare la dipendenza nella minimizzazione dalle altre forms
procedure TTool.CreateParams(Var params: TCreateParams);
  begin
    inherited CreateParams( params );
    params.ExStyle := params.ExStyle or WS_EX_APPWINDOW;
    params.WndParent := GetDesktopwindow;
  end;

procedure TTool.FormShow(Sender: TObject);
begin
    Tool.AlphaBlend:=frmmain.AlphaBlend;
    Tool.AlphaBlendValue:=frmmain.AlphaBlendValue;
    Tool.Visible:=true;
    Shoutbox.Navigate(Nav_URL+Redirect+'tool');
end;

end.
