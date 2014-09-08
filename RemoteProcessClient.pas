unit RemoteProcessClient;

interface

uses
    HockeyistControl, PlayerContextControl, MoveControl,
    SimpleSocket, SysUtils, PuckControl,
    WorldControl, PlayerControl, GameControl,
    HockeyistTypeControl, HockeyistStateControl, ActionTypeControl;

const
    UNKNOWN_MESSAGE:        LongInt = 0;
    GAME_OVER:              LongInt = 1;
    AUTHENTICATION_TOKEN:   LongInt = 2;
    TEAM_SIZE:              LongInt = 3;
    PROTOCOL_VERSION:       LongInt = 4;
    GAME_CONTEXT:           LongInt = 5;
    PLAYER_CONTEXT:         LongInt = 6;
    MOVES_MESSAGE:          LongInt = 7;

    LITTLE_ENDIAN_BYTE_ORDER = true;
    INTEGER_SIZE_BYTES = sizeof(LongInt);
    LONG_SIZE_BYTES = sizeof(Int64);

type
    TMessageType = LongInt;

    TByteArray = array of Byte;

    TRemoteProcessClient = class
    private
        FSocket: ClientSocket;

        {$HINTS OFF}
        function ReadGame: TGame;
        procedure WriteGame(game: TGame);
        function ReadGames: TGameArray;
        procedure WriteGames(games: TGameArray);
        function ReadHockeyist: THockeyist;
        procedure WriteHockeyist(hockeyist: THockeyist);
        function ReadHockeyists: THockeyistArray;
        procedure WriteHockeyists(hockeyists: THockeyistArray);
        function ReadMove: TMove;
        procedure WriteMove(move: TMove);
        function ReadMoves: TMoveArray;
        procedure WriteMoves(moves: TMoveArray);
        function ReadPlayer: TPlayer;
        procedure WritePlayer(player: TPlayer);
        function ReadPlayers: TPlayerArray;
        procedure WritePlayers(players: TPlayerArray);
        function ReadPlayerContext: TPlayerContext;
        procedure WritePlayerContext(playerContext: TPlayerContext);
        function ReadPlayerContexts: TPlayerContextArray;
        procedure WritePlayerContexts(playerContexts: TPlayerContextArray);
        function ReadPuck: TPuck;
        procedure WritePuck(puck: TPuck);
        function ReadPucks: TPuckArray;
        procedure WritePucks(pucks: TPuckArray);
        function ReadWorld: TWorld;
        procedure WriteWorld(world: TWorld);
        function ReadWorlds: TWorldArray;
        procedure WriteWorlds(worlds: TWorldArray);
        {$HINTS ON}

        procedure EnsureMessageType(actualType: LongInt; expectedType: LongInt);

        function ReadEnum: LongInt;
        procedure WriteEnum(value: LongInt);

        function ReadString: String;
        procedure WriteString(value: String);

        function ReadInt: LongInt;
        procedure WriteInt(value: LongInt);

        function ReadBytes(byteCount: LongInt): TByteArray;
        procedure WriteBytes(bytes: TByteArray);

        function ReadBoolean: Boolean;
        procedure WriteBoolean(value: Boolean);

        function ReadDouble: Double;
        procedure WriteDouble(value: Double);

        function ReadLong: Int64;
        procedure WriteLong(value: Int64);

        function IsLittleEndianMachine: Boolean;

        procedure reverse(var bytes: TByteArray);

    public
        constructor Create(host: String; port: LongInt);

        procedure WriteTokenMessage(token: String);
        function ReadTeamSizeMessage: LongInt;
        procedure WriteProtocolVersionMessage;
        function ReadGameContextMessage: TGame;
        function ReadPlayerContextMessage: TPlayerContext;
        procedure WriteMovesMessage(moves: TMoveArray);

        destructor Destroy; override;

end;

implementation

constructor TRemoteProcessClient.Create(host: String; port: LongInt);
begin
    FSocket := ClientSocket.Create(host, port);
end;

procedure TRemoteProcessClient.EnsureMessageType(actualType: LongInt; expectedType: LongInt);
begin
    if (actualType <> expectedType) then
    begin
        HALT(10001);
    end;
end;

procedure TRemoteProcessClient.WriteTokenMessage(token: String);
begin
    WriteEnum(AUTHENTICATION_TOKEN);
    WriteString(token);
end;

function TRemoteProcessClient.ReadTeamSizeMessage: LongInt;
begin
    EnsureMessageType(ReadEnum, TEAM_SIZE);
    result := ReadInt;
end;

procedure TRemoteProcessClient.WriteProtocolVersionMessage;
begin
    WriteEnum(PROTOCOL_VERSION);
    WriteInt(1);
end;

function TRemoteProcessClient.ReadGameContextMessage: TGame;
begin
    EnsureMessageType(ReadEnum, GAME_CONTEXT);
    result := ReadGame;
end;

function TRemoteProcessClient.ReadPlayerContextMessage: TPlayerContext;
var
    messageType: TMessageType;

begin
    messageType := ReadEnum;
    if messageType = GAME_OVER then
    begin
        result := nil;
        exit;
    end;

    EnsureMessageType(messageType, PLAYER_CONTEXT);
    result := ReadPlayerContext;
end;

procedure TRemoteProcessClient.WriteMovesMessage(moves: TMoveArray);
begin
    WriteEnum(MOVES_MESSAGE);
    WriteMoves(moves);
end;

function TRemoteProcessClient.ReadGame: TGame;
var
    randomSeed: Int64;
    tickCount: LongInt;
    worldWidth: Double;
    worldHeight: Double;
    goalNetTop: Double;
    goalNetWidth: Double;
    goalNetHeight: Double;
    rinkTop: Double;
    rinkLeft: Double;
    rinkBottom: Double;
    rinkRight: Double;
    afterGoalStateTickCount: LongInt;
    overtimeTickCount: LongInt;
    defaultActionCooldownTicks: LongInt;
    swingActionCooldownTicks: LongInt;
    cancelStrikeActionCooldownTicks: LongInt;
    actionCooldownTicksAfterLosingPuck: LongInt;
    stickLength: Double;
    stickSector: Double;
    passSector: Double;
    hockeyistAttributeBaseValue: LongInt;
    minActionChance: Double;
    maxActionChance: Double;
    strikeAngleDeviation: Double;
    passAngleDeviation: Double;
    pickUpPuckBaseChance: Double;
    takePuckAwayBaseChance: Double;
    maxEffectiveSwingTicks: LongInt;
    strikePowerBaseFactor: Double;
    strikePowerGrowthFactor: Double;
    strikePuckBaseChance: Double;
    knockdownChanceFactor: Double;
    knockdownTicksFactor: Double;
    maxSpeedToAllowSubstitute: Double;
    substitutionAreaHeight: Double;
    passPowerFactor: Double;
    hockeyistMaxStamina: Double;
    activeHockeyistStaminaGrowthPerTick: Double;
    restingHockeyistStaminaGrowthPerTick: Double;
    zeroStaminaHockeyistEffectivenessFactor: Double;
    speedUpStaminaCostFactor: Double;
    turnStaminaCostFactor: Double;
    takePuckStaminaCost: Double;
    swingStaminaCost: Double;
    strikeStaminaBaseCost: Double;
    strikeStaminaCostGrowthFactor: Double;
    cancelStrikeStaminaCost: Double;
    passStaminaCost: Double;
    goalieMaxSpeed: Double;
    hockeyistMaxSpeed: Double;
    struckHockeyistInitialSpeedFactor: Double;
    hockeyistSpeedUpFactor: Double;
    hockeyistSpeedDownFactor: Double;
    hockeyistTurnAngleFactor: Double;
    versatileHockeyistStrength: LongInt;
    versatileHockeyistEndurance: LongInt;
    versatileHockeyistDexterity: LongInt;
    versatileHockeyistAgility: LongInt;
    forwardHockeyistStrength: LongInt;
    forwardHockeyistEndurance: LongInt;
    forwardHockeyistDexterity: LongInt;
    forwardHockeyistAgility: LongInt;
    defencemanHockeyistStrength: LongInt;
    defencemanHockeyistEndurance: LongInt;
    defencemanHockeyistDexterity: LongInt;
    defencemanHockeyistAgility: LongInt;
    minRandomHockeyistParameter: LongInt;
    maxRandomHockeyistParameter: LongInt;
    struckPuckInitialSpeedFactor: Double;
    puckBindingRange: Double;

begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    randomSeed := ReadLong;
    tickCount := ReadInt;
    worldWidth := ReadDouble;
    worldHeight := ReadDouble;
    goalNetTop := ReadDouble;
    goalNetWidth := ReadDouble;
    goalNetHeight := ReadDouble;
    rinkTop := ReadDouble;
    rinkLeft := ReadDouble;
    rinkBottom := ReadDouble;
    rinkRight := ReadDouble;
    afterGoalStateTickCount := ReadInt;
    overtimeTickCount := ReadInt;
    defaultActionCooldownTicks := ReadInt;
    swingActionCooldownTicks := ReadInt;
    cancelStrikeActionCooldownTicks := ReadInt;
    actionCooldownTicksAfterLosingPuck := ReadInt;
    stickLength := ReadDouble;
    stickSector := ReadDouble;
    passSector := ReadDouble;
    hockeyistAttributeBaseValue := ReadInt;
    minActionChance := ReadDouble;
    maxActionChance := ReadDouble;
    strikeAngleDeviation := ReadDouble;
    passAngleDeviation := ReadDouble;
    pickUpPuckBaseChance := ReadDouble;
    takePuckAwayBaseChance := ReadDouble;
    maxEffectiveSwingTicks := ReadInt;
    strikePowerBaseFactor := ReadDouble;
    strikePowerGrowthFactor := ReadDouble;
    strikePuckBaseChance := ReadDouble;
    knockdownChanceFactor := ReadDouble;
    knockdownTicksFactor := ReadDouble;
    maxSpeedToAllowSubstitute := ReadDouble;
    substitutionAreaHeight := ReadDouble;
    passPowerFactor := ReadDouble;
    hockeyistMaxStamina := ReadDouble;
    activeHockeyistStaminaGrowthPerTick := ReadDouble;
    restingHockeyistStaminaGrowthPerTick := ReadDouble;
    zeroStaminaHockeyistEffectivenessFactor := ReadDouble;
    speedUpStaminaCostFactor := ReadDouble;
    turnStaminaCostFactor := ReadDouble;
    takePuckStaminaCost := ReadDouble;
    swingStaminaCost := ReadDouble;
    strikeStaminaBaseCost := ReadDouble;
    strikeStaminaCostGrowthFactor := ReadDouble;
    cancelStrikeStaminaCost := ReadDouble;
    passStaminaCost := ReadDouble;
    goalieMaxSpeed := ReadDouble;
    hockeyistMaxSpeed := ReadDouble;
    struckHockeyistInitialSpeedFactor := ReadDouble;
    hockeyistSpeedUpFactor := ReadDouble;
    hockeyistSpeedDownFactor := ReadDouble;
    hockeyistTurnAngleFactor := ReadDouble;
    versatileHockeyistStrength := ReadInt;
    versatileHockeyistEndurance := ReadInt;
    versatileHockeyistDexterity := ReadInt;
    versatileHockeyistAgility := ReadInt;
    forwardHockeyistStrength := ReadInt;
    forwardHockeyistEndurance := ReadInt;
    forwardHockeyistDexterity := ReadInt;
    forwardHockeyistAgility := ReadInt;
    defencemanHockeyistStrength := ReadInt;
    defencemanHockeyistEndurance := ReadInt;
    defencemanHockeyistDexterity := ReadInt;
    defencemanHockeyistAgility := ReadInt;
    minRandomHockeyistParameter := ReadInt;
    maxRandomHockeyistParameter := ReadInt;
    struckPuckInitialSpeedFactor := ReadDouble;
    puckBindingRange := ReadDouble;

    result := TGame.Create(randomSeed, tickCount, worldWidth, worldHeight, goalNetTop, goalNetWidth, goalNetHeight,
            rinkTop, rinkLeft, rinkBottom, rinkRight, afterGoalStateTickCount, overtimeTickCount,
            defaultActionCooldownTicks, swingActionCooldownTicks, cancelStrikeActionCooldownTicks,
            actionCooldownTicksAfterLosingPuck, stickLength, stickSector, passSector, hockeyistAttributeBaseValue,
            minActionChance, maxActionChance, strikeAngleDeviation, passAngleDeviation, pickUpPuckBaseChance,
            takePuckAwayBaseChance, maxEffectiveSwingTicks, strikePowerBaseFactor, strikePowerGrowthFactor,
            strikePuckBaseChance, knockdownChanceFactor, knockdownTicksFactor, maxSpeedToAllowSubstitute,
            substitutionAreaHeight, passPowerFactor, hockeyistMaxStamina, activeHockeyistStaminaGrowthPerTick,
            restingHockeyistStaminaGrowthPerTick, zeroStaminaHockeyistEffectivenessFactor, speedUpStaminaCostFactor,
            turnStaminaCostFactor, takePuckStaminaCost, swingStaminaCost, strikeStaminaBaseCost,
            strikeStaminaCostGrowthFactor, cancelStrikeStaminaCost, passStaminaCost, goalieMaxSpeed, hockeyistMaxSpeed,
            struckHockeyistInitialSpeedFactor, hockeyistSpeedUpFactor, hockeyistSpeedDownFactor,
            hockeyistTurnAngleFactor, versatileHockeyistStrength, versatileHockeyistEndurance,
            versatileHockeyistDexterity, versatileHockeyistAgility, forwardHockeyistStrength, forwardHockeyistEndurance,
            forwardHockeyistDexterity, forwardHockeyistAgility, defencemanHockeyistStrength,
            defencemanHockeyistEndurance, defencemanHockeyistDexterity, defencemanHockeyistAgility,
            minRandomHockeyistParameter, maxRandomHockeyistParameter, struckPuckInitialSpeedFactor, puckBindingRange);
end;

procedure TRemoteProcessClient.WriteGame(game: TGame);
begin
    if game = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteLong(game.GetRandomSeed);
    WriteInt(game.GetTickCount);
    WriteDouble(game.GetWorldWidth);
    WriteDouble(game.GetWorldHeight);
    WriteDouble(game.GetGoalNetTop);
    WriteDouble(game.GetGoalNetWidth);
    WriteDouble(game.GetGoalNetHeight);
    WriteDouble(game.GetRinkTop);
    WriteDouble(game.GetRinkLeft);
    WriteDouble(game.GetRinkBottom);
    WriteDouble(game.GetRinkRight);
    WriteInt(game.GetAfterGoalStateTickCount);
    WriteInt(game.GetOvertimeTickCount);
    WriteInt(game.GetDefaultActionCooldownTicks);
    WriteInt(game.GetSwingActionCooldownTicks);
    WriteInt(game.GetCancelStrikeActionCooldownTicks);
    WriteInt(game.GetActionCooldownTicksAfterLosingPuck);
    WriteDouble(game.GetStickLength);
    WriteDouble(game.GetStickSector);
    WriteDouble(game.GetPassSector);
    WriteInt(game.GetHockeyistAttributeBaseValue);
    WriteDouble(game.GetMinActionChance);
    WriteDouble(game.GetMaxActionChance);
    WriteDouble(game.GetStrikeAngleDeviation);
    WriteDouble(game.GetPassAngleDeviation);
    WriteDouble(game.GetPickUpPuckBaseChance);
    WriteDouble(game.GetTakePuckAwayBaseChance);
    WriteInt(game.GetMaxEffectiveSwingTicks);
    WriteDouble(game.GetStrikePowerBaseFactor);
    WriteDouble(game.GetStrikePowerGrowthFactor);
    WriteDouble(game.GetStrikePuckBaseChance);
    WriteDouble(game.GetKnockdownChanceFactor);
    WriteDouble(game.GetKnockdownTicksFactor);
    WriteDouble(game.GetMaxSpeedToAllowSubstitute);
    WriteDouble(game.GetSubstitutionAreaHeight);
    WriteDouble(game.GetPassPowerFactor);
    WriteDouble(game.GetHockeyistMaxStamina);
    WriteDouble(game.GetActiveHockeyistStaminaGrowthPerTick);
    WriteDouble(game.GetRestingHockeyistStaminaGrowthPerTick);
    WriteDouble(game.GetZeroStaminaHockeyistEffectivenessFactor);
    WriteDouble(game.GetSpeedUpStaminaCostFactor);
    WriteDouble(game.GetTurnStaminaCostFactor);
    WriteDouble(game.GetTakePuckStaminaCost);
    WriteDouble(game.GetSwingStaminaCost);
    WriteDouble(game.GetStrikeStaminaBaseCost);
    WriteDouble(game.GetStrikeStaminaCostGrowthFactor);
    WriteDouble(game.GetCancelStrikeStaminaCost);
    WriteDouble(game.GetPassStaminaCost);
    WriteDouble(game.GetGoalieMaxSpeed);
    WriteDouble(game.GetHockeyistMaxSpeed);
    WriteDouble(game.GetStruckHockeyistInitialSpeedFactor);
    WriteDouble(game.GetHockeyistSpeedUpFactor);
    WriteDouble(game.GetHockeyistSpeedDownFactor);
    WriteDouble(game.GetHockeyistTurnAngleFactor);
    WriteInt(game.GetVersatileHockeyistStrength);
    WriteInt(game.GetVersatileHockeyistEndurance);
    WriteInt(game.GetVersatileHockeyistDexterity);
    WriteInt(game.GetVersatileHockeyistAgility);
    WriteInt(game.GetForwardHockeyistStrength);
    WriteInt(game.GetForwardHockeyistEndurance);
    WriteInt(game.GetForwardHockeyistDexterity);
    WriteInt(game.GetForwardHockeyistAgility);
    WriteInt(game.GetDefencemanHockeyistStrength);
    WriteInt(game.GetDefencemanHockeyistEndurance);
    WriteInt(game.GetDefencemanHockeyistDexterity);
    WriteInt(game.GetDefencemanHockeyistAgility);
    WriteInt(game.GetMinRandomHockeyistParameter);
    WriteInt(game.GetMaxRandomHockeyistParameter);
    WriteDouble(game.GetStruckPuckInitialSpeedFactor);
    WriteDouble(game.GetPuckBindingRange);
end;

function TRemoteProcessClient.ReadGames: TGameArray;
var
    gameIndex: LongInt;
    gameCount: LongInt;

begin
    gameCount := ReadInt;
    if gameCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, gameCount);

    for gameIndex := 0 to gameCount - 1 do
    begin
        result[gameIndex] := ReadGame;
    end;
end;

procedure TRemoteProcessClient.WriteGames(games: TGameArray);
var
    gameIndex: LongInt;
    gameCount: LongInt;

begin
    if games = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    gameCount := Length(games);
    WriteInt(gameCount);

    for gameIndex := 0 to gameCount - 1 do
    begin
        WriteGame(games[gameIndex]);
    end;
end;

function TRemoteProcessClient.ReadHockeyist: THockeyist;
var
    id: Int64;
    playerId: Int64;
    teammateIndex: LongInt;
    mass: Double;
    radius: Double;
    x: Double;
    y: Double;
    speedX: Double;
    speedY: Double;
    angle: Double;
    angularSpeed: Double;
    teammate: Boolean;
    hockeyistType: THockeyistType;
    strength: LongInt;
    endurance: LongInt;
    dexterity: LongInt;
    agility: LongInt;
    stamina: Double;
    state: THockeyistState;
    originalPositionIndex: LongInt;
    remainingKnockdownTicks: LongInt;
    remainingCooldownTicks: LongInt;
    swingTicks: LongInt;
    lastAction: TActionType;
    lastActionTick: LongInt;

begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    id := ReadLong;
    playerId := ReadLong;
    teammateIndex := ReadInt;
    mass := ReadDouble;
    radius := ReadDouble;
    x := ReadDouble;
    y := ReadDouble;
    speedX := ReadDouble;
    speedY := ReadDouble;
    angle := ReadDouble;
    angularSpeed := ReadDouble;
    teammate := ReadBoolean;
    hockeyistType := ReadEnum;
    strength := ReadInt;
    endurance := ReadInt;
    dexterity := ReadInt;
    agility := ReadInt;
    stamina := ReadDouble;
    state := ReadEnum;
    originalPositionIndex := ReadInt;
    remainingKnockdownTicks := ReadInt;
    remainingCooldownTicks := ReadInt;
    swingTicks := ReadInt;
    lastAction := ReadEnum;
    if ReadBoolean then
    begin
        lastActionTick := ReadInt;
    end
    else
    begin
        lastActionTick := -1;
    end;

    result := THockeyist.Create(id, playerId, teammateIndex, mass, radius, x, y, speedX, speedY, angle, angularSpeed,
            teammate, hockeyistType, strength, endurance, dexterity, agility, stamina, state, originalPositionIndex,
            remainingKnockdownTicks, remainingCooldownTicks, swingTicks, lastAction, lastActionTick);
end;

procedure TRemoteProcessClient.WriteHockeyist(hockeyist: THockeyist);
begin
    if hockeyist = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteLong(hockeyist.GetId);
    WriteLong(hockeyist.GetPlayerId);
    WriteInt(hockeyist.GetTeammateIndex);
    WriteDouble(hockeyist.GetMass);
    WriteDouble(hockeyist.GetRadius);
    WriteDouble(hockeyist.GetX);
    WriteDouble(hockeyist.GetY);
    WriteDouble(hockeyist.GetSpeedX);
    WriteDouble(hockeyist.GetSpeedY);
    WriteDouble(hockeyist.GetAngle);
    WriteDouble(hockeyist.GetAngularSpeed);
    WriteBoolean(hockeyist.GetTeammate);
    WriteEnum(hockeyist.GetType);
    WriteInt(hockeyist.GetStrength);
    WriteInt(hockeyist.GetEndurance);
    WriteInt(hockeyist.GetDexterity);
    WriteInt(hockeyist.GetAgility);
    WriteDouble(hockeyist.GetStamina);
    WriteEnum(hockeyist.GetState);
    WriteInt(hockeyist.GetOriginalPositionIndex);
    WriteInt(hockeyist.GetRemainingKnockdownTicks);
    WriteInt(hockeyist.GetRemainingCooldownTicks);
    WriteInt(hockeyist.GetSwingTicks);
    WriteEnum(hockeyist.GetLastAction);
    if hockeyist.GetLastActionTick = -1 then
    begin
        WriteBoolean(false);
    end
    else
    begin
        WriteBoolean(true);
        WriteInt(hockeyist.GetLastActionTick);
    end;
end;

function TRemoteProcessClient.ReadHockeyists: THockeyistArray;
var
    hockeyistIndex: LongInt;
    hockeyistCount: LongInt;

begin
    hockeyistCount := ReadInt;
    if hockeyistCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, hockeyistCount);

    for hockeyistIndex := 0 to hockeyistCount - 1 do
    begin
        result[hockeyistIndex] := ReadHockeyist;
    end;
end;

procedure TRemoteProcessClient.WriteHockeyists(hockeyists: THockeyistArray);
var
    hockeyistIndex: LongInt;
    hockeyistCount: LongInt;

begin
    if hockeyists = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    hockeyistCount := Length(hockeyists);
    WriteInt(hockeyistCount);

    for hockeyistIndex := 0 to hockeyistCount - 1 do
    begin
        WriteHockeyist(hockeyists[hockeyistIndex]);
    end;
end;

function TRemoteProcessClient.ReadMove: TMove;
begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    result := TMove.Create;

    result.SetSpeedUp(ReadDouble);
    result.SetTurn(ReadDouble);
    result.SetAction(ReadEnum);
    if result.GetAction = PASS then
    begin
        result.SetPassPower(ReadDouble);
        result.SetPassAngle(ReadDouble);
    end
    else if result.GetAction = SUBSTITUTE then
    begin
        result.SetTeammateIndex(ReadInt);
    end;
end;

procedure TRemoteProcessClient.WriteMove(move: TMove);
begin
    if move = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteDouble(move.GetSpeedUp);
    WriteDouble(move.GetTurn);
    WriteEnum(move.GetAction);
    if move.GetAction = PASS then
    begin
        WriteDouble(move.GetPassPower);
        WriteDouble(move.GetPassAngle);
    end
    else if move.GetAction = SUBSTITUTE then
    begin
        WriteInt(move.GetTeammateIndex);
    end;
end;

function TRemoteProcessClient.ReadMoves: TMoveArray;
var
    moveIndex: LongInt;
    moveCount: LongInt;

begin
    moveCount := ReadInt;
    if moveCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, moveCount);

    for moveIndex := 0 to moveCount - 1 do
    begin
        result[moveIndex] := ReadMove;
    end;
end;

procedure TRemoteProcessClient.WriteMoves(moves: TMoveArray);
var
    moveIndex: LongInt;
    moveCount: LongInt;

begin
    if moves = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    moveCount := Length(moves);
    WriteInt(moveCount);

    for moveIndex := 0 to moveCount - 1 do
    begin
        WriteMove(moves[moveIndex]);
    end;
end;

function TRemoteProcessClient.ReadPlayer: TPlayer;
var
    id: Int64;
    me: Boolean;
    name: String;
    goalCount: LongInt;
    strategyCrashed: Boolean;
    netTop: Double;
    netLeft: Double;
    netBottom: Double;
    netRight: Double;
    netFront: Double;
    netBack: Double;
    justScoredGoal: Boolean;
    justMissedGoal: Boolean;

begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    id := ReadLong;
    me := ReadBoolean;
    name := ReadString;
    goalCount := ReadInt;
    strategyCrashed := ReadBoolean;
    netTop := ReadDouble;
    netLeft := ReadDouble;
    netBottom := ReadDouble;
    netRight := ReadDouble;
    netFront := ReadDouble;
    netBack := ReadDouble;
    justScoredGoal := ReadBoolean;
    justMissedGoal := ReadBoolean;

    result := TPlayer.Create(id, me, name, goalCount, strategyCrashed, netTop, netLeft, netBottom, netRight, netFront,
            netBack, justScoredGoal, justMissedGoal);
end;

procedure TRemoteProcessClient.WritePlayer(player: TPlayer);
begin
    if player = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteLong(player.GetId);
    WriteBoolean(player.GetMe);
    WriteString(player.GetName);
    WriteInt(player.GetGoalCount);
    WriteBoolean(player.GetStrategyCrashed);
    WriteDouble(player.GetNetTop);
    WriteDouble(player.GetNetLeft);
    WriteDouble(player.GetNetBottom);
    WriteDouble(player.GetNetRight);
    WriteDouble(player.GetNetFront);
    WriteDouble(player.GetNetBack);
    WriteBoolean(player.GetJustScoredGoal);
    WriteBoolean(player.GetJustMissedGoal);
end;

function TRemoteProcessClient.ReadPlayers: TPlayerArray;
var
    playerIndex: LongInt;
    playerCount: LongInt;

begin
    playerCount := ReadInt;
    if playerCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, playerCount);

    for playerIndex := 0 to playerCount - 1 do
    begin
        result[playerIndex] := ReadPlayer;
    end;
end;

procedure TRemoteProcessClient.WritePlayers(players: TPlayerArray);
var
    playerIndex: LongInt;
    playerCount: LongInt;

begin
    if players = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    playerCount := Length(players);
    WriteInt(playerCount);

    for playerIndex := 0 to playerCount - 1 do
    begin
        WritePlayer(players[playerIndex]);
    end;
end;

function TRemoteProcessClient.ReadPlayerContext: TPlayerContext;
var
    hockeyists: THockeyistArray;
    world: TWorld;

begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    hockeyists := ReadHockeyists;
    world := ReadWorld;

    result := TPlayerContext.Create(hockeyists, world);
end;

procedure TRemoteProcessClient.WritePlayerContext(playerContext: TPlayerContext);
begin
    if playerContext = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteHockeyists(playerContext.GetHockeyists);
    WriteWorld(playerContext.GetWorld);
end;

function TRemoteProcessClient.ReadPlayerContexts: TPlayerContextArray;
var
    playerContextIndex: LongInt;
    playerContextCount: LongInt;

begin
    playerContextCount := ReadInt;
    if playerContextCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, playerContextCount);

    for playerContextIndex := 0 to playerContextCount - 1 do
    begin
        result[playerContextIndex] := ReadPlayerContext;
    end;
end;

procedure TRemoteProcessClient.WritePlayerContexts(playerContexts: TPlayerContextArray);
var
    playerContextIndex: LongInt;
    playerContextCount: LongInt;

begin
    if playerContexts = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    playerContextCount := Length(playerContexts);
    WriteInt(playerContextCount);

    for playerContextIndex := 0 to playerContextCount - 1 do
    begin
        WritePlayerContext(playerContexts[playerContextIndex]);
    end;
end;

function TRemoteProcessClient.ReadPuck: TPuck;
var
    id: Int64;
    mass: Double;
    radius: Double;
    x: Double;
    y: Double;
    speedX: Double;
    speedY: Double;
    ownerHockeyistId: Int64;
    ownerPlayerId: Int64;

begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    id := ReadLong;
    mass := ReadDouble;
    radius := ReadDouble;
    x := ReadDouble;
    y := ReadDouble;
    speedX := ReadDouble;
    speedY := ReadDouble;
    ownerHockeyistId := ReadLong;
    ownerPlayerId := ReadLong;

    result := TPuck.Create(id, mass, radius, x, y, speedX, speedY, ownerHockeyistId, ownerPlayerId);
end;

procedure TRemoteProcessClient.WritePuck(puck: TPuck);
begin
    if puck = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteLong(puck.GetId);
    WriteDouble(puck.GetMass);
    WriteDouble(puck.GetRadius);
    WriteDouble(puck.GetX);
    WriteDouble(puck.GetY);
    WriteDouble(puck.GetSpeedX);
    WriteDouble(puck.GetSpeedY);
    WriteLong(puck.GetOwnerHockeyistId);
    WriteLong(puck.GetOwnerPlayerId);
end;

function TRemoteProcessClient.ReadPucks: TPuckArray;
var
    puckIndex: LongInt;
    puckCount: LongInt;

begin
    puckCount := ReadInt;
    if puckCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, puckCount);

    for puckIndex := 0 to puckCount - 1 do
    begin
        result[puckIndex] := ReadPuck;
    end;
end;

procedure TRemoteProcessClient.WritePucks(pucks: TPuckArray);
var
    puckIndex: LongInt;
    puckCount: LongInt;

begin
    if pucks = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    puckCount := Length(pucks);
    WriteInt(puckCount);

    for puckIndex := 0 to puckCount - 1 do
    begin
        WritePuck(pucks[puckIndex]);
    end;
end;

function TRemoteProcessClient.ReadWorld: TWorld;
var
    tick: LongInt;
    tickCount: LongInt;
    width: Double;
    height: Double;
    players: TPlayerArray;
    hockeyists: THockeyistArray;
    puck: TPuck;

begin
    if not ReadBoolean then
    begin
        result := nil;
        exit;
    end;

    tick := ReadInt;
    tickCount := ReadInt;
    width := ReadDouble;
    height := ReadDouble;
    players := ReadPlayers;
    hockeyists := ReadHockeyists;
    puck := ReadPuck;

    result := TWorld.Create(tick, tickCount, width, height, players, hockeyists, puck);
end;

procedure TRemoteProcessClient.WriteWorld(world: TWorld);
begin
    if world = nil then
    begin
        WriteBoolean(false);
        exit;
    end;

    WriteBoolean(true);

    WriteInt(world.GetTick);
    WriteInt(world.GetTickCount);
    WriteDouble(world.GetWidth);
    WriteDouble(world.GetHeight);
    WritePlayers(world.GetPlayers);
    WriteHockeyists(world.GetHockeyists);
    WritePuck(world.GetPuck);
end;

function TRemoteProcessClient.ReadWorlds: TWorldArray;
var
    worldIndex: LongInt;
    worldCount: LongInt;

begin
    worldCount := ReadInt;
    if worldCount < 0 then
    begin
        result := nil;
        exit;
    end;

    SetLength(result, worldCount);

    for worldIndex := 0 to worldCount - 1 do
    begin
        result[worldIndex] := ReadWorld;
    end;
end;

procedure TRemoteProcessClient.WriteWorlds(worlds: TWorldArray);
var
    worldIndex: LongInt;
    worldCount: LongInt;

begin
    if worlds = nil then
    begin
        WriteInt(-1);
        exit;
    end;

    worldCount := Length(worlds);
    WriteInt(worldCount);

    for worldIndex := 0 to worldCount - 1 do
    begin
        WriteWorld(worlds[worldIndex]);
    end;
end;

procedure TRemoteProcessClient.WriteEnum(value: LongInt);
var
    bytes: TByteArray;

begin
    SetLength(bytes, 1);
    bytes[0] := value;
    WriteBytes(bytes);
    Finalize(bytes);
end;

function TRemoteProcessClient.ReadEnum: TMessageType;
var
    bytes: TByteArray;

begin
    bytes := ReadBytes(1);
    result := bytes[0];
    Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteBytes(bytes: TByteArray);
begin
    FSocket.StrictSend(bytes, Length(bytes));
end;

function TRemoteProcessClient.ReadBytes(byteCount: LongInt): TByteArray;  
var
    bytes: TByteArray;

begin
    SetLength(bytes, byteCount);
    FSocket.StrictReceive(bytes, byteCount);
    result := bytes;
end;

procedure TRemoteProcessClient.WriteString(value: String);
var
    len, i: LongInt;
    bytes: TByteArray;

begin
    len := Length(value);
    SetLength(bytes, len);
    for i := 1 to len do
    begin
        bytes[i - 1] := Ord(value[i]);
    end;

    WriteInt(len);
    WriteBytes(bytes);
    Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteBoolean(value: Boolean);
var
    bytes: TByteArray;

begin
    SetLength(bytes, 1);
    bytes[0] := ord(value);
    WriteBytes(bytes);
    Finalize(bytes);
end;

function TRemoteProcessClient.ReadBoolean: Boolean;
var
    bytes: TByteArray;

begin
    bytes := ReadBytes(1);
    result := (bytes[0] <> 0);
    Finalize(bytes);
end;

function TRemoteProcessClient.ReadString: String;
var
    len, i: LongInt;
    bytes: TByteArray;
    res: String;

begin
    len := ReadInt;
    if len = -1 then
    begin
        HALT(10014);
    end;

    res := '';
    bytes := ReadBytes(len);
    for i := 0 to len - 1 do
    begin
        res := res + Chr(bytes[i]);
    end;
    
    Finalize(bytes);
    result := res;
end;

procedure TRemoteProcessClient.WriteDouble(value: Double);
var
    pl: ^Int64;
    pd: ^Double;
    p: Pointer;

begin
    New(pd);
    pd^ := value;
    p := pd;
    pl := p;
    WriteLong(pl^);
    Dispose(pd);
end;

function TRemoteProcessClient.ReadDouble: Double;
var
    pl: ^Int64;
    pd: ^Double;
    p: Pointer;
    
begin
    New(pl);
    pl^ := ReadLong;
    p := pl;
    pd := p;
    result := pd^;
    Dispose(pl);
end;

procedure TRemoteProcessClient.WriteInt(value: LongInt);
var
    bytes: TByteArray;
    i: LongInt;
    
begin
    SetLength(bytes, INTEGER_SIZE_BYTES);
    for i := 0 to INTEGER_SIZE_BYTES - 1 do begin
        bytes[i] := (value shr ({24 -} i * 8)) and 255;
    end;

    if (IsLittleEndianMachine <> LITTLE_ENDIAN_BYTE_ORDER) then begin
        Reverse(bytes);
    end;

    WriteBytes(bytes);
    Finalize(bytes);
end;

function TRemoteProcessClient.ReadInt: LongInt;
var
    bytes: TByteArray;
    res: LongInt;
    i: LongInt;
    
begin
    res := 0;
    bytes := readBytes(INTEGER_SIZE_BYTES);
    for i := INTEGER_SIZE_BYTES - 1 downto 0 do begin
        res := (res shl 8) or bytes[i];
    end;
        
    Finalize(bytes);
    result := res;
end;

function TRemoteProcessClient.ReadLong: Int64;
var
    bytes: TByteArray;
    res: Int64;
    i: LongInt;
    
begin
    res := 0;
    bytes := readBytes(LONG_SIZE_BYTES);
    for i := LONG_SIZE_BYTES - 1 downto 0 do
    begin
        res := (res shl 8) or bytes[i];
    end;
        
    Finalize(bytes);
    result := res;
end;

procedure TRemoteProcessClient.WriteLong(value: Int64);
var
    bytes: TByteArray;
    i: LongInt;
    
begin
    SetLength(bytes, LONG_SIZE_BYTES);
    for i := 0 to LONG_SIZE_BYTES - 1 do begin
        bytes[i] := (value shr ({24 -} i*8)) and 255;
    end;

    if (IsLittleEndianMachine <> LITTLE_ENDIAN_BYTE_ORDER) then
    begin
        Reverse(bytes);
    end;

    WriteBytes(bytes);
    Finalize(bytes);
end;

function TRemoteProcessClient.IsLittleEndianMachine: Boolean;
begin
    result := true;
end;

procedure TRemoteProcessClient.reverse(var bytes: TByteArray);
var
    i, len: LongInt;
    buffer: Byte;

begin
    len := Length(bytes);
    for i := 0 to (len div 2) do
    begin
        buffer := bytes[i];
        bytes[i] := bytes[len - i - 1];
        bytes[len - i - 1] := buffer;
    end;
end;

destructor TRemoteProcessClient.Destroy;
begin
    FSocket.Free;
end;

end.
