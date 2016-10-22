<?php
	function conectar()
	{
	    $host="localhost";
	    $user="root";
	    $pass="";
	    $db="dbveterinaria";

	    $con = mysql_connect ($host, $user, $pass) or die ("Error de conexion");
	    mysql_select_db($db, $con);
	    mysql_query("SET NAMES 'utf8'");
		
	    return $con;
	}
?>