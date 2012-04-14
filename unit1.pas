unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NeuroCrypt, StdCtrls, ExtCtrls, Spin, ComCtrls, Grids;

type

  tDoubleVector = array of Double;

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
    SpinEdit4: TSpinEdit;
    Label8: TLabel;
    SpinEdit5: TSpinEdit;
    Label9: TLabel;
    StatusBar2: TStatusBar;
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
  myFile : TextFile;
  myFile_overlap : TextFile;
  myFile_delta_overlap_vs_overlap : TextFile;
  myFile_delta_overlap_attraction_vs_overlap : TextFile;
  myFile_delta_overlap_repulsion_vs_overlap : TextFile;
  myFile_pa_vs_overlap : TextFile;

implementation

{$R *.dfm}
const ABC='ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789';

function Equ(a,b:integer):integer;
begin
   if a=b then equ:=1
   else equ:=0;
end;


function sliceDotProduct(A,B:tVector;K,N:integer): Double;
Var s: Double;
Var i, j: integer;
begin
   s:=0.0;
   for i:=K*N to (K*N+N) do
   begin
      s := s+ A[i]*B[i];
   end;
   sliceDotProduct:= s;
end;


function DotProduct(A,B:tVector): Double;
Var s: Double;
Var i, j: integer;
begin
   s:=0.0;
   for i:=0 to length(A)-1 do
   begin
      s := s+ A[i]*B[i];
   end;
   DotProduct:= s;
end;


procedure TForm1.Button3Click(Sender: TObject);
Var cnt,nM,r,i,k,sum,max,maxSUM,j,ii,i3,key_size,key_length:integer;
Var fname, fname_delta_overlap_vs_overlap, fname_delta_overlap_attraction_vs_overlap, fname_delta_overlap_repulsion_vs_overlap, fname_pa_vs_overlap :String;
Var overlap, prev_overlap, delta_overlap: Double;
Var tot_overlap, tot_prev_overlap, tot_delta_overlap: Double;
Var semip, t1, t2, t3: Double;
Var attraction_log, repulsion_log: tDoubleVector;
Var attraction_log_count, repulsion_log_count: tVector;
Var granularity:integer;
begin
  granularity := 10;
  nM := spinedit5.Value;

  fname := 'log_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
  AssignFile(myFile, fname);
  Rewrite(myFile);
  CloseFile(myFile);


  setlength(attraction_log, granularity+1);
  setlength(repulsion_log, granularity+1);
  setlength(attraction_log_count, granularity+1);
  setlength(repulsion_log_count, granularity+1);

  for cnt:=0 to granularity do
  begin
     attraction_log[cnt] := 0;
     repulsion_log[cnt] := 0;
     attraction_log_count[cnt] := 0;
     repulsion_log_count[cnt] := 0;
  end;


  for r:=1 to spinedit4.Value do
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
     if nM = 3 then
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

     prev_overlap:= 0.0;
     overlap:= 0.0;
     delta_overlap:= 0.0;
     if nM = 3 then
     begin
        overlap:= abs( (DotProduct(a.W, b.W) / Sqrt(DotProduct(a.W,a.W) * DotProduct(b.W,b.W)))   *  ( (DotProduct(b.W, c.W) / Sqrt(DotProduct(b.W,b.W) * DotProduct(c.W,c.W)))) * ((DotProduct(c.W, a.W) / Sqrt(DotProduct(c.W,c.W) * DotProduct(a.W,a.W)))) );
        sum:=GetSum3(A,B,C);
     end
     else
     begin
        overlap:= abs(DotProduct(a.W, b.W) / Sqrt(DotProduct(a.W,a.W) * DotProduct(b.W,b.W)));
        sum:=GetSum2(A,B);
     end;


//     max:=sqr(a.L*a.l)*a.N*a.K;
     max:=4*sqr(a.L*a.l)*a.N*a.K;
     maxSUM:=a.K*a.N*a.L div 4;
     for i:=1 to max do
     begin
        if nM = 3 then
          begin
            inp.FormRandomVector(b.K,b.N);
            A.CountResult(inp.X);
            b.CountResult(inp.X);
            C.CountResult(inp.X);
            if (a.TPOutput=b.TPOutput)AND(b.TPOutput=c.TPOutput) then
            begin
               a.wold := a.w;
               b.wold := b.w;
               c.wold := c.w;

               a.UpdateWeight(inp.X);
               b.UpdateWeight(inp.X);
               c.UpdateWeight(inp.X);

               prev_overlap:= overlap;
               overlap:= abs( (DotProduct(a.W, b.W) / Sqrt(DotProduct(a.W,a.W) * DotProduct(b.W,b.W)))   *  ( (DotProduct(b.W, c.W) / Sqrt(DotProduct(b.W,b.W) * DotProduct(c.W,c.W)))) * ((DotProduct(c.W, a.W) / Sqrt(DotProduct(c.W,c.W) * DotProduct(a.W,a.W)))) );
               delta_overlap:= overlap - prev_overlap;

               if delta_overlap > 0 then begin
                      attraction_log[round(overlap*granularity)] := attraction_log[round(overlap*granularity-1)] + delta_overlap;
                      attraction_log_count[round(overlap*granularity)] := attraction_log_count[round(overlap*granularity-1)] + 1;
               end
               else begin
                      repulsion_log[round(overlap*granularity)] := repulsion_log[round(overlap*granularity-1)] + delta_overlap;
                      repulsion_log_count[round(overlap*granularity)] := repulsion_log_count[round(overlap*granularity-1)] + 1;
               end;

{               for cnt:=0 to a.K-1 do
               begin
                  if equ(a.TPOutput, b.TPOutput)*equ(b.TPOutput, c.TPOutput) = 1 then begin
                    if equ(a.TPOutput,a.h[cnt])*equ(b.TPOutput,b.h[cnt])*equ(c.TPOutput,c.h[cnt]) = 1 then begin
                      //attractive step
                      attraction_log[round(overlap*granularity)] := attraction_log[round(overlap*granularity)] + delta_overlap;
                      attraction_log_count[round(overlap*granularity)] := attraction_log_count[round(overlap*granularity)] + 1;
                    end
                    else begin
                      //repulsive step
                      repulsion_log[round(overlap*granularity)] := repulsion_log[round(overlap*granularity)] + delta_overlap;
                      repulsion_log_count[round(overlap*granularity)] := repulsion_log_count[round(overlap*granularity)] + 1;
                    end;
                  end
                  else begin
                    overlap := overlap;
                  end;
               end;
}


  {            image1.Canvas.MoveTo((i-1)*image1.Width div max,image1.Height-20-round((sum/5)*(image1.Height-20)/maxSUM));
               sum:=GetSum3(A,B,C);
               image1.Canvas.Lineto(i*image1.Width div max,image1.Height-20-round((sum/5)*(image1.Height-20)/maxSUM));
  }

               image1.Canvas.MoveTo((i-1)*image1.Width div max,image1.Height-20-round((prev_overlap/1.1)*(image1.Height-20)/1.1));
               image1.Canvas.Lineto(i*image1.Width div max,image1.Height-20-round((overlap/1.1)*(image1.Height-20)/1.1));


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

               StatusBar2.SimpleText:='Current round stats >  Iterations: '+inttostr(i)+'  |  overlap : ' + FormatFloat('0.0000', overlap);


               if i mod 1000 = 0 then begin
                  fname_delta_overlap_vs_overlap := 'log_delta_overlap_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_delta_overlap_vs_overlap, fname_delta_overlap_vs_overlap);
                  Rewrite(myFile_delta_overlap_vs_overlap);

                  fname_delta_overlap_attraction_vs_overlap := 'log_delta_overlap_attraction_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_delta_overlap_attraction_vs_overlap, fname_delta_overlap_attraction_vs_overlap);
                  Rewrite(myFile_delta_overlap_attraction_vs_overlap);

                  fname_delta_overlap_repulsion_vs_overlap := 'log_delta_overlap_repulsion_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_delta_overlap_repulsion_vs_overlap, fname_delta_overlap_repulsion_vs_overlap);
                  Rewrite(myFile_delta_overlap_repulsion_vs_overlap);

                  fname_pa_vs_overlap := 'log_pa_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_pa_vs_overlap, fname_pa_vs_overlap);
                  Rewrite(myFile_pa_vs_overlap);


                  for i3 := 0 to granularity do begin
                    if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
                      WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0 ) )
                    else
                      WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', (attraction_log[i3]+repulsion_log[i3]) / (attraction_log_count[i3]+repulsion_log_count[i3]) ) );

                    if attraction_log_count[i3] = 0 then
                      WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
                    else
                      WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log[i3] / attraction_log_count[i3]  ) );

                    if repulsion_log_count[i3] = 0 then
                      WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
                    else
                      WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', repulsion_log[i3] / repulsion_log_count[i3]) );

                    if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
                      WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0  ) )
                    else
                      WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log_count[i3] / (attraction_log_count[i3]+repulsion_log_count[i3])  ) );
                  end;
                  CloseFile(myFile_delta_overlap_vs_overlap);
                  CloseFile(myFile_delta_overlap_attraction_vs_overlap);
                  CloseFile(myFile_delta_overlap_repulsion_vs_overlap);
                  CloseFile(myFile_pa_vs_overlap);
               end;




               inc(k);
               {if sum=0 then break;}
               if overlap>0.9999999 then break;
            end;
          end
        else
          begin
            inp.FormRandomVector(b.K,b.N);
            A.CountResult(inp.X);
            b.CountResult(inp.X);
            if (a.TPOutput=b.TPOutput) then
            begin
               a.wold := a.w;
               b.wold := b.w;


               a.UpdateWeight(inp.X);
               b.UpdateWeight(inp.X);

               prev_overlap:= overlap;{abs( (DotProduct(a.wold, b.wold) / Sqrt(DotProduct(a.wold, a.wold) * DotProduct(b.wold, b.wold))) );}
               overlap:= abs( (DotProduct(a.W, b.W) / Sqrt(DotProduct(a.W,a.W) * DotProduct(b.W,b.W))) );
               delta_overlap:= overlap - prev_overlap;

               if delta_overlap > 0 then begin
                      attraction_log[round(overlap*granularity)] := attraction_log[round(overlap*granularity)] + delta_overlap;
                      attraction_log_count[round(overlap*granularity)] := attraction_log_count[round(overlap*granularity)] + 1;
               end
               else begin
                      repulsion_log[round(overlap*granularity)] := repulsion_log[round(overlap*granularity)] + delta_overlap;
                      repulsion_log_count[round(overlap*granularity)] := repulsion_log_count[round(overlap*granularity)] + 1;
               end;

{               for cnt:=0 to a.K-1 do
               begin
                  if equ(a.TPOutput, b.TPOutput) = 1 then begin
                    prev_overlap := abs( (sliceDotProduct(a.wold, b.wold, cnt, a.N) / Sqrt(sliceDotProduct(a.wold, a.wold, cnt, a.N) * sliceDotProduct(b.wold, b.wold, cnt, a.N))) );
                    overlap      := abs( (sliceDotProduct(a.W, b.W, cnt, a.N) / Sqrt(sliceDotProduct(a.W, a.W, cnt, a.N) * sliceDotProduct(b.W, b.W, cnt, a.N))) );
                    delta_overlap:= overlap - prev_overlap;
                    if equ(a.TPOutput,a.h[cnt])*equ(b.TPOutput,b.h[cnt]) = 1 then begin
                      //attractive step
                      attraction_log[round(overlap*granularity)] := attraction_log[round(overlap*granularity-1)] + delta_overlap;
                      attraction_log_count[round(overlap*granularity)] := attraction_log_count[round(overlap*granularity-1)] + 1;
                    end
                    else begin
                      //repulsive step
                      repulsion_log[round(overlap*granularity)] := repulsion_log[round(overlap*granularity-1)] + delta_overlap;
                      repulsion_log_count[round(overlap*granularity)] := repulsion_log_count[round(overlap*granularity-1)] + 1;
                    end;
                  end
                  else begin
                    tot_overlap := tot_overlap;
                  end;
               end;
}

  {            image1.Canvas.MoveTo((i-1)*image1.Width div max,image1.Height-20-round((sum/5)*(image1.Height-20)/maxSUM));
               sum:=GetSum3(A,B,C);
               image1.Canvas.Lineto(i*image1.Width div max,image1.Height-20-round((sum/5)*(image1.Height-20)/maxSUM));
  }

               image1.Canvas.MoveTo((i-1)*image1.Width div max,image1.Height-20-round((prev_overlap/1.1)*(image1.Height-20)/1.1));
               image1.Canvas.Lineto(i*image1.Width div max,image1.Height-20-round((overlap/1.1)*(image1.Height-20)/1.1));


               for ii:=0 to a.K-1 do
               for j:=0 to a.N-1 do
               begin
                  stringgrid1.Cells[j,ii]:=inttostr(a.w[ii*a.N+j]);
                  stringgrid2.Cells[j,ii]:=inttostr(b.w[ii*a.N+j]);
               end;
               stringgrid1.Repaint;
               stringgrid2.Repaint;
               image1.Repaint;

               StatusBar2.SimpleText:='Current round stats >  Iterations: '+inttostr(i)+'  |  overlap : ' + FormatFloat('0.0000', overlap);

               if i mod 1000 = 0 then begin

                  fname_delta_overlap_vs_overlap := 'log_delta_overlap_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_delta_overlap_vs_overlap, fname_delta_overlap_vs_overlap);
                  Rewrite(myFile_delta_overlap_vs_overlap);

                  fname_delta_overlap_attraction_vs_overlap := 'log_delta_overlap_attraction_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_delta_overlap_attraction_vs_overlap, fname_delta_overlap_attraction_vs_overlap);
                  Rewrite(myFile_delta_overlap_attraction_vs_overlap);

                  fname_delta_overlap_repulsion_vs_overlap := 'log_delta_overlap_repulsion_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_delta_overlap_repulsion_vs_overlap, fname_delta_overlap_repulsion_vs_overlap);
                  Rewrite(myFile_delta_overlap_repulsion_vs_overlap);

                  fname_pa_vs_overlap := 'log_pa_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
                  AssignFile(myFile_pa_vs_overlap, fname_pa_vs_overlap);
                  Rewrite(myFile_pa_vs_overlap);


                  for i3 := 0 to granularity do begin
                    if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
                      WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0 ) )
                    else
                      WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', (attraction_log[i3]+repulsion_log[i3]) / (attraction_log_count[i3]+repulsion_log_count[i3]) ) );

                    if attraction_log_count[i3] = 0 then
                      WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
                    else
                      WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log[i3] / attraction_log_count[i3]  ) );

                    if repulsion_log_count[i3] = 0 then
                      WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
                    else
                      WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', repulsion_log[i3] / repulsion_log_count[i3]) );

                    if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
                      WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0  ) )
                    else
                      WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log_count[i3] / (attraction_log_count[i3]+repulsion_log_count[i3])  ) );
                  end;
                  CloseFile(myFile_delta_overlap_vs_overlap);
                  CloseFile(myFile_delta_overlap_attraction_vs_overlap);
                  CloseFile(myFile_delta_overlap_repulsion_vs_overlap);
                  CloseFile(myFile_pa_vs_overlap);

               end;

               inc(k);
               {if sum=0 then break;}
               if overlap>0.9999999 then break;
            end;
        end;
     end;


     AssignFile(myFile, fname);
     Append(myFile);
     {   if sum=0 then begin}
     if overlap>0.999999 then begin
        StatusBar1.SimpleText:='SUCCESS. '+'round:'+inttostr(r);
        WriteLn (myFile, 'SUCCESS'+' Iterations: '+inttostr(i));
     end
     else
     begin
        StatusBar1.SimpleText:='FAILED. '+'round:'+inttostr(r);
        WriteLn (myFile, 'FAILED'+' Iterations: '+inttostr(i));
     end;
     CloseFile(myFile);


     StatusBar1.SimpleText:=StatusBar1.SimpleText+'. Iterations: '+inttostr(i)+'.';
     StatusBar1.SimpleText:=StatusBar1.SimpleText+' Data exchanged: '+inttostr(i*(a.K*a.N+4) div 1024)+'Kb.';



      fname_delta_overlap_vs_overlap := 'log_delta_overlap_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
      AssignFile(myFile_delta_overlap_vs_overlap, fname_delta_overlap_vs_overlap);
      Rewrite(myFile_delta_overlap_vs_overlap);

      fname_delta_overlap_attraction_vs_overlap := 'log_delta_overlap_attraction_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
      AssignFile(myFile_delta_overlap_attraction_vs_overlap, fname_delta_overlap_attraction_vs_overlap);
      Rewrite(myFile_delta_overlap_attraction_vs_overlap);

      fname_delta_overlap_repulsion_vs_overlap := 'log_delta_overlap_repulsion_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
      AssignFile(myFile_delta_overlap_repulsion_vs_overlap, fname_delta_overlap_repulsion_vs_overlap);
      Rewrite(myFile_delta_overlap_repulsion_vs_overlap);

      fname_pa_vs_overlap := 'log_pa_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
      AssignFile(myFile_pa_vs_overlap, fname_pa_vs_overlap);
      Rewrite(myFile_pa_vs_overlap);


      for i3 := 0 to granularity do begin
        if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
          WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0 ) )
        else
          WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', (attraction_log[i3]+repulsion_log[i3]) / (attraction_log_count[i3]+repulsion_log_count[i3]) ) );

        if attraction_log_count[i3] = 0 then
          WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
        else
          WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log[i3] / attraction_log_count[i3]  ) );

        if repulsion_log_count[i3] = 0 then
          WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
        else
          WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', repulsion_log[i3] / repulsion_log_count[i3]) );

        if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
          WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0  ) )
        else
          WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log_count[i3] / (attraction_log_count[i3]+repulsion_log_count[i3])  ) );
      end;
      CloseFile(myFile_delta_overlap_vs_overlap);
      CloseFile(myFile_delta_overlap_attraction_vs_overlap);
      CloseFile(myFile_delta_overlap_repulsion_vs_overlap);
      CloseFile(myFile_pa_vs_overlap);

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

  fname_delta_overlap_vs_overlap := 'log_delta_overlap_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
  AssignFile(myFile_delta_overlap_vs_overlap, fname_delta_overlap_vs_overlap);
  Rewrite(myFile_delta_overlap_vs_overlap);

  fname_delta_overlap_attraction_vs_overlap := 'log_delta_overlap_attraction_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
  AssignFile(myFile_delta_overlap_attraction_vs_overlap, fname_delta_overlap_attraction_vs_overlap);
  Rewrite(myFile_delta_overlap_attraction_vs_overlap);

  fname_delta_overlap_repulsion_vs_overlap := 'log_delta_overlap_repulsion_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
  AssignFile(myFile_delta_overlap_repulsion_vs_overlap, fname_delta_overlap_repulsion_vs_overlap);
  Rewrite(myFile_delta_overlap_repulsion_vs_overlap);

  fname_pa_vs_overlap := 'log_pa_vs_overlap_K='+inttostr(spinedit1.Value)+'_L='+inttostr(spinedit3.Value)+'_N='+inttostr(spinedit2.Value)+'_m='+inttostr(spinedit5.Value)+'_r='+inttostr(spinedit4.Value)+'.txt';
  AssignFile(myFile_pa_vs_overlap, fname_pa_vs_overlap);
  Rewrite(myFile_pa_vs_overlap);


  for i3 := 0 to granularity do begin
    if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
      WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0 ) )
    else
      WriteLn (myFile_delta_overlap_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', (attraction_log[i3]+repulsion_log[i3]) / (attraction_log_count[i3]+repulsion_log_count[i3]) ) );

    if attraction_log_count[i3] = 0 then
      WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
    else
      WriteLn (myFile_delta_overlap_attraction_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log[i3] / attraction_log_count[i3]  ) );

    if repulsion_log_count[i3] = 0 then
      WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0) )
    else
      WriteLn (myFile_delta_overlap_repulsion_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', repulsion_log[i3] / repulsion_log_count[i3]) );

    if (attraction_log_count[i3]+repulsion_log_count[i3]) = 0 then
      WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', -1.0  ) )
    else
      WriteLn (myFile_pa_vs_overlap, FormatFloat('0.0000', i3/granularity) +'  '+ FormatFloat('0.0000', attraction_log_count[i3] / (attraction_log_count[i3]+repulsion_log_count[i3])  ) );
  end;
  CloseFile(myFile_delta_overlap_vs_overlap);
  CloseFile(myFile_delta_overlap_attraction_vs_overlap);
  CloseFile(myFile_delta_overlap_repulsion_vs_overlap);
  CloseFile(myFile_pa_vs_overlap);
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
