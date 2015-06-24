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

unit RlmForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    realmlabel: TLabel;
    Save: TBitBtn;
    Realmlist: TEdit;
    Description: TEdit;
    Label1: TLabel;
    Site: TEdit;
    Label2: TLabel;
    procedure SaveClick(Sender: TObject);
    procedure RealmlistChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    edit:boolean;
  end;

var
  Form3: TForm3;

implementation

uses Main, Tools, Engine, Config;

{$R *.dfm}

// FUNZIONE DI SUPPORTO

function IndexofRealmlist(realmlist:string;combo:Tcombobox):integer;
var i,res:integer;
    trovato:boolean;
begin
 i:=0;
 res:=-1;
 trovato:=false;
 while (i<=combo.Items.Count)  and not (trovato ) do
   begin
      if realmlist=copy(combo.Items.Strings[i],1,length(realmlist)) then
       begin
        trovato:=true;
        res:=i;
       end;
    inc(i);
   end;
 result:=res;
end;



// FUNZIONI DI INTERFACCIA


procedure TForm3.SaveClick(Sender: TObject);
var esistente:boolean;
    index: integer;
    temp: RlmInf;
begin
 temp.addr:='';

 if (Realmlist.text<>'') and (Realmlist.text<>RealmOff) then
 begin
      temp.addr:=Realmlist.text;
      if (Description.Text<>'') or (Site.text<>'') then
        temp.addr:=temp.addr+' #'+Description.Text;
      if Site.text<>'' then temp.addr:=temp.addr+' &RlmSite='+Site.Text;

      HandleRlmSyntax(temp);
      esistente:=false;

      //index:=IndexofRealmlist(temp.rlm,Form1.Realmlist);
      index:=0;
      while (index<Form1.Realmlist.Items.Count) and (not esistente) do
      begin
       if copy(Form1.Realmlist.Items.Strings[index],1,length(temp.rlm))=temp.rlm then
        esistente:=true
       else
        inc(index);
      end;

      if esistente then
       if edit then
       begin
        form1.Realmlist.Items.Strings[index]:=temp.addr;
        Form1.Realmlist.Text:=Temp.addr
       end
       else
       begin
        MessageDlg(GetText('RlmErr1Dlg',[]),mtError,[mbOk] ,0);  // esiste già
        exit;
       end
     else
      begin
        Form1.Realmlist.Items.Add(temp.addr);
        Form1.Realmlist.Text:=Temp.addr
      end;

  Form3.Close;

 end;


end;

procedure TForm3.RealmlistChange(Sender: TObject);
begin
 CheckRealmlistDgt(Realmlist.Text);
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Form1.Enabled:=true;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  Form1.Enabled:=false;
end;

end.
