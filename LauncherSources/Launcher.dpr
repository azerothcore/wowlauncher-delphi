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


program Launcher;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Config in 'Config.pas' {Form1},
  Tools in 'Tools.pas' {Tool},
  Engine in 'Engine.pas',
  SecondaryForm in 'SecondaryForm.pas' {Form2},
  RlmForm in 'RlmForm.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'World of Warcraft';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TTool, Tool);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  //preparazione forms
  FrmMain.PreparaForm;
  Form1.PreparaForm1;
  Application.Run;
end.
