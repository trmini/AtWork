SELECT 
	MONTH(Date) as Month
	, Platform
	, MainHost
	, COUNT(1) as Cnt
FROM V_AppActivated_OSI

WHERE MONTH(Date) > 2

GROUP BY MONTH(Date), Platform, MainHost
ORDER BY Month, Platform, MainHost
