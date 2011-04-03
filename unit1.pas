unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NeuroCrypt, StdCtrls, ExtCtrls, Spin, ComCtrls, Grids;

type
  TForm1 = class(TForm)
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    SpinEdit3: TSpinEdit;
    Button3: TButton;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox4: TGroupBox;
    StringGrid3: TStringGrid;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A,B,C:tTPM;
    inp:tInputVector;
  end;

var
  Form1: TForm1;
  vec:tVector;

implementation

{$R *.dfm}
const ABC='ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789';

procedure TForm1.Button3Click(Sender: TObject);
Var i,k,sum,max,maxSUM,j,ii,key_size,key_length:integer;
begin
  image1.Canvas.Brush.Color:=clInfoBK;
  image1.Canvas.Pen.Color:=clBlue;
  image1.Canvas.FillRect(image1.ClientRect);
  image1.Canvas.MoveTo(0,image1.Height-20);
  image1.Canvas.LineTo(image1.Width,image1.Height-20);
  image1.Canvas.MoveTo(0,20);
  image1.Canvas.LineTo(image1.Width,20);
  with A do
   begin
      K:=spinedit1.Value;
      N:=spinedit2.Value;
      L:=spinedit3.Value;
      InitAll;
      RandomWeight;
   end;
   with B do
   begin
      K:=spinedit1.Value;
      N:=spinedit2.Value;
      L:=spinedit3.Value;
      InitAll;
      RandomWeight;
   end;
   with C do
   begin
      K:=spinedit1.Value;
      N:=spinedit2.Value;
      L:=spinedit3.Value;
      InitAll;
      RandomWeight;
   end;
   StringGrid1.RowCount:=a.K;
   StringGrid1.ColCount:=a.N;
   stringgrid1.FixedCols:=0;
   stringgrid1.FixedRows:=0;

   StringGrid2.RowCount:=a.K;
   StringGrid2.ColCount:=a.N;
   stringgrid2.FixedCols:=0;
   stringgrid2.FixedRows:=0;

   StringGrid3.RowCount:=a.K;
   StringGrid3.ColCount:=a.N;
   stringgrid3.FixedCols:=0;
   stringgrid3.FixedRows:=0;

   setlength(vec,b.K*b.N);
   k:=0;
   sum:=GetSum(A,B,C);
   max:=sqr(a.L*a.l)*a.N*a.K;
   maxSUM:=a.K*a.N*a.L div 4;
   for i:=1 to max do
   begin
      inp.FormRandomVector(b.K,b.N);
      A.CountResult(inp.X);
      b.CountResult(inp.X);
      C.CountResult(inp.X);
      if (a.TPOutput=b.TPOutput)AND(b.TPOutput=c.TPOutput) then
      begin
         a.UpdateWeight(inp.X);
         b.UpdateWeight(inp.X);
         c.UpdateWeight(inp.X);
         image1.Canvas.MoveTo((i-1)*image1.Width div max,image1.Height-20-round((sum/5)*(image1.Height-20)/maxSUM));
         sum:=GetSum(A,B,C);
         image1.Canvas.Lineto(i*image1.Width div max,image1.Height-20-round((sum/5)*(image1.Height-20)/maxSUM));
         for ii:=0 to a.K-1 do
         for j:=0 to a.N-1 do
         begin
            stringgrid1.Cells[j,ii]:=inttostr(a.w[ii*a.N+j]);
            stringgrid2.Cells[j,ii]:=inttostr(b.w[ii*a.N+j]);
            stringgrid3.Cells[j,ii]:=inttostr(b.w[ii*a.N+j]);
         end;
         stringgrid1.Repaint;
         stringgrid2.Repaint;
         stringgrid3.Repaint;
         image1.Repaint;
         inc(k);
         if sum=0 then break;
      end;
   end;
   if sum=0 then StatusBar1.SimpleText:='SUCCESS' else StatusBar1.SimpleText:='FAILED';
   StatusBar1.SimpleText:=StatusBar1.SimpleText+'. Iterations: '+inttostr(i)+'.';
   StatusBar1.SimpleText:=StatusBar1.SimpleText+' Data exchanged: '+inttostr(i*(a.K*a.N+4) div 1024)+'Kb.';

   //makeing key
   edit1.Text:='';
   key_size:=length(ABC) div (a.l*2+1);
   key_length:=a.K*a.n div key_size;
   for i:=1 to key_length do
   begin
      k:=1;
      for j:=(i-1)*key_size to i*key_size-1 do
         k:=k+a.w[j]+a.l;
      edit1.Text:=edit1.Text+ABC[k];
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  image1.Canvas.Brush.Color:=clInfoBk;
  image1.Canvas.Pen.Color:=clBlue;
  image1.Canvas.FillRect(image1.ClientRect);
  image1.Canvas.MoveTo(0,image1.Height-20);
  image1.Canvas.LineTo(image1.Width,image1.Height-20);

  image1.Canvas.MoveTo(0,20);
  image1.Canvas.LineTo(image1.Width,20);
  Randomize;
end;

end.
