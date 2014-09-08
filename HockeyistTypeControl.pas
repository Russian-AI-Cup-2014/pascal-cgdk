unit HockeyistTypeControl;

interface

const
    _UNKNOWN_HOCKEYIST_TYPE_: LongInt = -1;
    GOALIE                  : LongInt = 0;
    VERSATILE               : LongInt = 1;
    FORWARD                 : LongInt = 2;
    DEFENCEMAN              : LongInt = 3;
    RANDOM                  : LongInt = 4;
    _HOCKEYIST_TYPE_COUNT_  : LongInt = 5;

type
    THockeyistType = LongInt;
    THockeyistTypeArray = array of THockeyistType;

implementation

end.
