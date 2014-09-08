unit StrategyControl;

interface

uses
    HockeyistControl, WorldControl, GameControl, MoveControl;

type
    TStrategy = class
    public
        procedure Move(me: THockeyist; world: TWorld; game: TGame; move: TMove); virtual; abstract;

    end;

implementation

end.
