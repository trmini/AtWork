DECLARE @Before DATETIME = DATEADD(DAY, -7, GETDATE()) -- Look back 7 days to avoid missing data points
DECLARE @After DATETIME = DATEADD(DAY, -7, @Before)

SELECT
	HostApp
	, APIName
	, AppId
	, AppURL
	, COUNT(1) As APICnt

FROM V_APIUsage_OSI
WHERE
	Date BETWEEN @After AND @Before
	AND AppURL IS NOT NULL
	AND AppURL NOT LIKE '%oasys%'
	AND AppURL NOT LIKE '%res.outlook.com%'
	AND AppURL NOT LIKE '%localhost%'
	AND AppURL NOT LIKE '%http://bb%'
	AND AppURL NOT LIKE '%jsomtestapp%'

	/* 3rd party non-dictionary */
	AND AppURL NOT LIKE '%dict%'
	AND AppURL NOT LIKE '%definitions.net%'
	AND AppURL NOT LIKE '%athenadevapps%'
	AND AppURL NOT LIKE '%firstpartyapps%'
	AND AppURL NOT LIKE '%fontfinder%'
	AND AppURL NOT LIKE '%officeapps.live.com%'
	AND AppURL NOT LIKE '%7a774f0c-7a6f-11e0-85ad-07fb4824019b%' 
	AND AppURL NOT LIKE '%a216ceed-7791-4635-a752-5a4ac0a5eb93%' 
	AND AppURL NOT LIKE '%bc13b9d0-5ba2-446a-956b-c583bdc94d5e%' 
	AND AppURL NOT LIKE '%d39dee0e-fdc3-4015-af8d-94d4d49294b3%' 
	AND AppURL NOT LIKE '%f60b8ac7-c3e3-4e42-8dad-e4e1fea59ff7%' 


GROUP BY HostApp, APIName, AppId, AppURL
ORDER BY HostApp, APIName, APICnt