-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT backers_count, cf_id, outcome
FROM campaign
WHERE (outcome = 'live')
ORDER BY backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT (bks.cf_id), bks.cf_id 
FROM backers as bks
GROUP BY bks.cf_id
ORDER BY COUNT (bks.cf_id) DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT cn.first_name, cn.last_name, cn.email, (cp.goal-cp.pledged) as "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign as cp
INNER JOIN contacts as cn
ON (cp.contact_id = cn.contact_id)
WHERE (outcome = 'live')
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT*FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bks.email, bks.first_name, bks.last_name, bks.cf_id, cp.company_name, cp.description, cp.end_date, (cp.goal - cp.pledged) as "Left of Goal" 
INTO email_backers_remaining_goal_amount
FROM backers as bks
INNER JOIN campaign as cp
ON (bks.cf_id = cp.cf_id)
WHERE (cp.outcome='live')
ORDER BY (bks.last_name);

-- Check the table
SELECT*FROM email_backers_remaining_goal_amount
