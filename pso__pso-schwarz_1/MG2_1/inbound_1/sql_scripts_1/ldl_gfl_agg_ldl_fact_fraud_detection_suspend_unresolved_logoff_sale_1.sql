/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_suspend_unresolved_logoff_sale.sql
#----------------------------------------------------------------------------
# History:
#  1.0  12.09.2024  Mihail Ivanov  - ZKP GF_1 - Initial implementation
		UserStory 
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33390/
		Setting the following flags:
			SUSPEND_UNRESOLVED_AND_LOGOFF_FG
			SUSPEND_UNRESOLVED_AND_SALE_FG
#  1.1  17.09.2024  Andrzej Wandtke - ZKP GF_1 - replace CONT_RETAIL_EVENT_SID by SUSP_RETAIL_EVENT_SID - forced by a change in DB
#  1.2  28.11.2024  Kamil Roszczyk  - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59465
									Change log:
										- subsequent receipt logic changed and adjusted to old ZKP (removed 400, 405, 420, 425, 430 and 480 type events from the subsequent receipt candidates - all_cash_reg_events CTE)
										- added conditions to pick not any sales_1 but the small sales_1 according to the old ZKP definition (receipt sales_1 lines + receipt deposit return lines = 1; no cancelled lines; total receipt gross value lesser than the threshold parameter value)
										- added cashier_hash to the join condition for picking the subsequent receipt as per old ZKP ('country_1, store, cash register, cashier, date' combination)
										- rebuilt the code to improve performance
#  1.3  03.01.2025  Osman Yilmaz  - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62167
									Change log:
										- The condition is removed during the check of resumed receipt. The resume receipt can be also canceled or suspended in this case it is not open suspended


#  1.4  11.03.2025  Mihail Ivanov  - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64821
									Change log:
										added filtering for suspended receipts based on threshold "Bonrückstellung mit Gesamtwert Bonrückstellung > X"
#  1.5	18.03.2025  Andrzej Wandtke   - ZKP GF_1 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.6  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country_1 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
						- Using CASHIER_NR to determine next receipt by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR

#  1.7  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.8  29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69257
*/

INSERT INTO
	${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final
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

			, suspend_unresolved_and_logoff_fg
			, suspend_unresolved_and_sale_fg
		)
with
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1
    WHERE SCENARIO_ID = 16 --  (US: 33390) Offene Bonrückstellung + Kleinstbon oder Abmeldung Kasse
)
,suspended_receipts as
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
		,ce.CASHIER_NR
    FROM core_rel.T_RETAIL_EVENT_1 o_re
		join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
			on ce.CASHIER_HASH = o_re.CASHIER_HASH	
    WHERE 1=1
        and o_re.BUS_DT between $MIN_DWH_CAL_DT and $MAX_DWH_CAL_DT
        and (o_re.country_org_cd, o_re.bus_dt, o_re.store_sid) IN --Delta country_1, date, store logic
			(
			  SELECT country_cd, dwh_cal_dt, loc_sid
				  FROM ${FWRK_WORK_DB}.vt1
			)
        and o_re.RETAIL_EVENT_TYPE_CD = 'S'
        and o_re.SUSPEND_FG = TRUE  -- suspended
        and o_re.CANCEL_FG = FALSE  -- not cancelled
        and (o_re.CASH_REGISTER_TYPE_CD = 'TIL'
			OR o_re.CASH_REGISTER_TYPE_CD IS NULL) -- standard cash registers
        -- not continued  with regular (payed) receipt
        and not exists
    	(	
            select 1
    		from core_rel.T_RETAIL_EVENT_1 c_re
    		where o_re.RETAIL_EVENT_SID = c_re.SUSP_RETAIL_EVENT_SID
    			and c_re.BUS_DT = o_re.BUS_DT
                and c_re.RETAIL_EVENT_TYPE_CD = 'S'
				-- the conditions are removed according to change on 03.01.2025, resume transaction can be also canceled 
                -- and c_re.SUSPEND_FG = FALSE
                -- and c_re.CANCEL_FG = FALSE
    	)
)
,all_cash_reg_events as
(
    SELECT
		tcre.TECH_CASH_REGISTER_EVENT_SID		as CASH_REGISTER_EVENT_SID
        ,tcre.CASH_REGISTER_EVENT_NR
        ,tcre.EVENT_TMSP
        ,tcre.BUS_DT
        ,tcre.COUNTRY_ORG_CD
        ,tcre.CASH_REGISTER_SID
        ,tcre.CASHIER_HASH
        ,'TECH_EVENT'                           as EVENT_CATEGORY
        ,tcre.TECH_CASH_REGISTER_EVENT_TYPE_CD	as EVENT_SUBCATEGORY
        ,tcre.CANCEL_FG
        ,tcre.SUSPEND_FG
		,0										as TXN_GROSS_VAL
		,ce.CASHIER_NR
    FROM core_rel.T_TECHNICAL_CASH_REGISTER_EVENT_1 tcre
		join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
			on ce.CASHIER_HASH = tcre.CASHIER_HASH
    WHERE 1=1
		--all technical events apart from 400, 405, 420, 425, 430 and 480 - exclusion logic same as in old ZKP (480 is a price info event - separate subquery removed from subsequent receipts' candidates CTE - 28.11.2024)
		and tcre.TECH_CASH_REGISTER_EVENT_TYPE_CD not in (400, 405, 420, 425, 430)
        and tcre.BUS_DT between $MIN_DWH_CAL_DT and $MAX_DWH_CAL_DT
        and (tcre.country_org_cd, tcre.bus_dt, tcre.store_sid) IN
			(
			  SELECT country_cd, dwh_cal_dt, loc_sid
				  FROM ${FWRK_WORK_DB}.vt1
			)
    UNION ALL
    SELECT
		re.RETAIL_EVENT_SID			as CASH_REGISTER_EVENT_SID
        ,re.CASH_REGISTER_EVENT_NR
        ,re.EVENT_START_TMSP
        ,re.BUS_DT
        ,re.COUNTRY_ORG_CD
        ,re.CASH_REGISTER_SID
        ,re.CASHIER_HASH
        ,'RETAIL_EVENT'             as EVENT_CATEGORY
        ,re.RETAIL_EVENT_TYPE_CD   	as EVENT_SUBCATEGORY
        ,re.CANCEL_FG
        ,re.SUSPEND_FG
		,re.TXN_GROSS_VAL
		,ce.CASHIER_NR
    FROM core_rel.T_RETAIL_EVENT_1 re_1
		join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
			on ce.CASHIER_HASH = re.CASHIER_HASH
    WHERE 1=1
        and re.BUS_DT between $MIN_DWH_CAL_DT and $MAX_DWH_CAL_DT
        and (re.country_org_cd, re.bus_dt, re.store_sid) IN
			(
			  SELECT country_cd, dwh_cal_dt, loc_sid
				  FROM ${FWRK_WORK_DB}.vt1
			)
)
,small_sales_receipt_lines as
(
	SELECT 
        tprl.RETAIL_EVENT_SID
    FROM ${FWRK_WORK_DB}.vt1
		join core_rel.T_PRODUCT_RETAIL_LINE_1 tprl
				on vt1.COUNTRY_CD = tprl.COUNTRY_ORG_CD
				and vt1.DWH_CAL_DT = tprl.BUS_DT
				and vt1.LOC_SID = tprl.STORE_SID
    WHERE 1=1
		and tprl.TURNOVER_RELEVANT_FG = TRUE
        and tprl.BUS_DT between $MIN_DWH_CAL_DT and $MAX_DWH_CAL_DT
	GROUP BY
        tprl.RETAIL_EVENT_SID
    HAVING
		--take only these receipts with only one sale or deposit return line
		SUM(CASE WHEN tprl.RETAIL_EVENT_LINE_SCENARIO_ID IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
		--take only these receipts where there is no cancellation line with relevant value
		AND SUM(CASE WHEN tprl.CANCEL_LINE_SEQ IS NOT NULL AND tprl.RETAIL_LINE_GROSS_VAL > 0 THEN 1 ELSE 0 END) = 0
)
,event_and_next_event as
(
SELECT
    sr.RETAIL_EVENT_SID				as cash_register_event_sid
	,sr.cash_register_event_nr		as cash_register_event_nr
	,sr.event_start_tmsp
	,sr.bus_dt
	,sr.cash_register_sid
	,sr.store_sid
	,sr.cashier_hash
	,sr.txn_net_val
	,sr.txn_gross_val
	,sr.curr_cd
	
	,acre.cash_register_event_sid	as next_cash_register_event_sid
	,acre.event_category			as next_event_category
	,acre.event_subcategory			as next_event_subcategory
	,acre.country_org_cd			as next_country_org_cd
	,acre.suspend_fg				as next_suspend_fg
	,acre.txn_gross_val				as next_txn_gross_val
FROM suspended_receipts sr
    join all_cash_reg_events acre
            on sr.CASH_REGISTER_SID = acre.CASH_REGISTER_SID
            and sr.BUS_DT = acre.BUS_DT
            and sr.CASHIER_NR = acre.CASHIER_NR -- no need to add condition for same Store, it is already guaranteed because we have condition for same cash_register_sid
            and sr.CASH_REGISTER_EVENT_NR < acre.CASH_REGISTER_EVENT_NR
QUALIFY
    -- we take the next event at the same Cash Register (that happened after the suspended receipt)
    ROW_NUMBER() over (partition by sr.RETAIL_EVENT_SID order by acre.CASH_REGISTER_EVENT_NR asc) = 1
)
SELECT
    eane.cash_register_event_sid
	,eane.cash_register_event_nr
	,eane.event_start_tmsp
	,eane.bus_dt
	,eane.cash_register_sid
	,cr.cash_register_nr
	,eane.store_sid
	,eane.cashier_hash
	,eane.txn_net_val
	,eane.txn_gross_val
	,eane.curr_cd
	
    ,decode(eane.NEXT_EVENT_CATEGORY, 'TECH_EVENT', 1, 0)    as suspend_unresolved_and_logoff_fg
    ,decode(eane.NEXT_EVENT_CATEGORY, 'RETAIL_EVENT', 1, 0)  as suspend_unresolved_and_sale_fg
FROM event_and_next_event eane
	join core_rel.T_CASH_REGISTER_1 cr
		ON eane.CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
	join mat_params s16_kb    -- Scenario 16, parameter "Small sale lesser than X LW"
			on s16_kb.COUNTRY_ORG_CD = eane.NEXT_COUNTRY_ORG_CD
			and s16_kb.PARAM_ID = 49
			-- if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join
			and s16_kb.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
	join mat_params s16_sa    -- Scenario 16, parameter for Suspended Amount ("Bonrückstellung mit Gesamtwert Bonrückstellung > X")
			on s16_sa.COUNTRY_ORG_CD = eane.NEXT_COUNTRY_ORG_CD
			and s16_sa.PARAM_ID = 127
			-- if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join
			and s16_sa.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
	left join small_sales_receipt_lines ssrl
			on eane.NEXT_CASH_REGISTER_EVENT_SID = ssrl.RETAIL_EVENT_SID
WHERE 1=1
    -- we check if next event is valid (not suspended, cancelled receipts can be included as per old ZKP logic)
    and eane.NEXT_SUSPEND_FG = FALSE
	
	and eane.txn_gross_val >= s16_sa.PARAM_VAL_QTY
    
    -- and we check if this next event is a sale or a logoff event
    and (   
            -- "sign off" cash register event
            (eane.NEXT_EVENT_CATEGORY = 'TECH_EVENT'
				and eane.NEXT_EVENT_SUBCATEGORY = '410')
            -- "small sale" retail event
            or (eane.NEXT_EVENT_CATEGORY = 'RETAIL_EVENT'
				and eane.NEXT_EVENT_SUBCATEGORY = 'S'
				and ssrl.RETAIL_EVENT_SID IS NOT NULL
				and eane.NEXT_TXN_GROSS_VAL < s16_kb.PARAM_VAL_QTY)
        )
;
