unit UnitControl;

interface

uses
    Math;

type
    TUnit = class
    private
        FId: Int64;
        FMass: Double;
        FRadius: Double;
        FX: Double;
        FY: Double;
        FSpeedX: Double;
        FSpeedY: Double;
        FAngle: Double;
        FAngularSpeed: Double;

    protected
        constructor Create(id: Int64; mass: Double; radius: Double; x: Double; y: Double; speedX: Double;
                speedY: Double; angle: Double; angularSpeed: Double);

    public
        function GetId: Int64;
        function GetMass: Double;
        function GetRadius: Double;
        function GetX: Double;
        function GetY: Double;
        function GetSpeedX: Double;
        function GetSpeedY: Double;
        function GetAngle: Double;
        function GetAngularSpeed: Double;

        function GetAngleTo(x: Double; y: Double): Double; overload;
        function GetAngleTo(anotherUnit: TUnit): Double; overload;
        function GetDistanceTo(x: Double; y: Double): Double; overload;
        function GetDistanceTo(anotherUnit: TUnit): Double; overload;

        destructor Destroy; override;

    end;

    TUnitArray = array of TUnit;

implementation

constructor TUnit.Create(id: Int64; mass: Double; radius: Double; x: Double; y: Double; speedX: Double; speedY: Double;
        angle: Double; angularSpeed: Double);
begin
    FId := id;
    FMass := mass;
    FRadius := radius;
    FX := x;
    FY := y;
    FSpeedX := speedX;
    FSpeedY := speedY;
    FAngle := angle;
    FAngularSpeed := angularSpeed;
end;

function TUnit.GetId: Int64;
begin
    result := FId;
end;

function TUnit.GetMass: Double;
begin
    result := FMass;
end;

function TUnit.GetRadius: Double;
begin
    result := FRadius;
end;

function TUnit.GetX: Double;
begin
    result := FX;
end;

function TUnit.GetY: Double;
begin
    result := FY;
end;

function TUnit.GetSpeedX: Double;
begin
    result := FSpeedX;
end;

function TUnit.GetSpeedY: Double;
begin
    result := FSpeedY;
end;

function TUnit.GetAngle: Double;
begin
    result := FAngle;
end;

function TUnit.GetAngularSpeed: Double;
begin
    result := FAngularSpeed;
end;

function TUnit.GetAngleTo(x: Double; y: Double): Double;
var
    absoluteAngleTo, relativeAngleTo: Double;

begin
    absoluteAngleTo := ArcTan2(y - FY, x - FX);
    relativeAngleTo := absoluteAngleTo - FAngle;

    while relativeAngleTo > PI do
    begin
        relativeAngleTo := relativeAngleTo - 2 * PI;
    end;

    while relativeAngleTo < -PI do
    begin
        relativeAngleTo := relativeAngleTo + 2 * PI;
    end;

    result := relativeAngleTo;
end;

function TUnit.getAngleTo(anotherUnit: TUnit): Double;
begin
    result := GetAngleTo(anotherUnit.FX, anotherUnit.FY);
end;

function TUnit.getDistanceTo(x: Double; y: Double): Double;
begin
    result := Sqrt(Sqr(FX - x) + Sqr(FY - y));
end;

function TUnit.getDistanceTo(anotherUnit: TUnit): Double;
begin
    result := GetDistanceTo(anotherUnit.FX, anotherUnit.FY);
end;

destructor TUnit.Destroy;
begin
    inherited;
end;

end.
