// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require jquery_ujs
// require turbolinks
// require 'tolls.js'
$(document).ready(function() {

    //display number of axle only when number of wheels is greater than or equal to 4
    $('#wheels').change(function () {
        var wheels = $('#wheels').val();
        if (wheels == "4" || wheels == "6") {
            $('.axle').css('display', 'block');
        }
        else {
            $('.axle').css('display', 'none');
        }

    });

    //allow only digits for number of axle field
    $("#axle").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            $("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
});