SELECT *
--	Host
--	, ProviderName
--	, AppName
--	, SuccessOrFail
--	, ErrorCode
--	, ErrorResult
----	, COUNT(1) as Cnt

FROM V_AppLoadTime_WAC

WHERE Month = 5
	AND SuccessOrFail NOT LIKE 'Success'
	AND (
		AppName LIKE '%Web Viewer%'
		OR AppName LIKE '%Bing Maps%'
		OR AppName LIKE '%Multiple Response Poll%'
		OR AppName LIKE '%SPCatalog Apps%'
		OR AppName LIKE '%Gauge%'
		OR AppName LIKE '%Multiple Choice Quiz%'
	)

--GROUP BY Host, ProviderName, AppName, SuccessOrFail
ORDER BY Host, ProviderName, AppName
