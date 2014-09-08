unit HockeyistStateControl;

interface

const
    _UNKNOWN_HOCKEYIST_STATE_: LongInt = -1;
    ACTIVE                   : LongInt = 0;
    SWINGING                 : LongInt = 1;
    KNOCKED_DOWN             : LongInt = 2;
    RESTING                  : LongInt = 3;
    _HOCKEYIST_STATE_COUNT_  : LongInt = 4;

type
    THockeyistState = LongInt;
    THockeyistStateArray = array of THockeyistState;

implementation

end.
