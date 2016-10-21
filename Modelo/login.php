<html>
	<head>
		<meta charset="UTF-8">
	</head>

	<body>
	
		<?php
		session_start(); 
			require './fnConectar.php';
			
			$user=$_POST['txtUsuario'];
			$pass=$_POST['txtContraseña'];
			$tipoUser1='ADMIN';
			$tipoUser2='USER';
                        
            $con= conectar();


			// $query1 = mysql_query("SELECT * FROM usuarios WHERE IDUSER='$user'",$con);
			$consulta = "call Sp_Loggin('$user')";
			$query1 = mysql_query($consulta,$con);
			
			if($result=mysql_fetch_array($query1))
			{
                if($user==$result['IDUSER']) 
                 {
				if($pass==$result['PASS']) 
				{
					if($tipoUser1==$result['TIPOUSER'])
					{
						$_SESSION['id']=$result['IDUSER'];
						$_SESSION['user']=$result['USERNAME'];
                        header("Location:../Vista/inicio_admin.php");
					}

					elseif ($tipoUser2==$result['TIPOUSER']) 
					{
						$_SESSION['id']=$result['IDUSER'];
						$_SESSION['user']=$result['USERNAME'];
                        header("Location:../Vista/inicio_user.php");
					}
				}
				else
				{
					echo '<script>alert("CONTRASEÑA INVALIDA")</script>';
					echo "<script>location.href='../index.php'</script>";
                                        
				}
            }
            else
            {
                echo '<script>alert("USUARIO INVALIDO")</script>';
                echo "<script>location.href='../index.php'</script>";
            }
		}
		else
		{
			echo '<script>alert("USUARIO NO REGISTRADO")</script>';
            echo "<script>location.href='../index.php'</script>";
		}

		?>
	</body>
</html>