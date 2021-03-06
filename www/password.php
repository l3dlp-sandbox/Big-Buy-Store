<?php

// Load classes
$file = preg_replace('/\.php$/', '', basename(__FILE__));
include ("inc/classload.inc.php");

// Process
if (isset($_POST["changepassword"])) {	
	
	$error = array();
	
	if ($user->performPasswordChange($_POST["passo"], $_POST["pass1"], $_POST["pass2"]) == true) {
		$_SESSION["success"] = "Password updated.";
		$_POST = array();
	}
	
}

// Include header template
include ("inc/header.inc.php");

?>

<div id = "maincontent">
	
	<div id = "submenu">
	
		<?php 
		
		dashnav($user->account_type());	
		
		?>			
	
	</div>
	
	<br/>
	
	<div id = "displaywindow">
		
		<div id = "divlabel">Update your password</div>
		
		<?php errorhandler(); ?>
	
		<form action="password.php" method="post" id="contentform">  
	
			<input type="hidden" name="token" value="<?php echo generateToken(30); ?>" />
			<input type="hidden" name="form" value="passwordupdate" />
			
			<div id ="label">Old Password</div><div id ="fieldreq">
			<input type="password" name="passo" 
			style = "<?php echo (isset($error["passo"]) ? "border:2px solid red;" : null); ?>" 
			value = "<?php echo (isset($_POST["passo"]) ? cleanDisplay($_POST["passo"]) : null); ?>" />
			<?php echo (isset($error["passo"]) ? "<p class = \"inputerror\">".$error["passo"]."</p>" : null); ?></div>
			
			<div id ="label">New Password</div><div id ="fieldreq">
			<input type="password" name="pass1" 
			style = "<?php echo (isset($error["pass1"]) ? "border:2px solid red;" : null); ?>" 
			value = "<?php echo (isset($_POST["pass1"]) ? cleanDisplay($_POST["pass1"]) : null); ?>" />
			<?php echo (isset($error["pass1"]) ? "<p class = \"inputerror\">".$error["pass1"]."</p>" : null); ?></div>
			
			<div id ="label">Repeat New Password</div><div id ="fieldreq">
			<input type="password" name="pass2" 
			style = "<?php echo (isset($error["pass2"]) ? "border:2px solid red;" : null); ?>" 
			value = "<?php echo (isset($_POST["pass2"]) ? cleanDisplay($_POST["pass2"]) : null); ?>" />
			<?php echo (isset($error["pass2"]) ? "<p class = \"inputerror\">".$error["pass2"]."</p>" : null); ?></div>			
			
			<input type="submit" name="changepassword" value="Change" id="submit" />
			
		</form>

		
	</div>

</div>


<?php

// Include footer template
include ("inc/footer.inc.php");
	
?>
