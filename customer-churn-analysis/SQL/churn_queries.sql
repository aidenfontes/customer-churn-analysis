-- churn by contract type
SELECT Contract,
				COUNT(*) AS total_customers,
				SUM(CASE WHEN Churn='Yes' THEN 1 ELSE  0 END) AS Churned,
				ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE  0 END)*1.0 / COUNT(*) * 100, 2) AS ChurnRate	
FROM churn_data
GROUP BY Contract
ORDER BY ChurnRate DESC;

-- churn by internet service
SELECT InternetService,
				COUNT(*) AS total_customers,
				SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
				ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE  0 END)*1.0 / COUNT(*) * 100, 2) AS ChurnRate					
FROM churn_data
GROUP BY InternetService
ORDER BY ChurnRate DESC;

-- churn by monthly and total charges
SELECT Churn,
				ROUND(AVG(MonthlyCharges), 2) AS AvgMonthlyCharges,
				ROUND(AVG(TotalCharges), 2) AS AvgTotalCharges
FROM churn_data
GROUP BY Churn;

-- churn by tenure
SELECT 
			CASE
				WHEN tenure BETWEEN 0 AND 12 THEN '0 - 12 months'
				WHEN tenure BETWEEN 13 AND 24 THEN '13 - 24 months'
				WHEN tenure BETWEEN 25 AND 36 THEN '25 - 36 months'
				WHEN tenure BETWEEN 37 AND 48 THEN '37 - 48 months'
				WHEN tenure BETWEEN 49 AND 60 THEN '49 - 60 months'
				ELSE '61+ months'
			END AS 'TenureGroup',
			COUNT(*) AS TotalCustomers,
			SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
			ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE  0 END)*1.0 / COUNT(*) * 100, 2) AS ChurnRate		
FROM churn_data
GROUP BY TenureGroup
ORDER BY ChurnRate DESC;