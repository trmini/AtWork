SELECT 
	  DATENAME(month,Date) as Month
	, Platform
	, MainHost
	, COUNT(DISTINCT ClientId)
FROM [ODP_PROD].[dbo].[V_AppActivated_OSI]

WHERE    
	Platform <> 'Unsupported'
	AND YEAR(Date) = 2015
	 
	AND AppURL NOT LIKE '%oasys%'
	AND AppURL NOT LIKE '%localhost%'
	AND AppURL NOT LIKE '%http://bb%'
	AND AppURL NOT LIKE '%osf-agave%'
	AND 
	(
		(AppURL NOT LIKE '%res.outlook.com%' AND AppURL NOT LIKE '%res.office365.com%')
		OR AppURL LIKE '%7a774f0c-7a6f-11e0-85ad-07fb4824019b%'
		OR AppURL LIKE '%a216ceed-7791-4635-a752-5a4ac0a5eb93%'
		OR AppURL LIKE '%bc13b9d0-5ba2-446a-956b-c583bdc94d5e%'
		OR AppURL LIKE '%d39dee0e-fdc3-4015-af8d-94d4d49294b3%'
		OR AppURL LIKE '%f60b8ac7-c3e3-4e42-8dad-e4e1fea59ff7%'
	)

	/*not dictionary*/
	AND AppURL NOT LIKE '%definitions.net%'
	AND AppURL NOT LIKE '%ictionary%'

	/*3rd party */

	AND AppURL NOT LIKE '%oaspapps%'
	AND AppURL NOT LIKE '%athenadevapps%'
	AND AppURL NOT LIKE '%officeapps.live.com%'
	AND AppURL NOT LIKE '%ssl.bing.com/dict%'
	AND AppURL NOT LIKE '%fontfinder%'
	AND AppURL NOT LIKE '%7a774f0c-7a6f-11e0-85ad-07fb4824019b%'
	AND AppURL NOT LIKE '%a216ceed-7791-4635-a752-5a4ac0a5eb93%'
	AND AppURL NOT LIKE '%bc13b9d0-5ba2-446a-956b-c583bdc94d5e%'
	AND AppURL NOT LIKE '%d39dee0e-fdc3-4015-af8d-94d4d49294b3%'
	AND AppURL NOT LIKE '%f60b8ac7-c3e3-4e42-8dad-e4e1fea59ff7%'
	AND AppURL NOT LIKE '%ssl.bing.com/dict%'

GROUP BY DATENAME(month,Date), Platform, MainHost
ORDER BY Month, Platform, MainHost