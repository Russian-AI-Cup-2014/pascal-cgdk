unit MyStrategy;

interface

uses
    StrategyControl, HockeyistControl, WorldControl, GameControl, MoveControl,
    HockeyistTypeControl, HockeyistStateControl, ActionTypeControl;

type
    TMyStrategy = class (TStrategy)
    public
        procedure Move(me: THockeyist; world: TWorld; game: TGame; move: TMove); override;

    end;

implementation

uses
    Math;
    
procedure TMyStrategy.Move(me: THockeyist; world: TWorld; game: TGame; move: TMove);
begin
    move.SetSpeedUp(-1.0);
    move.SetTurn(PI);
    move.SetAction(STRIKE);
end;

end.
