unit Forms1;

interface

type
  // ERROR:
  TMainForm = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  end;

  TRack = class(TObject)
    Name: string;
  end;

implementation

end.
