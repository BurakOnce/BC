page 50101 BOSignatures
{
    PageType = List;
    SourceTable = BOSignature;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Signatures';
    CardPageId = BOSignatureCard;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No"; Rec."No")
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                    Style = AttentionAccent;
                }
                field(Signature; Rec.Signature)
                {
                    ToolTip = 'Specifies the value of the Signature field.', Comment = '%';
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewWithAutoNo)
            {
                Caption = 'New';
                Image = New;
                trigger OnAction()
                var
                    Signature: Record BOSignature;
                    NoSeriesMgt: Codeunit "No. Series";
                begin
                    Signature.Init();
                    Signature."No" := NoSeriesMgt.GetNextNo('SGNTR', Today(), true);
                    Signature.Insert(true);
                    PAGE.Run(PAGE::BOSignatureCard, Signature);
                end;
            }
        }
    }



}
