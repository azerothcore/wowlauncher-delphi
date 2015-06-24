unit SJ_BitmapButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TBitmapButton = class(TGraphicControl)
  private
    FBitmap: TBitmap;
    FLighter: TBitmap;
    FDarker: Tbitmap;
    FPushDown:boolean;
    FMouseOver:boolean;
    FLatching: boolean;
    FDown: boolean;
    FHotTrack: boolean;
    procedure SetBitmap(const Value: TBitmap);
    procedure MakeDarker;
    procedure MakeLighter;
    procedure SetLatching(const Value: boolean);
    procedure SetDown(const Value: boolean);
    procedure SetHotTrack(const Value: boolean);
    { Private declarations }
  protected
    { Protected declarations }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure Click;override;
    procedure CMMouseLeave(var Message:TMessage); message CM_MouseLeave;
    procedure Loaded;override;
    procedure Resize;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure   Paint; override;
  published
    { Published declarations }
    property Bitmap:TBitmap read FBitmap write SetBitmap;
    property Down:boolean read FDown write SetDown;
    property Latching:boolean read FLatching write SetLatching;
    property HotTrack:boolean read FHotTrack write SetHotTrack;
    property onclick;
    property onmousedown;
    property onmouseup;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('SimJoy', [TBitmapButton]);
end;

{ TBitmapButton }

procedure TBitmapButton.Click;
begin
  inherited;
//  if FPushDown then if assigned(onclick) then onclick(self);
end;

constructor TBitmapButton.Create(AOwner: TComponent);
begin
  inherited;
  width:=24;
  height:=24;
  FPushDown:=false;
  FMouseOver:=false;
  FLatching:=false;
  FHotTrack:=true;
  FDown:=false;
  FBitmap:=TBitmap.create;
  Fbitmap.width:=24;
  Fbitmap.Height:=24;
  Fbitmap.canvas.brush.color:=clgray;
  FBitmap.canvas.FillRect (rect(1,1,23,23));
  FLighter:=Tbitmap.create;
  FDarker:=Tbitmap.create;
end;

destructor TBitmapButton.Destroy;
begin
  FBitmap.free;
  FLighter.free;
  FDarker.free;
  inherited;
end;

procedure TBitmapButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FBitmap.canvas.pixels[x,y]<>Fbitmap.canvas.pixels[0,FBitmap.height-1] then
   FPushDown:=true
   else
   FPushDown:=false;
  Paint;
  if assigned(onmousedown) then
    onmousedown(self,button,shift,x,y);
end;

procedure TBitmapButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FPushDown:=false;
  if Latching then
    FDown:= not FDown
  else
    FDown:=false;
  Paint;
  if assigned(onmouseup) then
    onmouseup(self,button,shift,x,y);
end;

procedure TBitmapButton.Paint;
var Acolor:TColor;
begin
  inherited;
  if assigned(FBitmap) then
  begin
    AColor:=FBitmap.canvas.pixels[0,FBitmap.height-1];
    Fbitmap.transparent:=true;
    Fbitmap.transparentcolor:=Acolor;
    FLighter.transparent:=true;
    Flighter.TransparentColor :=AColor;
    FDarker.transparent:=true;
    FDarker.TransparentColor :=AColor;
    if FPushdown then
    begin
      canvas.draw(1,1,FDarker)
    end
    else
    begin
      if Down then
        canvas.Draw(1,1,FDarker)
      else if (FMouseOver and FHotTrack) then
        canvas.draw(0,0,FLighter)
      else
        canvas.Draw (0,0,FBitmap);
    end;
  end;
end;

procedure TBitmapButton.SetBitmap(const Value: TBitmap);
begin
  FBitmap.assign(Value);
  FBitmap.transparent:=true;
  FBitmap.TransparentColor :=FBitmap.Canvas.pixels[0,FBitmap.Height-1];
  width:=FBitmap.Width ;
  height:=FBitmap.Height ;
  MakeLighter;
  MakeDarker;
end;

procedure TBitmapButton.MakeLighter;
var p1,p2:Pbytearray;
    x,y:integer;
    rt,gt,bt:byte;
    AColor:TColor;
begin
  FLighter.Width :=FBitmap.Width ;
  FLighter.Height :=FBitmap.height;
  Acolor:=colortorgb(FBitmap.canvas.pixels[0,FBitmap.height-1]);
  rt:=GetRValue(Acolor);
  gt:=GetGValue(AColor);
  bt:=getBValue(AColor);
  FBitmap.PixelFormat :=pf24bit;
  FLighter.PixelFormat :=pf24bit;
  for y:=0 to Fbitmap.height-1 do
  begin
    p1:=Fbitmap.ScanLine [y];
    p2:=FLighter.ScanLine [y];
    for x:=0 to FBitmap.width-1 do
    begin
      if (p1[x*3]=bt)and (p1[x*3+1]=gt)and (p1[x*3+2]=rt) then
      begin
        p2[x*3]:=p1[x*3];
        p2[x*3+1]:=p1[x*3+1];
        p2[x*3+2]:=p1[x*3+2];
      end
      else
      begin
        p2[x*3]:=$FF-round(0.8*abs($FF-p1[x*3]));
        p2[x*3+1]:=$FF-round(0.8*abs($FF-p1[x*3+1]));
        p2[x*3+2]:=$FF-round(0.8*abs($FF-p1[x*3+2]));
      end;
    end;
  end;
end;

procedure TBitmapButton.MakeDarker;
var p1,p2:Pbytearray;
    x,y:integer;
    rt,gt,bt:byte;
    AColor:TColor;
begin
  FDarker.Width :=FBitmap.Width ;
  FDarker.Height :=FBitmap.height;
  Acolor:=colortorgb(FBitmap.canvas.pixels[0,FBitmap.height-1]);
  rt:=GetRValue(Acolor);
  gt:=GetGValue(AColor);
  bt:=getBValue(AColor);
  FBitmap.PixelFormat :=pf24bit;
  FDarker.PixelFormat :=pf24bit;
  for y:=0 to Fbitmap.height-1 do
  begin
    p1:=Fbitmap.ScanLine [y];
    p2:=FDarker.ScanLine [y];
    for x:=0 to FBitmap.width-1 do
    begin
      if (p1[x*3]=bt)and (p1[x*3+1]=gt)and (p1[x*3+2]=rt) then
      begin
        p2[x*3]:=p1[x*3];
        p2[x*3+1]:=p1[x*3+1];
        p2[x*3+2]:=p1[x*3+2];
      end
      else
      begin
        p2[x*3]:=round(0.7*p1[x*3]);
        p2[x*3+1]:=round(0.7*p1[x*3+1]);
        p2[x*3+2]:=round(0.7*p1[x*3+2]);
      end
    end;
  end;
end;


procedure TBitmapButton.CMMouseLeave(var Message: TMessage);
begin
  FMouseOver:=false;
  Paint;
end;

procedure TBitmapButton.Loaded;
begin
  inherited;
  if not FBitmap.Empty then
  begin
    MakeDarker;
    MakeLighter;
  end;
end;

procedure TBitmapButton.SetLatching(const Value: boolean);
begin
  FLatching := Value;
  if not FLatching then
  begin
    FDown:=false;
    paint;
  end;  
end;

procedure TBitmapButton.SetDown(const Value: boolean);
begin
  if FLatching then
  begin
    FDown := Value;
    paint;
  end
  else
  begin
    FDown:=false;
    paint;
  end;
end;

procedure TBitmapButton.Resize;
begin
  inherited;
  if assigned(Fbitmap) then
  begin
    width:=FBitmap.width;
    height:=FBitmap.Height ;
  end
  else
  begin
    width:=24;
    height:=24;
  end;
end;


procedure TBitmapButton.SetHotTrack(const Value: boolean);
begin
  FHotTrack := Value;
end;

procedure TBitmapButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var Value:boolean;
begin
  inherited;
  Value:= FBitmap.canvas.pixels[x,y]<>Fbitmap.canvas.pixels[0,FBitmap.height-1];
  if value<>FMouseOver then
  begin
    FMouseOver:=value;
    Paint;
  end;
  if assigned(onmousemove) then
    onmousemove(self,shift,x,y);
end;

end.
