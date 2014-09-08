unit PuckControl;

interface

uses
    Math, UnitControl;

type
    TPuck = class (TUnit)
    private
        FOwnerHockeyistId: Int64;
        FOwnerPlayerId: Int64;

    public
        constructor Create(id: Int64; mass: Double; radius: Double; x: Double; y: Double; speedX: Double;
                speedY: Double; ownerHockeyistId: Int64; ownerPlayerId: Int64);

        function GetOwnerHockeyistId: Int64;
        function GetOwnerPlayerId: Int64;

        destructor Destroy; override;

    end;

    TPuckArray = array of TPuck;

implementation

constructor TPuck.Create(id: Int64; mass: Double; radius: Double; x: Double; y: Double; speedX: Double; speedY: Double;
        ownerHockeyistId: Int64; ownerPlayerId: Int64);
begin
    inherited Create(id, mass, radius, x, y, speedX, speedY, 0.0, 0.0);

    FOwnerHockeyistId := ownerHockeyistId;
    FOwnerPlayerId := ownerPlayerId;
end;

function TPuck.GetOwnerHockeyistId: Int64;
begin
    result := FOwnerHockeyistId;
end;

function TPuck.GetOwnerPlayerId: Int64;
begin
    result := FOwnerPlayerId;
end;

destructor TPuck.Destroy;
begin
    inherited;
end;

end.
