program lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  Vector2D = class
  public
    x : double;
    y : double;

    constructor Create(_x : double; _y : double);

    function Sub(v : Vector2D) : Vector2D;

    function Length : real;
  end;

  constructor Vector2D.Create(_x: double; _y: double);
  begin
    x := _x;
    y := _y;
  end;

  function Vector2D.Sub(v: Vector2D): Vector2D;
  begin
    var r := Vector2D.Create(0, 0);

    r.x := x - v.x;
    r.y := y - v.y;

    Sub := r;
  end;

  function Vector2D.Length: real;
  begin
    Length := Sqrt(x * x + y * y);
  end;


type
  Triangle = class
  public
    Point1 : Vector2D;
    Point2 : Vector2D;
    Point3 : Vector2D;

    constructor Create(p1 : Vector2D; p2 : Vector2D; p3 : Vector2D);

    function GetArea() : double;
    function ComputeBarycentricCoords(p : Vector2D) : Vector2D;
  end;

  constructor Triangle.Create(p1: Vector2D; p2: Vector2D; p3: Vector2D);
  begin
    Point1 := p1;
    Point2 := p2;
    Point3 := p3;
  end;

  //���� ����� ���������� �� �������� ������
  function Triangle.GetArea: double;
  begin
    var side1 := Point2.Sub(Point1).Length();
    var side2 := Point3.Sub(Point1).Length();
    var side3 := Point3.Sub(Point2).Length();

    var p := 0.5 * (side1 + side2 + side3);

    GetArea := Sqrt(p * (p - side1) * (p - side2) * (p - side3));
  end;

  //���� ������������� ���������� ���������� �� ��������, ��� ��������, �� ����������
  //����������� �� ���� ���������� ���������� � ������ p
  //������� ����� 2 ���������� ����, �� ������� �������� �����: w = 1 - (u + v)
  function Triangle.ComputeBarycentricCoords(p : Vector2D): Vector2D;
  begin
    var t1 := Triangle.Create(Point3, Point1, p);
    var t2 := Triangle.Create(Point1, Point2, p);

    var u := t1.GetArea() / GetArea();
    var v := t2.GetArea() / GetArea();

    ComputeBarycentricCoords := Vector2D.Create(u, v);
  end;

begin
  var point1 := Vector2D.Create(0.0, 0.0);
  var point2 := Vector2D.Create(0.0, 0.0);
  var point3 := Vector2D.Create(0.0, 0.0);

  Writeln('Enter first triangle vertex:');
  Readln(point1.x, point1.y);

  Writeln('Enter second triangle vertex:');
  Readln(point2.x, point2.y);

  Writeln('Enter third triangle vertex:');
  Readln(point3.x, point3.y);

  while True do
  begin
       var userPoint := Vector2D.Create(0.0, 0.0);

       Writeln('Enter point:');
       Readln(userPoint.x, userPoint.y);


       var userTrig := Triangle.Create(point1, point2, point3);
       var barycentricP := userTrig.ComputeBarycentricCoords(userPoint);

       //���������� �� ����� � ����� ����������
       if(barycentricP.x >= 0.0) and (barycentricP.y >= 0.0)
          and ((barycentricP.x + barycentricP.y) <= 1.0)  then
          begin

          //³��������� ����� ����������
          var thirdCoord := 1.0 - (barycentricP.x + barycentricP.y);

          //��� �� �� �������� ������� �����, ���� ����� � ����������
          //���� ���� �� ��������� �� ���������� 1.0
          //���� ��� �������� ���� �� ����� ����������� �� ��������� ����������
          //�� ������ ����������� ������ �������� �����
          if(barycentricP.x = 1.0) or (barycentricP.y = 1.0)
             or (thirdCoord = 1.0) then
              Writeln('Point on the triangle vertex!')
          else if(barycentricP.x = 0.0) or (barycentricP.y = 0.0) //����� ����� � ���������� ������� ������������� � ���
                  or (thirdCoord = 0.0) then
              Writeln('Point on the triangle side!')
          else
              Writeln('Point inside triangle!');
          end
       else
          Writeln('Point lies outside of the triangle!');
  end;
end.