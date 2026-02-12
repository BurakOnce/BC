pageextension 50100 BOVendorCard extends "Vendor Card"
{
    layout
    {
        addfirst(factboxes)
        {
            part(BODragAndDropFactbox; BODragAndDropFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(23), "No." = field("No.");
            }
        }
    }
}
