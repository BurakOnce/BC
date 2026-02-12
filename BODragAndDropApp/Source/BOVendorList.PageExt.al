pageextension 50101 BOVendorList extends "Vendor List"
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
