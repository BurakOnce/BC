table 50100 BOSignature
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSeriesMgt.TestManual('SGNTR');
                    NoSeries := '';
                end;
            end;
        }
        field(2; NoSeries; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
        field(3; Signature; Blob)
        {
            Caption = 'Signature';
            DataClassification = CustomerContent;
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    var
        NoSeriesMgt: Codeunit "No. Series";
        SalesLine: Record "Sales Line";

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSeries := 'SGNTR';
            if NoSeriesMgt.AreRelated(NoSeries, xRec.NoSeries) then
                NoSeries := xRec.NoSeries;
            No := NoSeriesMgt.GetNextNo(NoSeries);
        end;
    end;

    procedure SignDocument(var Base64Text: Text)
    var
        Base64Cu: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TempInStream: InStream;
        TempOutStream: OutStream;
        RecOutStream: OutStream;
    begin
        Base64Text := Base64Text.Replace('data:image/png;base64,', '');
        TempBlob.CreateOutStream(TempOutStream);
        Base64Cu.FromBase64(Base64Text, TempOutStream);

        TempBlob.CreateInStream(TempInStream);
        Rec.Signature.CreateOutStream(RecOutStream);
        CopyStream(RecOutStream, TempInStream);

        if Rec.IsTemporary then
            exit;

        if Rec."No" = '' then
            Rec.Insert(true)
        else
            Rec.Modify(true);
    end;


}
