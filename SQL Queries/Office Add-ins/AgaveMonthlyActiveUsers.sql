SELECT
	 Month
	,Platform
	,MainHost
	, COUNT(1) AS [Number Of Users]

FROM ( 
	SELECT DISTINCT
		Platform
		, MainHost
		, ClientId
		, DATENAME(MONTH, Date) AS Month
	FROM V_AppActivated_OSI

	WHERE Platform <> 'Unsupported'
	) AS UniqueUsers

GROUP BY Month, Platform, MainHost
ORDER BY Month, Platform, MainHost