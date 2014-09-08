unit HockeyistControl;

interface

uses
    Math, ActionTypeControl, HockeyistStateControl, HockeyistTypeControl, UnitControl;

type
    THockeyist = class (TUnit)
    private
        FPlayerId: Int64;
        FTeammateIndex: LongInt;
        FTeammate: Boolean;
        FType: THockeyistType;
        FStrength: LongInt;
        FEndurance: LongInt;
        FDexterity: LongInt;
        FAgility: LongInt;
        FStamina: Double;
        FState: THockeyistState;
        FOriginalPositionIndex: LongInt;
        FRemainingKnockdownTicks: LongInt;
        FRemainingCooldownTicks: LongInt;
        FSwingTicks: LongInt;
        FLastAction: TActionType;
        FLastActionTick: LongInt;

    public
        constructor Create(id: Int64; playerId: Int64; teammateIndex: LongInt; mass: Double; radius: Double; x: Double;
                y: Double; speedX: Double; speedY: Double; angle: Double; angularSpeed: Double; teammate: Boolean;
                hockeyistType: THockeyistType; strength: LongInt; endurance: LongInt; dexterity: LongInt;
                agility: LongInt; stamina: Double; state: THockeyistState; originalPositionIndex: LongInt;
                remainingKnockdownTicks: LongInt; remainingCooldownTicks: LongInt; swingTicks: LongInt;
                lastAction: TActionType; lastActionTick: LongInt);

        function GetPlayerId: Int64;
        function GetTeammateIndex: LongInt;
        function GetTeammate: Boolean;
        function GetType: THockeyistType;
        function GetStrength: LongInt;
        function GetEndurance: LongInt;
        function GetDexterity: LongInt;
        function GetAgility: LongInt;
        function GetStamina: Double;
        function GetState: THockeyistState;
        function GetOriginalPositionIndex: LongInt;
        function GetRemainingKnockdownTicks: LongInt;
        function GetRemainingCooldownTicks: LongInt;
        function GetSwingTicks: LongInt;
        function GetLastAction: TActionType;
        function GetLastActionTick: LongInt;

        destructor Destroy; override;

    end;

    THockeyistArray = array of THockeyist;

implementation

constructor THockeyist.Create(id: Int64; playerId: Int64; teammateIndex: LongInt; mass: Double; radius: Double;
        x: Double; y: Double; speedX: Double; speedY: Double; angle: Double; angularSpeed: Double; teammate: Boolean;
        hockeyistType: THockeyistType; strength: LongInt; endurance: LongInt; dexterity: LongInt; agility: LongInt;
        stamina: Double; state: THockeyistState; originalPositionIndex: LongInt; remainingKnockdownTicks: LongInt;
        remainingCooldownTicks: LongInt; swingTicks: LongInt; lastAction: TActionType; lastActionTick: LongInt);
begin
    inherited Create(id, mass, radius, x, y, speedX, speedY, angle, angularSpeed);

    FPlayerId := playerId;
    FTeammateIndex := teammateIndex;
    FTeammate := teammate;
    FType := hockeyistType;
    FStrength := strength;
    FEndurance := endurance;
    FDexterity := dexterity;
    FAgility := agility;
    FStamina := stamina;
    FState := state;
    FOriginalPositionIndex := originalPositionIndex;
    FRemainingKnockdownTicks := remainingKnockdownTicks;
    FRemainingCooldownTicks := remainingCooldownTicks;
    FSwingTicks := swingTicks;
    FLastAction := lastAction;
    FLastActionTick := lastActionTick;
end;

function THockeyist.GetPlayerId: Int64;
begin
    result := FPlayerId;
end;

function THockeyist.GetTeammateIndex: LongInt;
begin
    result := FTeammateIndex;
end;

function THockeyist.GetTeammate: Boolean;
begin
    result := FTeammate;
end;

function THockeyist.GetType: THockeyistType;
begin
    result := FType;
end;

function THockeyist.GetStrength: LongInt;
begin
    result := FStrength;
end;

function THockeyist.GetEndurance: LongInt;
begin
    result := FEndurance;
end;

function THockeyist.GetDexterity: LongInt;
begin
    result := FDexterity;
end;

function THockeyist.GetAgility: LongInt;
begin
    result := FAgility;
end;

function THockeyist.GetStamina: Double;
begin
    result := FStamina;
end;

function THockeyist.GetState: THockeyistState;
begin
    result := FState;
end;

function THockeyist.GetOriginalPositionIndex: LongInt;
begin
    result := FOriginalPositionIndex;
end;

function THockeyist.GetRemainingKnockdownTicks: LongInt;
begin
    result := FRemainingKnockdownTicks;
end;

function THockeyist.GetRemainingCooldownTicks: LongInt;
begin
    result := FRemainingCooldownTicks;
end;

function THockeyist.GetSwingTicks: LongInt;
begin
    result := FSwingTicks;
end;

function THockeyist.GetLastAction: TActionType;
begin
    result := FLastAction;
end;

function THockeyist.GetLastActionTick: LongInt;
begin
    result := FLastActionTick;
end;

destructor THockeyist.Destroy;
begin
    inherited;
end;

end.
