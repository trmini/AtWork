SELECT
	Month
	, HostApp AS Host
	, COUNT(1) AS [Number Of Users]

FROM ( 
	SELECT DISTINCT
		HostApp
		, UserId
		, DATENAME(MONTH, Date) AS Month
	FROM V_AppActivated_OSI
	) AS UniqueUsers
GROUP BY Month, HostApp
ORDER BY Month, HostApp