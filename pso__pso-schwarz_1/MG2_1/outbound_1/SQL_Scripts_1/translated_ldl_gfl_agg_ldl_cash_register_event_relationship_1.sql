/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: t_cash_register_event_relationship.sql
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
												requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/68261 (point2)
											
											- New relationship type "SUCC_ALL_NPI_EVENTS" (successor, all non-PriceInfo events) slightly different logic than "SUCCESSOR"
												the rel type SUCC_ALL_NPI_EVENTS considers also events like "key lock/unlock" as next event, and is relevant only for few "Price Info" scenarios for now.
												requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/68723

# 1.10  24.04.2025  Mihail Ivanov - ZKP - Fixes:
											- Fixed logic how relationship type RETURN_SAME_ORIGINAL is created. Previous implementation caused bugs also in type "ORIGINAL" which are now resolved.
												now we take into account_1 that a return marked for scenario 8, could also be marked for other scenarios, so rel type "ORIGINAL" is created for every unique receipt marked for any return scenario (as is rel type SELF)
												rel type "RETURN_SAME_ORIGINAL" only for returns marked for scenario 8, and if we have more than 1 return with same original purchase, links are created only for the earliest.

# 1.11  08.05.2025  Kamil Roszczyk - ZKP - changes:
											- added new relationship type "PRED_ALL_NPI_EVENTS" (predecessor, all non-PriceInfo events). Similar to "SUCC_ALL_NPI_EVENTS" but labels the event before the first price check in series
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/68723
												
# 1.12  12.05.2025  Andrzej Wandtke - ZKP - changes: added explicit date conversion for SV_MIN_DT

# 1.13  20.05.2025  Kamil Roszczyk - ZKP - changes:
											- added "DEPOSIT_SAME_EAN" relationship for deposit return receipts (scenario_id = 2). Similar to "RETURN_SAME_ORIGINAL"
											- added temporary table etl.T_TMP_DEPOSIT_PRODUCT_LINES to precalculate EAN_1 groups due to readability and performance improvements
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/70656


TODO: next time this script is changed, we might break the big SQL for the final insert into several temporary tables.
	We are getting more and more CTEs and it is getting difficult to read.

*/



--!SET exit_on_error=True;

DECLARE SV_MIN_DT BIGNUMERIC;
DECLARE SV_MAX_DT BIGNUMERIC;
SET SV_MIN_DT = (
  SELECT
      min(T_STORES_QUALIFIED.BUS_DT)
    FROM
      LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1
);
SET SV_MAX_DT = (
  SELECT
      max(T_STORES_QUALIFIED.BUS_DT)
    FROM
      LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1
);
CREATE OR REPLACE TEMPORARY TABLE T_TMP_ALL_RELEVANT_EVENTS
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_EVENT_NR ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    STORE_SID ERROR_TYPE(Error<error-type>),
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    CASHIER_HASH ERROR_TYPE(Error<error-type>),
    CASHIER_NR ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_EVENT_TYPE_CD BIGNUMERIC,
    EVENT_CATEGORY_CD STRING
  )
  AS
    SELECT
        -- All available cash register events as a base for calculations
        PIE.PRICE_INFO_EVENT_SID AS CASH_REGISTER_EVENT_SID,
        PIE.CASH_REGISTER_EVENT_NR,
        PIE.BUS_DT,
        PIE.STORE_SID,
        PIE.COUNTRY_ORG_CD,
        PIE.CASHIER_HASH,
        CE.CASHIER_NR,
        PIE.CASH_REGISTER_SID,
        NUMERIC '480' AS CASH_REGISTER_EVENT_TYPE_CD,
        'PRICE_INFO_EVENT' AS EVENT_CATEGORY_CD
      FROM
        LDL_DATA_PRODUCTION.CORE_REL.T_PRICE_INFORMATION_EVENT_1 AS PIE
        INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = PIE.STORE_SID
         AND SQ.BUS_DT = PIE.BUS_DT
         AND SQ.COUNTRY_ORG_CD = PIE.COUNTRY_ORG_CD
        INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_1 AS CE ON PIE.CASHIER_HASH = CE.CASHIER_HASH
    UNION ALL
    SELECT
        RE.RETAIL_EVENT_SID AS CASH_REGISTER_EVENT_SID,
        RE.CASH_REGISTER_EVENT_NR,
        RE.BUS_DT,
        RE.STORE_SID,
        RE.COUNTRY_ORG_CD,
        RE.CASHIER_HASH,
        CE.CASHIER_NR,
        RE.CASH_REGISTER_SID,
        RE.RETAIL_EVENT_SCENARIO_ID AS CASH_REGISTER_EVENT_TYPE_CD,
        'RETAIL_EVENT' AS EVENT_CATEGORY_CD
      FROM
        LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_1 AS RE_1
        INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = RE.STORE_SID
         AND SQ.BUS_DT = RE.BUS_DT
         AND SQ.COUNTRY_ORG_CD = RE.COUNTRY_ORG_CD
        INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_1 AS CE ON RE.CASHIER_HASH = CE.CASHIER_HASH
    UNION ALL
    SELECT
        TE.TECH_CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
        TE.CASH_REGISTER_EVENT_NR,
        TE.BUS_DT,
        TE.STORE_SID,
        TE.COUNTRY_ORG_CD,
        TE.CASHIER_HASH,
        CE.CASHIER_NR,
        TE.CASH_REGISTER_SID,
        TE.TECH_CASH_REGISTER_EVENT_TYPE_CD AS CASH_REGISTER_EVENT_TYPE_CD,
        'TECH_EVENT' AS EVENT_CATEGORY_CD
      FROM
        LDL_DATA_PRODUCTION.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_1 AS TE
        INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = TE.STORE_SID
         AND SQ.BUS_DT = TE.BUS_DT
         AND SQ.COUNTRY_ORG_CD = TE.COUNTRY_ORG_CD
        INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_1 AS CE ON TE.CASHIER_HASH = CE.CASHIER_HASH
;
----------------------------------------------------------------------------
--
-- Delete all the receipts from the scope currently selected (including original receipts)
--
DELETE FROM LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP_1 AS TRG WHERE TRG.CASH_REGISTER_EVENT_SID IN(
  SELECT
      CASH_REGISTER_EVENT_SID
    FROM
      LDL_DATA_PRODUCTION.ETL.T_TMP_ALL_RELEVANT_EVENTS
);
--
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- Precalculate two types of "next event" and one type of "previous event" for each event in the given scope
-- 		NEXT_FILTERED_CASH_REGISTER_EVENT_SID 	is chosen from set of events that includes all retail events and SOME tech events, but excludes other tech events like "key lock/unlock"
-- 		NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID is chosen from set of events that includes all retail events and ALL tech events
-- 		PREV_UNFILTERED_CASH_REGISTER_EVENT_SID is chosen from set of events that includes all retail events and ALL tech events
--   for next events, in most cases we will get same event SID in both columns, but rarely they might be different
CREATE OR REPLACE TEMPORARY TABLE T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    STORE_SID ERROR_TYPE(Error<error-type>),
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    NEXT_FILTERED_CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    PREV_UNFILTERED_CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>)
  )
  AS
    WITH NON_PRICE_INFO_EVENTS AS (
      SELECT
          -- for these scenarios we look for "next event" of specific type
          TARE.CASH_REGISTER_EVENT_SID,
          TARE.CASH_REGISTER_EVENT_NR,
          TARE.BUS_DT,
          TARE.STORE_SID,
          TARE.COUNTRY_ORG_CD,
          TARE.CASH_REGISTER_SID,
          TARE.CASHIER_HASH,
          TARE.CASHIER_NR,
          TARE.CASH_REGISTER_EVENT_TYPE_CD
        FROM
          LDL_DATA_PRODUCTION.ETL.T_TMP_ALL_RELEVANT_EVENTS AS TARE
        WHERE TARE.EVENT_CATEGORY_CD = 'RETAIL_EVENT'
         OR TARE.EVENT_CATEGORY_CD = 'TECH_EVENT' /* and cash_register_event_type_cd NOT IN (400, 405, 420, 425, 430))*/
    ), ALL_EVENTS AS (
      SELECT
          NON_PRICE_INFO_EVENTS.*
        FROM
          NON_PRICE_INFO_EVENTS
      UNION ALL
      SELECT
          PIE.CASH_REGISTER_EVENT_SID,
          PIE.CASH_REGISTER_EVENT_NR,
          PIE.BUS_DT,
          PIE.STORE_SID,
          PIE.COUNTRY_ORG_CD,
          PIE.CASH_REGISTER_SID,
          PIE.CASHIER_HASH,
          PIE.CASHIER_NR,
          PIE.CASH_REGISTER_EVENT_TYPE_CD
        FROM
          LDL_DATA_PRODUCTION.ETL.T_TMP_ALL_RELEVANT_EVENTS AS PIE
        WHERE PIE.EVENT_CATEGORY_CD = 'PRICE_INFO_EVENT'
    ), NEXT_FILTERED_EVENT AS (
      SELECT
          -- for all events get the next event that is not "key lock/unlock"
          -- for each event we get which non-price-info event comes after it
          AE.CASH_REGISTER_EVENT_SID,
          AE.BUS_DT,
          AE.STORE_SID,
          AE.COUNTRY_ORG_CD,
          NPIE.CASH_REGISTER_EVENT_SID AS NEXT_FILTERED_CASH_REGISTER_EVENT_SID,
          AE.CASH_REGISTER_EVENT_NR,
          AE.CASHIER_NR,
          AE.CASH_REGISTER_SID
        FROM
          ALL_EVENTS AS AE
          LEFT OUTER JOIN NON_PRICE_INFO_EVENTS AS NPIE ON AE.STORE_SID = NPIE.STORE_SID
           AND AE.CASHIER_NR = NPIE.CASHIER_NR
           AND AE.BUS_DT = NPIE.BUS_DT
           AND AE.CASH_REGISTER_SID = NPIE.CASH_REGISTER_SID /* same cash register*/
           AND NPIE.CASH_REGISTER_EVENT_TYPE_CD NOT IN(
            NUMERIC '400', NUMERIC '405', NUMERIC '420', NUMERIC '425', NUMERIC '430'
          )
           AND AE.CASH_REGISTER_EVENT_NR < NPIE.CASH_REGISTER_EVENT_NR
        QUALIFY row_number() OVER (PARTITION BY AE.CASH_REGISTER_EVENT_SID ORDER BY if(NPIE.CASH_REGISTER_EVENT_NR IS NULL, 0, 1) DESC, NPIE.CASH_REGISTER_EVENT_NR) = NUMERIC '1'
    ), NEXT_UNFILTERED_EVENT AS (
      SELECT
          -- for all events get the next event regardless if it is retail or tech event of any type, including "key lock/unlock"
          NFE.CASH_REGISTER_EVENT_SID,
          NFE.BUS_DT,
          NFE.STORE_SID,
          NFE.COUNTRY_ORG_CD,
          NFE.NEXT_FILTERED_CASH_REGISTER_EVENT_SID,
          NPIE2.CASH_REGISTER_EVENT_SID AS NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID,
          NFE.CASH_REGISTER_EVENT_NR,
          NFE.CASHIER_NR,
          NFE.CASH_REGISTER_SID
        FROM
          NEXT_FILTERED_EVENT AS NFE
          LEFT OUTER JOIN NON_PRICE_INFO_EVENTS AS NPIE2 ON NFE.STORE_SID = NPIE2.STORE_SID
           AND NFE.CASHIER_NR = NPIE2.CASHIER_NR
           AND NFE.BUS_DT = NPIE2.BUS_DT
           AND NFE.CASH_REGISTER_SID = NPIE2.CASH_REGISTER_SID /* same cash register*/
           AND NFE.CASH_REGISTER_EVENT_NR < NPIE2.CASH_REGISTER_EVENT_NR
        QUALIFY row_number() OVER (PARTITION BY NFE.CASH_REGISTER_EVENT_SID ORDER BY if(NPIE2.CASH_REGISTER_EVENT_NR IS NULL, 0, 1) DESC, NPIE2.CASH_REGISTER_EVENT_NR) = NUMERIC '1'
    )
    SELECT
        -- for all events get the next event regardless if it is retail or tech event of any type, including "key lock/unlock"
        NUE.CASH_REGISTER_EVENT_SID,
        NUE.BUS_DT,
        NUE.STORE_SID,
        NUE.COUNTRY_ORG_CD,
        NUE.NEXT_FILTERED_CASH_REGISTER_EVENT_SID,
        NUE.NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID,
        NPIE3.CASH_REGISTER_EVENT_SID AS PREV_UNFILTERED_CASH_REGISTER_EVENT_SID
      FROM
        NEXT_UNFILTERED_EVENT AS NUE
        LEFT OUTER JOIN NON_PRICE_INFO_EVENTS AS NPIE3 ON NUE.STORE_SID = NPIE3.STORE_SID
         AND NUE.CASHIER_NR = NPIE3.CASHIER_NR
         AND NUE.BUS_DT = NPIE3.BUS_DT
         AND NUE.CASH_REGISTER_SID = NPIE3.CASH_REGISTER_SID /* same cash register*/
         AND NUE.CASH_REGISTER_EVENT_NR > NPIE3.CASH_REGISTER_EVENT_NR
      QUALIFY row_number() OVER (PARTITION BY NUE.CASH_REGISTER_EVENT_SID ORDER BY if(NPIE3.CASH_REGISTER_EVENT_NR IS NULL, 0, 1), NPIE3.CASH_REGISTER_EVENT_NR DESC) = NUMERIC '1'
;
--
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- precalculate series of PriceInfoEvents
--
CREATE OR REPLACE TEMPORARY TABLE T_TMP_PRICE_INFO_SEQ
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    STORE_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_SID ERROR_TYPE(Error<error-type>),
    GROUP_ID BIGNUMERIC
  )
  AS
    WITH ALL_EVENTS_WITH_CHANGE_FG AS (
      SELECT
          AE.*,
          prev_cash_register_event_type_cd AS PREV_CASH_REGISTER_EVENT_TYPE_CD,
          CASE
            WHEN AE.CASH_REGISTER_EVENT_TYPE_CD <> prev_cash_register_event_type_cd THEN NUMERIC '1'
            ELSE NUMERIC '0'
          END AS EVENT_TYPE_CHANGE_FG,
          row_number() OVER (PARTITION BY AE.BUS_DT, AE.CASH_REGISTER_SID ORDER BY if(AE.CASH_REGISTER_EVENT_NR IS NULL, 0, 1) DESC, AE.CASH_REGISTER_EVENT_NR) AS RNK
        FROM
          LDL_DATA_PRODUCTION.ETL.T_TMP_ALL_RELEVANT_EVENTS AS AE
          CROSS JOIN UNNEST(ARRAY[
            LAG(AE.CASH_REGISTER_EVENT_TYPE_CD, NUMERIC '1', -NUMERIC '9999') OVER (PARTITION BY AE.BUS_DT, AE.CASH_REGISTER_SID ORDER BY if(AE.CASH_REGISTER_EVENT_NR IS NULL, 0, 1) DESC, AE.CASH_REGISTER_EVENT_NR)
          ]) AS prev_cash_register_event_type_cd
    )
    SELECT
        AECH.CASH_REGISTER_EVENT_SID,
        AECH.BUS_DT,
        AECH.STORE_SID,
        AECH.CASH_REGISTER_SID,
        sum(AECH.EVENT_TYPE_CHANGE_FG) OVER (PARTITION BY AECH.BUS_DT, AECH.CASH_REGISTER_SID ORDER BY AECH.RNK NULLS LAST ROWS UNBOUNDED PRECEDING) AS GROUP_ID
      FROM
        ALL_EVENTS_WITH_CHANGE_FG AS AECH
      QUALIFY AECH.CASH_REGISTER_EVENT_TYPE_CD = NUMERIC '480'
;
--
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- precalculate retail lines with deposit EAN_1 group information
--
CREATE OR REPLACE TEMPORARY TABLE T_TMP_DEPOSIT_PRODUCT_LINES
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    STORE_SID ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    CASHIER_NR ERROR_TYPE(Error<error-type>),
    EVENT_END_TMSP ERROR_TYPE(Error<error-type>),
    EAN_GROUP STRING
  )
  AS
    SELECT DISTINCT
        RL.RETAIL_EVENT_SID AS CASH_REGISTER_EVENT_SID,
        RL.COUNTRY_ORG_CD,
        RL.STORE_SID,
        RL.BUS_DT,
        CE.CASHIER_NR,
        RE.EVENT_END_TMSP,
        CASE
           length(RL.PROD_VARIANT_INPUT_NR)
          /* Add length to the end to keep the information about it in the grouping.
          				Lenghts 19 and 24 are to be evaluated independently. */
          WHEN NUMERIC '19' THEN concat(substr(RL.PROD_VARIANT_INPUT_NR, 1, 13), '19')
          WHEN NUMERIC '24' THEN concat(substr(RL.PROD_VARIANT_INPUT_NR, 1, 3), substr(RL.PROD_VARIANT_INPUT_NR, 15, 10), '24')
          ELSE NULL
        END AS EAN_GROUP
      FROM
        LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_RETAIL_LINE_1 AS RL
        INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_1 AS RE_1 ON RL.RETAIL_EVENT_SID = RE.RETAIL_EVENT_SID
        INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_1 AS CE ON RL.CASHIER_HASH = CE.CASHIER_HASH
      WHERE RL.TURNOVER_RELEVANT_FG = true
       AND RL.PROD_RETAIL_LINE_TYPE_CD = 'D'
      /* Deposit Return Receipt */
       AND CAST(length(RL.PROD_VARIANT_INPUT_NR) as BIGNUMERIC) IN(
        NUMERIC '19', NUMERIC '24'
      )
       AND RL.BUS_DT >= date_sub(SV_MIN_DT, interval 30 DAY)
       AND EXISTS (
        SELECT
            NUMERIC '1'
          FROM
            LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ
          WHERE SQ.STORE_SID = RL.STORE_SID
           AND SQ.COUNTRY_ORG_CD = RL.COUNTRY_ORG_CD
      )
      QUALIFY count(*) OVER (PARTITION BY RL.STORE_SID, CE.CASHIER_NR, EAN_GROUP) > NUMERIC '1'
;
--
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- Create a temp table with rel types "SELF", "RESUME", "PRICE_INFO_SEQ" - calculated easily within one CTE each
--
CREATE OR REPLACE TEMPORARY TABLE T_TMP_GENERIC_REL
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_EVENT_REL_TYPE_CD STRING,
    REL_CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    REL_BUS_DT ERROR_TYPE(Error<error-type>)
  )
  AS
    WITH SELF_REL AS (
      SELECT DISTINCT
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'SELF' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          FACT.CASH_REGISTER_EVENT_SID AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD,
          FACT.BUS_DT,
          FACT.BUS_DT AS REL_BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.BUS_DT = FACT.BUS_DT
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
    ), SUSP_AND_RESUME_REL AS (
      SELECT DISTINCT
          -- CASH_REGISTER_EVENT_SID is suspended, and then resumed by REL_CASH_REGISTER_EVENT_SID
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'RESUME' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          RESUME.RETAIL_EVENT_SID AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT,
          RESUME.BUS_DT AS REL_BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.BUS_DT = FACT.BUS_DT
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
          INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_1 AS S ON S.SCENARIO_ID = FACT.SCENARIO_ID
           AND S.SCENARIO_GRP_ID = NUMERIC '1' /* Scenario for Aborted/Suspended receipts (Bonabbruch/Bonrückstellung)*/
          INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_1 AS RESUME ON RESUME.SUSP_RETAIL_EVENT_SID = FACT.CASH_REGISTER_EVENT_SID
           AND RESUME.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
           AND RESUME.BUS_DT >= FACT.BUS_DT /* a resume event cannot happen before the suspended event*/
    ), PRICE_INFO_SEQ AS (
      SELECT DISTINCT
          -- when we generate all SIDs between the "original" receipt and its "successor" in advance we can use "=" in the join
          -- we do this to avoid joins using ">" and "<" between big tables  "successor_rel" and "T_TMP_ALL_RELEVANT_EVENTS"
          -- should be unnecessary because we are taking 1 scenario only
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'PRICE_INFO_SEQ' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          PIS2.CASH_REGISTER_EVENT_SID AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT,
          PIS2.BUS_DT AS REL_BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.BUS_DT = FACT.BUS_DT
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_TMP_PRICE_INFO_SEQ AS PIS1 ON PIS1.CASH_REGISTER_EVENT_SID = FACT.CASH_REGISTER_EVENT_SID
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_TMP_PRICE_INFO_SEQ AS PIS2 /* take all events that belong to same group_id, same day, same cash_register_sid*/ ON PIS1.BUS_DT = PIS2.BUS_DT
           AND PIS1.CASH_REGISTER_SID = PIS2.CASH_REGISTER_SID
           AND PIS1.GROUP_ID = PIS2.GROUP_ID /* events belong to same sequence(series)*/
           AND PIS1.CASH_REGISTER_EVENT_SID <> PIS2.CASH_REGISTER_EVENT_SID /* take only the "other" receipts from the sequence*/
        WHERE FACT.SCENARIO_ID = NUMERIC '5'
    )
    SELECT
        SELF_REL.CASH_REGISTER_EVENT_SID,
        SELF_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        SELF_REL.REL_CASH_REGISTER_EVENT_SID,
        SELF_REL.COUNTRY_ORG_CD,
        SELF_REL.BUS_DT,
        SELF_REL.REL_BUS_DT
      FROM
        SELF_REL
    UNION ALL
    SELECT
        SUSP_AND_RESUME_REL.CASH_REGISTER_EVENT_SID,
        SUSP_AND_RESUME_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        SUSP_AND_RESUME_REL.REL_CASH_REGISTER_EVENT_SID,
        SUSP_AND_RESUME_REL.COUNTRY_ORG_CD,
        SUSP_AND_RESUME_REL.BUS_DT,
        SUSP_AND_RESUME_REL.REL_BUS_DT
      FROM
        SUSP_AND_RESUME_REL
    UNION ALL
    SELECT
        PRICE_INFO_SEQ.CASH_REGISTER_EVENT_SID,
        PRICE_INFO_SEQ.CASH_REGISTER_EVENT_REL_TYPE_CD,
        PRICE_INFO_SEQ.REL_CASH_REGISTER_EVENT_SID,
        PRICE_INFO_SEQ.COUNTRY_ORG_CD,
        PRICE_INFO_SEQ.BUS_DT,
        PRICE_INFO_SEQ.REL_BUS_DT
      FROM
        PRICE_INFO_SEQ
;
--
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- Create temp table with rel types for returns ("ORIGINAL" and "RETURN_SAME_ORIGINAL")
--
CREATE OR REPLACE TEMPORARY TABLE T_TMP_ORIGINAL_REL
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_EVENT_REL_TYPE_CD STRING,
    REL_CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    REL_BUS_DT ERROR_TYPE(Error<error-type>)
  )
  AS
    WITH RETURN_ORIGINAL_PURCH_REL AS (
      SELECT DISTINCT
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'ORIGINAL' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          RL.ORIG_SALES_EVENT_SID AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT,
          ORIG.BUS_DT AS REL_BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.BUS_DT = FACT.BUS_DT
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
          INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_1 AS S ON S.SCENARIO_ID = FACT.SCENARIO_ID
           AND S.SCENARIO_GRP_ID = NUMERIC '2' /* scenarios for returns (Geldrückgabe)*/
          INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_RETAIL_LINE_1 AS RL ON FACT.CASH_REGISTER_EVENT_SID = RL.RETAIL_EVENT_SID
           AND FACT.COUNTRY_ORG_CD = RL.COUNTRY_ORG_CD
           AND FACT.BUS_DT = RL.BUS_DT
          INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_1 AS ORIG ON ORIG.RETAIL_EVENT_SID = RL.ORIG_SALES_EVENT_SID
           AND ORIG.COUNTRY_ORG_CD = SQ.COUNTRY_ORG_CD
           AND ORIG.BUS_DT >= date_sub(SV_MIN_DT, interval 365 DAY) /* assuming we cannot have a return more than a year after a purchase*/
        WHERE ORIG.COUNTRY_ORG_CD IN(
          SELECT DISTINCT
              FACT.COUNTRY_ORG_CD
            FROM
              LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1
        )
    ), FIRST_OF_MULTI_RETURNS AS (
      SELECT
          -- when return is flagged for "scenario 8" (multiple returns with same original purchase receipt)
          -- we want to link all other returns made with same original purchase to the FIRST(EARLIEST) flagged return receipt
          ROPR.CASH_REGISTER_EVENT_SID
        FROM
          RETURN_ORIGINAL_PURCH_REL AS ROPR
          INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS S8 ON ROPR.CASH_REGISTER_EVENT_SID = S8.CASH_REGISTER_EVENT_SID
          -- only returns qualified for scenario 8 "Multiple returns with same original receipt"
           AND S8.SCENARIO_ID = NUMERIC '8'
          INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_1 AS RE_R ON RE_R.RETAIL_EVENT_SID = ROPR.CASH_REGISTER_EVENT_SID
        -- if more than one return exists for the same original purchase, take the earliest
        QUALIFY row_number() OVER (PARTITION BY ROPR.REL_CASH_REGISTER_EVENT_SID ORDER BY if(RE_R.EVENT_END_TMSP IS NULL, 0, 1) DESC, RE_R.EVENT_END_TMSP) = NUMERIC '1'
    ), RETURN_SAME_RECEIPT_ADDITIONAL_REL AS (
      SELECT DISTINCT
          ROPR.CASH_REGISTER_EVENT_SID /* SID of the Return to which we want to link other Returns*/,
          'RETURN_SAME_ORIGINAL' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          PRL.RETAIL_EVENT_SID /* SID of the "other" Return*/ AS REL_CASH_REGISTER_EVENT_SID,
          ROPR.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          ROPR.BUS_DT /* date of Return*/ AS BUS_DT,
          PRL.BUS_DT /* date of Purchase*/ AS REL_BUS_DT
        FROM
          RETURN_ORIGINAL_PURCH_REL AS ROPR
          INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_RETAIL_LINE_1 AS PRL ON PRL.ORIG_SALES_EVENT_SID = ROPR.REL_CASH_REGISTER_EVENT_SID
          -- all OTHER returns made with same original purchase
           AND PRL.COUNTRY_ORG_CD = ROPR.COUNTRY_ORG_CD
           AND PRL.BUS_DT >= date_sub(SV_MIN_DT, interval 365 DAY) /* orig purchases are bigger than this date, so the other returns will also have bigger date*/
           AND PRL.RETAIL_EVENT_SID <> ROPR.CASH_REGISTER_EVENT_SID
          INNER JOIN LDL_DATA_PRODUCTION.CORE_REL.T_RETAIL_EVENT_1 AS RE_1 ON RE.RETAIL_EVENT_SID = PRL.RETAIL_EVENT_SID
           AND RE.COUNTRY_ORG_CD = ROPR.COUNTRY_ORG_CD
           AND RE.BUS_DT >= date_sub(SV_MIN_DT, interval 365 DAY) /* orig purchases are bigger than this date, so the other returns will also have bigger date*/
        -- we link only "actual" returns, not Cancelled,Aborted,Suspended ...
        WHERE NUMERIC '1' = NUMERIC '1'
         AND PRL.TURNOVER_RELEVANT_FG = true
         AND RE.TURNOVER_RELEVANT_FG = true
        -- only returns that are marked for "Scenario 8" - "Multiple returns with same original receipt"
        -- and only the earliest return per original purchase
         AND ROPR.CASH_REGISTER_EVENT_SID IN(
          SELECT
              FIRST_OF_MULTI_RETURNS.CASH_REGISTER_EVENT_SID
            FROM
              FIRST_OF_MULTI_RETURNS
        )
    )
    SELECT
        RETURN_ORIGINAL_PURCH_REL.CASH_REGISTER_EVENT_SID,
        RETURN_ORIGINAL_PURCH_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        RETURN_ORIGINAL_PURCH_REL.REL_CASH_REGISTER_EVENT_SID,
        RETURN_ORIGINAL_PURCH_REL.COUNTRY_ORG_CD,
        RETURN_ORIGINAL_PURCH_REL.BUS_DT,
        RETURN_ORIGINAL_PURCH_REL.REL_BUS_DT
      FROM
        RETURN_ORIGINAL_PURCH_REL
    UNION ALL
    SELECT
        RETURN_SAME_RECEIPT_ADDITIONAL_REL.CASH_REGISTER_EVENT_SID,
        RETURN_SAME_RECEIPT_ADDITIONAL_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        RETURN_SAME_RECEIPT_ADDITIONAL_REL.REL_CASH_REGISTER_EVENT_SID,
        RETURN_SAME_RECEIPT_ADDITIONAL_REL.COUNTRY_ORG_CD,
        RETURN_SAME_RECEIPT_ADDITIONAL_REL.BUS_DT,
        RETURN_SAME_RECEIPT_ADDITIONAL_REL.REL_BUS_DT
      FROM
        RETURN_SAME_RECEIPT_ADDITIONAL_REL
;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- Create temp table with "SUCCESSOR" relationship type and types derived from it ( EVENT_AROUND_LOGOFF)
--
CREATE OR REPLACE TEMPORARY TABLE T_TMP_SUCCESSOR_REL
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_EVENT_REL_TYPE_CD STRING,
    REL_CASH_REGISTER_EVENT_SID BIGNUMERIC,
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    REL_BUS_DT ERROR_TYPE(Error<error-type>)
  )
  AS
    WITH EVENTS_FOR_SUCCESSOR_PREDECESSOR_ALL_NPI_EVENTS_REL AS (
      SELECT DISTINCT
          ------------------------------------------------
          -- rel type "SUCC_ALL_NPI_EVENTS" and "PRED_ALL_NPI_EVENTS"
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.BUS_DT = FACT.BUS_DT
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
          INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_1 AS S ON S.SCENARIO_ID = FACT.SCENARIO_ID
        WHERE S.SCENARIO_ID = NUMERIC '5' /* AUTO scenario for "Multpliple price checks in a row" (this type of relationship is required only for that scenario so far)*/
    ), SUCCESSOR_ALL_NPI_EVENTS_REL AS (
      SELECT
          --
          -- for "SUCC_ALL_NPI_EVENTS" we are looking for "next event", which could be ANY type RetailEvent (sale or return) and ANY types of technical events (so UNfiltered tech events)
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'SUCC_ALL_NPI_EVENTS' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          -- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
          coalesce(ENPE.NEXT_UNFILTERED_CASH_REGISTER_EVENT_SID, -NUMERIC '1') AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT,
          ENPE.BUS_DT AS REL_BUS_DT
        FROM
          EVENTS_FOR_SUCCESSOR_PREDECESSOR_ALL_NPI_EVENTS_REL AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT AS ENPE ON FACT.CASH_REGISTER_EVENT_SID = ENPE.CASH_REGISTER_EVENT_SID
           AND FACT.BUS_DT = ENPE.BUS_DT /* next event is always on the same date*/
    ), PREDECESSOR_ALL_NPI_EVENTS_REL AS (
      SELECT
          --
          -- for "PRED_ALL_NPI_EVENTS" we are looking for "previous event", which could be ANY type RetailEvent (sale or return) and ANY types of technical events (so UNfiltered tech events)
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'PRED_ALL_NPI_EVENTS' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          -- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
          coalesce(ENPE.PREV_UNFILTERED_CASH_REGISTER_EVENT_SID, -NUMERIC '1') AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT,
          ENPE.BUS_DT AS REL_BUS_DT
        FROM
          EVENTS_FOR_SUCCESSOR_PREDECESSOR_ALL_NPI_EVENTS_REL AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT AS ENPE ON FACT.CASH_REGISTER_EVENT_SID = ENPE.CASH_REGISTER_EVENT_SID
           AND FACT.BUS_DT = ENPE.BUS_DT /* next event is always on the same date*/
    ), EVENTS_FOR_SUCCESSOR AS (
      SELECT DISTINCT
          ------------------------------------------------
          -- rel type "SUCCESSOR"
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.BUS_DT = FACT.BUS_DT
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
          INNER JOIN LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_1 AS S ON S.SCENARIO_ID = FACT.SCENARIO_ID
        WHERE S.SCENARIO_GRP_ID = NUMERIC '1' /* Scenarios for Aborted/Suspended receipts (Bonabbruch/Bonrückstellung)*/
         OR S.SCENARIO_ID IN(
          NUMERIC '6', NUMERIC '36', NUMERIC '51', NUMERIC '52'
        ) /* AUTO and MANUAL scenarios for "Price Checks", but not "Multpliple price checks in a row"*/
    ), SUCCESSOR_REL AS (
      SELECT
          --
          -- for "SUCCESSOR" we are looking for "next event", which could be ANY type RetailEvent (sale or return) and SOME types of technical events (so filtered tech events)
          FACT.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'SUCCESSOR' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          -- almost every suspicious event should have real value here. -1 Shows incorrect data most likely and should be investigated
          coalesce(ENE.NEXT_FILTERED_CASH_REGISTER_EVENT_SID, -NUMERIC '1') AS REL_CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          FACT.BUS_DT AS BUS_DT,
          ENE.BUS_DT AS REL_BUS_DT
        FROM
          EVENTS_FOR_SUCCESSOR AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_TMP_EVENT_AND_NEXT_AND_PREV_EVENT AS ENE ON FACT.CASH_REGISTER_EVENT_SID = ENE.CASH_REGISTER_EVENT_SID
           AND FACT.BUS_DT = ENE.BUS_DT /* next event is always on the same date*/
    ), SUCCESSOR_REL_EXTENDED AS (
      SELECT
          SR.*,
          SR.CASH_REGISTER_EVENT_SID + EXT100.RN /* when we increase SID with small number (less than 10,000,000) we are guanrateed to get new sid in same Date, Store and CashRegister*/ AS AROUND_SUCCESSOR_SID
        FROM
          SUCCESSOR_REL AS SR
          INNER JOIN (
            SELECT
                row_number() OVER (ORDER BY if(NUMERIC '1' IS NULL, 0, 1) DESC, NUMERIC '1') AS RN
              FROM
                UNNEST(generate_array(NUMERIC '0', NUMERIC '99')) AS n
          ) AS EXT100 ON EXT100.RN <= SR.REL_CASH_REGISTER_EVENT_SID - SR.CASH_REGISTER_EVENT_SID + NUMERIC '1'
        -- if successor has EventNR=7 and original has EventNR = 3 the difference is 4, and we need  RN=1,2,3 to produce EventNR 4,5,6
        -- we also need the produce the next event, after 7 -> so we take row number up to  "Diff+1"
        -- 		This will give us Evnets (4,5,6,7***,8)
        -- 		***in the NEXT CTE however we must make sure we exclude "7" because this is the "SUCCESSOR"
        -- exclude dummy_1 successors
        WHERE SR.REL_CASH_REGISTER_EVENT_SID > -NUMERIC '1'
        -- Take only events for some scenarios - we want "pre_successors" only for them
         AND EXISTS (
          SELECT
              NUMERIC '1'
            FROM
              LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
            WHERE FACT.CASH_REGISTER_EVENT_SID = SR.CASH_REGISTER_EVENT_SID
             AND FACT.SCENARIO_ID IN(
              NUMERIC '6' /*	Preisanzeige + Kleinstbon oder Abmeldung Kasse*/, NUMERIC '16' /*	Offene Bonrückstellung + Kleinstbon o. Abmeldung Kasse*/, NUMERIC '17'
            )
        )
    ), EVENT_AROUND_LOGOFF_REL AS (
      SELECT
          -- 	Bonabbruch + Kleinstbon oder Abmeldung Kasse
          SRE.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
          'EVENT_AROUND_LOGOFF' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
          AE.CASH_REGISTER_EVENT_SID AS REL_CASH_REGISTER_EVENT_SID,
          SRE.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
          SRE.BUS_DT AS BUS_DT,
          AE.BUS_DT AS REL_BUS_DT
        FROM
          SUCCESSOR_REL_EXTENDED AS SRE
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_TMP_ALL_RELEVANT_EVENTS AS AE ON AE.BUS_DT = SRE.BUS_DT
           AND AE.CASH_REGISTER_EVENT_SID = SRE.AROUND_SUCCESSOR_SID
          -- we already have relationship of type "SUCCESSOR" with REL_CASH_REGISTER_EVENT_SID - so we exclude it
           AND AE.CASH_REGISTER_EVENT_SID <> SRE.REL_CASH_REGISTER_EVENT_SID
    )
    SELECT
        SUCCESSOR_ALL_NPI_EVENTS_REL.CASH_REGISTER_EVENT_SID,
        SUCCESSOR_ALL_NPI_EVENTS_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        SUCCESSOR_ALL_NPI_EVENTS_REL.REL_CASH_REGISTER_EVENT_SID,
        SUCCESSOR_ALL_NPI_EVENTS_REL.COUNTRY_ORG_CD,
        SUCCESSOR_ALL_NPI_EVENTS_REL.BUS_DT,
        SUCCESSOR_ALL_NPI_EVENTS_REL.REL_BUS_DT
      FROM
        SUCCESSOR_ALL_NPI_EVENTS_REL
    UNION ALL
    SELECT
        PREDECESSOR_ALL_NPI_EVENTS_REL.CASH_REGISTER_EVENT_SID,
        PREDECESSOR_ALL_NPI_EVENTS_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        PREDECESSOR_ALL_NPI_EVENTS_REL.REL_CASH_REGISTER_EVENT_SID,
        PREDECESSOR_ALL_NPI_EVENTS_REL.COUNTRY_ORG_CD,
        PREDECESSOR_ALL_NPI_EVENTS_REL.BUS_DT,
        PREDECESSOR_ALL_NPI_EVENTS_REL.REL_BUS_DT
      FROM
        PREDECESSOR_ALL_NPI_EVENTS_REL
    UNION ALL
    SELECT
        SUCCESSOR_REL.CASH_REGISTER_EVENT_SID,
        SUCCESSOR_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        SUCCESSOR_REL.REL_CASH_REGISTER_EVENT_SID,
        SUCCESSOR_REL.COUNTRY_ORG_CD,
        SUCCESSOR_REL.BUS_DT,
        SUCCESSOR_REL.REL_BUS_DT
      FROM
        SUCCESSOR_REL
    UNION ALL
    SELECT
        EVENT_AROUND_LOGOFF_REL.CASH_REGISTER_EVENT_SID,
        EVENT_AROUND_LOGOFF_REL.CASH_REGISTER_EVENT_REL_TYPE_CD,
        EVENT_AROUND_LOGOFF_REL.REL_CASH_REGISTER_EVENT_SID,
        EVENT_AROUND_LOGOFF_REL.COUNTRY_ORG_CD,
        EVENT_AROUND_LOGOFF_REL.BUS_DT,
        EVENT_AROUND_LOGOFF_REL.REL_BUS_DT
      FROM
        EVENT_AROUND_LOGOFF_REL
;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--
-- Create temp table with "DEPOSIT_SAME_EAN" relationship type
--
CREATE OR REPLACE TEMPORARY TABLE T_TMP_DEPOSIT_REL
  (
    CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    CASH_REGISTER_EVENT_REL_TYPE_CD STRING,
    REL_CASH_REGISTER_EVENT_SID ERROR_TYPE(Error<error-type>),
    COUNTRY_ORG_CD ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    REL_BUS_DT ERROR_TYPE(Error<error-type>)
  )
  AS
    WITH SUSPICIOUS_DEPOSIT_RECEIPTS AS (
      SELECT
          -- Receipts from classification table for scenario_id = 2 - only suspicious
          FACT.CASH_REGISTER_EVENT_SID,
          FACT.COUNTRY_ORG_CD,
          FACT.BUS_DT
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 AS FACT
          INNER JOIN LDL_DATA_PRODUCTION.ETL.T_STORES_QUALIFIED_1 AS SQ ON SQ.STORE_SID = FACT.STORE_SID
           AND SQ.COUNTRY_ORG_CD = FACT.COUNTRY_ORG_CD
           AND SQ.BUS_DT = FACT.BUS_DT
        WHERE FACT.SCENARIO_ID = NUMERIC '2'
    ), ALL_DEPOSIT_GROUPS AS (
      SELECT DISTINCT
          -- Marking the groups from temporary table suspicious based on the input from suspicious_deposit_receipts CTE
          DPL.CASH_REGISTER_EVENT_SID,
          DPL.COUNTRY_ORG_CD,
          DPL.BUS_DT,
          DPL.STORE_SID,
          DPL.CASHIER_NR,
          DPL.EVENT_END_TMSP,
          DPL.EAN_GROUP,
          CASE
            WHEN SDR.CASH_REGISTER_EVENT_SID IS NOT DISTINCT FROM CAST(NULL as STRING) THEN NUMERIC '0'
            ELSE NUMERIC '1'
          END AS SUSPICIOUS_FG
        FROM
          LDL_DATA_PRODUCTION.ETL.T_TMP_DEPOSIT_PRODUCT_LINES AS DPL
          LEFT OUTER JOIN SUSPICIOUS_DEPOSIT_RECEIPTS AS SDR ON SDR.CASH_REGISTER_EVENT_SID = DPL.CASH_REGISTER_EVENT_SID
           AND SDR.COUNTRY_ORG_CD = DPL.COUNTRY_ORG_CD
           AND SDR.BUS_DT = DPL.BUS_DT
    ), DEPOSIT_GROUPS_FILTERED AS (
      SELECT
          ALL_DEPOSIT_GROUPS.*
        FROM
          ALL_DEPOSIT_GROUPS
        -- Take only these EAN_1 groups where at least one receipt is marked suspicious
        QUALIFY sum(ALL_DEPOSIT_GROUPS.SUSPICIOUS_FG) OVER (PARTITION BY ALL_DEPOSIT_GROUPS.EAN_GROUP) > NUMERIC '0'
         AND sum(CASE
           ALL_DEPOSIT_GROUPS.SUSPICIOUS_FG
          -- Take only these EAN_1 groups where exactly one receipt is marked non suspicious
          -- This filter will discard multiple entries for the same receipt where, apart from suspicious EAN_1 numbers, there is any EAN_1 number that was not suspicious
          WHEN NUMERIC '0' THEN NUMERIC '1'
          ELSE NUMERIC '0'
        END) OVER (PARTITION BY ALL_DEPOSIT_GROUPS.EAN_GROUP) = NUMERIC '1'
    ), FIRST_SUSPICIOUS AS (
      SELECT
          DEPOSIT_GROUPS_FILTERED.*
        FROM
          DEPOSIT_GROUPS_FILTERED
        WHERE DEPOSIT_GROUPS_FILTERED.SUSPICIOUS_FG = NUMERIC '1'
        -- For all suspicious receipts, find only the first one by a time precedence
        -- This receipt will be a "parent" one in the report
        QUALIFY row_number() OVER (PARTITION BY DEPOSIT_GROUPS_FILTERED.EAN_GROUP ORDER BY if(DEPOSIT_GROUPS_FILTERED.EVENT_END_TMSP IS NULL, 0, 1) DESC, DEPOSIT_GROUPS_FILTERED.EVENT_END_TMSP) = NUMERIC '1'
    )
    SELECT
        FS.CASH_REGISTER_EVENT_SID AS CASH_REGISTER_EVENT_SID,
        'DEPOSIT_SAME_EAN' AS CASH_REGISTER_EVENT_REL_TYPE_CD,
        F.CASH_REGISTER_EVENT_SID AS REL_CASH_REGISTER_EVENT_SID,
        FS.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
        FS.BUS_DT AS BUS_DT,
        F.BUS_DT AS REL_BUS_DT
        -- "Parent" receipts
      FROM
        FIRST_SUSPICIOUS AS FS
        INNER JOIN DEPOSIT_GROUPS_FILTERED AS F ON FS.EAN_GROUP = F.EAN_GROUP
        -- "Child" receipt - all related to the same EAN_1 group apart from "parent"
         AND FS.CASH_REGISTER_EVENT_SID <> F.CASH_REGISTER_EVENT_SID
;
INSERT INTO LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP_1 (CASH_REGISTER_EVENT_SID, CASH_REGISTER_EVENT_REL_TYPE_CD, REL_CASH_REGISTER_EVENT_SID, COUNTRY_ORG_CD, BUS_DT, REL_BUS_DT, DWH_CREATED_TMSP, DWH_UPDATED_TMSP, DWH_LOAD_ID, DWH_NODE_CD)
  WITH ALL_RELS AS (
    SELECT
        *
      FROM
        LDL_DATA_PRODUCTION.ETL.T_TMP_GENERIC_REL
    UNION ALL
    SELECT
        *
      FROM
        LDL_DATA_PRODUCTION.ETL.T_TMP_ORIGINAL_REL
    UNION ALL
    SELECT
        *
      FROM
        LDL_DATA_PRODUCTION.ETL.T_TMP_SUCCESSOR_REL
    UNION ALL
    SELECT
        *
      FROM
        LDL_DATA_PRODUCTION.ETL.T_TMP_DEPOSIT_REL
  )
  SELECT
      ALL_RELS.CASH_REGISTER_EVENT_SID,
      ALL_RELS.CASH_REGISTER_EVENT_REL_TYPE_CD,
      ALL_RELS.REL_CASH_REGISTER_EVENT_SID,
      ALL_RELS.COUNTRY_ORG_CD,
      ALL_RELS.BUS_DT,
      ALL_RELS.REL_BUS_DT,
      current_timestamp() AS DWH_CREATED_TMSP,
      current_timestamp() AS DWH_UPDATED_TMSP,
      ALL_RELS.${LOAD_ID} AS DWH_LOAD_ID,
      'CORE_REL' AS DWH_NODE_CD
    FROM
      ALL_RELS
  ORDER BY
    COUNTRY_ORG_CD NULLS LAST
;
------------------------------------------------
-- rel type "EVENT_AROUND_LOGOFF"
--
-- when we generate all SIDs between the "original" receipt and its "successor" in advance we can use "=" in the join
-- we do this to avoid joins using ">" and "<" between big tables  "successor_rel" and "T_TMP_ALL_RELEVANT_EVENTS"
