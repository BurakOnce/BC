Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Ready", "");

function InitializeSignaturePad() {
    let canvas = document.createElement("canvas");
    canvas.id = "signbox";
    canvas.width = 700;
    canvas.height = 300;

    let submitButton = document.createElement("button");
    submitButton.id = "signDocument";
    submitButton.innerHTML = "Sign";

    let container = document.createElement("div");
    container.id = "signatureContainer";
    container.appendChild(canvas);
    container.appendChild(submitButton);

    let signatureLocation = document.getElementById("controlAddIn");
    signatureLocation.appendChild(container);

    let signaturePad = new SignaturePad(canvas, {
        backgroundColor: "rgb(255, 255, 255)",
    });

    submitButton.addEventListener("click", function () {
        if (signaturePad.isEmpty()) {
            alert("Please enter signature...");
        } else {
            let base64String = signaturePad.toDataURL();
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Sign", [base64String]);
            signaturePad.clear();
        }
    });
}
