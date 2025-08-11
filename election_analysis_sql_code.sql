set search_path to election_results

select * from "Election_results". constituencywise_details;

select * from "Election_results". cw_results;

select * from "Election_results". states;

select * from "Election_results". pw_results;

select * from "Election_results".statewise_results;

--1)Total Seats

select
      count(*) as total_seats
from "Election_results".cw_results;

--2)What are the total number of seats available for elections in each state
select * from
"Election_results".statewise_results;

select 
       sr.state_id,
	   s.state as state_name,
	   count(*) as total_seats
FROM "Election_results".statewise_results as sr
join "Election_results".states as s
on sr.state_id = s.state_id
Group by sr.state_id,s.state
order by total_seats desc 

--3)Total Seats Won by NDA Alliance

select *
from "Election_results". cw_results as cwr
join  "Election_results". pw_results pwr
on cwr.party_id = pwr.party_id

--4)Seats Won by NDA Alliance Parties   
select * from "Election_results". pw_results;
select 
        sum(won) as nda_seats_won_by_nda
from "Election_results". pw_results
where party_name in (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            )
			
      -- using case statement
	  
SELECT 
    SUM(CASE 
            WHEN party_name IN (
                'Bharatiya Janata Party - BJP',  
                'Telugu Desam - TDP',  
                'Janata Dal  (United) - JD(U)',  
                'Shiv Sena - SHS',  
                'AJSU Party - AJSUP',  
                'Apna Dal (Soneylal) - ADAL',  
                'Asom Gana Parishad - AGP',  
                'Hindustani Awam Morcha (Secular) - HAMS',  
                'Janasena Party - JnP',  
                'Janata Dal  (Secular) - JD(S)',  
                'Lok Janshakti Party(Ram Vilas) - LJPRV',  
                'Nationalist Congress Party - NCP',  
                'Rashtriya Lok Dal - RLD',  
                'Sikkim Krantikari Morcha - SKM'
            ) THEN won
            ELSE 0
        END) AS nda_seats_won_by_nda
FROM "Election_results".pw_results;

--5)Total Seats Won by I.N.D.I.A. Alliance

select 
  sum(won) as total_INDIA_alliance_seats
FROM "Election_results".pw_results
where party_name in (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            )


--6)Seats Won by I.N.D.I.A. Alliance Parties
select
       party_name,
	   won  
from  "Election_results".pw_results
where party_name in ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
order by won desc

--7)Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
select * from "Election_results". pw_results;

-- 8)Add the new column
ALTER TABLE "Election_results".pw_results
ADD COLUMN party_alliance VARCHAR(50);

--(9) Assign 'I.N.D.I.A' alliance
UPDATE "Election_results".pw_results
SET party_alliance = 'I.N.D.I.A'
WHERE party_name IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

-- Assign 'NDA' alliance
UPDATE "Election_results".pw_results
SET party_alliance = 'NDA'
WHERE party_name IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

-- Assign 'OTHER' to remaining parties
UPDATE "Election_results".pw_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

-- 10)Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

SELECT 
    p.party_alliance,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    "Election_results".cw_results cr
JOIN 
    "Election_results".pw_results p ON cr.Party_ID = p.Party_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    p.party_alliance
ORDER BY 
    Seats_Won DESC;

-- 11)Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
select 
         c.wining_candidate,
		 c.constituency_name,
		 c.party_id,
		 p.party_name,
		 c.total_votes,
		 c.margin,
		 ss.state
FROM 
     "Election_results".cw_results as c 
JOIN 
     "Election_results".statewise_results as sr
ON
     c.parliament_constituency = sr.parliament_constituency
JOIN 
     "Election_results".states as ss
ON 
   ss.state_id = sr.state_id
JOIN
     "Election_results".pw_results as p
ON
     c.party_id = p.party_id
where  
      sr.state in ('Andhra Pradesh')
order by 
       c.margin desc

-- 12)What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
select 
      cd.candidate,
	  cd.party,
	  cd.evm_votes,
	  cd.postal_votes,
	  cr.constituency_name
from
   "Election_results".cw_results cr
join 
    "Election_results".constituencywise_details cd
on 
    cr.constituency_id = cd.constituency_id
where constituency_name in ('HINDUPUR')

-- 13)Which parties won the most seats in a State, and how many seats did each party win?

select * from "Election_results".statewise_results;

select 
       
	   pr.party_name,
	   count(ca.party_id) as NO_of_seats
       
from 
      "Election_results".cw_results ca
join 
      "Election_results".pw_results pr
on
       ca.party_id = pr.party_id
join 
       "Election_results".statewise_results  sr
on 
       sr.parliament_constituency = ca.parliament_constituency
JOIN 
     "Election_results".states st 
on
      st.state_id = sr.state_id

where  st.state in ('Karnataka')
group by pr.party_name
order by NO_of_seats desc
;

-- 14)What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) 
--in each state for the India Elections 2024
select * from "Election_results". pw_results;

select 
       party_name,
	   won,
	   party_alliance
from "Election_results".pw_results
where party_alliance in ('NDA')
order by won desc

select 
       party_name,
	   won,
	   party_alliance
from "Election_results".pw_results
where party_alliance in ('I.N.D.I.A')
order by won desc

select 
       party_name,
	   won,
	   party_alliance
from "Election_results".pw_results
where party_alliance in ('OTHER')
order by won desc

-- 15)Which candidate received the highest number of EVM votes in each constituency (Top 10)?
SELECT 
       * 
FROM  "Election_results".constituencywise_details
--
with ranked_candidates as 
   (select 
       candidate,
       party,
	   evm_votes,
	   row_number() over(partition by constituency_id order by evm_votes desc) as row_num
	   
from "Election_results".constituencywise_details) 
select 
      candidate,
	  party,
	  evm_votes,
	  row_num
from ranked_candidates
where row_num = 1
order by evm_votes desc
limit 10

with ranked_candidates as 
   (select 
       cd.candidate,
       cd.party,
	   cr.constituency_name,
	   cd.evm_votes,
	   row_number() over(partition by cd.constituency_id order by cd.evm_votes desc) as row_num
	   
from "Election_results".constituencywise_details as cd
JOIN "Election_results".cw_results as cr
on cr.constituency_id = cd.constituency_id) 
select 
     candidate,
     party,
	 constituency_name,
	 evm_votes,
	 row_num
from ranked_candidates
where row_num = 1
order by evm_votes desc
limit 10

-- 16)Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

with ranked_candidates as 
   (select 
       cd.candidate,
       cd.party,
	   cr.constituency_name,
	   cd.evm_votes,
	   row_number() over(partition by cd.constituency_id order by cd.evm_votes desc) as row_num
	   
from "Election_results".constituencywise_details as cd
JOIN "Election_results".cw_results as cr
on cr.constituency_id = cd.constituency_id) 
select 
     constituency_name,
     candidate,
     party,
	 evm_votes,
	 row_num
from ranked_candidates
where row_num in (1,2)



-- 17)For the state of Maharashtra, what are the total number of seats, total number of candidates, 
--total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
SELECT 
    COUNT(DISTINCT (cr.Constituency_ID)) AS Total_Seats,
    COUNT(DISTINCT (cd.Candidate)) AS Total_Candidates,
    COUNT(DISTINCT (p.Party_name)) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    "Election_results".cw_results cr
JOIN 
    "Election_results".constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    "Election_results".statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    "Election_results".states s ON sr.State_ID = s.State_ID
JOIN 
    "Election_results".pw_results p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';
