/*Question 1
Get the count of cities that have hosted an IPL match  - 33 cities
*/

select * from IPL_matches;
select count(distinct city) as IPL_Hosted_cities from IPL_matches;

/* 2
create table deliveries_v02 with all the columns of the table ‘deliveries’ and an additional
column ball_result containing values boundary, dot or other depending on the total_run
(boundary for >= 4, dot for 0 and other for any other number)
(Hint 1 : CASE WHEN statement is used to get condition based results)
(Hint 2: To convert the output data of the select statement into a table, you can use a
subquery. Create table table_name as [entire select statement]
*/

select * from IPL_Ball;
create table deliveries_v02 as
select *, (
	case when total_runs >= 4 then 'boundary' 
		when total_runs = 0 then 'dot'
		else 'other'
	end) as ball_result
from IPL_Ball

select * from deliveries_v02;

/* 3
write a query to fetch the total number of boundaries and dot balls from the
deliveries_v02 table
*/

select  
	sum(case when ball_result in ('boundary') then 1 else 0 end ) as total_boundaries,
	sum(case when ball_result in ('dot') then 1 else 0 end ) as total_dots
	from deliveries_v02;

/*4
Write a query to fetch the total number of boundaries scored by each team from the
deliveries_v02 table and order it in descending order of the number of boundaries
scored.
*/

select batting_team, count(ball_result) as total_boundaries
from deliveries_v02
where ball_result IN ('boundary')
group by batting_team
order by total_boundaries desc;

/*5
Write a query to fetch the total number of dot balls bowled by each team and order it in
descending order of the total number of dot balls bowled
*/

select bowling_team, count(ball_result) as dot_balls
from deliveries_v02
where ball_result in ('dot')
group by bowling_team
order by dot_balls desc;

/*6
Write a query to fetch the total number of dismissals by dismissal kinds where dismissal
kind is not NA
*/

select * from deliveries_v02;

select count(dismissal_kind) as total_dismissals
from deliveries_v02
where dismissal_kind not in ('NA');

/*7
Write a query to get the top 5 bowlers who conceded maximum extra runs from the
deliveries table
*/

select bowler, count(extra_runs) as no_of_extra_runs
from deliveries_v02
where extra_runs > 0
group by bowler
order by no_of_extra_runs desc
LIMIT 5;

/*8
Write a query to create a table named deliveries_v03 with all the columns of
deliveries_v02 table and two additional column (named venue and match_date) of venue
and date from table matches
*/

-- NOTE: as in my previous analysis i have already created matches for this query i am creating table match, 
-- please consider this match table at the place of matches 

create table match as 
	select * from IPL_matches;

create table deliveries_v03 as 
select a.*, b.venue as venue, b.date as match_date
from deliveries_v02 a
join 
match b
on a.id = b.id;

select * from deliveries_v03;

/*9
Write a query to fetch the total runs scored for each venue and order it in the descending
order of total runs scored.
*/

select distinct venue, sum(total_runs) as total_runs_scored
from deliveries_v03
group by venue
order by total_runs_scored desc;

/*10
. Write a query to fetch the year-wise total runs scored at Eden Gardens and order it in the
descending order of total runs scored.
*/

select venue, extract(year from match_date) as year, sum(total_runs) as total_runs_scored
from deliveries_v03
where venue IN ('Eden Gardens')
group by extract(year from match_date), venue
order by total_runs_scored desc;


































































