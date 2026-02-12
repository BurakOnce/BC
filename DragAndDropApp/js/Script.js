var FactBox = null;
var uploadStatus = null;
var filesCount = 0;

function InitializeControl(controlId) {
}

function InitializeFileDragAndDrop() {
    var nodes = window.parent.document.querySelectorAll(
        'div[controlname="BODragAndDropFactbox"]'
    );

    if (!nodes || nodes.length === 0)
        return;

    FactBox = nodes[nodes.length - 1];

    FactBox.style.border = "2px dashed #ccc";
    FactBox.style.padding = "8px";
    FactBox.style.position = "relative";
    FactBox.style.textAlign = "center";

    var hint = document.createElement("div");
    hint.innerText = "Drag and drop the file here.";
    hint.style.fontSize = "12px";
    hint.style.color = "#666";
    hint.style.pointerEvents = "none";

    FactBox.appendChild(hint);

    uploadStatus = document.createElement("div");
    uploadStatus.innerText = "";
    uploadStatus.style.fontSize = "11px";
    uploadStatus.style.color = "#0078D4";
    uploadStatus.style.marginTop = "4px";

    FactBox.appendChild(uploadStatus);

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(function (eventName) {
        FactBox.addEventListener(eventName, preventDefaults, false);
    });

    ['dragenter', 'dragover'].forEach(function (eventName) {
        FactBox.addEventListener(eventName, highlight, false);
    });

    ['dragleave', 'drop'].forEach(function (eventName) {
        FactBox.addEventListener(eventName, unhighlight, false);
    });

    FactBox.addEventListener('drop', handleDrop, false);
}

function preventDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
}

function highlight(e) {
    FactBox.style.border = "2px dashed #0078D4";
    FactBox.style.backgroundColor = "#f3f9fd";
}

function unhighlight(e) {
    FactBox.style.border = "2px dashed #ccc";
    FactBox.style.backgroundColor = "";
}

function handleDrop(e) {
    var dt = e.dataTransfer;
    var files = dt.files;

    if (!files || files.length === 0) {
        uploadStatus.innerText = "File undetected";
        return;
    }

    handleFiles(files);
}

function handleFiles(files) {
    files = Array.prototype.slice.call(files);
    filesCount = files.length;

    uploadStatus.innerText = filesCount + " file loading...";
        
    files.forEach(uploadFile);
}

function uploadFile(file, i) {
    var reader = new FileReader();

    reader.addEventListener("loadend", function () {
        var base64data = reader.result;

        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
            'OnFileUpload',
            [file.name, base64data, filesCount === (i + 1)]
        );

        if (filesCount === (i + 1)) {
            uploadStatus.innerText = "";
        }
    });

    reader.readAsDataURL(file);
}
