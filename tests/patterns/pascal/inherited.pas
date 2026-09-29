destructor TFoo.Destroy;
begin
  FItems.Free;
  // ERROR:
  inherited;
end;

constructor TFoo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
