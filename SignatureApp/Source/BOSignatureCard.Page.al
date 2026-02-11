page 50100 BOSignatureCard
{
    PageType = Card;
    SourceTable = BOSignature;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Signature Card';

    layout
    {
        area(Content)
        {
            group("Signature Group")
            {
                Caption = 'Signature ';
                usercontrol(SignaturePad; BOSignaturePad)
                {
                    ApplicationArea = All;

                    trigger Ready()
                    begin
                        CurrPage.SignaturePad.InitializeSignaturePad();
                    end;

                    trigger Sign(Signature: Text)
                    begin
                        Rec.SignDocument(Signature);
                        CurrPage.Update();
                    end;
                }

                field(Signature; Rec.Signature)
                {
                    Caption = 'Signature';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
