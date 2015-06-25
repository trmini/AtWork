<?php
	// set your infomation.
	$host		=	'localhost';
	$user		=	'keg_ro';
	$pass		=	'keg_ro';
	$database	=	'Kegginator';

	// connect to the mysql database server.
	$connect = @mysql_connect ($host, $user, $pass);

	if ( $connect )
	{
		$sql = 'SELECT K.Name, KS.Volume, K.Brewer, K.Description, K.ImageURL, K.InfoURL, K.Hops, K.Malts, K.Bitterness, K.Alcohol FROM `Kegs` K JOIN KegSizes KS ON KS.SizeId = K.SizeId WHERE OnTap = TRUE';
		mysql_select_db ( $database, $connect );
		if ( @mysql_query ( $sql ) )
		{
			$query = mysql_query ( $sql );
			$row = mysql_fetch_assoc ( $query );
			$kegName = $row['Name'];
			$kegBrewer = $row['Brewer'];
			$kegDescription = $row['Description'];
			$kegImageURL = $row['ImageURL'];
			$kegMalts = $row['Malts'];
			$kegHops = $row['Hops'];
			$kegBitterness = $row['Bitterness'];
			$kegAlcohol = $row['Alcohol'];
			$kegVolume = $row['Volume'];
			
			//Debug
			$kegRemaining = 70;
			$remainRatio = $kegRemaining/$kegVolume;
		}
		else {
			trigger_error ( mysql_error (), E_USER_ERROR );
		}
	}
	else {
		trigger_error ( mysql_error(), E_USER_ERROR );
	}
?>
<html>
<head>
	<title>On Tap: <?php echo $kegName ?></title>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="styles/keg.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="styles/beer.css" />
	<script type="text/javascript">
		$(document).ready(function() {
			 $('#liquid')
				.delay(1000)
				.animate({
				  height: '<?php echo round(200*$remainRatio) ?>px'
				}, 2500);
			  
			 $('.beer-foam')
				.delay(1000)
				.animate({
				  bottom: '<?php echo round(200*$remainRatio) + 25 ?>px'
				  }, 2500);
		});
	</script>
</head>
<body>
	<div class="keg_info">
		<div>
			<h2 class="beer_name"><?php echo $kegName ?></h2>
			<p>By <?php echo $kegBrewer ?></p>
		</div>
		<div class='beer_description'>
			<?php echo $kegDescription ?><br />
		</div>
		<div class="beer_content">
			<p>
				<span class='alcohol_level'><?php echo $kegAlcohol ?>%</span> ABV
				<span class='alcohol_level'><?php echo $kegBitterness ?></span>  IBU<br />

				<span>MALTS: <?php echo $kegMalts ?> </span><br />
				<span>HOPS: <?php echo $kegHops ?> </span><br />
			</p>
		</div>
		<div class='keg_status'>
			Volume: <span class='alcohol_level'><?php echo $kegVolume ?></span> (12oz pours)<br />
			<progress value="<?php echo $kegRemaining ?>" max="<?php echo $kegVolume ?>"></progress>
		</div>
		<div id="container">
		  <div id="beaker">
			<div class="beer-foam">
			  <div class="foam-1"></div>
			  <div class="foam-2"></div>
			  <div class="foam-3"></div>
			  <div class="foam-4"></div>
			  <div class="foam-5"></div>
			  <div class="foam-6"></div>
			  <div class="foam-7"></div>
			</div>
			
			<div id="liquid">			  
			  <div class="bubble bubble1"></div>
			  <div class="bubble bubble2"></div>
			  <div class="bubble bubble3"></div>
			  <div class="bubble bubble4"></div>
			  <div class="bubble bubble5"></div>
			  <div class='alcohol_gauge'><?php echo $kegRemaining ?> pours</div>
			</div>
		  </div>
		</div>
		
		<div class="crop">
			<?php
				echo "<img src=\"" . $kegImageURL . "\">";
			?>
		</div>
	</div>
</body>
</html>
