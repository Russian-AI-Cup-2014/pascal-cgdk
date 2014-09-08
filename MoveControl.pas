unit MoveControl;

interface

uses
    Math, ActionTypeControl;

type
    TMove = class
    private
        FSpeedUp: Double;
        FTurn: Double;
        FAction: TActionType;
        FPassPower: Double;
        FPassAngle: Double;
        FTeammateIndex: LongInt;

    public
        constructor Create;

        function GetSpeedUp: Double;
        procedure SetSpeedUp(speedUp: Double);
        function GetTurn: Double;
        procedure SetTurn(turn: Double);
        function GetAction: TActionType;
        procedure SetAction(action: TActionType);
        function GetPassPower: Double;
        procedure SetPassPower(passPower: Double);
        function GetPassAngle: Double;
        procedure SetPassAngle(passAngle: Double);
        function GetTeammateIndex: LongInt;
        procedure SetTeammateIndex(teammateIndex: LongInt);

        destructor Destroy; override;

    end;

    TMoveArray = array of TMove;

implementation

constructor TMove.Create;
begin
    FSpeedUp := 0.0;
    FTurn := 0.0;
    FAction := NONE;
    FPassPower := 1.0;
    FPassAngle := 0.0;
    FTeammateIndex := -1;
end;

function TMove.GetSpeedUp: Double;
begin
    result := FSpeedUp;
end;

procedure TMove.SetSpeedUp(speedUp: Double);
begin
    FSpeedUp := speedUp;
end;

function TMove.GetTurn: Double;
begin
    result := FTurn;
end;

procedure TMove.SetTurn(turn: Double);
begin
    FTurn := turn;
end;

function TMove.GetAction: TActionType;
begin
    result := FAction;
end;

procedure TMove.SetAction(action: TActionType);
begin
    FAction := action;
end;

function TMove.GetPassPower: Double;
begin
    result := FPassPower;
end;

procedure TMove.SetPassPower(passPower: Double);
begin
    FPassPower := passPower;
end;

function TMove.GetPassAngle: Double;
begin
    result := FPassAngle;
end;

procedure TMove.SetPassAngle(passAngle: Double);
begin
    FPassAngle := passAngle;
end;

function TMove.GetTeammateIndex: LongInt;
begin
    result := FTeammateIndex;
end;

procedure TMove.SetTeammateIndex(teammateIndex: LongInt);
begin
    FTeammateIndex := teammateIndex;
end;

destructor TMove.Destroy;
begin
    inherited;
end;

end.
