use datasets;
select * from opportunity;
analyze table invoice;

-- 1.No of Invoice by Accnt Exec
select * from invoice;
select  `Account Executive` as Acc_Exe, count(invoice_number) as No_Invoice from invoice
 group by `Account Executive`;
 
 -- 2-Yearly Meeting Count
select * from meeting;
select  year(str_to_date(meeting_date, '%d-%m-%Y')) as meeting_Year, count(*) as Meeting_count from meeting
group by year(str_to_date(meeting_date, '%d-%m-%Y'))
order by meeting_year;

-- Cross sell -- Target, New, Placed

select
(select SUM(`Cross sell bugdet`)  from budget) as Cross_Sell_Target , -- Target_Cross sell
(
	(select SUM(Amount) from Brokerage 
	where income_class = 'Cross Sell' )
    +															-- Placed_renewal
	(select sum(amount)from fees
	where income_class='Cross Sell')
    ) as Cross_Sell_placed,
(select SUM(Amount) 
                from invoice 									-- Invoice_Renewal
                where income_class = 'Cross Sell') as Cross_Sell_Achieved ;

-- Renewal -- Target, placed, New

select
(select SUM(`Renewal Budget`)  from budget) as Renewal_Target , -- Target_Renewal
(
	(select SUM(Amount) from Brokerage 
	where income_class = 'Renewal' )
    +															-- Placed_renewal
	(select sum(amount)from fees
	where income_class='Renewal')
) as Renewal_placed,
(select SUM(Amount) 
                from invoice 									-- Invoice_Renewal
                where income_class = 'Renewal') as Renewal_Achieved ;

-- NEW -- Target, placed, Achieved

select
(select SUM(`New Budget`)  from budget) as New_Target , -- Target_New
(
	(select SUM(Amount) from Brokerage 
	where income_class = 'New' )
    +															-- Placed_New
	(select sum(amount)from fees
	where income_class='New')
    ) as New_Placed,
(select SUM(Amount) 
                from invoice 									-- Invoice_New
                where income_class = 'New') as New_Achieved ;





-- 4. Stage Funnel by Revenue
select * from opportunity;
select stage, sum(revenue_amount) as revenue from opportunity
group by stage;

-- 6-Top Open Opportunity
select * from opportunity;
select opportunity_name, `Account Executive`, revenue_amount, stage from opportunity
where stage in ('Propose Solution', 'Qualify Opportunity')
order by revenue_amount desc
limit 10; 

