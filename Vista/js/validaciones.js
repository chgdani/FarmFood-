$(document).ready(function() {
	inicio();
	$("#btnRegistrar").click(validarTelefono);
	$("#btnRegistrar").click(validarNombre);


});

function inicio(){
	$("span.help-block").hide();
	// $("#btnRegistrar").click(validarNombre);
}

function validarNombre(){
	var valor = document.getElementById("txtNombre").value;
	if ( valor == null || valor.length == 0 || /^\s+$/.test(valor) ) {
		$("#icono1").remove();
		$("#txtNombre").parent().parent().attr("class","form-group has-error has-feedback");
		$("#txtNombre").parent().parent().children("span").text("Este campo no puede ir en blanco").show();
		$("#txtNombre").parent().append("<span id='icono1' class='glyphicon glyphicon-remove form-control-feedback'></span>");
		return false;
	}
	else {
		$("#icono1").remove();
		$("#txtNombre").parent().parent().attr("class","form-group has-success has-feedback");
		$("#txtNombre").parent().parent().children("span").hide();
		$("#txtNombre").parent().append("<span id='icono1' class='glyphicon glyphicon-ok form-control-feedback'></span>");
		return true;
	}
}

function validarTelefono(){
	var valor = document.getElementById("txtTelefono").value;
	if ( valor == null || valor.length == 0 || /^\s+$/.test(valor) ) {
		$("#icono").remove();
		$("#txtTelefono").parent().parent().attr("class","form-group has-error has-feedback");
		$("#txtTelefono").parent().parent().children("span").text("Este campo no puede ir en blanco").show();
		$("#txtTelefono").parent().append("<span id='icono' class='glyphicon glyphicon-remove form-control-feedback'></span>");
		return false;
	}
	else if (isNaN(valor) ) {
		$("#icono").remove();
		$("#txtTelefono").parent().parent().attr("class","form-group has-error has-feedback");
		$("#txtTelefono").parent().parent().children("span").text("Este campo solo acepta numeros").show();
		$("#txtTelefono").parent().append("<span id='icono' class='glyphicon glyphicon-remove form-control-feedback'></span>");
		return false;
	}
	else {
		$("#icono").remove();
		$("#txtTelefono").parent().parent().attr("class","form-group has-success has-feedback");
		$("#txtNombre").parent().parent().children("span").hide();
		$("#txtTelefono").parent().append("<span id='icono' class='glyphicon glyphicon-ok form-control-feedback'></span>");
		return true;
	}
}

// 	var nombre = document.getElementById("txtNombre").value;
// 	var apellidos = document.getElementById("txtApellidos").value;
// 	var direccion = document.getElementById("txtDireccion").value;
// 	var telefono = document.getElementById("txtTelefono").value;
// 	var email = document.getElementById("txtEmail").value;
// 	var pass = document.getElementById("txtPass").value;
// 	var repas = document.getElementById("txtRePass").value;

