function verificar()
        {
            var enviar = true;

            var n = document.form1.nome.value;
            if( n.length == 0 )
            {
                enviar = false;
                document.querySelector("#erroName").textContent = "Preencha o campo nome";
            }

            var i = document.form1.cpf.value;
            if( isNaN(i)  ||  i.length == 0 )
            {
                enviar = false;
                document.querySelector("#erroCpf").textContent = "Preencha corretamente o campo CPF";
            }

            var e = document.form1.email.value;
            if( e.indexOf("@") < 0  )
            {
                enviar = false;
                document.querySelector("#erroEmail").textContent = "Preencha corretamente o campo email";
            }
            var n = document.form1.senha.value;
            if( n.length == 0 )
            {
                enviar = false;
                document.querySelector("#erroSenha").textContent = "Preencha Com uma senha";
            }

            if(enviar)
            {
                document.form1.submit();
            }
        }