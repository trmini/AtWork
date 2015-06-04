SELECT
	Host
	, ProviderName
	, AppName
	, COUNT(1) as Cnt

FROM V_AppLoadTime_WAC

WHERE Month = 5

GROUP BY Host, ProviderName, AppName
ORDER BY Host, ProviderName, Cnt DESC
