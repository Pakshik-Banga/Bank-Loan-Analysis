--  1.  Calculate total no of loan application

SELECT COUNT(id) AS Total_Loan_Application from bank_loan_data


-- 2 . Sale for month 2021-12 

SELECT COUNT(id) AS MTD_Total_Loan_Application from bank_loan_data
WHERE TO_CHAR(issue_date,'YYYY-MM') = '2021-12'


-- 3 . Percentage change in sale in 2021-12 and 2021-11 month

with sale as (

	SELECT COUNT(id) FILTER(where TO_CHAR(issue_date,'YYYY-MM') = '2021-12') as cur , 
	       COUNT(id) FILTER(where TO_CHAR(issue_date,'YYYY-MM') = '2021-11') as prev
	FROM bank_loan_data
)

SELECT ROUND(((cur - prev)*100.0)/prev , 3) as percent_change FROM sale


-- 4  Total Funded Amount

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data



-- 5 Total Received Payment

SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data



-- 6 Average Interest Rate

SELECT AVG(int_rate)*100 AS Avg_Interest_Rate FROM bank_loan_data


-- 7 Average DTI Query

SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data


-- 8 . Percentage  of Good Loans . Good Loans have loan_status is fully paid , current

SELECT 
     (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100.0)/COUNT(id) 
       AS Good_loan_percentage
FROM bank_loan_data


-- 9 . Good Loan Funded Amount

SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM bank_loan_data
WHERE loan_status IN ('Fully Paid' , 'Current')

--  10. For Bad Loan , same as above 


-- 11. Loan Status Grid Query

SELECT
  loan_status,
  COUNT(id) AS LoanCount,
  SUM(total_payment) AS Total_Amount_Received,
  SUM(loan_amount) AS Total_Funded_Amount,
  AVG(int_rate*100.0) AS Interest_Rate,
  AVG(dti*100.0) AS DTI
FROM 
    bank_loan_data
GROUP BY 
    loan_status


--  12 Loan month grid query 

SELECT 
     TO_CHAR(issue_date,'Month') AS month,
     COUNT(id) AS Total_Loan_Application,
     SUM(loan_amount) AS Total_Funded_Amount,
     SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY month , TO_CHAR(issue_date , 'MM')
ORDER BY TO_CHAR(issue_date , 'MM')




--  13.  Loan Regional grid query 


SELECT 
      address_state,
      COUNT(id) AS Total_Loan_Application,
      SUM(loan_amount) AS Total_Funded_Amount,
      SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state



-- 14. Loan Term grid query 


SELECT 
      term,
      COUNT(id) AS Total_Loan_Application,
      SUM(loan_amount) AS Total_Funded_Amount,
      SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term


-- 15. Loan Purpose Grid Query 


SELECT 
      purpose,
      COUNT(id) AS Total_Loan_Application,
      SUM(loan_amount) AS Total_Funded_Amount,
      SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose



