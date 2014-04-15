$(document).ready(function() {
    $('#passwort_reset').on('click', function() {
        // toggle reset password functionality OFF
        if ($('#login_new_password').attr('value')) {
            $('#login_new_password').attr('value', '');
            $('#new_password_info_box').removeClass('show').addClass('hidden');
            $('#login_password').removeAttr('disabled').attr({'placeholder': 'Passwort'});
            $('#login_permanent').removeAttr('disabled');
            $('#login_button').text('einloggen');

        // toggle reset password functionality ON
        } else {
            $('#login_new_password').attr('value', '1');
            $('#login_password').attr({'disabled': 'disabled', 'placeholder': 'Passwortfeld gesperrt'});
            $('#login_permanent').attr({'disabled': 'disabled'});
            $('#login_button').text('Passwort anfordern');
            $('#new_password_info_box').removeClass('hidden').addClass('show');
        }
    });
})