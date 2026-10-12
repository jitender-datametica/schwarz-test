/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_abort_logoff_sale.sql
#----------------------------------------------------------------------------
# History:
#  1.0  27.09.2024  Mihail Ivanov  - ZKP GF_2 - Initial implementation
		UserStory 
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/53162/
			"ZKP: aborted and sale + aborted and log off"
		Setting the following flags:
			ABORT_AND_SALE_FG
			ABORT_AND_LOGOFF_FG
			
# 1.1	01.10.2024	Mihail Ivanov - bugfix
		- fix column order in the SELECT-INSERT
# 1.2   09.12.2024  Osman Yilmaz - bugfix
        - Extension with value thresholds and small sales_2
# 1.3   12.12.2024  Osman Yilmaz - bugfix
        - Condition update for the small sales_2
# 1.4   24.01.2025  Andrzej Wandtke  - ZKP GF_2 - bugfixing: bug 63595 - skip some transaction types while looking for next receipt in T_TECHNICAL_CASH_REGISTER_EVENT_2
        - As the price info operations are also skipped in the old world they are skipped in GF_2 as well. Technically it means : remove data extraction from T_PRICE_INFORMATION_EVENT_2 in CTE all_cash_reg_events


# 1.5  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country_2 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios

# 1.6  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/

INSERT INTO `${BQ_PROJECT_ID}.${FWRK_WORK_DB}.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL`  
		(
			cash_register_event_sid
			, cash_register_event_nr
			, event_start_tmsp
			, bus_dt
			, cash_register_sid
			, cash_register_nr
			, store_sid
			, cashier_hash
			, txn_net_val
			, txn_gross_val
			, curr_cd
			
			, abort_and_sale_fg
			, abort_and_logoff_fg
		)
WITH
-- scenario_paramvalues AS
-- (
    -- SELECT sc_pv.COUNTRY_ORG_CD
           -- ,MAX(decode(sc_pv.PARAM_ID,51,sc_pv.PARAM_VAL_QTY,NULL)) AS ABORT_EVENT_MIN_VAL
           -- ,MAX(decode(sc_pv.PARAM_ID,52,sc_pv.PARAM_VAL_QTY,NULL)) AS SALE_EVENT_MAX_VAL
    -- FROM core_app_fraud_detection.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2 sc_pv
    -- GROUP BY sc_pv.COUNTRY_ORG_CD
-- )
mat_params AS
(
    SELECT *
    FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2`
    WHERE SCENARIO_ID = 17 --   Bonabbruch + Kleinstbon oder Abmeldung Kasse
)
,small_sales AS
(
SELECT 
        tprl.RETAIL_EVENT_SID
    FROM VT1 
		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_2` tprl
				ON vt1.COUNTRY_CD = tprl.COUNTRY_ORG_CD
				AND vt1.DWH_CAL_DT = tprl.BUS_DT
				AND vt1.LOC_SID = tprl.STORE_SID
        JOIN mat_params p_smv -- param sale max val (Folgebon ist ein Kleinstbon < X LW und nur 1 Artikel_2)
            ON p_smv.COUNTRY_ORG_CD = tprl.COUNTRY_ORG_CD
			and p_smv.PARAM_ID = 52
			-- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
			and p_smv.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
    WHERE 1=1
		and tprl.TURNOVER_RELEVANT_FG = TRUE
        and tprl.BUS_DT between MIN_DWH_CAL_DT and MAX_DWH_CAL_DT
	GROUP BY
        tprl.RETAIL_EVENT_SID
    HAVING
		--take only these receipts with only one sale or deposit return line
		SUM(CASE WHEN tprl.RETAIL_EVENT_LINE_SCENARIO_ID IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
		--take only these receipts where there is no cancellation line with relevant value
		AND SUM(CASE WHEN tprl.CANCEL_LINE_SEQ IS NULL AND tprl.RETAIL_LINE_GROSS_VAL < p_smv.PARAM_VAL_QTY AND tprl.RETAIL_EVENT_LINE_SCENARIO_ID IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
)
,aborted_receipts AS
(
    SELECT
        o_re.RETAIL_EVENT_SID
        ,o_re.BUS_DT
        ,o_re.EVENT_START_TMSP
        ,o_re.CASH_REGISTER_SID
        ,o_re.CASH_REGISTER_EVENT_NR
		,o_re.STORE_SID
		,o_re.CASHIER_HASH
		,o_re.TXN_NET_VAL
		,o_re.TXN_GROSS_VAL
		,o_re.curr_cd
    FROM VT1 -- delta ${FWRK_WORK_DB} 
		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_2` o_re
				ON o_re.BUS_DT = vt1.DWH_CAL_DT
				AND o_re.COUNTRY_ORG_CD = vt1.COUNTRY_CD
				AND o_re.STORE_SID = vt1.LOC_SID
        JOIN mat_params p_amv -- param abort min val (Gesamtwert Bonabbruch >= X LW (Landeswährung))
            ON p_amv.COUNTRY_ORG_CD = o_re.COUNTRY_ORG_CD
			and p_amv.PARAM_ID = 51
			-- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
			and p_amv.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
    WHERE 1=1
		-- delta
		AND o_re.BUS_DT BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT

		-- bus logic: Aborted/Cancelled Sales_2 Event
		AND o_re.RETAIL_EVENT_TYPE_CD = 'S'
		AND o_re.CANCEL_FG = TRUE  -- Aborted
        AND o_re.TXN_GROSS_VAL >= p_amv.PARAM_VAL_QTY -- Threshold check Gesamtwert Bonabbruch >= X LW 09.12
)
,all_cash_reg_events AS
(
    SELECT 
        CASH_REGISTER_EVENT_NR
        ,EVENT_TMSP
        ,BUS_DT
        ,CASH_REGISTER_SID
        ,'TECH_EVENT'                           AS EVENT_CATEGORY
        ,TECH_CASH_REGISTER_EVENT_TYPE_CD     	AS EVENT_SUBCATEGORY
        ,CANCEL_FG
        ,SUSPEND_FG
        ,FALSE                                  AS SMALL_SALE_FG  -- Just added as default value for union, later important for small sale determination
    FROM VT1 
		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_2` tcre
				ON tcre.BUS_DT = vt1.DWH_CAL_DT
				AND tcre.COUNTRY_ORG_CD = vt1.COUNTRY_CD
				AND tcre.STORE_SID = vt1.LOC_SID
    WHERE BUS_DT BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT
    AND   CAST(TECH_CASH_REGISTER_EVENT_TYPE_CD AS INT64) NOT IN (400, 405, 420, 425, 430)

    UNION ALL
    
	SELECT 
        CASH_REGISTER_EVENT_NR
        ,EVENT_START_TMSP
        ,BUS_DT
        ,CASH_REGISTER_SID
        ,'RETAIL_EVENT'             AS EVENT_CATEGORY
        ,RETAIL_EVENT_TYPE_CD       AS EVENT_SUBCATEGORY
        ,CANCEL_FG
        ,SUSPEND_FG
        ,CASE WHEN sm_sl.RETAIL_EVENT_SID IS NOT NULL THEN TRUE ELSE FALSE END AS SMALL_SALE_FG -- Small sales_2 receipt 
    FROM VT1
		JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_2` re_2
				ON re.BUS_DT = vt1.DWH_CAL_DT
				AND re.COUNTRY_ORG_CD = vt1.COUNTRY_CD
				AND re.STORE_SID = vt1.LOC_SID
        LEFT JOIN  small_sales sm_sl
                ON sm_sl.RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
    WHERE BUS_DT BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT 

)
SELECT
    ar.RETAIL_EVENT_SID				AS cash_register_event_sid
	,cast(ar.cash_register_event_nr as string)		AS cash_register_event_nr
	,ar.event_start_tmsp
	,ar.bus_dt
	,ar.cash_register_sid
	,cast(cr.cash_register_nr as string)
	,ar.store_sid
	,ar.cashier_hash
	,ar.txn_net_val
	,ar.txn_gross_val
	,ar.curr_cd
	
	-- ,DECODE(acre.EVENT_CATEGORY, 'RETAIL_EVENT', 1, 0)  AS abort_and_sale_fg
  --   ,DECODE(acre.EVENT_CATEGORY, 'TECH_EVENT', 1, 0)    AS abort_and_logoff_fg
    ,CASE WHEN acre.EVENT_CATEGORY = 'RETAIL_EVENT' THEN TRUE ELSE FALSE END AS abort_and_sale_fg
,CASE WHEN acre.EVENT_CATEGORY = 'TECH_EVENT'   THEN TRUE ELSE FALSE END AS abort_and_logoff_fg


FROM aborted_receipts ar
    JOIN all_cash_reg_events acre
            ON ar.CASH_REGISTER_SID = acre.CASH_REGISTER_SID
            AND ar.BUS_DT = acre.BUS_DT
            AND ar.CASH_REGISTER_EVENT_NR < acre.CASH_REGISTER_EVENT_NR
	JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER_2` cr
		ON ar.CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE

QUALIFY 1=1
    -- we take the next event at the same Cash Register (that happened after the suspended receipt)
    AND ROW_NUMBER() OVER (partition by ar.RETAIL_EVENT_SID ORDER BY acre.CASH_REGISTER_EVENT_NR ASC) = 1
    
    -- we check if next event is valid (not suspended, not cancelled)
    AND acre.CANCEL_FG = FALSE
    AND acre.SUSPEND_FG = FALSE
    
    -- AND we check if this next event is a sale or a logoff event
    AND (   
            -- "sign off" cash register event
            (acre.EVENT_CATEGORY = 'TECH_EVENT' AND acre.EVENT_SUBCATEGORY='410')
            -- "sale" retail event
            OR (acre.EVENT_CATEGORY = 'RETAIL_EVENT' AND acre.EVENT_SUBCATEGORY='S' AND acre.SMALL_SALE_FG)
        )
;
