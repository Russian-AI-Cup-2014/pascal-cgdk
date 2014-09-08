unit GameControl;

interface

uses
    Math;

type
    TGame = class
    private
        FRandomSeed: Int64;
        FTickCount: LongInt;
        FWorldWidth: Double;
        FWorldHeight: Double;
        FGoalNetTop: Double;
        FGoalNetWidth: Double;
        FGoalNetHeight: Double;
        FRinkTop: Double;
        FRinkLeft: Double;
        FRinkBottom: Double;
        FRinkRight: Double;
        FAfterGoalStateTickCount: LongInt;
        FOvertimeTickCount: LongInt;
        FDefaultActionCooldownTicks: LongInt;
        FSwingActionCooldownTicks: LongInt;
        FCancelStrikeActionCooldownTicks: LongInt;
        FActionCooldownTicksAfterLosingPuck: LongInt;
        FStickLength: Double;
        FStickSector: Double;
        FPassSector: Double;
        FHockeyistAttributeBaseValue: LongInt;
        FMinActionChance: Double;
        FMaxActionChance: Double;
        FStrikeAngleDeviation: Double;
        FPassAngleDeviation: Double;
        FPickUpPuckBaseChance: Double;
        FTakePuckAwayBaseChance: Double;
        FMaxEffectiveSwingTicks: LongInt;
        FStrikePowerBaseFactor: Double;
        FStrikePowerGrowthFactor: Double;
        FStrikePuckBaseChance: Double;
        FKnockdownChanceFactor: Double;
        FKnockdownTicksFactor: Double;
        FMaxSpeedToAllowSubstitute: Double;
        FSubstitutionAreaHeight: Double;
        FPassPowerFactor: Double;
        FHockeyistMaxStamina: Double;
        FActiveHockeyistStaminaGrowthPerTick: Double;
        FRestingHockeyistStaminaGrowthPerTick: Double;
        FZeroStaminaHockeyistEffectivenessFactor: Double;
        FSpeedUpStaminaCostFactor: Double;
        FTurnStaminaCostFactor: Double;
        FTakePuckStaminaCost: Double;
        FSwingStaminaCost: Double;
        FStrikeStaminaBaseCost: Double;
        FStrikeStaminaCostGrowthFactor: Double;
        FCancelStrikeStaminaCost: Double;
        FPassStaminaCost: Double;
        FGoalieMaxSpeed: Double;
        FHockeyistMaxSpeed: Double;
        FStruckHockeyistInitialSpeedFactor: Double;
        FHockeyistSpeedUpFactor: Double;
        FHockeyistSpeedDownFactor: Double;
        FHockeyistTurnAngleFactor: Double;
        FVersatileHockeyistStrength: LongInt;
        FVersatileHockeyistEndurance: LongInt;
        FVersatileHockeyistDexterity: LongInt;
        FVersatileHockeyistAgility: LongInt;
        FForwardHockeyistStrength: LongInt;
        FForwardHockeyistEndurance: LongInt;
        FForwardHockeyistDexterity: LongInt;
        FForwardHockeyistAgility: LongInt;
        FDefencemanHockeyistStrength: LongInt;
        FDefencemanHockeyistEndurance: LongInt;
        FDefencemanHockeyistDexterity: LongInt;
        FDefencemanHockeyistAgility: LongInt;
        FMinRandomHockeyistParameter: LongInt;
        FMaxRandomHockeyistParameter: LongInt;
        FStruckPuckInitialSpeedFactor: Double;
        FPuckBindingRange: Double;

    public
        constructor Create(randomSeed: Int64; tickCount: LongInt; worldWidth: Double; worldHeight: Double;
                goalNetTop: Double; goalNetWidth: Double; goalNetHeight: Double; rinkTop: Double; rinkLeft: Double;
                rinkBottom: Double; rinkRight: Double; afterGoalStateTickCount: LongInt; overtimeTickCount: LongInt;
                defaultActionCooldownTicks: LongInt; swingActionCooldownTicks: LongInt;
                cancelStrikeActionCooldownTicks: LongInt; actionCooldownTicksAfterLosingPuck: LongInt;
                stickLength: Double; stickSector: Double; passSector: Double; hockeyistAttributeBaseValue: LongInt;
                minActionChance: Double; maxActionChance: Double; strikeAngleDeviation: Double;
                passAngleDeviation: Double; pickUpPuckBaseChance: Double; takePuckAwayBaseChance: Double;
                maxEffectiveSwingTicks: LongInt; strikePowerBaseFactor: Double; strikePowerGrowthFactor: Double;
                strikePuckBaseChance: Double; knockdownChanceFactor: Double; knockdownTicksFactor: Double;
                maxSpeedToAllowSubstitute: Double; substitutionAreaHeight: Double; passPowerFactor: Double;
                hockeyistMaxStamina: Double; activeHockeyistStaminaGrowthPerTick: Double;
                restingHockeyistStaminaGrowthPerTick: Double; zeroStaminaHockeyistEffectivenessFactor: Double;
                speedUpStaminaCostFactor: Double; turnStaminaCostFactor: Double; takePuckStaminaCost: Double;
                swingStaminaCost: Double; strikeStaminaBaseCost: Double; strikeStaminaCostGrowthFactor: Double;
                cancelStrikeStaminaCost: Double; passStaminaCost: Double; goalieMaxSpeed: Double;
                hockeyistMaxSpeed: Double; struckHockeyistInitialSpeedFactor: Double; hockeyistSpeedUpFactor: Double;
                hockeyistSpeedDownFactor: Double; hockeyistTurnAngleFactor: Double; versatileHockeyistStrength: LongInt;
                versatileHockeyistEndurance: LongInt; versatileHockeyistDexterity: LongInt;
                versatileHockeyistAgility: LongInt; forwardHockeyistStrength: LongInt;
                forwardHockeyistEndurance: LongInt; forwardHockeyistDexterity: LongInt;
                forwardHockeyistAgility: LongInt; defencemanHockeyistStrength: LongInt;
                defencemanHockeyistEndurance: LongInt; defencemanHockeyistDexterity: LongInt;
                defencemanHockeyistAgility: LongInt; minRandomHockeyistParameter: LongInt;
                maxRandomHockeyistParameter: LongInt; struckPuckInitialSpeedFactor: Double; puckBindingRange: Double);

        function GetRandomSeed: Int64;
        function GetTickCount: LongInt;
        function GetWorldWidth: Double;
        function GetWorldHeight: Double;
        function GetGoalNetTop: Double;
        function GetGoalNetWidth: Double;
        function GetGoalNetHeight: Double;
        function GetRinkTop: Double;
        function GetRinkLeft: Double;
        function GetRinkBottom: Double;
        function GetRinkRight: Double;
        function GetAfterGoalStateTickCount: LongInt;
        function GetOvertimeTickCount: LongInt;
        function GetDefaultActionCooldownTicks: LongInt;
        function GetSwingActionCooldownTicks: LongInt;
        function GetCancelStrikeActionCooldownTicks: LongInt;
        function GetActionCooldownTicksAfterLosingPuck: LongInt;
        function GetStickLength: Double;
        function GetStickSector: Double;
        function GetPassSector: Double;
        function GetHockeyistAttributeBaseValue: LongInt;
        function GetMinActionChance: Double;
        function GetMaxActionChance: Double;
        function GetStrikeAngleDeviation: Double;
        function GetPassAngleDeviation: Double;
        function GetPickUpPuckBaseChance: Double;
        function GetTakePuckAwayBaseChance: Double;
        function GetMaxEffectiveSwingTicks: LongInt;
        function GetStrikePowerBaseFactor: Double;
        function GetStrikePowerGrowthFactor: Double;
        function GetStrikePuckBaseChance: Double;
        function GetKnockdownChanceFactor: Double;
        function GetKnockdownTicksFactor: Double;
        function GetMaxSpeedToAllowSubstitute: Double;
        function GetSubstitutionAreaHeight: Double;
        function GetPassPowerFactor: Double;
        function GetHockeyistMaxStamina: Double;
        function GetActiveHockeyistStaminaGrowthPerTick: Double;
        function GetRestingHockeyistStaminaGrowthPerTick: Double;
        function GetZeroStaminaHockeyistEffectivenessFactor: Double;
        function GetSpeedUpStaminaCostFactor: Double;
        function GetTurnStaminaCostFactor: Double;
        function GetTakePuckStaminaCost: Double;
        function GetSwingStaminaCost: Double;
        function GetStrikeStaminaBaseCost: Double;
        function GetStrikeStaminaCostGrowthFactor: Double;
        function GetCancelStrikeStaminaCost: Double;
        function GetPassStaminaCost: Double;
        function GetGoalieMaxSpeed: Double;
        function GetHockeyistMaxSpeed: Double;
        function GetStruckHockeyistInitialSpeedFactor: Double;
        function GetHockeyistSpeedUpFactor: Double;
        function GetHockeyistSpeedDownFactor: Double;
        function GetHockeyistTurnAngleFactor: Double;
        function GetVersatileHockeyistStrength: LongInt;
        function GetVersatileHockeyistEndurance: LongInt;
        function GetVersatileHockeyistDexterity: LongInt;
        function GetVersatileHockeyistAgility: LongInt;
        function GetForwardHockeyistStrength: LongInt;
        function GetForwardHockeyistEndurance: LongInt;
        function GetForwardHockeyistDexterity: LongInt;
        function GetForwardHockeyistAgility: LongInt;
        function GetDefencemanHockeyistStrength: LongInt;
        function GetDefencemanHockeyistEndurance: LongInt;
        function GetDefencemanHockeyistDexterity: LongInt;
        function GetDefencemanHockeyistAgility: LongInt;
        function GetMinRandomHockeyistParameter: LongInt;
        function GetMaxRandomHockeyistParameter: LongInt;
        function GetStruckPuckInitialSpeedFactor: Double;
        function GetPuckBindingRange: Double;

        destructor Destroy; override;

    end;

    TGameArray = array of TGame;

implementation

constructor TGame.Create(randomSeed: Int64; tickCount: LongInt; worldWidth: Double; worldHeight: Double;
        goalNetTop: Double; goalNetWidth: Double; goalNetHeight: Double; rinkTop: Double; rinkLeft: Double;
        rinkBottom: Double; rinkRight: Double; afterGoalStateTickCount: LongInt; overtimeTickCount: LongInt;
        defaultActionCooldownTicks: LongInt; swingActionCooldownTicks: LongInt;
        cancelStrikeActionCooldownTicks: LongInt; actionCooldownTicksAfterLosingPuck: LongInt; stickLength: Double;
        stickSector: Double; passSector: Double; hockeyistAttributeBaseValue: LongInt; minActionChance: Double;
        maxActionChance: Double; strikeAngleDeviation: Double; passAngleDeviation: Double; pickUpPuckBaseChance: Double;
        takePuckAwayBaseChance: Double; maxEffectiveSwingTicks: LongInt; strikePowerBaseFactor: Double;
        strikePowerGrowthFactor: Double; strikePuckBaseChance: Double; knockdownChanceFactor: Double;
        knockdownTicksFactor: Double; maxSpeedToAllowSubstitute: Double; substitutionAreaHeight: Double;
        passPowerFactor: Double; hockeyistMaxStamina: Double; activeHockeyistStaminaGrowthPerTick: Double;
        restingHockeyistStaminaGrowthPerTick: Double; zeroStaminaHockeyistEffectivenessFactor: Double;
        speedUpStaminaCostFactor: Double; turnStaminaCostFactor: Double; takePuckStaminaCost: Double;
        swingStaminaCost: Double; strikeStaminaBaseCost: Double; strikeStaminaCostGrowthFactor: Double;
        cancelStrikeStaminaCost: Double; passStaminaCost: Double; goalieMaxSpeed: Double; hockeyistMaxSpeed: Double;
        struckHockeyistInitialSpeedFactor: Double; hockeyistSpeedUpFactor: Double; hockeyistSpeedDownFactor: Double;
        hockeyistTurnAngleFactor: Double; versatileHockeyistStrength: LongInt; versatileHockeyistEndurance: LongInt;
        versatileHockeyistDexterity: LongInt; versatileHockeyistAgility: LongInt; forwardHockeyistStrength: LongInt;
        forwardHockeyistEndurance: LongInt; forwardHockeyistDexterity: LongInt; forwardHockeyistAgility: LongInt;
        defencemanHockeyistStrength: LongInt; defencemanHockeyistEndurance: LongInt;
        defencemanHockeyistDexterity: LongInt; defencemanHockeyistAgility: LongInt;
        minRandomHockeyistParameter: LongInt; maxRandomHockeyistParameter: LongInt;
        struckPuckInitialSpeedFactor: Double; puckBindingRange: Double);
begin
    FRandomSeed := randomSeed;
    FTickCount := tickCount;
    FWorldWidth := worldWidth;
    FWorldHeight := worldHeight;
    FGoalNetTop := goalNetTop;
    FGoalNetWidth := goalNetWidth;
    FGoalNetHeight := goalNetHeight;
    FRinkTop := rinkTop;
    FRinkLeft := rinkLeft;
    FRinkBottom := rinkBottom;
    FRinkRight := rinkRight;
    FAfterGoalStateTickCount := afterGoalStateTickCount;
    FOvertimeTickCount := overtimeTickCount;
    FDefaultActionCooldownTicks := defaultActionCooldownTicks;
    FSwingActionCooldownTicks := swingActionCooldownTicks;
    FCancelStrikeActionCooldownTicks := cancelStrikeActionCooldownTicks;
    FActionCooldownTicksAfterLosingPuck := actionCooldownTicksAfterLosingPuck;
    FStickLength := stickLength;
    FStickSector := stickSector;
    FPassSector := passSector;
    FHockeyistAttributeBaseValue := hockeyistAttributeBaseValue;
    FMinActionChance := minActionChance;
    FMaxActionChance := maxActionChance;
    FStrikeAngleDeviation := strikeAngleDeviation;
    FPassAngleDeviation := passAngleDeviation;
    FPickUpPuckBaseChance := pickUpPuckBaseChance;
    FTakePuckAwayBaseChance := takePuckAwayBaseChance;
    FMaxEffectiveSwingTicks := maxEffectiveSwingTicks;
    FStrikePowerBaseFactor := strikePowerBaseFactor;
    FStrikePowerGrowthFactor := strikePowerGrowthFactor;
    FStrikePuckBaseChance := strikePuckBaseChance;
    FKnockdownChanceFactor := knockdownChanceFactor;
    FKnockdownTicksFactor := knockdownTicksFactor;
    FMaxSpeedToAllowSubstitute := maxSpeedToAllowSubstitute;
    FSubstitutionAreaHeight := substitutionAreaHeight;
    FPassPowerFactor := passPowerFactor;
    FHockeyistMaxStamina := hockeyistMaxStamina;
    FActiveHockeyistStaminaGrowthPerTick := activeHockeyistStaminaGrowthPerTick;
    FRestingHockeyistStaminaGrowthPerTick := restingHockeyistStaminaGrowthPerTick;
    FZeroStaminaHockeyistEffectivenessFactor := zeroStaminaHockeyistEffectivenessFactor;
    FSpeedUpStaminaCostFactor := speedUpStaminaCostFactor;
    FTurnStaminaCostFactor := turnStaminaCostFactor;
    FTakePuckStaminaCost := takePuckStaminaCost;
    FSwingStaminaCost := swingStaminaCost;
    FStrikeStaminaBaseCost := strikeStaminaBaseCost;
    FStrikeStaminaCostGrowthFactor := strikeStaminaCostGrowthFactor;
    FCancelStrikeStaminaCost := cancelStrikeStaminaCost;
    FPassStaminaCost := passStaminaCost;
    FGoalieMaxSpeed := goalieMaxSpeed;
    FHockeyistMaxSpeed := hockeyistMaxSpeed;
    FStruckHockeyistInitialSpeedFactor := struckHockeyistInitialSpeedFactor;
    FHockeyistSpeedUpFactor := hockeyistSpeedUpFactor;
    FHockeyistSpeedDownFactor := hockeyistSpeedDownFactor;
    FHockeyistTurnAngleFactor := hockeyistTurnAngleFactor;
    FVersatileHockeyistStrength := versatileHockeyistStrength;
    FVersatileHockeyistEndurance := versatileHockeyistEndurance;
    FVersatileHockeyistDexterity := versatileHockeyistDexterity;
    FVersatileHockeyistAgility := versatileHockeyistAgility;
    FForwardHockeyistStrength := forwardHockeyistStrength;
    FForwardHockeyistEndurance := forwardHockeyistEndurance;
    FForwardHockeyistDexterity := forwardHockeyistDexterity;
    FForwardHockeyistAgility := forwardHockeyistAgility;
    FDefencemanHockeyistStrength := defencemanHockeyistStrength;
    FDefencemanHockeyistEndurance := defencemanHockeyistEndurance;
    FDefencemanHockeyistDexterity := defencemanHockeyistDexterity;
    FDefencemanHockeyistAgility := defencemanHockeyistAgility;
    FMinRandomHockeyistParameter := minRandomHockeyistParameter;
    FMaxRandomHockeyistParameter := maxRandomHockeyistParameter;
    FStruckPuckInitialSpeedFactor := struckPuckInitialSpeedFactor;
    FPuckBindingRange := puckBindingRange;
end;

function TGame.GetRandomSeed: Int64;
begin
    result := FRandomSeed;
end;

function TGame.GetTickCount: LongInt;
begin
    result := FTickCount;
end;

function TGame.GetWorldWidth: Double;
begin
    result := FWorldWidth;
end;

function TGame.GetWorldHeight: Double;
begin
    result := FWorldHeight;
end;

function TGame.GetGoalNetTop: Double;
begin
    result := FGoalNetTop;
end;

function TGame.GetGoalNetWidth: Double;
begin
    result := FGoalNetWidth;
end;

function TGame.GetGoalNetHeight: Double;
begin
    result := FGoalNetHeight;
end;

function TGame.GetRinkTop: Double;
begin
    result := FRinkTop;
end;

function TGame.GetRinkLeft: Double;
begin
    result := FRinkLeft;
end;

function TGame.GetRinkBottom: Double;
begin
    result := FRinkBottom;
end;

function TGame.GetRinkRight: Double;
begin
    result := FRinkRight;
end;

function TGame.GetAfterGoalStateTickCount: LongInt;
begin
    result := FAfterGoalStateTickCount;
end;

function TGame.GetOvertimeTickCount: LongInt;
begin
    result := FOvertimeTickCount;
end;

function TGame.GetDefaultActionCooldownTicks: LongInt;
begin
    result := FDefaultActionCooldownTicks;
end;

function TGame.GetSwingActionCooldownTicks: LongInt;
begin
    result := FSwingActionCooldownTicks;
end;

function TGame.GetCancelStrikeActionCooldownTicks: LongInt;
begin
    result := FCancelStrikeActionCooldownTicks;
end;

function TGame.GetActionCooldownTicksAfterLosingPuck: LongInt;
begin
    result := FActionCooldownTicksAfterLosingPuck;
end;

function TGame.GetStickLength: Double;
begin
    result := FStickLength;
end;

function TGame.GetStickSector: Double;
begin
    result := FStickSector;
end;

function TGame.GetPassSector: Double;
begin
    result := FPassSector;
end;

function TGame.GetHockeyistAttributeBaseValue: LongInt;
begin
    result := FHockeyistAttributeBaseValue;
end;

function TGame.GetMinActionChance: Double;
begin
    result := FMinActionChance;
end;

function TGame.GetMaxActionChance: Double;
begin
    result := FMaxActionChance;
end;

function TGame.GetStrikeAngleDeviation: Double;
begin
    result := FStrikeAngleDeviation;
end;

function TGame.GetPassAngleDeviation: Double;
begin
    result := FPassAngleDeviation;
end;

function TGame.GetPickUpPuckBaseChance: Double;
begin
    result := FPickUpPuckBaseChance;
end;

function TGame.GetTakePuckAwayBaseChance: Double;
begin
    result := FTakePuckAwayBaseChance;
end;

function TGame.GetMaxEffectiveSwingTicks: LongInt;
begin
    result := FMaxEffectiveSwingTicks;
end;

function TGame.GetStrikePowerBaseFactor: Double;
begin
    result := FStrikePowerBaseFactor;
end;

function TGame.GetStrikePowerGrowthFactor: Double;
begin
    result := FStrikePowerGrowthFactor;
end;

function TGame.GetStrikePuckBaseChance: Double;
begin
    result := FStrikePuckBaseChance;
end;

function TGame.GetKnockdownChanceFactor: Double;
begin
    result := FKnockdownChanceFactor;
end;

function TGame.GetKnockdownTicksFactor: Double;
begin
    result := FKnockdownTicksFactor;
end;

function TGame.GetMaxSpeedToAllowSubstitute: Double;
begin
    result := FMaxSpeedToAllowSubstitute;
end;

function TGame.GetSubstitutionAreaHeight: Double;
begin
    result := FSubstitutionAreaHeight;
end;

function TGame.GetPassPowerFactor: Double;
begin
    result := FPassPowerFactor;
end;

function TGame.GetHockeyistMaxStamina: Double;
begin
    result := FHockeyistMaxStamina;
end;

function TGame.GetActiveHockeyistStaminaGrowthPerTick: Double;
begin
    result := FActiveHockeyistStaminaGrowthPerTick;
end;

function TGame.GetRestingHockeyistStaminaGrowthPerTick: Double;
begin
    result := FRestingHockeyistStaminaGrowthPerTick;
end;

function TGame.GetZeroStaminaHockeyistEffectivenessFactor: Double;
begin
    result := FZeroStaminaHockeyistEffectivenessFactor;
end;

function TGame.GetSpeedUpStaminaCostFactor: Double;
begin
    result := FSpeedUpStaminaCostFactor;
end;

function TGame.GetTurnStaminaCostFactor: Double;
begin
    result := FTurnStaminaCostFactor;
end;

function TGame.GetTakePuckStaminaCost: Double;
begin
    result := FTakePuckStaminaCost;
end;

function TGame.GetSwingStaminaCost: Double;
begin
    result := FSwingStaminaCost;
end;

function TGame.GetStrikeStaminaBaseCost: Double;
begin
    result := FStrikeStaminaBaseCost;
end;

function TGame.GetStrikeStaminaCostGrowthFactor: Double;
begin
    result := FStrikeStaminaCostGrowthFactor;
end;

function TGame.GetCancelStrikeStaminaCost: Double;
begin
    result := FCancelStrikeStaminaCost;
end;

function TGame.GetPassStaminaCost: Double;
begin
    result := FPassStaminaCost;
end;

function TGame.GetGoalieMaxSpeed: Double;
begin
    result := FGoalieMaxSpeed;
end;

function TGame.GetHockeyistMaxSpeed: Double;
begin
    result := FHockeyistMaxSpeed;
end;

function TGame.GetStruckHockeyistInitialSpeedFactor: Double;
begin
    result := FStruckHockeyistInitialSpeedFactor;
end;

function TGame.GetHockeyistSpeedUpFactor: Double;
begin
    result := FHockeyistSpeedUpFactor;
end;

function TGame.GetHockeyistSpeedDownFactor: Double;
begin
    result := FHockeyistSpeedDownFactor;
end;

function TGame.GetHockeyistTurnAngleFactor: Double;
begin
    result := FHockeyistTurnAngleFactor;
end;

function TGame.GetVersatileHockeyistStrength: LongInt;
begin
    result := FVersatileHockeyistStrength;
end;

function TGame.GetVersatileHockeyistEndurance: LongInt;
begin
    result := FVersatileHockeyistEndurance;
end;

function TGame.GetVersatileHockeyistDexterity: LongInt;
begin
    result := FVersatileHockeyistDexterity;
end;

function TGame.GetVersatileHockeyistAgility: LongInt;
begin
    result := FVersatileHockeyistAgility;
end;

function TGame.GetForwardHockeyistStrength: LongInt;
begin
    result := FForwardHockeyistStrength;
end;

function TGame.GetForwardHockeyistEndurance: LongInt;
begin
    result := FForwardHockeyistEndurance;
end;

function TGame.GetForwardHockeyistDexterity: LongInt;
begin
    result := FForwardHockeyistDexterity;
end;

function TGame.GetForwardHockeyistAgility: LongInt;
begin
    result := FForwardHockeyistAgility;
end;

function TGame.GetDefencemanHockeyistStrength: LongInt;
begin
    result := FDefencemanHockeyistStrength;
end;

function TGame.GetDefencemanHockeyistEndurance: LongInt;
begin
    result := FDefencemanHockeyistEndurance;
end;

function TGame.GetDefencemanHockeyistDexterity: LongInt;
begin
    result := FDefencemanHockeyistDexterity;
end;

function TGame.GetDefencemanHockeyistAgility: LongInt;
begin
    result := FDefencemanHockeyistAgility;
end;

function TGame.GetMinRandomHockeyistParameter: LongInt;
begin
    result := FMinRandomHockeyistParameter;
end;

function TGame.GetMaxRandomHockeyistParameter: LongInt;
begin
    result := FMaxRandomHockeyistParameter;
end;

function TGame.GetStruckPuckInitialSpeedFactor: Double;
begin
    result := FStruckPuckInitialSpeedFactor;
end;

function TGame.GetPuckBindingRange: Double;
begin
    result := FPuckBindingRange;
end;

destructor TGame.Destroy;
begin
    inherited;
end;

end.
