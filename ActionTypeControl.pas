unit ActionTypeControl;

interface

const
    _UNKNOWN_ACTION_TYPE_: LongInt = -1;
    NONE                 : LongInt = 0;
    TAKE_PUCK            : LongInt = 1;
    SWING                : LongInt = 2;
    STRIKE               : LongInt = 3;
    CANCEL_STRIKE        : LongInt = 4;
    PASS                 : LongInt = 5;
    SUBSTITUTE           : LongInt = 6;
    _ACTION_TYPE_COUNT_  : LongInt = 7;

type
    TActionType = LongInt;
    TActionTypeArray = array of TActionType;

implementation

end.
