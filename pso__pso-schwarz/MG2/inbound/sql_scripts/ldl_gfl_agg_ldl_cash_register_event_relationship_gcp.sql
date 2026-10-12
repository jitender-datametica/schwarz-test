/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: t_cash_register_event_relationship.sql
#----------------------------------------------------------------------------
# History:
# 1.0  28.11.2024  Andrzej Wandtke - ZKP - t_cash_register_event_relationship  - intial version
# 1.1  10.12.2024  Andrzej Wandtke - ZKP - add DELETE part
# 1.2  21.01.2025  Andrzej Wandtke - ZKP - Bug 63098 - set rel_bus_dt for 'ORIGINAL' section, change DELETE part
# 1.3  03.02.2025  Mihail Ivanov - ZKP - Bug 63647 - added new types of relationships (SUCCESSOR, PRICE_INFO_SEQ, RESUME)
# 1.4  12.02.2025  Mihail Ivanov - ZKP - Bug 63647 - added relationship type "SUCCESSOR" for scenarios of group 6 (Price info)
# 1.5  06.03.2025  Mihail Ivanov - ZKP - Bug 65902 - added relationship type "RETURN_SAME_ORIGINAL" links to each other return receipts that were made with same original purchase.
# 1.6  14.03.2025  Mihail Ivanov - ZKP - Bug 65781 - added relationship type "EVENT_AROUND_LOGOFF" receipts between a suspictious receipt and its "relevant"* successor
														*only certain types of events are considered for "successor", but before them there could be other events (keyboard lock/unlock)
														if there are such events that happened between the suspicious event and the "relevant" successor - we want to link them and show them

														additionally some optimization are made - T_TMP_ALL_RELEVANT_EVENTS created and then reused in several places

# 1.7  18.03.2025  Mihail Ivanov - ZKP - Bug 67057 - Excluded Cancelled,Aborted,Suspended returns from relationship type RETURN_SAME_ORIGINAL

# 1.8  24.03.2025  Mihail Ivanov - ZKP - Bug 67057 - Comparing CASHIER_NR instead of CASHIER_HASH for next event,
														because data from P_LEW_CORE is imported with hashes that generated differently
														This leads to multiple different hashes for same cashier+day+store

# 1.9  24.04.2025  Mihail Ivanov - ZKP - Changes:
											- Refactoring - one big INSERT with 7-8 CTEs is broken down to 3 temp tables with 2-3 CTEs each, and these tables are combined in final INSERT
												just for ease of maintenance and readability. There is no performance impact, code is more readable.
											- Changed logic for "RETURN_SAME_ORIGINAL" - now we create links with relationships only to the "first suspicious event" for "scenario 8"
												"the first SUSPICIOUS return" is actually the "second return" in cases when we have multiple returns with same original bon.
												the first return is not marked as suspicious,
												the second return is "the first suspicious return"
												all other returns are also suspicious but we do not create link where they are parent and the other events are linked to them - all events related to this scenario are linked to the first suspicious (second in total) return
												requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68261 (point2)

											- New relationship type "SUCC_ALL_NPI_EVENTS" (successor, all non-PriceInfo events) slightly different logic than "SUCCESSOR"
												the rel type SUCC_ALL_NPI_EVENTS considers also events like "key lock/unlock" as next event, and is relevant only for few "Price Info" scenarios for now.
												requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68723

# 1.10  24.04.2025  Mihail Ivanov - ZKP - Fixes:
											- Fixed logic how relationship type RETURN_SAME_ORIGINAL is created. Previous implementation caused bugs also in type "ORIGINAL" which are now resolved.
												now we take into account that a return marked for scenario 8, could also be marked for other scenarios, so rel type "ORIGINAL" is created for every unique receipt marked for any return scenario (as is rel type SELF)
												rel type "RETURN_SAME_ORIGINAL" only for returns marked for scenario 8, and if we have more than 1 return with same original purchase, links are created only for the earliest.

# 1.11  08.05.2025  Kamil Roszczyk - ZKP - changes:
											- added new relationship type "PRED_ALL_NPI_EVENTS" (predecessor, all non-PriceInfo events). Similar to "SUCC_ALL_NPI_EVENTS" but labels the event before the first price check in series
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68723

# 1.12  12.05.2025  Andrzej Wandtke - ZKP - changes: added explicit date conversion for SV_MIN_DT

# 1.13  20.05.2025  Kamil Roszczyk - ZKP - changes:
											- added "DEPOSIT_SAME_EAN" relationship for deposit return receipts (scenario_id = 2). Similar to "RETURN_SAME_ORIGINAL"
											- added temporary table ETL.T_TMP_DEPOSIT_PRODUCT_LINES to precalculate EAN groups due to readability and performance improvements
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/70656


TODO: next time this script is changed, we might break the big SQL for the final insert into several temporary tables.
	We are getting more and more CTEs and it is getting difficult to read.

*/

DECLARE SV_MIN_DT DATE;
DECLARE SV_MAX_DT DATE;

SET SV_MIN_DT = (SELECT min(bus_dt) FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED`);
SET SV_MAX_DT = (SELECT max(bus_dt) FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED`);


CREATE OR REPLACE TEMP TABLE T_TMP_ALL_RELEVANT_EVENTS
-- (
-- 	CASH_REGISTER_EVENT_SID,
-- 	CASH_REGISTER_EVENT_NR ,
-- 	BUS_DT ,
-- 	STORE_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	CASHIER_HASH ,
-- 	CASHIER_NR ,
-- 	CASH_REGISTER_SID ,
-- 	CASH_REGISTER_EVENT_TYPE_CD ,
-- 	EVENT_CATEGORY_CD 
-- )
AS
--All available cash register events as a base for calculations
SELECT
	pie.price_info_Event_sid as cash_register_event_sid
	, pie.cash_register_event_nr
	, pie.bus_dt
	, pie.store_sid
	, pie.country_org_cd
	, pie.cashier_hash
	, ce.cashier_nr
	, pie.cash_register_sid
	, 480 as cash_register_event_type_cd
	, 'PRICE_INFO_EVENT' as event_category_cd

FROM `${BQ_PROJECT_ID}.CORE_REL.T_PRICE_INFORMATION_EVENT` pie
	JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
			on sq.STORE_SID = pie.STORE_SID
			and sq.BUS_DT = pie.BUS_DT
			and sq.COUNTRY_ORG_CD = pie.COUNTRY_ORG_CD
	join `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
        on pie.cashier_hash = ce.cashier_hash

UNION ALL

SELECT
	re.retail_event_sid as cash_register_event_sid
	, re.cash_register_event_nr
	, re.bus_dt
	, re.store_sid
	, re.country_org_cd
	, re.cashier_hash
	, ce.cashier_nr
	, re.cash_register_sid
	, re.retail_event_scenario_id as cash_register_event_type_cd
	, 'RETAIL_EVENT' as event_category_cd
FROM `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re
	JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
			on sq.STORE_SID = re.STORE_SID
			and sq.BUS_DT = re.BUS_DT
			and sq.COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
	join `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
        on re.cashier_hash = ce.cashier_hash

UNION ALL

SELECT
	te.tech_cash_register_event_sid cash_register_event_sid
	, te.cash_register_event_nr
	, te.bus_dt
	, te.store_sid
	, te.country_org_cd
	, te.cashier_hash
	, ce.cashier_nr
	, te.cash_register_sid
	, CAST(te.tech_cash_register_event_type_cd AS BIGNUMERIC) as cash_register_event_type_cd
	, 'TECH_EVENT' as event_category_cd
FROM `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT` te
	JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
			on sq.STORE_SID = te.STORE_SID
			and sq.BUS_DT = te.BUS_DT
			and sq.COUNTRY_ORG_CD = te.COUNTRY_ORG_CD
	join `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
        on te.cashier_hash = ce.cashier_hash
;

----------------------------------------------------------------------------
--
-- Delete all the receipts from the scope currently selected (including original receipts)
--
DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP` trg
WHERE trg.CASH_REGISTER_EVENT_SID in
	(
		select CASH_REGISTER_EVENT_SID
		from T_TMP_ALL_RELEVANT_EVENTS
	)
;
--
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- Precalculate two types of "next event" and one type of "previous event" for each event in the given scope
-- 		NEXT_FILTERED_CASH_REGISTER_EVENT_SID 	is chosen from set of events that includes all retail events and SOME tech events, but excludes other tech events like "key lock/unlock"
--		NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID is chosen from set of events that includes all retail events and ALL tech events
--		PREV_UNFILTERED_CASH_REGISTER_EVENT_SID is chosen from set of events that includes all retail events and ALL tech events
--   for next events, in most cases we will get same event SID in both columns, but rarely they might be different
CREATE OR REPLACE TEMP TABLE T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	BUS_DT ,
-- 	STORE_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	NEXT_FILTERED_CASH_REGISTER_EVENT_SID ,
-- 	NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID ,
-- 	PREV_UNFILTERED_CASH_REGISTER_EVENT_SID 
-- )
AS
WITH
-- for these scenarios we look for "next event" of specific type
non_price_info_events AS
(
	SELECT
		tare.cash_register_event_sid
		,tare.cash_register_event_nr
		,tare.bus_dt
		,tare.store_sid
		,tare.country_org_cd
		,tare.cash_register_sid
		,tare.cashier_hash
		,tare.cashier_nr
		,tare.cash_register_event_type_cd
	FROM T_TMP_ALL_RELEVANT_EVENTS tare
	WHERE
		EVENT_CATEGORY_CD = 'RETAIL_EVENT'
		OR EVENT_CATEGORY_CD = 'TECH_EVENT' -- and cash_register_event_type_cd NOT IN (400, 405, 420, 425, 430))
)
,all_events as
(
	select *
	from non_price_info_events

	union all

	select
		pie.cash_register_event_sid
		,pie.cash_register_event_nr
		,pie.bus_dt
		,pie.store_sid
		,pie.country_org_cd
		,pie.cash_register_sid
		,pie.cashier_hash
		,pie.cashier_nr
		,pie.cash_register_event_type_cd
	FROM T_TMP_ALL_RELEVANT_EVENTS pie
	WHERE
		pie.EVENT_CATEGORY_CD = 'PRICE_INFO_EVENT'
)
-- for all events get the next event that is not "key lock/unlock"
,next_filtered_event as
(
    SELECT * FROM (
        -- for each event we get which non-price-info event comes after it
        SELECT
            ae.CASH_REGISTER_EVENT_SID
            ,ae.BUS_DT
            ,ae.STORE_SID
            ,ae.COUNTRY_ORG_CD

            ,npie.CASH_REGISTER_EVENT_SID as NEXT_FILTERED_CASH_REGISTER_EVENT_SID

            ,ae.CASH_REGISTER_EVENT_NR
            ,ae.CASHIER_NR
            ,ae.CASH_REGISTER_SID
            ,ROW_NUMBER() over (partition by ae.CASH_REGISTER_EVENT_SID order by npie.cash_register_event_nr asc) as rn
        FROM all_events ae
            left join non_price_info_events npie
                on ae.STORE_SID = npie.STORE_SID
                and ae.CASHIER_NR = npie.CASHIER_NR
                and ae.BUS_DT = npie.BUS_DT
                and ae.CASH_REGISTER_SID = npie.CASH_REGISTER_SID -- same cash register
                and npie.cash_register_event_type_cd NOT IN (400, 405, 420, 425, 430)
                and ae.cash_register_event_nr < npie.cash_register_event_nr
    ) WHERE rn = 1
)
,next_unfiltered_event as
(
    SELECT * FROM (
        -- for all events get the next event regardless if it is retail or tech event of any type, including "key lock/unlock"
        SELECT
            nfe.CASH_REGISTER_EVENT_SID
            ,nfe.BUS_DT
            ,nfe.STORE_SID
            ,nfe.COUNTRY_ORG_CD
            ,nfe.NEXT_FILTERED_CASH_REGISTER_EVENT_SID
            ,npie2.CASH_REGISTER_EVENT_SID as NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID
            ,nfe.CASH_REGISTER_EVENT_NR
            ,nfe.CASHIER_NR
            ,nfe.CASH_REGISTER_SID
            ,ROW_NUMBER() over (partition by nfe.CASH_REGISTER_EVENT_SID order by npie2.cash_register_event_nr asc) as rn
        FROM next_filtered_event nfe
            left join non_price_info_events npie2
                on nfe.STORE_SID = npie2.STORE_SID
                and nfe.CASHIER_NR = npie2.CASHIER_NR
                and nfe.BUS_DT = npie2.BUS_DT
                and nfe.CASH_REGISTER_SID = npie2.CASH_REGISTER_SID -- same cash register
                and nfe.cash_register_event_nr < npie2.cash_register_event_nr
    ) WHERE rn = 1
)
-- for all events get the next event regardless if it is retail or tech event of any type, including "key lock/unlock"
SELECT
    *
FROM (
    SELECT
        nue.CASH_REGISTER_EVENT_SID
        ,nue.BUS_DT
        ,nue.STORE_SID
        ,nue.COUNTRY_ORG_CD
        ,nue.NEXT_FILTERED_CASH_REGISTER_EVENT_SID
        ,nue.NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID
        ,npie3.CASH_REGISTER_EVENT_SID as PREV_UNFILTERED_CASH_REGISTER_EVENT_SID
        ,ROW_NUMBER() over (partition by nue.CASH_REGISTER_EVENT_SID order by npie3.cash_register_event_nr desc) as rn
    FROM next_unfiltered_event nue
        left join non_price_info_events npie3
            on nue.STORE_SID = npie3.STORE_SID
            and nue.CASHIER_NR = npie3.CASHIER_NR
            and nue.BUS_DT = npie3.BUS_DT
            and nue.CASH_REGISTER_SID = npie3.CASH_REGISTER_SID -- same cash register
            and nue.cash_register_event_nr > npie3.cash_register_event_nr
) WHERE rn = 1
;
--
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- precalculate series of PriceInfoEvents
--
CREATE OR REPLACE TEMP TABLE T_TMP_PRICE_INFO_SEQ
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	BUS_DT ,
-- 	STORE_SID ,
-- 	CASH_REGISTER_SID ,
-- 	GROUP_ID 
-- )
AS
WITH
all_events_with_change_fg as
(
	select
		ae.*
		, LAG(cash_register_event_type_cd, 1, -9999) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr) as prev_cash_register_event_type_cd
		, CASE
				WHEN cash_register_event_type_cd <> LAG(cash_register_event_type_cd, 1, -9999) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr) THEN 1
				ELSE 0
			END AS event_type_change_fg
		, ROW_NUMBER() OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr) AS rnk
	from T_TMP_ALL_RELEVANT_EVENTS ae
)
select
	aech.CASH_REGISTER_EVENT_SID
	,aech.BUS_DT
	,aech.STORE_SID
	,aech.CASH_REGISTER_SID
	,SUM(event_type_change_fg) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY rnk ROWS UNBOUNDED PRECEDING) AS GROUP_ID
from all_events_with_change_fg aech
WHERE aech.CASH_REGISTER_EVENT_TYPE_CD = 480
;
--
----------------------------------------------------------------------------




----------------------------------------------------------------------------
--
-- precalculate retail lines with deposit EAN group information
--
CREATE OR REPLACE TEMP TABLE T_TMP_DEPOSIT_PRODUCT_LINES
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	STORE_SID ,
-- 	BUS_DT ,
-- 	CASHIER_NR ,
-- 	EVENT_END_TMSP TIMESTAMP,
-- 	EAN_GROUP 
-- )
AS
SELECT * FROM (
    SELECT DISTINCT
        rl.retail_event_sid AS cash_register_event_sid
        , rl.country_org_cd
        , rl.store_sid
        , rl.bus_dt
        , ce.cashier_nr
        , re.event_end_tmsp
        , CASE
                /* Add length to the end to keep the information about it in the grouping.
                    Lenghts 19 and 24 are to be evaluated independently. */
                WHEN LENGTH(rl.prod_variant_input_nr) = 19 THEN SUBSTR(rl.prod_variant_input_nr, 1, 13) || '19'
                WHEN LENGTH(rl.prod_variant_input_nr) = 24 THEN SUBSTR(rl.prod_variant_input_nr, 1, 3) || SUBSTR(rl.prod_variant_input_nr, 15, 10) || '24'
                ELSE NULL
            END ean_group
        , COUNT(*) OVER (PARTITION BY rl.store_sid, ce.cashier_nr,
            CASE
                WHEN LENGTH(rl.prod_variant_input_nr) = 19 THEN SUBSTR(rl.prod_variant_input_nr, 1, 13) || '19'
                WHEN LENGTH(rl.prod_variant_input_nr) = 24 THEN SUBSTR(rl.prod_variant_input_nr, 1, 3) || SUBSTR(rl.prod_variant_input_nr, 15, 10) || '24'
                ELSE NULL
            END
          ) as count_per_group
    FROM
        `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` rl
    INNER JOIN
        `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re
            ON rl.retail_event_sid = re.retail_event_sid
    INNER JOIN
        `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
            ON rl.cashier_hash = ce.cashier_hash
    WHERE
        rl.turnover_relevant_fg = True
        AND rl.prod_retail_line_type_cd = 'D' /* Deposit Return Receipt */
        AND LENGTH(rl.prod_variant_input_nr) IN (19,24)
        AND rl.bus_dt >= DATE_SUB(SV_MIN_DT, INTERVAL 30 DAY)
        AND EXISTS
            (
                SELECT 1
                FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
                WHERE sq.STORE_SID = rl.STORE_SID
                AND sq.COUNTRY_ORG_CD = rl.COUNTRY_ORG_CD
            )
) WHERE count_per_group > 1
;
--
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- Create a temp table with rel types "SELF", "RESUME", "PRICE_INFO_SEQ" - calculated easily within one CTE each
--
CREATE OR REPLACE TEMP TABLE T_TMP_GENERIC_REL
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	CASH_REGISTER_EVENT_REL_TYPE_CD ,
-- 	REL_CASH_REGISTER_EVENT_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	BUS_DT ,
-- 	REL_BUS_DT 
-- ) 
AS
WITH
self_rel as
(
	SELECT
		DISTINCT
		fact.cash_register_event_sid 	AS cash_register_event_sid
		,'SELF'                       	AS cash_register_event_rel_type_cd
		,fact.cash_register_event_sid 	AS rel_cash_register_event_sid
		,fact.country_org_cd
		,fact.bus_dt
		,fact.bus_dt                  	AS rel_bus_dt
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
		JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
				on sq.STORE_SID = fact.STORE_SID
				and sq.BUS_DT = fact.BUS_DT
				and sq.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
)
,susp_and_resume_rel as
(
	SELECT
		-- CASH_REGISTER_EVENT_SID is suspended, and then resumed by REL_CASH_REGISTER_EVENT_SID
		DISTINCT
		fact.cash_register_event_sid		AS cash_register_event_sid
		,'RESUME' 							AS cash_register_event_rel_type_cd
		,resume.RETAIL_EVENT_SID			AS rel_cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
		,resume.BUS_DT 						AS rel_bus_dt

	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
		JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
				on sq.STORE_SID = fact.STORE_SID
				and sq.BUS_DT = fact.BUS_DT
				and sq.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
		JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO` s
				ON s.SCENARIO_ID = fact.SCENARIO_ID
				and s.SCENARIO_GRP_ID = 1 -- Scenario for Aborted/Suspended receipts (Bonabbruch/Bonrückstellung)

		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` resume
				on resume.SUSP_RETAIL_EVENT_SID = fact.CASH_REGISTER_EVENT_SID
				and resume.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
				and resume.BUS_DT >= fact.BUS_DT -- a resume event cannot happen before the suspended event

)
-- when we generate all SIDs between the "original" receipt and its "successor" in advance we can use "=" in the join
-- we do this to avoid joins using ">" and "<" between big tables  "successor_rel" and "T_TMP_ALL_RELEVANT_EVENTS"
,price_info_seq as
(
	SELECT
			DISTINCT -- should be unnecessary because we are taking 1 scenario only
			fact.cash_register_event_sid		AS cash_register_event_sid
			,'PRICE_INFO_SEQ' 					AS cash_register_event_rel_type_cd
			,pis2.CASH_REGISTER_EVENT_SID		AS rel_cash_register_event_sid
			,fact.country_org_cd				AS country_org_cd
			,fact.bus_dt						AS bus_dt
			,pis2.BUS_DT 						AS rel_bus_dt

	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
		JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
				on sq.STORE_SID = fact.STORE_SID
				and sq.BUS_DT = fact.BUS_DT
				and sq.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
		join T_TMP_PRICE_INFO_SEQ pis1
				on pis1.CASH_REGISTER_EVENT_SID = fact.CASH_REGISTER_EVENT_SID
		join T_TMP_PRICE_INFO_SEQ pis2 -- take all events that belong to same group_id, same day, same cash_register_sid
				on pis1.BUS_DT = pis2.BUS_DT
        		and pis1.CASH_REGISTER_SID = pis2.CASH_REGISTER_SID
				and pis1.GROUP_ID = pis2.GROUP_ID -- events belong to same sequence(series)
                and pis1.CASH_REGISTER_EVENT_SID <> pis2.CASH_REGISTER_EVENT_SID -- take only the "other" receipts from the sequence
	WHERE fact.SCENARIO_ID = 5
)
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM self_rel
UNION ALL
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM susp_and_resume_rel
UNION ALL
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM price_info_seq
;
--
----------------------------------------------------------------------------






----------------------------------------------------------------------------
--
-- Create temp table with rel types for returns ("ORIGINAL" and "RETURN_SAME_ORIGINAL")
--
CREATE OR REPLACE TEMP TABLE T_TMP_ORIGINAL_REL
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	CASH_REGISTER_EVENT_REL_TYPE_CD ,
-- 	REL_CASH_REGISTER_EVENT_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	BUS_DT ,
-- 	REL_BUS_DT 
-- )
 AS
WITH
return_original_purch_rel as
(
	SELECT
		DISTINCT
		fact.cash_register_event_sid		AS cash_register_event_sid
		,'ORIGINAL'							AS cash_register_event_rel_type_cd
		,rl.orig_sales_event_sid			AS rel_cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
		,orig.BUS_DT 						AS rel_bus_dt

	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
		JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
				on sq.STORE_SID = fact.STORE_SID
				and sq.BUS_DT = fact.BUS_DT
				and sq.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
		JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO` s
				ON s.SCENARIO_ID = fact.SCENARIO_ID
				and s.SCENARIO_GRP_ID = 2 -- scenarios for returns (Geldrückgabe)

		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` rl
				ON fact.cash_register_event_sid = rl.retail_event_sid
				AND fact.country_org_cd =  rl.country_org_cd
				and fact.BUS_DT = rl.BUS_DT
		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` orig
				on orig.RETAIL_EVENT_SID = rl.orig_sales_event_sid
				and orig.country_org_cd = sq.country_org_cd
				and orig.BUS_DT >= DATE_SUB(SV_MIN_DT, INTERVAL 365 DAY) 		-- assuming we cannot have a return more than a year after a purchase

    where orig.country_org_cd in (select distinct country_org_cd from `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED`)
)
-- when return is flagged for "scenario 8" (multiple returns with same original purchase receipt)
-- we want to link all other returns made with same original purchase to the FIRST(EARLIEST) flagged return receipt
,first_of_multi_returns as
(
    SELECT * FROM (
        SELECT
            ropr.CASH_REGISTER_EVENT_SID,
            row_number() over (partition by ropr.REL_CASH_REGISTER_EVENT_SID order by re_r.EVENT_END_TMSP asc) as rn
        FROM return_original_purch_rel ropr
            -- only returns qualified for scenario 8 "Multiple returns with same original receipt"
            join `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` s8
                on ropr.CASH_REGISTER_EVENT_SID = s8.CASH_REGISTER_EVENT_SID
                and s8.SCENARIO_ID = 8
            join `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re_r
                on re_r.RETAIL_EVENT_SID = ropr.CASH_REGISTER_EVENT_SID
    ) WHERE rn = 1
)
,return_same_receipt_additional_rel as
(
	SELECT
		DISTINCT
		ropr.CASH_REGISTER_EVENT_SID  	-- SID of the Return to which we want to link other Returns
		,'RETURN_SAME_ORIGINAL'			AS cash_register_event_rel_type_cd
		,prl.RETAIL_EVENT_SID			AS rel_cash_register_event_sid	-- SID of the "other" Return
		,ropr.COUNTRY_ORG_CD			AS country_org_cd
		,ropr.BUS_DT					AS bus_dt						-- date of Return
		,prl.BUS_DT 					AS rel_bus_dt					-- date of Purchase
	FROM return_original_purch_rel ropr
		-- all OTHER returns made with same original purchase
		join `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` prl
			on prl.ORIG_SALES_EVENT_SID = ropr.REL_CASH_REGISTER_EVENT_SID
            and prl.COUNTRY_ORG_CD = ropr.COUNTRY_ORG_CD
            and prl.BUS_DT >= DATE_SUB(SV_MIN_DT, INTERVAL 365 DAY) -- orig purchases are bigger than this date, so the other returns will also have bigger date
			and prl.RETAIL_EVENT_SID <> ropr.CASH_REGISTER_EVENT_SID
		join `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re
			on re.RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID
            and re.COUNTRY_ORG_CD = ropr.COUNTRY_ORG_CD
            and re.BUS_DT >= DATE_SUB(SV_MIN_DT, INTERVAL 365 DAY) -- orig purchases are bigger than this date, so the other returns will also have bigger date

	-- we link only "actual" returns, not Cancelled,Aborted,Suspended ...
	WHERE 1=1
		and prl.TURNOVER_RELEVANT_FG = TRUE
		and re.TURNOVER_RELEVANT_FG = TRUE

		-- only returns that are marked for "Scenario 8" - "Multiple returns with same original receipt"
		-- and only the earliest return per original purchase
		and ropr.CASH_REGISTER_EVENT_SID in
			(
				SELECT CASH_REGISTER_EVENT_SID
				FROM first_of_multi_returns
			)
)
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM return_original_purch_rel
UNION ALL
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM return_same_receipt_additional_rel
;
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- Create temp table with "SUCCESSOR" relationship type and types derived from it ( EVENT_AROUND_LOGOFF)
--
CREATE OR REPLACE TEMP TABLE T_TMP_SUCCESSOR_REL
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	CASH_REGISTER_EVENT_REL_TYPE_CD ,
-- 	REL_CASH_REGISTER_EVENT_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	BUS_DT ,
-- 	REL_BUS_DT 
-- ) 
AS
WITH
------------------------------------------------
-- rel type "SUCC_ALL_NPI_EVENTS" and "PRED_ALL_NPI_EVENTS"
events_for_successor_predecessor_all_npi_events_rel as
(
	SELECT
		DISTINCT
		fact.cash_register_event_sid		AS cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
		JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
				on sq.STORE_SID = fact.STORE_SID
				and sq.BUS_DT = fact.BUS_DT
				and sq.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
		JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO` s
				ON s.SCENARIO_ID = fact.SCENARIO_ID

	WHERE s.SCENARIO_ID = 5 -- AUTO scenario for "Multpliple price checks in a row" (this type of relationship is required only for that scenario so far)
)
--
-- for "SUCC_ALL_NPI_EVENTS" we are looking for "next event", which could be ANY type RetailEvent (sale or return) and ANY types of technical events (so UNfiltered tech events)
,successor_all_npi_events_rel as
(
	SELECT
		fact.cash_register_event_sid					AS cash_register_event_sid
		,'SUCC_ALL_NPI_EVENTS' 							AS cash_register_event_rel_type_cd
		-- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
		,IFNULL(enpe.NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID,-1)	AS rel_cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
		,enpe.BUS_DT 						AS rel_bus_dt

	FROM events_for_successor_predecessor_all_npi_events_rel fact
		JOIN T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT enpe
				on fact.CASH_REGISTER_EVENT_SID = enpe.CASH_REGISTER_EVENT_SID
				and fact.BUS_DT = enpe.BUS_DT -- next event is always on the same date
)
--
-- for "PRED_ALL_NPI_EVENTS" we are looking for "previous event", which could be ANY type RetailEvent (sale or return) and ANY types of technical events (so UNfiltered tech events)
,predecessor_all_npi_events_rel as
(
	SELECT
		fact.cash_register_event_sid					AS cash_register_event_sid
		,'PRED_ALL_NPI_EVENTS' 							AS cash_register_event_rel_type_cd
		-- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
		,IFNULL(enpe.PREV_UNFILTERED_CASH_REGISTER_EVENT_SID,-1)	AS rel_cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
		,enpe.BUS_DT 						AS rel_bus_dt

	FROM events_for_successor_predecessor_all_npi_events_rel fact
		JOIN T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT enpe
				on fact.CASH_REGISTER_EVENT_SID = enpe.CASH_REGISTER_EVENT_SID
				and fact.BUS_DT = enpe.BUS_DT -- next event is always on the same date
)
------------------------------------------------
-- rel type "SUCCESSOR"
,events_for_successor as
(
	SELECT
		DISTINCT
		fact.cash_register_event_sid		AS cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
	FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
		JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
				on sq.STORE_SID = fact.STORE_SID
				and sq.BUS_DT = fact.BUS_DT
				and sq.COUNTRY_ORG_CD = fact.COUNTRY_ORG_CD
		JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO` s
				ON s.SCENARIO_ID = fact.SCENARIO_ID

	WHERE s.SCENARIO_GRP_ID = 1 -- Scenarios for Aborted/Suspended receipts (Bonabbruch/Bonrückstellung)
		or s.SCENARIO_ID in (6, 36, 51, 52) -- AUTO and MANUAL scenarios for "Price Checks", but not "Multpliple price checks in a row"
)

--
-- for "SUCCESSOR" we are looking for "next event", which could be ANY type RetailEvent (sale or return) and SOME types of technical events (so filtered tech events)
,successor_rel as
(
	SELECT
		fact.cash_register_event_sid							AS cash_register_event_sid
		,'SUCCESSOR' 											AS cash_register_event_rel_type_cd
		-- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
		,IFNULL(ene.NEXT_FILTERED_CASH_REGISTER_EVENT_SID,-1)		AS rel_cash_register_event_sid
		,fact.country_org_cd				AS country_org_cd
		,fact.bus_dt						AS bus_dt
		,ene.BUS_DT 						AS rel_bus_dt

	FROM events_for_successor fact
		JOIN T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT ene
				on fact.CASH_REGISTER_EVENT_SID = ene.CASH_REGISTER_EVENT_SID
				and fact.BUS_DT = ene.BUS_DT -- next event is always on the same date
)
------------------------------------------------
-- rel type "EVENT_AROUND_LOGOFF"
--
-- when we generate all SIDs between the "original" receipt and its "successor" in advance we can use "=" in the join
-- we do this to avoid joins using ">" and "<" between big tables  "successor_rel" and "T_TMP_ALL_RELEVANT_EVENTS"
,successor_rel_extended as
(
	SELECT
		sr.*
		,sr.cash_register_event_sid + RN  as AROUND_SUCCESSOR_SID -- when we increase SID with small number (less than 10,000,000) we are guanrateed to get new sid in same Date, Store and CashRegister
	FROM successor_rel sr
		, UNNEST(GENERATE_ARRAY(1,100)) as RN
    WHERE sr.REL_CASH_REGISTER_EVENT_SID > -1 
		-- exclude dummy successors
		-- if successor has EventNR=7 and original has EventNR = 3 the difference is 4, and we need  RN=1,2,3 to produce EventNR 4,5,6
		-- we also need the produce the next event, after 7 -> so we take row number up to  "Diff+1"
		-- 		This will give us Evnets (4,5,6,7***,8)
		--		***in the NEXT CTE however we must make sure we exclude "7" because this is the "SUCCESSOR"
		AND RN <= (sr.rel_cash_register_event_sid - sr.cash_register_event_sid) + 1
		-- Take only events for some scenarios - we want "pre_successors" only for them
		and exists
		(
			SELECT 1
			FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
			WHERE fact.CASH_REGISTER_EVENT_SID = sr.CASH_REGISTER_EVENT_SID
				and fact.SCENARIO_ID in (
						6	--	Preisanzeige + Kleinstbon oder Abmeldung Kasse
						,16	--	Offene Bonrückstellung + Kleinstbon o. Abmeldung Kasse
						,17	--	Bonabbruch + Kleinstbon oder Abmeldung Kasse
					)
		)
)
,event_around_logoff_rel as
(
	SELECT
		sre.CASH_REGISTER_EVENT_SID			AS cash_register_event_sid
		,'EVENT_AROUND_LOGOFF' 				AS cash_register_event_rel_type_cd
		,ae.CASH_REGISTER_EVENT_SID			AS rel_cash_register_event_sid
		,sre.country_org_cd					AS country_org_cd
		,sre.bus_dt							AS bus_dt
		,ae.BUS_DT 							AS rel_bus_dt
	FROM successor_rel_extended sre
		join T_TMP_ALL_RELEVANT_EVENTS ae
			on ae.BUS_DT = sre.BUS_DT
			and ae.CASH_REGISTER_EVENT_SID = sre.AROUND_SUCCESSOR_SID
			-- we already have relationship of type "SUCCESSOR" with REL_CASH_REGISTER_EVENT_SID - so we exclude it
			and ae.CASH_REGISTER_EVENT_SID <> sre.REL_CASH_REGISTER_EVENT_SID
)
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM successor_all_npi_events_rel
UNION ALL
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM predecessor_all_npi_events_rel
UNION ALL
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM successor_rel
UNION ALL
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
FROM event_around_logoff_rel
;
----------------------------------------------------------------------------




----------------------------------------------------------------------------
--
-- Create temp table with "DEPOSIT_SAME_EAN" relationship type
--
CREATE OR REPLACE TEMP TABLE T_TMP_DEPOSIT_REL
-- (
-- 	CASH_REGISTER_EVENT_SID ,
-- 	CASH_REGISTER_EVENT_REL_TYPE_CD ,
-- 	REL_CASH_REGISTER_EVENT_SID ,
-- 	COUNTRY_ORG_CD ,
-- 	BUS_DT ,
-- 	REL_BUS_DT 
-- ) 
AS
WITH
	--Receipts from classification table for scenario_id = 2 - only suspicious
	suspicious_deposit_receipts AS
		(
			SELECT
				fact.cash_register_event_sid
				, fact.country_org_cd
				, fact.bus_dt
			FROM
				`${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION` fact
			INNER JOIN
				`${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
					ON sq.store_sid = fact.store_sid
					AND sq.country_org_cd = fact.country_org_cd
					AND sq.bus_dt = fact.bus_dt
			WHERE
				fact.scenario_id = 2
		)
	--Marking the groups from temporary table suspicious based on the input from suspicious_deposit_receipts CTE
	, all_deposit_groups AS
		(
			SELECT DISTINCT
				dpl.cash_register_event_sid
				, dpl.country_org_cd
				, dpl.bus_dt
				, dpl.store_sid
				, dpl.cashier_nr
				, dpl.event_end_tmsp
				, dpl.ean_group
				, IF(sdr.cash_register_event_sid IS NULL, 0, 1) AS suspicious_fg
			FROM
				T_TMP_DEPOSIT_PRODUCT_LINES dpl
			LEFT OUTER JOIN
				suspicious_deposit_receipts sdr
					ON sdr.cash_register_event_sid = dpl.cash_register_event_sid
					AND sdr.country_org_cd =  dpl.country_org_cd
					AND sdr.bus_dt = dpl.bus_dt
		)
	, deposit_groups_filtered AS
		(
			SELECT
				*
			FROM (
                SELECT
                    *,
                    --Take only these EAN groups where at least one receipt is marked suspicious
                    SUM(suspicious_fg) OVER(PARTITION BY ean_group) as sum_suspicious,
                    --Take only these EAN groups where exactly one receipt is marked non suspicious
                    --This filter will discard multiple entries for the same receipt where, apart from suspicious EAN numbers, there is any EAN number that was not suspicious
                    SUM(IF(suspicious_fg = 0, 1, 0)) OVER(PARTITION BY ean_group) as sum_not_suspicious
                FROM all_deposit_groups
            )
			WHERE sum_suspicious > 0 AND sum_not_suspicious = 1
		)
	, first_suspicious AS
		(
			SELECT
				*
			FROM (
                SELECT
                    *,
                    --For all suspicious receipts, find only the first one by a time precedence
                    --This receipt will be a "parent" one in the report
                    ROW_NUMBER() OVER(PARTITION BY ean_group ORDER BY event_end_tmsp) as rn
                FROM
                    deposit_groups_filtered
                WHERE
                    suspicious_fg = 1
            )
			WHERE rn = 1
		)
SELECT
    fs.cash_register_event_sid			AS cash_register_event_sid
    ,'DEPOSIT_SAME_EAN' 				AS cash_register_event_rel_type_cd
    ,f.cash_register_event_sid			AS rel_cash_register_event_sid
    ,fs.country_org_cd					AS country_org_cd
    ,fs.bus_dt							AS bus_dt
    ,f.bus_dt 							AS rel_bus_dt
FROM
	--"Parent" receipts
    first_suspicious fs
INNER JOIN
	--"Child" receipt - all related to the same EAN group apart from "parent"
    deposit_groups_filtered f
        ON fs.ean_group = f.ean_group
        AND fs.cash_register_event_sid <> f.cash_register_event_sid
;








INSERT INTO `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP`
(
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
WITH
all_rels as
(
	SELECT *
	FROM T_TMP_GENERIC_REL
	UNION ALL
	SELECT *
	FROM T_TMP_ORIGINAL_REL
	UNION ALL
	SELECT *
	FROM T_TMP_SUCCESSOR_REL
	UNION ALL
	SELECT *
	FROM T_TMP_DEPOSIT_REL
)
SELECT
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_REL_TYPE_CD
	,REL_CASH_REGISTER_EVENT_SID
	,COUNTRY_ORG_CD
	,BUS_DT
	,REL_BUS_DT
	,current_timestamp()	as DWH_CREATED_TMSP
	,current_timestamp()	as DWH_UPDATED_TMSP
	,${LOAD_ID}				as DWH_LOAD_ID
	,'CORE_REL'				as DWH_NODE_CD
FROM all_rels
ORDER BY COUNTRY_ORG_CD
;
