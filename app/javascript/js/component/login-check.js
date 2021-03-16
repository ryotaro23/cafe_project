document.addEventListener("turbolinks:load", function () {

    let loginSubmitButton = document.getElementsByClassName('js-login-submit')[0];
    let loginEmailButton = document.getElementsByClassName('js-login-email')[0];
    let loginPasswordButton = document.getElementsByClassName('js-login-password')[0];
    loginSubmitButton.disabled = true;


    loginEmailButton.addEventListener('keyup', function () {
        console.log(this.value.length);
        console.log(this.value);
        if (this.value.length < 2 || !this.value.match(/@/)) {
            loginSubmitButton.disabled = true;
        } else {
            loginSubmitButton.disabled = false;
        }
    }, false);

    loginPasswordButton.addEventListener('keyup', function () {
        console.log(this.value.length);
        if (this.value.length < 6) {
            loginSubmitButton.disabled = true;
        } else {
            loginSubmitButton.disabled = false;
        }
    }, false);

});