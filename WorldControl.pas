unit WorldControl;

interface

uses
    Math, HockeyistControl, PlayerControl, PuckControl;

type
    TWorld = class
    private
        FTick: LongInt;
        FTickCount: LongInt;
        FWidth: Double;
        FHeight: Double;
        FPlayers: TPlayerArray;
        FHockeyists: THockeyistArray;
        FPuck: TPuck;

    public
        constructor Create(tick: LongInt; tickCount: LongInt; width: Double; height: Double; players: TPlayerArray;
                hockeyists: THockeyistArray; puck: TPuck);

        function GetTick: LongInt;
        function GetTickCount: LongInt;
        function GetWidth: Double;
        function GetHeight: Double;
        function GetPlayers: TPlayerArray;
        function GetHockeyists: THockeyistArray;
        function GetPuck: TPuck;

        function GetMyPlayer: TPlayer;
        function GetOpponentPlayer: TPlayer;

        destructor Destroy; override;

    end;

    TWorldArray = array of TWorld;

implementation

constructor TWorld.Create(tick: LongInt; tickCount: LongInt; width: Double; height: Double; players: TPlayerArray;
        hockeyists: THockeyistArray; puck: TPuck);
begin
    FTick := tick;
    FTickCount := tickCount;
    FWidth := width;
    FHeight := height;
    if players = nil then
    begin
        FPlayers := nil;
    end
    else
    begin
        FPlayers := Copy(players, 0, Length(players));
    end;
    if hockeyists = nil then
    begin
        FHockeyists := nil;
    end
    else
    begin
        FHockeyists := Copy(hockeyists, 0, Length(hockeyists));
    end;
    FPuck := puck;
end;

function TWorld.GetTick: LongInt;
begin
    result := FTick;
end;

function TWorld.GetTickCount: LongInt;
begin
    result := FTickCount;
end;

function TWorld.GetWidth: Double;
begin
    result := FWidth;
end;

function TWorld.GetHeight: Double;
begin
    result := FHeight;
end;

function TWorld.GetPlayers: TPlayerArray;
begin
    if FPlayers = nil then
    begin
        result := nil;
    end
    else
    begin
        result := Copy(FPlayers, 0, Length(FPlayers));
    end;
end;

function TWorld.GetHockeyists: THockeyistArray;
begin
    if FHockeyists = nil then
    begin
        result := nil;
    end
    else
    begin
        result := Copy(FHockeyists, 0, Length(FHockeyists));
    end;
end;

function TWorld.GetPuck: TPuck;
begin
    result := FPuck;
end;

function TWorld.GetMyPlayer: TPlayer;
var
    playerIndex: LongInt;

begin
    for playerIndex := High(FPlayers) downto 0 do
    begin
        if FPlayers[playerIndex].GetMe then
        begin
            result := FPlayers[playerIndex];
            exit;
        end;
    end;

    result := nil;
end;

function TWorld.GetOpponentPlayer: TPlayer;
var
    playerIndex: LongInt;

begin
    for playerIndex := High(FPlayers) downto 0 do
    begin
        if not FPlayers[playerIndex].GetMe then
        begin
            result := FPlayers[playerIndex];
            exit;
        end;
    end;

    result := nil;
end;

destructor TWorld.Destroy;
var
    i: LongInt;

begin
    if FPlayers <> nil then
    begin
        for i := High(FPlayers) downto 0 do
        begin
            if FPlayers[i] <> nil then
            begin
                FPlayers[i].Free;
            end;
        end;
    end;

    if FHockeyists <> nil then
    begin
        for i := High(FHockeyists) downto 0 do
        begin
            if FHockeyists[i] <> nil then
            begin
                FHockeyists[i].Free;
            end;
        end;
    end;

    if FPuck <> nil then
    begin
        FPuck.Free;
    end;

    inherited;
end;

end.
