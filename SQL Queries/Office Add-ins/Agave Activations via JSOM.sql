SELECT 
	 DATENAME(month,Date) as Month
	,Platform
	,MainHost
	,COUNT(1) as Cnt
FROM V_AppActivated_OSI

WHERE Platform <> 'Unsupported'

GROUP BY DATENAME(month,Date), Platform, MainHost
ORDER BY Month, Platform, MainHost
