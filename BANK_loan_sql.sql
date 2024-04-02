create database bank_loan
select*from [dbo].[financial_loan]

--total number  of coustomer 
select count(id ) as total_number_of_coustomer from	[dbo].[financial_loan]
--total number of customer on last month
select count(id ) as MTD_total_number_of_coustomer from	[dbo].[financial_loan]
where month([issue_date])=12
--previous month customer for MOM trends
select count(id ) as PMTD_total_number_of_coustomer from	[dbo].[financial_loan]
where month([issue_date])=11

--total funded amount
select SUM(loan_amount) as total_funded_amount from financial_loan
--total funded amount on last month
select SUM(loan_amount) as MTD_funded_amount from financial_loan
where MONTH(issue_date)=12
--total funded amount on previous month
select SUM(loan_amount) as PMTD_funded_amount from financial_loan
where MONTH(issue_date)=11


--total amount recived 
select SUM(total_payment)as total_amount_recived  from financial_loan
--total amount recived on last month
select SUM(total_payment)as MTD_total_amount_recived  from financial_loan
where MONTH(issue_date)=12
--total amount recived on previous month
select SUM(total_payment)as PMTD_total_amount_recived  from financial_loan
where MONTH(issue_date)=11


--average intrest rate
select AVG(int_rate)*100[average_interst_rate] from financial_loan
--average intrest rate on last month
select AVG(int_rate)*100[MTD_average_interst_rate] from financial_loan
where MONTH(issue_date)=12
--average intrest rate on previous month
select AVG(int_rate)*100[PMTD_average_interst_rate] from financial_loan
where MONTH(issue_date)=11

--average Debt to income ratio 
select AVG(dti)*100 as avg_DTI from financial_loan
--average Debt to income ratio in last month
select AVG(dti)*100 as MTD_avg_DTI from financial_loan
where MONTH(issue_date)=12
--average Debt to income ratio in previous month
select AVG(dti)*100 as PMTD_avg_DTI from financial_loan
where MONTH(issue_date)=11


--good loan --
-- count of good loan 
select COUNT(id)as count_of_goodloan from financial_loan
where (loan_status) in('current', 'Fully Paid')
-- perrcentage of good loan
select
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
from financial_loan
--good loanfunded amount
select SUM(loan_amount) as good_loan_funded_amount from financial_loan
where  (loan_status) in('current', 'Fully Paid')
--good loan recived amount
select SUM(total_payment) as good_loan_funded_amount from financial_loan
where  (loan_status) in('current', 'Fully Paid')


                   --BAD LOAN--
-- count of good loan 
select COUNT(id)as count_of_badloan from financial_loan
where (loan_status) =('Charged Off')
-- perrcentage of good loan
select
    (COUNT(CASE WHEN loan_status = 'Charged Off'  THEN id END) * 100.0) / 
	COUNT(id) AS bad_Loan_Percentage
from financial_loan
--good loanfunded amount
select SUM(loan_amount) as bad_loan_funded_amount from financial_loan
where  (loan_status) =('Charged Off')
--good loan recived amount
select SUM(total_payment) as bad_loan_funded_amount from financial_loan
where  (loan_status) ='Charged Off'


                 --loan status--
select loan_status,COUNT(id)as total_application,SUM(loan_amount)as total_amount_funded,SUM(total_payment)as Total_amount_recived,
        AVG(int_rate)*100 as intrest_percentage,AVG(dti)*100 as dti_percentage
from financial_loan
group by loan_status


--mtd--
select loan_status,SUM(loan_amount)as MTD_Total_amount_funded,SUM(total_payment)as MTD_total_amount_recived from financial_loan
where month(issue_date)=12
group by loan_status


                   --bank loan overview--
--by month 
select MONTH (issue_date)as Month_number, DATENAME(MONTH,issue_date)as Month_name,COUNT(id)as total_application,
SUM(loan_amount)as total_amount_funded,SUM(total_payment)as Total_amount_recived
from financial_loan
group by MONTH (issue_date),DATENAME(MONTH,issue_date)
order by  MONTH (issue_date)


--by state
select address_state,COUNT(id)as total_application,
SUM(loan_amount)as total_amount_funded,SUM(total_payment)as Total_amount_recived
from financial_loan
group by address_state
order by address_state


--Term--
select term,COUNT(id)as total_application,SUM(loan_amount)as total_amount_funded,
SUM(total_payment)as Total_amount_recived 
from financial_loan
group by term

--employee length
select emp_length,COUNT(id)as total_application,SUM(loan_amount)as total_amount_funded,
SUM(total_payment)as Total_amount_recived 
from financial_loan
group by emp_length
order by emp_length

--purpose
select purpose,COUNT(id)as total_application,SUM(loan_amount)as total_amount_funded,
SUM(total_payment)as Total_amount_recived 
from financial_loan
group by purpose

--house ownership
select home_ownership,COUNT(id)as total_application,SUM(loan_amount)as total_amount_funded,
SUM(total_payment)as Total_amount_recived 
from financial_loan
group by home_ownership

