unit UserSessionUnit;

{
  This is a DataModule where you can add components or declare fields that are specific to
  ONE user. Instead of creating global variables, it is better to use this datamodule. You can then
  access the it using UserSession.
}
interface

uses
  IWUserSessionBase, SysUtils, Classes;

type
  TIWUserSession = class(TIWUserSessionBase)
  private
    FIDUsuario: string;
    FUserName: string;
    FLastLogin: TDateTime;
    { Private declarations }
  public
    { Public declarations }
    property UserName: string read FUserName write FUserName;
    property IDUsuario: string read FIDUsuario write FIDUsuario;
    property LastLogin: TDateTime read FLastLogin write FLastLogin;


  end;

implementation



{$R *.dfm}

end.
