unit UnitPrincipal;

interface
//https://www.youtube.com/watch?v=fTa8vXRahSU

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, uCustomCalendar,
  FMX.ListBox;

type
  TFormPrincipal = class(TForm)
    RectCalendario: TRectangle;
    LytNavegacao: TLayout;
    ImgAnterior: TImage;
    ImgPosterior: TImage;
    LblMes: TLabel;
    LytCalendario: TLayout;
    LblDia: TLabel;
    LtbAtividades: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DayClick(Sender: TObject);
    procedure ImgAnteriorClick(Sender: TObject);
    procedure ImgPosteriorClick(Sender: TObject);
  private
    calendar: TCustomCalendar;
    procedure LoadMonth;
    procedure ListData;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;
const
  AZUL    = $FF6A7BFF;
  AMARELO = $FFF3B835;
  BRANCO  = $FFFFFFFF;

implementation

{$R *.fmx}

procedure TFormPrincipal.DayClick(Sender: TObject);
begin
  ListData;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  calendar.DisposeOf;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  calendar := TCustomCalendar.Create(LytCalendario);
  calendar.OnClick := DayClick;

  //Personalizar o calendário;
  calendar.DayFontSize      := 14;
  calendar.DayFontColor     := BRANCO;
  calendar.SelectedDayColor := AMARELO;
  calendar.BackgroundColor  := AZUL;

  calendar.ShowCalendar;

  LoadMonth;
end;

procedure TFormPrincipal.ImgAnteriorClick(Sender: TObject);
begin
  calendar.PriorMonth;
end;

procedure TFormPrincipal.ImgPosteriorClick(Sender: TObject);
begin
  calendar.NextMonth;
end;

procedure TFormPrincipal.ListData;
begin
  LblDia.Text := 'Atividades do dia ' + FormatDateTime('dd', calendar.SelectedDate);
  LtbAtividades.BeginUpdate;
  try
    LtbAtividades.Items.Clear;
    LtbAtividades.Items.Add('Comprimsso dia ' + FormatDateTime('dd', calendar.SelectedDate));
  finally
    LtbAtividades.EndUpdate;
  end;
end;

procedure TFormPrincipal.LoadMonth;
begin
  LblMes.Text               := calendar.MonthName;
  calendar.AddMarker(9, AZUL, BRANCO);
  ListData;
end;

end.
