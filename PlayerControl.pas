unit PlayerControl;

interface

uses
    Math;

type
    TPlayer = class
    private
        FId: Int64;
        FMe: Boolean;
        FName: String;
        FGoalCount: LongInt;
        FStrategyCrashed: Boolean;
        FNetTop: Double;
        FNetLeft: Double;
        FNetBottom: Double;
        FNetRight: Double;
        FNetFront: Double;
        FNetBack: Double;
        FJustScoredGoal: Boolean;
        FJustMissedGoal: Boolean;

    public
        constructor Create(id: Int64; me: Boolean; name: String; goalCount: LongInt; strategyCrashed: Boolean;
                netTop: Double; netLeft: Double; netBottom: Double; netRight: Double; netFront: Double; netBack: Double;
                justScoredGoal: Boolean; justMissedGoal: Boolean);

        function GetId: Int64;
        function GetMe: Boolean;
        function GetName: String;
        function GetGoalCount: LongInt;
        function GetStrategyCrashed: Boolean;
        function GetNetTop: Double;
        function GetNetLeft: Double;
        function GetNetBottom: Double;
        function GetNetRight: Double;
        function GetNetFront: Double;
        function GetNetBack: Double;
        function GetJustScoredGoal: Boolean;
        function GetJustMissedGoal: Boolean;

        destructor Destroy; override;

    end;

    TPlayerArray = array of TPlayer;

implementation

constructor TPlayer.Create(id: Int64; me: Boolean; name: String; goalCount: LongInt; strategyCrashed: Boolean;
        netTop: Double; netLeft: Double; netBottom: Double; netRight: Double; netFront: Double; netBack: Double;
        justScoredGoal: Boolean; justMissedGoal: Boolean);
begin
    FId := id;
    FMe := me;
    FName := name;
    FGoalCount := goalCount;
    FStrategyCrashed := strategyCrashed;
    FNetTop := netTop;
    FNetLeft := netLeft;
    FNetBottom := netBottom;
    FNetRight := netRight;
    FNetFront := netFront;
    FNetBack := netBack;
    FJustScoredGoal := justScoredGoal;
    FJustMissedGoal := justMissedGoal;
end;

function TPlayer.GetId: Int64;
begin
    result := FId;
end;

function TPlayer.GetMe: Boolean;
begin
    result := FMe;
end;

function TPlayer.GetName: String;
begin
    result := FName;
end;

function TPlayer.GetGoalCount: LongInt;
begin
    result := FGoalCount;
end;

function TPlayer.GetStrategyCrashed: Boolean;
begin
    result := FStrategyCrashed;
end;

function TPlayer.GetNetTop: Double;
begin
    result := FNetTop;
end;

function TPlayer.GetNetLeft: Double;
begin
    result := FNetLeft;
end;

function TPlayer.GetNetBottom: Double;
begin
    result := FNetBottom;
end;

function TPlayer.GetNetRight: Double;
begin
    result := FNetRight;
end;

function TPlayer.GetNetFront: Double;
begin
    result := FNetFront;
end;

function TPlayer.GetNetBack: Double;
begin
    result := FNetBack;
end;

function TPlayer.GetJustScoredGoal: Boolean;
begin
    result := FJustScoredGoal;
end;

function TPlayer.GetJustMissedGoal: Boolean;
begin
    result := FJustMissedGoal;
end;

destructor TPlayer.Destroy;
begin
    inherited;
end;

end.
