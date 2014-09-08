uses
    SysUtils, RemoteProcessClient, StrategyControl, MyStrategy,
    HockeyistControl, PlayerContextControl, MoveControl, GameControl;

type
    TRunner = class
    private
        FRemoteProcessClient: TRemoteProcessClient;
        FToken: String;

    public
        constructor Create(arguments: array of String);

        procedure Run;

        destructor Destroy; override;

    end;

constructor TRunner.Create(arguments: array of String);
begin
    if Length(arguments) = 4 then
    begin
        FRemoteProcessClient := TRemoteProcessClient.Create(arguments[1], StrToInt(arguments[2]));
        FToken := arguments[3];
    end
    else
    begin
        FRemoteProcessClient := TRemoteProcessClient.Create('127.0.0.1', 31001);
        FToken := '0000000000000000';
    end;
end;

procedure TRunner.Run;
var
    teamSize: LongInt;
    hockeyistIndex: LongInt;
    strategyIndex: LongInt;
    strategies: array of TStrategy;
    playerHockeyist: THockeyist;
    playerHockeyists: THockeyistArray;
    playerContext: TPlayerContext;
    move: TMove;
    moves: TMoveArray;
    game: TGame;

begin
    FRemoteProcessClient.WriteTokenMessage(FToken);
    teamSize := FRemoteProcessClient.ReadTeamSizeMessage;
    FRemoteProcessClient.WriteProtocolVersionMessage;
    game := FRemoteProcessClient.ReadGameContextMessage;

    SetLength(strategies, teamSize);

    for strategyIndex := 0 to teamSize - 1 do
    begin
        strategies[strategyIndex] := TMyStrategy.Create;
    end;

    while true do
    begin
        playerContext := FRemoteProcessClient.ReadPlayerContextMessage;
        if playerContext = nil then
        begin
            break;
        end;

        playerHockeyists := playerContext.GetHockeyists;
        if Length(playerHockeyists) <> teamSize then
        begin
            break;
        end;

        SetLength(moves, teamSize);

        for hockeyistIndex := 0 to teamSize - 1 do
        begin
            playerHockeyist := playerHockeyists[hockeyistIndex];

            move := TMove.Create;
            moves[hockeyistIndex] := move;
            strategies[playerHockeyist.GetTeammateIndex].Move(playerHockeyist, playerContext.GetWorld, game, move);
        end;

        FRemoteProcessClient.WriteMovesMessage(moves);

        for hockeyistIndex := 0 to teamSize - 1 do
        begin
            moves[hockeyistIndex].Free;
        end;

        SetLength(moves, 0);

        playerContext.Free;
    end;

    for strategyIndex := 0 to teamSize - 1 do
    begin
        strategies[strategyIndex].Free;
    end;

    SetLength(strategies, 0);
end;

destructor TRunner.Destroy;
begin
    FRemoteProcessClient.Free;

    inherited;
end;

var
    i: LongInt;
    runner: TRunner;
    arguments: array of String;

begin
    try
        SetLength(arguments, paramCount + 1);

        for i := 0 to paramCount do
        begin
            arguments[i] := ParamStr(i);
        end;

        runner := TRunner.Create(arguments);
        runner.Run;
        runner.Free;

        SetLength(arguments, 0);
    except
        on E: Exception do
        begin
            WriteLn('Exception occured: type=', E.ClassName, ', message="', E.Message, '".');
            HALT(239);
        end;
    end;
end.
