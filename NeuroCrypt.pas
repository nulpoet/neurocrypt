{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
unit NeuroCrypt;

interface
uses MATH, SysUtils;


TYPE

   tVector = array of integer;
   tTPM = object
      w,wold,h:tVector;
      K,N,L:integer;
      TPOutput:integer;
      Procedure InitAll;
      Procedure CountResult(X:tVector);
      Procedure UpdateWeight(X:tVector);
      Procedure RandomWeight;
      Function VectorValue:integer;
   end;
   tInputVector=object
      X: TVector;
      Procedure FormRandomVector(k,n:integer);
   end;

   function GetSum3(A,B,C:tTPM):integer;
   function GetSum2(A,B:tTPM):integer;
   function KorrFichn(A,B:tVector):real;
implementation



function KorrFichn(A,B:tVector):real;
Var i,u,v:integer;
begin
   u:=0;v:=0;
   for i:=0 to length(A)-1 do
      if (A[i]*B[i])>=0 then inc(u) else inc(v);
   KorrFichn:=(u-v)/(u+v);
end;

function GetSum3(A,B,C:tTPM):integer;
Var i,s:integer;
begin
   s:=0;
   for i:=0 to a.k*a.n-1 do
   begin
      s:=s + abs(a.w[i]-b.w[i]) + abs(b.w[i]-c.w[i]);
   end;
   GetSum3:=s;
end;

function GetSum2(A,B:tTPM):integer;
Var i,s:integer;
begin
   s:=0;
   for i:=0 to a.k*a.n-1 do
   begin
      s:=s + abs(a.w[i]-b.w[i]);
   end;
   GetSum2:=s;
end;

function power(t,k:int64):int64;
var
  res:int64;
Begin
  res := 1;
  while (k > 0) do
  begin
    if (k and 1 = 1) then     {��� �������� "if (k and 1 = 1)" ��� ������� �������� ����������}
      res := res * t;
    t := t * t;
    k := k shr 1;        {��� �������� "k := k shr 1;" ��� ������� �������� ����������}
  end;
  power := res;
End;
function Equ(a,b:integer):integer;
begin
   if a=b then equ:=1
   else equ:=0;
end;
function RandomBit:integer;
Var a:integer;
begin
   a:=Random(2);
   if a=0 then result:=-1 else result:=1;
end;
function Sigma(r:real):integer;
begin
   if r>0 then result:=1 else result:=-1;
end;





{ tTPM }

procedure tTPM.CountResult(X: tVector);
Var i,j,sum:integer;
begin
  TPOutput:=1;
  for i:=0 to k-1 do
  begin
     sum:=0;
     for j:=0 to n-1 do
        sum:=sum+W[i*n+j]*X[i*n+j];
     h[i]:=sigma(sum);
     TPOutput:=TPoutput*Sigma(sum);
  end;
end;

procedure tTPM.InitAll;
begin
   SetLength(w,K*N);
   SetLength(wold,K*N);
   SetLength(h,K);
end;

procedure tTPM.RandomWeight;
Var i:integer;
begin
   for i:=0 to k*n-1 do
      w[i]:=L-Random(2*L+1);
end;

procedure tTPM.UpdateWeight(X:tVector);
Var i,j,newW:integer;
begin
   for i:=0 to K-1 do
   for j:=0 to N-1 do
   begin
      newW:=W[i*n+j];
      newW:=newW+X[i*n+j]*tpOutput*
      equ(tpOutput,h[i])*
      equ(tpOutPut,tpOutput);
      if newW>L then newW:=L;
      if newW<-L then newW:=-L;
      W[i*n+j]:=newW;
   end;
end;

function tTPM.VectorValue: integer;
Var i,s:integer;
begin
   s:=0;
   for i:=0 to k*n-1 do
   begin
      s:=s+(w[i]);
   end;
   VectorValue:=s;
end;

{ tInputVector }

procedure tInputVector.FormRandomVector(k, n: integer);
Var i:integer;
begin
   SetLength(X,k*n);
   for i:=0 to k*n-1 do
      X[i]:=RandomBit;
end;

end.
