controladdin BOFileDragAndDrop
{
    Scripts = 'https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js', 'js/script.js';
    StartupScript = 'js/Startup.js';

    RequestedHeight = 1;
    MinimumHeight = 1;
    HorizontalStretch = true;

    event ControlAddinReady();
    event OnFileUpload(FileName: Text; FileAsText: Text; IsLastFile: Boolean)
    procedure InitializeFileDragAndDrop()
}