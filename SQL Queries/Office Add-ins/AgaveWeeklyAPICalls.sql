DECLARE @Before DATETIME = DATEADD(DAY, -7, GETDATE()) -- Look back 7 days to avoid missing data points
DECLARE @After DATETIME = DATEADD(DAY, -7, @Before)

SELECT
	HostApp
	, APIName
	, AppId
	, COUNT(1) AS APICnt

FROM V_APIUsage_OSI
WHERE Date BETWEEN @After AND @Before

GROUP BY HostApp, APIName, AppId
ORDER BY HostApp, APICnt DESC
