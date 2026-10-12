/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_abort_logoff_sale.sql
#----------------------------------------------------------------------------
# History:
#  1.0  27.09.2024  Mihail Ivanov  - ZKP GF - Initial implementation
		UserStory 
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/53162/
			"ZKP: aborted and sale + aborted and log off"
		Setting the following flags:
			ABORT_AND_SALE_FG
			ABORT_AND_LOGOFF_FG
			
# 1.1	01.10.2024	Mihail Ivanov - bugfix
		- fix column order in the SELECT-INSERT
# 1.2   09.12.2024  Osman Yilmaz - bugfix
        - Extension with value thresholds and small sales
# 1.3   12.12.2024  Osman Yilmaz - bugfix
        - Condition update for the small sales
# 1.4   24.01.2025  Andrzej Wandtke  - ZKP GF - bugfixing: bug 63595 - skip some transaction types while looking for next receipt in T_TECHNICAL_CASH_REGISTER_EVENT
        - As the price info operations are also skipped in the old world they are skipped in GF as well. Technically it means : remove data extraction from T_PRICE_INFORMATION_EVENT in CTE all_cash_reg_events


# 1.5  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios

# 1.6  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
						
# 1.7  20.08.2025  Mihail Ivanov  - Changes:
						Add filter to exclude training receipts - as of this time TRAINING_FG is not correctly set in CORE_REL tables so we use retail_event_scenario_id
						https://jira.schwarz/browse/NEOGFPL-71572
						
# 1.8  03.11.2025  Mihail Ivanov  - Changes:
						Add filter to exclude receipts from Self Checkout registers (SCO)
						https://jira.schwarz/browse/NEOGFPL-71701
*/

INSERT INTO
${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final (cash_register_event_sid,
 cash_register_event_nr, event_start_tmsp, bus_dt, cash_register_sid, cash_register_nr, store_sid, cashier_hash,
 txn_net_val, txn_gross_val, curr_cd, abort_and_sale_fg, abort_and_logoff_fg)
WITH 
-- scenario_paramvalues AS
-- (
    -- SELECT sc_pv.COUNTRY_ORG_CD
           -- ,MAX(decode(sc_pv.PARAM_ID,51,sc_pv.PARAM_VAL_QTY,NULL)) AS ABORT_EVENT_MIN_VAL
           -- ,MAX(decode(sc_pv.PARAM_ID,52,sc_pv.PARAM_VAL_QTY,NULL)) AS SALE_EVENT_MAX_VAL
    -- FROM LDL_DATA.core_app_fraud_detection.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE sc_pv
    -- GROUP BY sc_pv.COUNTRY_ORG_CD
-- )
MAT_PARAMS AS (SELECT param_id,
    scenario_id,
    scenario_type_cd,
    param_name,
    country_org_cd,
    param_default_val_qty,
    param_country_val_qty,
    param_val_qty,
    param_last_update_tmsp,
    is_scenario_enabled_in_country_fg
   FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
   WHERE scenario_id = 17 -- Bonabbruch + Kleinstbon oder Abmeldung Kasse
), SMALL_SALES AS (SELECT TPRL.retail_event_sid
    
   FROM ${FWRK_WORK_DB}.vt1 AS vt12
    INNER JOIN ldl_data_core_rel.t_product_retail_line AS TPRL ON vt12.country_cd = TPRL.country_org_cd AND vt12.dwh_cal_dt
        = TPRL.bus_dt AND vt12.loc_sid = TPRL.store_sid
    INNER JOIN MAT_PARAMS AS p_smv -- param sale max val (Folgebon ist ein Kleinstbon < X LW und nur 1 Artikel)
    ON TPRL.country_org_cd = p_smv.country_org_cd AND p_smv.param_id = 52
       -- if scneario is not enabled all receipts from that country will be eliminated in the inner join
 AND p_smv.is_scenario_enabled_in_country_fg  = TRUE
     
   WHERE  TPRL.turnover_relevant_fg  = TRUE
    AND TPRL.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT

   GROUP BY TPRL.retail_event_sid
   HAVING -- take only these receipts with only one sale or deposit return line
 SUM(CASE
       WHEN TPRL.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222)
       THEN 1
       ELSE 0
       END) = 1 -- take only these receipts where there is no cancellation line with relevant value
 AND SUM(CASE
       WHEN TPRL.cancel_line_seq IS NULL AND TPRL.retail_line_gross_val < p_smv.param_val_qty AND TPRL.retail_event_line_scenario_id
          IN (101, 102, 120, 122, 201, 202, 220, 222)
       THEN 1
       ELSE 0
       END) = 1), ABORTED_RECEIPTS AS (SELECT O_RE.retail_event_sid
    ,
    O_RE.bus_dt,
    O_RE.event_start_tmsp,
    O_RE.cash_register_sid,
    O_RE.cash_register_event_nr,
    O_RE.store_sid,
    O_RE.cashier_hash,
    O_RE.txn_net_val,
    O_RE.txn_gross_val,
    O_RE.curr_cd
   FROM ${FWRK_WORK_DB}.vt1 -- delta
    INNER JOIN ldl_data_core_rel.t_retail_event AS O_RE ON vt1.dwh_cal_dt = O_RE.bus_dt AND vt1.country_cd = O_RE.country_org_cd
        AND vt1.loc_sid = O_RE.store_sid
    INNER JOIN MAT_PARAMS AS p_amv 
    -- param abort min val (Gesamtwert Bonabbruch >= X LW (Landeswährung))
    ON O_RE.country_org_cd = p_amv.country_org_cd AND p_amv.param_id = 51
       -- if scneario is not enabled all receipts from that country will be eliminated in the inner join
 AND p_amv.is_scenario_enabled_in_country_fg
     
   WHERE 
   -- delta
   O_RE.bus_dt  BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT

       -- bus logic: Aborted/Cancelled Sales Event

    AND O_RE.retail_event_type_cd = 'S'
    AND O_RE.cancel_fg = TRUE  -- Aborted
    AND O_RE.txn_gross_val >= p_amv.param_val_qty -- Threshold check Gesamtwert Bonabbruch >= X LW 09.12

     -- exclude training receipts

    AND (O_RE.cash_register_type_cd IN ('TIL', 'POS') OR O_RE.cash_register_type_cd IS NULL)
    -- only receipts at regular cash desks
    AND O_RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)), ALL_CASH_REG_EVENTS AS (SELECT TCRE.cash_register_event_nr,
     TCRE.event_tmsp,
     TCRE.bus_dt,
     TCRE.cash_register_sid,
     'TECH_EVENT' AS event_category,
     TCRE.tech_cash_register_event_type_cd AS event_subcategory,
     TCRE.cancel_fg,
     TCRE.suspend_fg,
     FALSE AS small_sale_fg -- Just added as default value for union, later important for small sale determination
    FROM ${FWRK_WORK_DB}.vt1 AS vt10 -- delta
     INNER JOIN ldl_data_core_rel.t_technical_cash_register_event AS TCRE ON vt10.dwh_cal_dt = TCRE.bus_dt AND vt10.country_cd
         = TCRE.country_org_cd AND vt10.loc_sid = TCRE.store_sid
    WHERE TCRE.bus_dt  BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
     AND CAST(TCRE.tech_cash_register_event_type_cd AS INTEGER) NOT IN (400, 405, 420, 425, 430)
    UNION ALL
    SELECT RE.cash_register_event_nr,
     RE.event_start_tmsp,
     RE.bus_dt,
     RE.cash_register_sid,
     'RETAIL_EVENT' AS event_category,
     RE.retail_event_type_cd AS event_subcategory,
     RE.cancel_fg,
     RE.suspend_fg,
     sm_sl.retail_event_sid IS NOT NULL AS small_sale_fg -- Small sales receipt
    FROM ${FWRK_WORK_DB}.vt1 AS vt11
     INNER JOIN ldl_data_core_rel.t_retail_event AS RE ON vt11.dwh_cal_dt = RE.bus_dt AND vt11.country_cd = RE.country_org_cd
         AND vt11.loc_sid = RE.store_sid
     LEFT JOIN SMALL_SALES AS sm_sl ON RE.retail_event_sid = sm_sl.retail_event_sid
    WHERE RE.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT)
   (SELECT ar.retail_event_sid AS cash_register_event_sid,
    ar.cash_register_event_nr,
    CAST(ar.event_start_tmsp AS DATETIME) AS event_start_tmsp,
    ar.bus_dt,
    ar.cash_register_sid,
    CAST(CR.cash_register_nr AS STRING) AS cash_register_nr,
    ar.store_sid,
    ar.cashier_hash,
    CAST(ar.txn_net_val AS NUMERIC) AS txn_net_val,
    CAST(ar.txn_gross_val AS NUMERIC) AS txn_gross_val,
    ar.curr_cd,
     CASE
     WHEN acre.event_category = 'RETAIL_EVENT'
     THEN 1
     ELSE 0
     END AS abort_and_sale_fg,
     CASE
     WHEN acre.event_category = 'TECH_EVENT'
     THEN 1
     ELSE 0
     END AS abort_and_logoff_fg
   FROM ABORTED_RECEIPTS AS ar
    INNER JOIN ALL_CASH_REG_EVENTS AS acre ON ar.cash_register_sid = acre.cash_register_sid AND ar.bus_dt = acre.bus_dt
     AND ar.cash_register_event_nr < acre.cash_register_event_nr
    INNER JOIN ldl_data_core_rel.t_cash_register AS CR ON ar.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg
   QUALIFY 
    -- we take the next event at the same Cash Register (that happened after the suspended receipt)
    (ROW_NUMBER() OVER (PARTITION BY ar.retail_event_sid  ORDER BY acre.cash_register_event_nr
            IS NULL, acre.cash_register_event_nr)) = 1
   -- we check if next event is valid (not suspended, not cancelled)
 AND acre.cancel_fg = FALSE AND acre.suspend_fg = FALSE
  -- AND we check if this next event is a sale or a logoff event
 AND ((acre.event_category = 'TECH_EVENT' AND
           acre.event_subcategory = '410' ) -- "sign off" cash register event
           OR (acre.event_category = 'RETAIL_EVENT' AND acre.event_subcategory = 'S' AND -- "sale" retail event
          acre.small_sale_fg)));