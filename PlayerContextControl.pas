unit PlayerContextControl;

interface

uses
    Math, HockeyistControl, WorldControl;

type
    TPlayerContext = class
    private
        FHockeyists: THockeyistArray;
        FWorld: TWorld;

    public
        constructor Create(hockeyists: THockeyistArray; world: TWorld);

        function GetHockeyists: THockeyistArray;
        function GetWorld: TWorld;

        destructor Destroy; override;

    end;

    TPlayerContextArray = array of TPlayerContext;

implementation

constructor TPlayerContext.Create(hockeyists: THockeyistArray; world: TWorld);
begin
    if hockeyists = nil then
    begin
        FHockeyists := nil;
    end
    else
    begin
        FHockeyists := Copy(hockeyists, 0, Length(hockeyists));
    end;
    FWorld := world;
end;

function TPlayerContext.GetHockeyists: THockeyistArray;
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

function TPlayerContext.GetWorld: TWorld;
begin
    result := FWorld;
end;

destructor TPlayerContext.Destroy;
var
    i: LongInt;

begin
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

    if FWorld <> nil then
    begin
        FWorld.Free;
    end;

    inherited;
end;

end.
