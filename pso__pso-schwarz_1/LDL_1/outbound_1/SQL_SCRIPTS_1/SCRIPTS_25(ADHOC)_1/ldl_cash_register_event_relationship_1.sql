/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_event_relationship.sql
#----------------------------------------------------------------------------
# History:
# 1.0  28.11.2024  Andrzej Wandtke - ZKP - t_cash_register_event_relationship_1  - intial version
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
												now we take into account_1 that a return marked for scenario 8, could also be marked for other scenarios, so rel type "ORIGINAL" is created for every unique receipt marked for any return scenario (as is rel type SELF)
												rel type "RETURN_SAME_ORIGINAL" only for returns marked for scenario 8, and if we have more than 1 return with same original purchase, links are created only for the earliest.

# 1.11  08.05.2025  Kamil Roszczyk - ZKP - changes:
											- added new relationship type "PRED_ALL_NPI_EVENTS" (predecessor, all non-PriceInfo events). Similar to "SUCC_ALL_NPI_EVENTS" but labels the event before the first price check in series
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68723
												
# 1.12  12.05.2025  Andrzej Wandtke - ZKP - changes: added explicit date conversion for SV_MIN_DT

# 1.13  20.05.2025  Kamil Roszczyk - ZKP - changes:
											- added "DEPOSIT_SAME_EAN" relationship for deposit return receipts (scenario_id = 2). Similar to "RETURN_SAME_ORIGINAL"
											- added temporary table etl.T_TMP_DEPOSIT_PRODUCT_LINES to precalculate EAN_1 groups due to readability and performance improvements
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/70656

# 1.14 20.08.2025	Mihail Ivanov		 - changes:
											- changed logic for EVENT_AROUND_LOGOFF - now take all events before "logoff" or "small sale" (as before)
												but take next event only after "Logoff" and only if this event is "Login"
													requested here: https://jira.schwarz/browse/NEOGFPL-71590
											- Add filter to exclude training receipts - as of this time TRAINING_FG is not correctly set in ldl_data_core_rel tables so we use retail_event_scenario_id
													https://jira.schwarz/browse/NEOGFPL-71572

# 1.15 28.08.2025  Andrzej Wandtke    - Add relationship DEPOSIT_SAME_VALUE (scenario 75)
#                                      https://jira.schwarz/browse/NEOGFPL-71582

# 1.16 01.09.2025  Mihail Ivanov      - Add sub-scenario 740200 "Transaktionen außerhalb Öffnungszeiten | Gelrückgabe (Return)" to relationship type "ORIGINAL"
#                                      	Requested here https://jira.schwarz/browse/NEOGFPL-71579
# 1.17 18.09.2025  Andrzej Wandtke    - Relationship DEPOSIT_SAME_VALUE - look for matches on line level, not on receipt level
#                                      https://jira.schwarz/browse/NEOGFPL-71582


# 1.18 31.10.2025  Mihail Ivanov      - New sub-scenarios added for Relationship type "EVENT_AROUND_LOGOFF"
												670100,'MAN','Anzahl Bonabbruch direkt vor Kleinstbon'
												670200,'MAN','Anzahl Bonabbruch direkt vor Abmeldung'
												680100,'MAN','Anzahl offene Bonrückstellung direkt vor Kleinstbon'
												680200,'MAN','Anzahl offene Bonrückstellung direkt vor Abmeldung'
#                                      		requsted here: https://jira.schwarz/browse/NEOGFPL-71683


# 1.19 31.10.2025  Andrzej Wandtke     - Remove scenario 36 from relationship type "SUCCESSOR", CTE events_for_successor
#                                      		requsted here: https://jira.schwarz/browse/NEOGFPL-71682


# 1.20 05.11.2025  Mihail Ivanov      - New scenarios added for Relationship type "EVENT_AROUND_LOGOFF"
												5	Mehrfache Preisanzeige in Folge
												6	Preisanzeige + Kleinstbon oder Abmeldung Kasse
										New scenario added for relationship type PRICE_INFO_SEQ
												50	Gesamtanzahl Preisanzeigen | Vorgänge > X Preisanzeigen in Folge
										requested here: https://jira.schwarz/browse/NEOGFPL-71688

								
# 1.21 03.02.2026  Marcin Malec       - Add new column event_start_tmsp and fill with data
#                                       https://jira.schwarz/browse/NEOGFPL-71676


*/



--!SET exit_on_error=True;

BEGIN
DECLARE SV_MIN_DT DATE;
DECLARE SV_MAX_DT DATE;
-- SET SV_MIN_DT = (SELECT min(bus_dt) FROM ETL.T_STORES_QUALIFIED_1);
SET SV_MIN_DT = (
  SELECT
      min(t_stores_qualified.bus_dt)
    from
      ldl_data_etl.t_stores_qualified_1 
);
-- SET SV_MAX_DT = (SELECT max(bus_dt) FROM ETL.T_STORES_QUALIFIED_1);
SET SV_MAX_DT = (
  SELECT
      max(t_stores_qualified.bus_dt)
    from
      ldl_data_etl.t_stores_qualified_1
);

CREATE OR REPLACE TEMPORARY TABLE t_tmp_all_relevant_events (
cash_register_event_sid BIGNUMERIC(38,0),
cash_register_event_nr BIGNUMERIC(38,0),
bus_dt DATE,
store_sid BIGNUMERIC(38,0),
country_org_cd STRING(2),
cashier_hash STRING(32),
cashier_nr STRING(20),
cash_register_sid BIGNUMERIC(38,0),
cash_register_event_type_cd BIGNUMERIC(38,0),
event_category_cd STRING(16)
) AS
--All available cash register events as a base for calculations
SELECT PIE.price_info_event_sid AS cash_register_event_sid,
 PIE.cash_register_event_nr,
 PIE.bus_dt,
 PIE.store_sid,
 PIE.country_org_cd,
 PIE.cashier_hash,
 CE.cashier_nr,
 PIE.cash_register_sid,
 480 AS cash_register_event_type_cd,
 'PRICE_INFO_EVENT' AS event_category_cd
FROM ldl_data_core_rel.t_price_information_event_1 AS PIE
 INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON PIE.store_sid = SQ.store_sid AND PIE.bus_dt = SQ.bus_dt AND PIE.country_org_cd
    = SQ.country_org_cd
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption_1 AS CE ON PIE.cashier_hash = CE.cashier_hash
UNION ALL
SELECT RE.retail_event_sid AS cash_register_event_sid,
 RE.cash_register_event_nr,
 RE.bus_dt,
 RE.store_sid,
 RE.country_org_cd,
 RE.cashier_hash,
 CE.cashier_nr,
 RE.cash_register_sid,
 RE.retail_event_scenario_id AS cash_register_event_type_cd,
 'RETAIL_EVENT' AS event_category_cd
FROM ldl_data_core_rel.t_retail_event_1 AS RE_1
 INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON RE.store_sid = SQ.store_sid AND RE.bus_dt = SQ.bus_dt AND RE.country_org_cd
    = SQ.country_org_cd
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption_1 AS CE ON RE.cashier_hash = CE.cashier_hash
WHERE 
 -- exclude training receipts
 RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)
UNION ALL
SELECT TE.tech_cash_register_event_sid AS cash_register_event_sid,
 TE.cash_register_event_nr,
 TE.bus_dt,
 TE.store_sid,
 TE.country_org_cd,
 TE.cashier_hash,
 CE.cashier_nr,
 TE.cash_register_sid,
 ROUND(CAST(TE.tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS cash_register_event_type_cd,
 'TECH_EVENT' AS event_category_cd
FROM ldl_data_core_rel.t_technical_cash_register_event_1 AS TE
 INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON TE.store_sid = SQ.store_sid AND TE.bus_dt = SQ.bus_dt AND TE.country_org_cd
    = SQ.country_org_cd
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption_1 AS CE ON TE.cashier_hash = CE.cashier_hash;

----------------------------------------------------------------------------
--
-- Delete all the receipts from the scope currently selected (including original receipts)
--
DELETE FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_1 AS TRG
WHERE cash_register_event_sid IN (SELECT cash_register_event_sid
  FROM t_tmp_all_relevant_events);

--
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- Precalculate two types of "next event" and one type of "previous event" for each event in the given scope
-- 		NEXT_FILTERED_CASH_REGISTER_EVENT_SID 	is chosen from set of events that includes all retail events and SOME tech events, but excludes other tech events like "key lock/unlock"
--		NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID is chosen from set of events that includes all retail events and ALL tech events
--		PREV_UNFILTERED_CASH_REGISTER_EVENT_SID is chosen from set of events that includes all retail events and ALL tech events
--   for next events, in most cases we will get same event SID in both columns, but rarely they might be different

CREATE OR REPLACE TEMPORARY TABLE t_tmp_event_and_next_and_prev_event AS WITH NON_PRICE_INFO_EVENTS AS (
  -- for these scenarios we look for "next event" of specific type
  SELECT cash_register_event_sid,
   cash_register_event_nr,
   bus_dt,
   store_sid,
   country_org_cd,
   cash_register_sid,
   cashier_hash,
   cashier_nr,
   cash_register_event_type_cd
  FROM t_tmp_all_relevant_events AS TARE
  WHERE event_category_cd = 'RETAIL_EVENT'
   OR event_category_cd = 'TECH_EVENT'), ALL_EVENTS AS (SELECT *
   FROM NON_PRICE_INFO_EVENTS
   UNION ALL
   SELECT cash_register_event_sid,
    cash_register_event_nr,
    bus_dt,
    store_sid,
    country_org_cd,
    cash_register_sid,
    cashier_hash,
    cashier_nr,
    cash_register_event_type_cd
   FROM t_tmp_all_relevant_events AS PIE
   WHERE event_category_cd = 'PRICE_INFO_EVENT'), NEXT_FILTERED_EVENT AS (
  -- for all events get the next event that is not "key lock/unlock"
  SELECT -- for each event we get which non-price-info event comes after it
   ae.cash_register_event_sid,
   ae.bus_dt,
   ae.store_sid,
   ae.country_org_cd,
   npie.cash_register_event_sid AS next_filtered_cash_register_event_sid,
   ae.cash_register_event_nr,
   ae.cashier_nr,
   ae.cash_register_sid
  FROM ALL_EVENTS AS ae
   LEFT JOIN NON_PRICE_INFO_EVENTS AS npie ON ae.store_sid = npie.store_sid AND ae.cashier_nr = npie.cashier_nr AND ae.bus_dt
         = npie.bus_dt AND ae.cash_register_sid = npie.cash_register_sid -- same cash register
         AND ae.cash_register_event_nr < npie.cash_register_event_nr
       AND npie.cash_register_event_type_cd NOT IN (400, 405, 420, 425, 430)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY ae.cash_register_event_sid ORDER BY npie.cash_register_event_nr
        IS NULL, npie.cash_register_event_nr)) = 1), NEXT_UNFILTERED_EVENT AS (
  -- for all events get the next event regardless if it is retail or tech event of any type, including "key lock/unlock"
  SELECT nfe.cash_register_event_sid,
   nfe.bus_dt,
   nfe.store_sid,
   nfe.country_org_cd,
   nfe.next_filtered_cash_register_event_sid,
   npie2.cash_register_event_sid AS next_unfiltered_cash_register_event_sid,
   nfe.cash_register_event_nr,
   nfe.cashier_nr,
   nfe.cash_register_sid
  FROM NEXT_FILTERED_EVENT AS nfe
   LEFT JOIN NON_PRICE_INFO_EVENTS AS npie2 ON nfe.store_sid = npie2.store_sid AND nfe.cashier_nr = npie2.cashier_nr AND
       nfe.bus_dt = npie2.bus_dt AND nfe.cash_register_sid = npie2.cash_register_sid -- same cash register
       AND nfe.cash_register_event_nr < npie2.cash_register_event_nr
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY nfe.cash_register_event_sid ORDER BY npie2.cash_register_event_nr
        IS NULL, npie2.cash_register_event_nr)) = 1) (
  -- for all events get the next event regardless if it is retail or tech event of any type, including "key lock/unlock"
  SELECT nue.cash_register_event_sid,
   nue.bus_dt,
   nue.store_sid,
   nue.country_org_cd,
   nue.next_filtered_cash_register_event_sid,
   nue.next_unfiltered_cash_register_event_sid,
   npie3.cash_register_event_sid AS prev_unfiltered_cash_register_event_sid
  FROM NEXT_UNFILTERED_EVENT AS nue
   LEFT JOIN NON_PRICE_INFO_EVENTS AS npie3 ON nue.store_sid = npie3.store_sid AND nue.cashier_nr = npie3.cashier_nr AND
       nue.bus_dt = npie3.bus_dt AND nue.cash_register_sid = npie3.cash_register_sid -- same cash register
       AND nue.cash_register_event_nr > npie3.cash_register_event_nr
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY nue.cash_register_event_sid ORDER BY npie3.cash_register_event_nr
        IS NULL DESC, npie3.cash_register_event_nr DESC)) = 1);
--
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- precalculate series of PriceInfoEvents
--

CREATE OR REPLACE TEMPORARY TABLE t_tmp_price_info_seq AS WITH ALL_EVENTS_WITH_CHANGE_FG AS (SELECT cash_register_event_sid,
   cash_register_event_nr,
   bus_dt,
   store_sid,
   country_org_cd,
   cashier_hash,
   cashier_nr,
   cash_register_sid,
   cash_register_event_type_cd,
   event_category_cd,
   LAG(cash_register_event_type_cd, 1, CAST(- 9999 AS BIGNUMERIC)) OVER (PARTITION BY bus_dt, cash_register_sid
      ORDER BY cash_register_event_nr IS NULL, cash_register_event_nr) AS prev_cash_register_event_type_cd,
    CASE
    WHEN cash_register_event_type_cd <> (LAG(cash_register_event_type_cd, 1, CAST(- 9999 AS BIGNUMERIC)) OVER (PARTITION BY
         bus_dt, cash_register_sid ORDER BY cash_register_event_nr IS NULL, cash_register_event_nr))
    THEN 1
    ELSE 0
    END AS event_type_change_fg,
   ROW_NUMBER() OVER (PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr IS NULL,
      cash_register_event_nr) AS rnk
  FROM t_tmp_all_relevant_events AS AE) (SELECT cash_register_event_sid,
   bus_dt,
   store_sid,
   cash_register_sid,
   group_id
  FROM (SELECT cash_register_event_sid,
     bus_dt,
     store_sid,
     cash_register_sid,
     SUM(event_type_change_fg) OVER (PARTITION BY bus_dt, cash_register_sid ORDER BY rnk IS NULL, rnk
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id,
     cash_register_event_type_cd
    FROM ALL_EVENTS_WITH_CHANGE_FG AS aech) AS t0
  WHERE cash_register_event_type_cd = 480);
--
----------------------------------------------------------------------------




----------------------------------------------------------------------------
--
-- precalculate retail lines with deposit EAN_1 group information
--

CREATE OR REPLACE TEMPORARY TABLE t_tmp_deposit_product_lines (
cash_register_event_sid BIGNUMERIC(38,0),
country_org_cd STRING(2),
store_sid BIGNUMERIC(38,0),
bus_dt DATE,
cashier_nr STRING(20),
event_end_tmsp TIMESTAMP,
ean_group STRING(16777216)
) AS
SELECT DISTINCT RL.retail_event_sid AS cash_register_event_sid,
 RL.country_org_cd,
 RL.store_sid,
 RL.bus_dt,
 CE.cashier_nr,
 RE.event_end_tmsp,
  CASE
  /* Add length to the end to keep the information about it in the grouping.
				Lenghts 19 and 24 are to be evaluated independently. */
  WHEN LENGTH(RL.prod_variant_input_nr) = 19
  THEN SUBSTR(RL.prod_variant_input_nr, 1, 13) || '19'
  WHEN LENGTH(RL.prod_variant_input_nr) = 24
  THEN SUBSTR(RL.prod_variant_input_nr, 1, 3) || SUBSTR(RL.prod_variant_input_nr, 15, 10) || '24'
  ELSE NULL
  END AS ean_group
FROM ldl_data_core_rel.t_product_retail_line_1 AS RL
 INNER JOIN ldl_data_core_rel.t_retail_event_1 AS RE_1 ON RL.retail_event_sid = RE.retail_event_sid
 INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption_1 AS CE ON RL.cashier_hash = CE.cashier_hash
WHERE RL.turnover_relevant_fg
 AND RL.prod_retail_line_type_cd = 'D' /* Deposit Return Receipt */
 AND LENGTH(RL.prod_variant_input_nr) IN (19, 24)
 AND RL.bus_dt >= DATE_SUB(DATE($SV_MIN_DT), INTERVAL 30 DAY)
 -- exclude training receipts
 AND EXISTS (SELECT 1
  FROM ldl_data_etl.t_stores_qualified_1 AS SQ
  WHERE store_sid = RL.store_sid
   AND country_org_cd = RL.country_org_cd)
 AND RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)
QUALIFY (COUNT(*) OVER (PARTITION BY RL.store_sid, CE.cashier_nr, ean_group RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1;
--
----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- Create a temp table with rel types "SELF", "RESUME", "PRICE_INFO_SEQ" - calculated easily within one CTE each 
--

CREATE OR REPLACE TEMPORARY TABLE t_tmp_generic_rel AS WITH SELF_REL AS (SELECT DISTINCT FACT.cash_register_event_sid,
   'SELF' AS cash_register_event_rel_type_cd,
   FACT.cash_register_event_sid AS rel_cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt,
   FACT.bus_dt AS rel_bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.bus_dt = SQ.bus_dt AND
     FACT.country_org_cd = SQ.country_org_cd)
     , SUSP_AND_RESUME_REL AS (SELECT 
     -- CASH_REGISTER_EVENT_SID is suspended, and then resumed by REL_CASH_REGISTER_EVENT_SID
     DISTINCT FACT.cash_register_event_sid,
   'RESUME' AS cash_register_event_rel_type_cd,
   RESUME.retail_event_sid AS rel_cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt,
   RESUME.bus_dt AS rel_bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.bus_dt = SQ.bus_dt AND
     FACT.country_org_cd = SQ.country_org_cd
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S ON FACT.scenario_id = S.scenario_id AND
     S.scenario_grp_id = 1 -- Scenario for Aborted/Suspended receipts (Bonabbruch/Bonrückstellung)
   INNER JOIN ldl_data_core_rel.t_retail_event_1 AS RESUME ON FACT.cash_register_event_sid = RESUME.susp_retail_event_sid
     AND FACT.country_org_cd = RESUME.country_org_cd AND FACT.bus_dt <= RESUME.bus_dt -- a resume event cannot happen before the suspended event
		
     )
-- when we generate all SIDs between the "original" receipt and its "successor" in advance we can use "=" in the join
-- we do this to avoid joins using ">" and "<" between big tables  "successor_rel" and "T_TMP_ALL_RELEVANT_EVENTS"
, PRICE_INFO_SEQ AS (SELECT
  DISTINCT FACT.cash_register_event_sid,
   'PRICE_INFO_SEQ' AS cash_register_event_rel_type_cd,
   PIS2.cash_register_event_sid AS rel_cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt,
   PIS2.bus_dt AS rel_bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.bus_dt = SQ.bus_dt AND
     FACT.country_org_cd = SQ.country_org_cd
   INNER JOIN ldl_data_etl.t_tmp_price_info_seq AS PIS1 ON FACT.cash_register_event_sid = PIS1.cash_register_event_sid
   INNER JOIN ldl_data_etl.t_tmp_price_info_seq AS PIS2 -- take all events that belong to same group_id, same day, same cash_register_sid
        ON PIS1.bus_dt = PIS2.bus_dt AND PIS1.cash_register_sid = PIS2.cash_register_sid
        AND PIS1.group_id = PIS2.group_id -- events belong to same sequence(series)
        AND PIS1.cash_register_event_sid <> PIS2.cash_register_event_sid -- take only the "other" receipts from the sequence
  WHERE FACT.scenario_id IN (
    5, -- Mehrfache Preisanzeige in Folge
    50 -- Gesamtanzahl Preisanzeigen | Vorgänge > X Preisanzeigen in Folge
    )) (SELECT *
  FROM (SELECT *
     FROM SELF_REL
     UNION ALL
     SELECT *
     FROM SUSP_AND_RESUME_REL
     UNION ALL
     SELECT *
     FROM PRICE_INFO_SEQ));

--
----------------------------------------------------------------------------






----------------------------------------------------------------------------
--
-- Create temp table with rel types for returns ("ORIGINAL" and "RETURN_SAME_ORIGINAL")
--
CREATE OR REPLACE TEMPORARY TABLE t_tmp_original_rel AS WITH RETURN_ORIGINAL_PURCH_REL AS (SELECT DISTINCT FACT.cash_register_event_sid,
   'ORIGINAL' AS cash_register_event_rel_type_cd,
   RL.orig_sales_event_sid AS rel_cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt,
   ORIG.bus_dt AS rel_bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.bus_dt = SQ.bus_dt AND
     FACT.country_org_cd = SQ.country_org_cd
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S ON FACT.scenario_id = S.scenario_id AND
     (S.scenario_grp_id = 2 -- scenarios for returns (Geldrückgabe)
     OR S.scenario_id = 740200) -- sub-scenario of "reciept outside work hours" (Transaktionen außerhalb Öffnungszeiten | Gelrückgabe (Return))
   INNER JOIN ldl_data_core_rel.t_product_retail_line_1 AS RL ON FACT.cash_register_event_sid = RL.retail_event_sid AND
      FACT.country_org_cd = RL.country_org_cd AND FACT.bus_dt = RL.bus_dt
   INNER JOIN ldl_data_core_rel.t_retail_event_1 AS ORIG ON RL.orig_sales_event_sid = ORIG.retail_event_sid AND SQ.country_org_cd
       = ORIG.country_org_cd AND ORIG.bus_dt >= DATE_SUB(DATE($SV_MIN_DT), INTERVAL 365 DAY)   -- assuming we cannot have a return more than a year after a purchase
  WHERE ORIG.country_org_cd IN (SELECT DISTINCT country_org_cd
     FROM ldl_data_etl.t_stores_qualified_1)), 
-- when return is flagged for "scenario 8" (multiple returns with same original purchase receipt)
-- we want to link all other returns made with same original purchase to the FIRST(EARLIEST) flagged return receipt
first_of_multi_returns AS (
  SELECT 
    ropr.cash_register_event_sid
  FROM return_original_purch_rel AS ropr
  -- Only returns qualified for scenario 8 "Multiple returns with same original receipt"
  INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS s8
    ON ropr.cash_register_event_sid = s8.cash_register_event_sid
    AND s8.scenario_id = 8
  INNER JOIN ldl_data_core_rel.t_retail_event_1 AS re_r
    ON re_r.retail_event_sid = ropr.cash_register_event_sid
  -- If more than one return exists for the same original purchase, take the earliest
  QUALIFY ROW_NUMBER() OVER(PARTITION BY ropr.rel_cash_register_event_sid ORDER BY re_r.event_end_tmsp ASC) = 1
)
,
     RETURN_SAME_RECEIPT_ADDITIONAL_REL AS (SELECT DISTINCT ropr.cash_register_event_sid -- SID of the Return to which we want to link other Returns
   ,
   'RETURN_SAME_ORIGINAL' AS cash_register_event_rel_type_cd,
   PRL.retail_event_sid AS rel_cash_register_event_sid, -- SID of the "other" Return
   ropr.country_org_cd,
   ropr.bus_dt, -- date of Return
   PRL.bus_dt AS rel_bus_dt -- date of Purchase
  FROM RETURN_ORIGINAL_PURCH_REL AS ropr
   -- all OTHER returns made with same original purchase
   INNER JOIN ldl_data_core_rel.t_product_retail_line_1 AS PRL ON ropr.rel_cash_register_event_sid = PRL.orig_sales_event_sid
        AND ropr.country_org_cd = PRL.country_org_cd AND PRL.bus_dt >= DATE_SUB(DATE($SV_MIN_DT), INTERVAL 365 DAY) -- orig purchases are bigger than this date, so the other returns will also have bigger date
    AND PRL.retail_event_sid <> ropr.cash_register_event_sid
   INNER JOIN ldl_data_core_rel.t_retail_event_1 AS RE_1 ON PRL.retail_event_sid = RE.retail_event_sid AND ropr.country_org_cd
       = RE.country_org_cd AND RE.bus_dt >= DATE_SUB(DATE($SV_MIN_DT), INTERVAL 365 DAY) -- orig purchases are bigger than this date, so the other returns will also have bigger date
  -- we link only "actual" returns, not Cancelled,Aborted,Suspended ... 
  WHERE PRL.turnover_relevant_fg
   AND RE.turnover_relevant_fg
   -- only returns that are marked for "Scenario 8" - "Multiple returns with same original receipt"
   -- and only the earliest return per original purchase
   AND ropr.cash_register_event_sid IN (SELECT ropr.cash_register_event_sid
     FROM first_of_multi_returns AS ropr)) (SELECT *
  FROM (SELECT *
     FROM RETURN_ORIGINAL_PURCH_REL
     UNION ALL
     SELECT *
     FROM RETURN_SAME_RECEIPT_ADDITIONAL_REL));

----------------------------------------------------------------------------





----------------------------------------------------------------------------
--
-- Create temp table with "SUCCESSOR" relationship type and types derived from it ( EVENT_AROUND_LOGOFF)
--
CREATE OR REPLACE TEMPORARY TABLE t_tmp_successor_rel AS WITH EVENTS_FOR_SUCCESSOR_PREDECESSOR_ALL_NPI_EVENTS_REL AS (
  ------------------------------------------------
  -- rel type "SUCC_ALL_NPI_EVENTS" and "PRED_ALL_NPI_EVENTS"
  SELECT FACT.cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.bus_dt = SQ.bus_dt AND
     FACT.country_org_cd = SQ.country_org_cd
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S ON FACT.scenario_id = S.scenario_id
  -- AUTO scenario for "Multpliple price checks in a row" (this type of relationship is required only for that scenario so far)
  WHERE S.scenario_id = 5
  GROUP BY FACT.cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt), 
   
   SUCCESSOR_ALL_NPI_EVENTS_REL AS (
   -- for "SUCC_ALL_NPI_EVENTS" we are looking for "next event", which could be ANY type RetailEvent (sale or return) and ANY types of technical events (so UNfiltered tech events)
   SELECT t2.cash_register_event_sid,
   'SUCC_ALL_NPI_EVENTS' AS cash_register_event_rel_type_cd,
   -- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
   IFNULL(ENPE.next_unfiltered_cash_register_event_sid, - 1) AS rel_cash_register_event_sid,
   t2.country_org_cd,
   t2.bus_dt,
   -- next event is always on the same date
   ENPE.bus_dt AS rel_bus_dt
  FROM (SELECT DISTINCT *
    FROM EVENTS_FOR_SUCCESSOR_PREDECESSOR_ALL_NPI_EVENTS_REL AS fact) AS t2
   INNER JOIN temp_schema.t_tmp_event_and_next_and_prev_event AS ENPE ON t2.cash_register_event_sid = ENPE.cash_register_event_sid
    AND t2.bus_dt = ENPE.bus_dt), 
    
    PREDECESSOR_ALL_NPI_EVENTS_REL AS (
   -- for "PRED_ALL_NPI_EVENTS" we are looking for "previous event", which could be ANY type RetailEvent (sale or return) and ANY types of technical events (so UNfiltered tech events)
   SELECT t10.cash_register_event_sid,
   'PRED_ALL_NPI_EVENTS' AS cash_register_event_rel_type_cd,
   -- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
   IFNULL(ENPE.prev_unfiltered_cash_register_event_sid, - 1) AS rel_cash_register_event_sid,
   t10.country_org_cd,
   t10.bus_dt,
   -- next event is always on the same date
   ENPE.bus_dt AS rel_bus_dt
  FROM (SELECT DISTINCT *
    FROM EVENTS_FOR_SUCCESSOR_PREDECESSOR_ALL_NPI_EVENTS_REL AS fact) AS t10
   INNER JOIN temp_schema.t_tmp_event_and_next_and_prev_event AS ENPE ON t10.cash_register_event_sid = ENPE.cash_register_event_sid
    AND t10.bus_dt = ENPE.bus_dt), 
    
    EVENTS_FOR_SUCCESSOR AS (
  ------------------------------------------------
  -- rel type "SUCCESSOR" 
  SELECT FACT.cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.bus_dt = SQ.bus_dt AND
     FACT.country_org_cd = SQ.country_org_cd
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S ON FACT.scenario_id = S.scenario_id
  WHERE S.scenario_grp_id = 1 -- Scenarios for Aborted/Suspended receipts (Bonabbruch/Bonrückstellung)
   OR S.scenario_id IN (6, 51, 52) -- AUTO and MANUAL scenarios for "Price Checks", but not "Multpliple price checks in a row"
  GROUP BY FACT.cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt), 
   
   SUCCESSOR_REL AS (
   -- for "SUCCESSOR" we are looking for "next event", which could be ANY type RetailEvent (sale or return) and SOME types of technical events (so filtered tech events)
   SELECT t18.cash_register_event_sid,
   'SUCCESSOR' AS cash_register_event_rel_type_cd,
   -- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
   IFNULL(ENE.next_filtered_cash_register_event_sid, - 1) AS rel_cash_register_event_sid,
   t18.country_org_cd,
   t18.bus_dt,
   -- next event is always on the same date
   ENE.bus_dt AS rel_bus_dt
  FROM (SELECT DISTINCT *
    FROM EVENTS_FOR_SUCCESSOR AS fact) AS t18
   INNER JOIN temp_schema.t_tmp_event_and_next_and_prev_event AS ENE ON t18.cash_register_event_sid = ENE.cash_register_event_sid
    AND t18.bus_dt = ENE.bus_dt), 
    ------------------------------------------------
-- rel type "EVENT_AROUND_LOGOFF" 
--
-- this type of relationship will be made only for scenarios of type "some event + SmallSale or Logoff"
-- depending if the second event is "small sale" or "logoff" the logic is slightly different ( for logoff we also want the event after it)
-- this is why we use sub-scenario IDs as filters.
--
-- when we generate all SIDs between the "original" receipt and its "successor" in advance, so we can use "=" in the join
-- we do this to avoid joins using ">" and "<" between big tables  "successor_rel" and "T_TMP_ALL_RELEVANT_EVENTS"
    SUCCESSOR_REL_EXTENDED AS (
   -- second event is abmeldung/logoff so we need the events before it + the event after the it
   SELECT sr.cash_register_event_sid,
    sr.cash_register_event_rel_type_cd,
    sr.rel_cash_register_event_sid,
    sr.country_org_cd,
    sr.bus_dt,
    sr.rel_bus_dt,
     sr.cash_register_event_sid + ext100.rn AS around_successor_sid -- when we increase SID with small number (less than 10,000,000) we are guanrateed to get new sid in same Date, Store and CashRegister
   FROM SUCCESSOR_REL AS sr
    INNER JOIN (SELECT ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS rn
     FROM UNNEST(GENERATE_ARRAY(0, 99)) AS SEQ) AS ext100 
     -- if successor has EventNR=7 and original has EventNR = 3 the difference is 4, and we need  RN=1,2,3 to produce EventNR 4,5,6
     -- we also need the produce the next event, after 7 -> so we take row number up to  "Diff+1" 
     -- This will give us Evnets (4,5,6,7***,8)
     -- ***in the NEXT CTE however we must make sure we exclude "7" because this is the "SUCCESSOR", we do not need it to be also "EVENT_AROUND_LOGOFF"
     ON ext100.rn <= sr.rel_cash_register_event_sid - sr.cash_register_event_sid
        + 1
   -- exclude dummy_1 successors
   WHERE sr.rel_cash_register_event_sid > - 1
    AND EXISTS (SELECT 1
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
     WHERE cash_register_event_sid = sr.cash_register_event_sid
      AND scenario_id IN (
        60200, -- Preisanzeige + Abmeldung (auto)
        160200, -- Offene Bonrückstellungen und Abmeldung (auto)
        170200, -- Bonabbruch und Abmeldung (auto)
        670200, -- Anzahl Bonabbruch direkt vor Abmeldung (manual)
        680200, -- Anzahl offene Bonrückstellung direkt vor Abmeldung (manual)
        51)) -- Gesamtanzahl Preisanzeigen | Preisanzeigen direkt vor Abmeldung (manual)
   UNION ALL
   -- second event is kleinsbon/small sale  so we need the events before it + the event after the it
   SELECT sr.cash_register_event_sid,
    sr.cash_register_event_rel_type_cd,
    sr.rel_cash_register_event_sid,
    sr.country_org_cd,
    sr.bus_dt,
    sr.rel_bus_dt,
     sr.cash_register_event_sid + ext100.rn AS around_successor_sid -- when we increase SID with small number (less than 10,000,000) we are guanrateed to get new sid in same Date, Store and CashRegister
   FROM SUCCESSOR_REL AS sr
    INNER JOIN (SELECT ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS rn
     FROM UNNEST(GENERATE_ARRAY(0, 99)) AS SEQ) AS ext100 
     -- if successor has EventNR=7 and original has EventNR = 3 the difference is 4, and we need  RN=1,2,3 to produce EventNR 4,5,6
     ON ext100.rn < sr.rel_cash_register_event_sid - sr.cash_register_event_sid
      
   -- exclude dummy_1 successors
   WHERE sr.rel_cash_register_event_sid > - 1
    AND EXISTS (SELECT 1
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
     WHERE cash_register_event_sid = sr.cash_register_event_sid
      AND scenario_id IN (
        60100, -- Preisanzeige + Kleinstbon (auto)
        160100, -- Offene Bonrückstellungen und Kleinstbon (auto)
        170100, -- Bonabbruch + Kleinstbon (auto)
        670100, -- Anzahl Bonabbruch direkt vor Kleinstbon (manual)
        680100, -- Anzahl offene Bonrückstellung direkt vor Kleinstbon (manual)
        52))), -- Gesamtanzahl Preisanzeigen | Preisanzeigen direkt vor Kleinstbon (manual)
        
        EVENT_AROUND_LOGOFF_REL AS (SELECT sre.cash_register_event_sid
   ,
   'EVENT_AROUND_LOGOFF' AS cash_register_event_rel_type_cd,
   AE.cash_register_event_sid AS rel_cash_register_event_sid,
   sre.country_org_cd,
   sre.bus_dt,
   AE.bus_dt AS rel_bus_dt
  FROM SUCCESSOR_REL_EXTENDED AS sre
   INNER JOIN t_tmp_all_relevant_events AS AE ON sre.bus_dt = AE.bus_dt AND sre.around_successor_sid = AE
      .cash_register_event_sid 
      -- we already have relationship of type "SUCCESSOR" with REL_CASH_REGISTER_EVENT_SID - so we exclude it
      AND (
        -- take all events between the PriceCheck and the Logoff/Small Sale
        sre.rel_cash_register_event_sid > AE.cash_register_event_sid 
        OR 
        -- in case we have PriceCheck+Logoff we will take the next event after the logoff
        -- but only if it is immediatelly a Logon event.
        sre.rel_cash_register_event_sid < AE.cash_register_event_sid AND AE.cash_register_event_type_cd = 415)) (SELECT *
  FROM (SELECT *
     FROM SUCCESSOR_ALL_NPI_EVENTS_REL
     UNION ALL
     SELECT *
     FROM PREDECESSOR_ALL_NPI_EVENTS_REL
     UNION ALL
     SELECT *
     FROM SUCCESSOR_REL
     UNION ALL
     SELECT *
     FROM EVENT_AROUND_LOGOFF_REL));
----------------------------------------------------------------------------




----------------------------------------------------------------------------
--
-- Create temp table with "DEPOSIT_SAME_EAN" relationship type
--

CREATE OR REPLACE TEMPORARY TABLE t_tmp_deposit_rel AS WITH SUSPICIOUS_DEPOSIT_RECEIPTS AS (
  --Receipts from classification table for scenario_id = 2 - only suspicious
  SELECT FACT.cash_register_event_sid,
   FACT.country_org_cd,
   FACT.bus_dt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
   INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.country_org_cd = SQ.country_org_cd
       AND FACT.bus_dt = SQ.bus_dt
  WHERE FACT.scenario_id = 2), 
  ALL_DEPOSIT_GROUPS AS (
   --Marking the groups from temporary table suspicious based on the input from suspicious_deposit_receipts CTE
   SELECT DISTINCT DPL.cash_register_event_sid,
   DPL.country_org_cd,
   DPL.bus_dt,
   DPL.store_sid,
   DPL.cashier_nr,
   DPL.event_end_tmsp,
   DPL.ean_group,
    IF(sdr.cash_register_event_sid IS NULL, 0, 1) AS suspicious_fg
  FROM temp_schema.t_tmp_deposit_product_lines AS DPL
   LEFT JOIN SUSPICIOUS_DEPOSIT_RECEIPTS AS sdr ON DPL.cash_register_event_sid = sdr.cash_register_event_sid AND DPL.country_org_cd
       = sdr.country_org_cd AND DPL.bus_dt = sdr.bus_dt), 
       DEPOSIT_GROUPS_FILTERED AS (SELECT *
    FROM ALL_DEPOSIT_GROUPS
    QUALIFY 
     --Take only these EAN_1 groups where at least one receipt is marked suspicious
     (SUM(suspicious_fg) OVER (PARTITION BY ean_group RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
     --Take only these EAN_1 groups where exactly one receipt is marked non suspicious
     --This filter will discard multiple entries for the same receipt where, apart from suspicious EAN_1 numbers, there is any EAN_1 number that was not suspicious
     AND (SUM(IF(suspicious_fg = 0, 1, 0)) OVER (PARTITION BY ean_group) = 1
)),
 FIRST_SUSPICIOUS AS (
   SELECT *
   FROM DEPOSIT_GROUPS_FILTERED
   WHERE suspicious_fg = 1
   --For all suspicious receipts, find only the first one by a time precedence
   --This receipt will be a "parent" one in the report
   QUALIFY ROW_NUMBER() OVER(PARTITION BY ean_group ORDER BY event_end_tmsp ASC) = 1
 )(SELECT t10.cash_register_event_sid, --"Parent" receipts
   'DEPOSIT_SAME_EAN' AS cash_register_event_rel_type_cd,
   t18.cash_register_event_sid AS rel_cash_register_event_sid, --"Child" receipt - all related to the same EAN_1 group apart from "parent"
   t10.country_org_cd,
   t10.bus_dt,
   t18.bus_dt AS rel_bus_dt
  FROM FIRST_SUSPICIOUS AS t10
   INNER JOIN DEPOSIT_GROUPS_FILTERED AS t18 ON t10.ean_group = t18.ean_group AND t10.cash_register_event_sid <> t18.cash_register_event_sid
     );
-- Add relationship DEPOSIT_SAME_VALUE
-- for this scenario, relationship between 'parent' receipt (scanned one) and the manual receipt cannot be simply taken from a table (unlike between return and original receipt)
-- Hence, for all qualified scanned receipts, related manual receipts are taken from core_dim table by matching store, day, checker and amount
-- The condition on amount is important because of rare cases when the same checker performs actions with 2 different deposit amounts
-- For the reason above, a lot of code is repeated from the scenario script. 
-- But if business says that the receipts with the same amount are not related, a lot of code below may be removed


INSERT INTO t_tmp_deposit_rel (cash_register_event_sid, cash_register_event_rel_type_cd,
 rel_cash_register_event_sid, country_org_cd, bus_dt, rel_bus_dt)
WITH DEPOSIT_SCAN_DET AS (SELECT FACT.cash_register_event_sid,
    FACT.bus_dt,
    FACT.store_sid,
    FACT.cashier_nr,
    FACT.country_org_cd,
    PRL.event_end_tmsp,
    PRL.retail_line_gross_val
   FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS FACT
    INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ ON FACT.store_sid = SQ.store_sid AND FACT.country_org_cd = SQ.country_org_cd
        AND FACT.bus_dt = SQ.bus_dt
    INNER JOIN ldl_data_core_rel.t_product_retail_line_1 AS PRL ON FACT.cash_register_event_sid = PRL.retail_event_sid
   WHERE FACT.scenario_id = 75
    AND PRL.prod_entry_method_cd IN ('SC')
    AND PRL.retail_event_line_scenario_id IN (120, 122)), DEPOSIT_MAN_DET AS (SELECT FD.cash_register_event_sid,
    FD.bus_dt,
    FD.store_sid,
    CE.cashier_nr,
    PRL0.event_end_tmsp,
    PRL0.retail_line_gross_val
   FROM ldl_data_core_dim.t_fact_fraud_detection_by_cash_register_event_1 AS FD
    INNER JOIN ldl_data_etl.t_stores_qualified_1 AS SQ0 ON FD.store_sid = SQ0.store_sid AND FD.bus_dt = SQ0.bus_dt
    INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption_1 AS CE ON FD.cashier_hash = CE.cashier_hash
    INNER JOIN ldl_data_core_rel.t_product_retail_line_1 AS PRL0 ON FD.cash_register_event_sid = PRL0.retail_event_sid
   WHERE PRL0.prod_entry_method_cd IN ('DV', 'KE')
    AND PRL0.retail_event_line_scenario_id IN (120, 122)
    AND FD.deposit_same_val_man_fg) (
   -- There can be many matches between the same pair of receipts, hence DISTINCT
   SELECT DISTINCT sca.cash_register_event_sid,
    'DEPOSIT_SAME_VALUE' AS cash_register_event_rel_type_cd,
    man.cash_register_event_sid AS rel_cash_register_event_sid,
    sca.country_org_cd,
    sca.bus_dt,
    sca.bus_dt AS rel_bus_dt
   FROM DEPOSIT_SCAN_DET AS sca
    INNER JOIN DEPOSIT_MAN_DET AS man ON sca.store_sid = man.store_sid AND sca.bus_dt = man.bus_dt AND sca.cashier_nr =
        man.cashier_nr AND sca.retail_line_gross_val = man.retail_line_gross_val 
        AND man.event_end_tmsp < sca.event_end_tmsp -- scan event has to be later
-- Although this condition is already applied in the scenario script, is it needed here because there can be many pairs per day
      );


INSERT INTO ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_1 (cash_register_event_sid,
 cash_register_event_rel_type_cd, rel_cash_register_event_sid, country_org_cd, bus_dt, rel_bus_dt, event_start_tmsp,
 dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
WITH ALL_RELS AS (SELECT *
    FROM t_tmp_generic_rel
    UNION ALL
    SELECT *
    FROM t_tmp_original_rel
    UNION ALL
    SELECT *
    FROM t_tmp_successor_rel
    UNION ALL
    SELECT *
    FROM t_tmp_deposit_rel) (SELECT cash_register_event_sid,
    cash_register_event_rel_type_cd,
    rel_cash_register_event_sid,
    country_org_cd,
    bus_dt,
    rel_bus_dt,
    a10,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
   FROM (WITH ALL_RELS AS (SELECT *
         FROM t_tmp_generic_rel
         UNION ALL
         SELECT *
         FROM t_tmp_original_rel
         UNION ALL
         SELECT *
         FROM t_tmp_successor_rel
         UNION ALL
         SELECT *
         FROM t_tmp_deposit_rel) (SELECT t0.cash_register_event_sid,
         t0.cash_register_event_rel_type_cd,
         t0.rel_cash_register_event_sid,
         t0.country_org_cd,
         t0.bus_dt,
         t0.rel_bus_dt,
         CURRENT_TIMESTAMP() AS dwh_created_tmsp,
         CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
        ${LOAD_ID} AS dwh_load_id,
         'ldl_data_core_rel' AS dwh_node_cd,
         COALESCE(RE.event_start_tmsp, TCRE.event_tmsp, PIE.event_tmsp) AS a10
        FROM ALL_RELS AS t0
         LEFT JOIN ldl_data_core_rel.t_retail_event_1 AS RE_1 ON t0.cash_register_event_sid = RE.retail_event_sid
         LEFT JOIN ldl_data_core_rel.t_technical_cash_register_event_1 AS TCRE ON t0.cash_register_event_sid = TCRE.tech_cash_register_event_sid
          
         LEFT JOIN ldl_data_core_rel.t_price_information_event_1 AS PIE ON t0.cash_register_event_sid = PIE.price_info_event_sid
          
        ORDER BY t0.country_org_cd NULLS LAST)));

END;