function verifyForm(){
    var enviar = true;

    var nome = document.form1.txtNome.value;
    if (nome.length == 0){
        enviar = false;
        document.querySelector("#erroNome").textContent =
            "\nPreencha com um nome";
    }
    var idade = document.form1.txtIdade.value;
    if (idade.length == 0){
        enviar = false;
        document.querySelector("#erroIdade").textContent =
            "\nPreencha com uma idade";
    }
    var email = document.form1.txtEmail.value;
    if (email.indexOf("@") < 0){
        enviar = false;
        document.querySelector("#erroEmail").textContent =
            "\nPreencha com um email";
    }
    var feedback = document.form1.txtFeedback.value;
    if (feedback.length == 0){
        enviar = false;
        document.querySelector("#erroFeedback").textContent =
            "\nPreencha com um feedback";
    }
    if (enviar){
        document.form1.submit();
    }
}