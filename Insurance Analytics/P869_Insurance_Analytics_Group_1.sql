use project;

-- No. of Inovice by Accexe
  select AccExec , count(invoice_number) invoice_count 
  from invoice 
  group by AccExec order by invoice_count Desc;
  
-- Yearly meeting count
   select 
   count(case when year(meeting_date)="2019" then 1 end) meeting_count_2019,
   count(case when year(meeting_date)="2020" then 1 end) meeting_count_2020
   from meeting;
   
-- KPI 3
  -- Cross sell
  Select (select concat(round(sum(Crosssell_bugdet)/1000000,1)," M") from budget) as Target,
   (select concat(round(sum(Amount)/1000000,1)," M") from brokfee where income_class="Cross sell") as Achieved,
   (select concat(round(sum(Amount)/1000000,1)," M") from invoice where income_class="Cross sell") as Invoice;

   -- New
   Select (select concat(round(sum(New_budget)/1000000,1),"M") from budget) as Target,
   (select concat(round(sum(Amount)/1000000,1)," M") from brokfee where income_class="New") as Achieved,
   (select concat(round(sum(Amount)/1000000,1)," M") from invoice where income_class="New") as Invoice;
   
-- Renewal
 Select (select concat(round(sum(Renewal_budget)/1000000,1)," M") from budget) as Target,
    (select concat(round(sum(Amount)/1000000,1)," M") from brokfee where income_class="Renewal") as Achieved,
    (select concat(round(sum(Amount)/1000000,1)," M") from invoice where income_class="Renewal") as Invoice;
    
-- Stage by Revenue
  select stage ,concat(round(sum(revenue_amount)/1000000,1),' M') as Revenue 
  from opportunity 
  group by stage order by sum(revenue_amount) Desc;
  
-- Meeting count by Acc Exec
    select AccExe , count(meeting_date) as meeting_count 
    from meeting 
    group by AccExe order by meeting_count Desc;
    
    
-- Top 5 open opportunity
  select opportunity_name , concat(round(sum(revenue_amount)/1000,1),' K') as Revenue 
  from opportunity 
  where stage !="Negotiate" 
  group by opportunity_name order by sum(revenue_amount) Desc limit 5;
  
  
-- top 5 Opportunity by revenue
  select opportunity_name , concat(round(sum(revenue_amount)/1000,1),' K') as Revenue 
  from opportunity 
  group by opportunity_name order by sum(revenue_amount) Desc limit 5;
  
  
-- cross sell plcd
    select 
    CONCAT(
    ROUND(
    (Select SUM(Amount) from brokfee where income_class="Cross sell") /
    SUM(Crosssell_bugdet) * 100, 2), '%') AS Cross_sell_PLCD
    from budget;
   

-- New PLCD %
  select 
    CONCAT(
    ROUND(
    (Select SUM(Amount) from brokfee where income_class="New") /
    SUM(New_budget) * 100, 2), '%') AS New_PLCD
    from budget;
    
-- Renewal PLCD %
 select 
    CONCAT(
    ROUND(
    (Select SUM(Amount) from brokfee where income_class="Renewal") /
    SUM(Renewal_budget) * 100, 2), '%') AS Renewal_PLCD
    from budget;
   

-- Total meeting count
 select count(meeting_date) as Meeting_count from meeting;
 
 -- Total Revenue 
  select concat(round(sum(Amount)/1000000,1)," M") as Revenue from invoice;
  