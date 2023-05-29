unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformbase, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls;

type
  TIWFormMain = class(TIWFormBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IWFormMain: TIWFormMain;

implementation

{$R *.dfm}


initialization
  TIWFormMain.SetAsMainForm;


end.
