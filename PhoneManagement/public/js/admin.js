$('#form1 ~ *').remove();

$(document).ready(function () {
    $('.btn-submit').click(function () {
        $(this).parent().submit();
        return false;
    });

    $('.form-delete').submit(function () {
        if (!confirm('Bạn có chắc muốn xóa thành viên này không?')) {
            return false;
        }

        $(this).append('<input type="hidden" name="redirect" value="' + window.location.href + '"/>');
        return true;
    });


    $("#changePassword").change(function () {
        if ($(this).is(':checked')) {
            $('.password').removeAttr('disabled');
            $('#re_password').removeClass('hide');
            $('.re_password').attr('required', '');
        }
        else {
            $('.password').attr('disabled', 'disabled');
            $('#re_password').addClass('hide');
            $('.re_password').removeAttr('required');
        }
    });

   
});

