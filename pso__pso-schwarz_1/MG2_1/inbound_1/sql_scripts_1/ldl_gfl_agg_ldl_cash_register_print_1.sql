/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_receipt_print.sql
#----------------------------------------------------------------------------
# History:
# 1.0  12.09.2024  Piotr Kleysa    - ZKP - t_retail_receipt_print_1  - intial version
# 1.1  18.09.2024  Andrzej Wandtke - ZKP - set destination table to t_cash_register_print_1
# 1.2  22.10.2024  Andrzej Wandtke - ZKP - add delete part
# 1.3  27.11.2024  Andrzej Wandtke - ZKP - use table T_STORES_QUALIFIED_1, add price info, subtotals, technical events
# 1.4  29.11.2024  Andrzej Wandtke - ZKP - add condition ch.cashier_hash IS NOT NULL
# 1.5  05.12.2024  Mihail Ivanov   - ZKP - setting default value -1 to parent_line_seq, becasue it is not part of the PK
										 - Added code for Tax Lines (source core_rel.T_TAX_LINE_1)
										 - Added code to populate new column DISCOUNT_FG
										 - Added code to populate new column CASH_REGISTER_EVENT_SCENARIO_ID
										 - Replaced column DISPLAYED_PROD_VARIANT_NAME with PROD_NAME
# 1.6  29.01.2025  Andrzej Wandtke - ZKP - fixing duplicates issue: cte retail_events: only the original receipts from the last batch
# 1.7  13.02.2025  Kamil Roszczyk  - ZKP - added code for discount lines (source: core_rel.t_discount_line_1)
										 - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63807
# 1.8  25.02.2025  Kamil Roszczyk  - ZKP - fixed retail_event_line_seq value in tech events subquery (changed from cash_register_event_nr to 1)
										 - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/65149
										 
# 1.9  05.03.2025  Mihail Ivanov   - ZKP - bugfix: changed DELETE statement for print table.
											This way original purchases that were outside of the analysis period are also deleted
											if they are referenced by returns that are part of the analysis.
											
# 1.10  26.03.2025  Mihail Ivanov  - Changes: 
						- Using CASHIER_NR to determine receipts by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR
						
						Requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/67501
							- Added new columns with detail for Original Reciept (meaning the "purchase receipt" in case of "receipts for Returns")
							- column AUTH_BY_NR renamed to EVENT_AUTH_BY_NR. Added column LINE_AUTH_BY_NR - this way we can show approvers of headers and positions

# 1.11  02.04.2025  Mihail Ivanov  - Bugfix: 
						- Changed how original purchases are selected for the DELETE statement

# 1.12  28.04.2025  Kamil Roszczyk - bugfix:
						- renamed columns: txn_gross_val to tax_line_gross_val and txn_vat_val to tax_line_val
						- adjusted sourcing for both columns and set the values to null for the types of lines not being tax ones
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68764

# 1.13  30.04.2025  Kamil Roszczyk - change:
						- added product name load for price information event lines
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68624

							
# 1.14  12.05.2025  Mihail Ivanov - change:
						- added column FIRST_LINE_OF_EVENT_FG - applicable only for RetailEvents and only for ProductRetail Lines of such events. (hard-coded FALSE for other events/line types)
							TRUE only for the ProductRetail line of each event that has the lowest RETAIL_EVENT_LINE_SEQ
							requested here (point1): https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69364 

# 1.15  14.05.2025  Mihail Ivanov - change:
						- column FIRST_LINE_OF_EVENT_FG hard-coded to TRUE for "Price Info" and "Technical" events
						- replaced value NULL with t_price_information_event.PROD_PRICE in column "UNIT_PRICE" for lines of PriceInfo events
*/

!SET exit_on_error=True;

SET SV_MIN_DT = (SELECT MIN(bus_dt) FROM ETL.T_STORES_QUALIFIED_1);
SET SV_MAX_DT = (SELECT MAX(bus_dt) FROM ETL.T_STORES_QUALIFIED_1);
SET NB_DAYS_ORIG_RECEIPT = 360;

CREATE OR REPLACE TEMPORARY TABLE etl.tmp_relevant AS
with 
retail_events as
(
	-- All the receipts from the proofing scope: needed for Bonumfeld
	SELECT
		 re.retail_event_sid AS CASH_REGISTER_EVENT_SID
		,re.store_sid
		,re.cash_register_sid
		,re.cashier_hash
		,re.bus_dt
		,re.real_estate_sid
		,re.event_end_tmsp as event_tmsp
	FROM core_rel.t_retail_event_1 re_1
		INNER JOIN ETL.T_STORES_QUALIFIED_1 sq
			ON  re.store_sid = sq.store_sid
			AND re.bus_dt    = sq.bus_dt
	WHERE sq.IS_DIRECTLY_ORDERED = 1
	UNION
	-- Add original (purchase) receipts for the predefined period before the start date of proofing period
	-- No join to ETL.T_STORES_QUALIFIED_1 because original receipts can come from a store outside of proofing scope
	SELECT
		 o_re.retail_event_sid AS CASH_REGISTER_EVENT_SID
		,o_re.store_sid
		,o_re.cash_register_sid
		,o_re.cashier_hash
		,o_re.bus_dt
		,o_re.real_estate_sid
		,o_re.event_end_tmsp as event_tmsp
	FROM ETL.T_STORES_QUALIFIED_1 sq
		inner join core_rel.t_retail_event_1 q_re -- qualified retail events (returns - only they have original receipt)
			ON  q_re.store_sid = sq.store_sid
			AND q_re.bus_dt    = sq.bus_dt
			and q_re.RETAIL_EVENT_TYPE_CD = 'R'
			
		inner join CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP_1 er
			on er.CASH_REGISTER_EVENT_SID = q_re.retail_event_sid
			and CASH_REGISTER_EVENT_REL_TYPE_CD = 'ORIGINAL'
			
		inner join core_rel.T_RETAIL_EVENT_1 o_re -- original purchases
			on o_re.retail_event_sid = er.REL_CASH_REGISTER_EVENT_SID 
		
	-- will uncomment this only if performance requires it.
	--where re.bus_dt between dateadd(day, -1 * $NB_DAYS_ORIG_RECEIPT, $SV_MIN_DT) AND $SV_MAX_DT
)
,price_info_events as
(
	SELECT
		 pie.price_info_event_sid AS CASH_REGISTER_EVENT_SID
		,pie.store_sid
		,pie.cash_register_sid
		,pie.cashier_hash
		,pie.bus_dt
		,pie.real_estate_sid
		,pie.event_tmsp
	FROM core_rel.t_price_information_event_1 pie
		INNER JOIN ETL.T_STORES_QUALIFIED_1 sq
			ON  pie.store_sid = sq.store_sid
			AND pie.bus_dt    = sq.bus_dt
	WHERE sq.IS_DIRECTLY_ORDERED = 1
)
,tech_events as
(
	SELECT
		 tcre.tech_cash_register_event_sid AS CASH_REGISTER_EVENT_SID
		,tcre.store_sid
		,tcre.cash_register_sid
		,tcre.cashier_hash
		,tcre.bus_dt
		,tcre.real_estate_sid
		,tcre.event_tmsp
	FROM core_rel.t_technical_cash_register_event_1 tcre
		INNER JOIN ETL.T_STORES_QUALIFIED_1 sq
			ON  tcre.store_sid = sq.store_sid
			AND tcre.bus_dt    = sq.bus_dt
	WHERE sq.IS_DIRECTLY_ORDERED = 1
)
,all_events as
(
	SELECT 
		re.*
		,'RE_1' as EVENT_TYPE_CD
	FROM retail_events re_1
	
	UNION All
	
	SELECT 
		pie.*
		,'PIE' as EVENT_TYPE_CD
	FROM price_info_events pie
	
	UNION All
	
	SELECT 
		te.*
		,'TE' as EVENT_TYPE_CD
	FROM tech_events te
)
select 
	 ae.CASH_REGISTER_EVENT_SID
	,ae.STORE_SID
	,ae.CASH_REGISTER_SID
	,ae.CASHIER_HASH
	,ae.BUS_DT
	,ae.EVENT_TYPE_CD
	,ae.REAL_ESTATE_SID
	,ae.EVENT_TMSP
	,ce.CASHIER_NR
	,row_number() over (partition by ae.STORE_SID, ae.BUS_DT, ce.CASHIER_NR order by EVENT_TMSP asc) as row_nr
from all_events ae
	join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
		on ce.CASHIER_HASH = ae.CASHIER_HASH
;


DELETE FROM core_app_fraud_detection.t_cash_register_print_1
WHERE CASH_REGISTER_EVENT_SID IN (
		SELECT CASH_REGISTER_EVENT_SID
		FROM   etl.TMP_RELEVANT 
	)
;


INSERT INTO core_app_fraud_detection.t_cash_register_print_1 
(
	 cash_register_event_sid
	,cash_register_event_nr
	,cashier_nr
	,cash_register_event_line_seq
	,event_auth_by_nr
	,line_auth_by_nr
	,parent_line_seq
	,first_line_of_event_fg
	,cash_register_event_scenario_id
	,retail_event_line_scenario_id
	,event_start_tmsp
	,event_end_tmsp
	,event_line_start_tmsp
	,event_line_end_tmsp
	,bus_dt
	,store_sid
	,store_nr
	,country_org_cd
	,cash_register_nr
	,prod_retail_line_type_cd
	,prod_variant_sid
	,local_prod_nr
	,prod_variant_input_nr
	,prod_variant_input_nr_type_cd
	,prod_name
	,prod_entry_method_cd
	,price_entry_method_cd
	,paym_line_type_cd
	,paym_type_id
	,fraud_detection_relevant_fg
	,prod_return_reason_sid
	,return_txt
	,parent_retail_event_sid
	,unit_price
	,prod_variant_cnt
	,prod_variant_qty
	,base_gross_val
	,retail_line_gross_val
	,retail_line_vat_val
	,local_paym_val
	,tax_line_gross_val
	,tax_line_val
	,tax_pct 
	,cash_register_event_seq
	,discount_fg
	,orig_country_org_cd        
	,orig_store_nr              
	,orig_bus_dt                
	,orig_cash_register_nr      
	,orig_cash_register_event_nr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_load_id
	,dwh_node_cd 
)                        
WITH receipts AS 
(
	--pick up the regular lines ( t_product_retail_line_1)
    SELECT 
		fd.cash_register_event_sid
		,e.cash_register_event_nr
		,l.retail_event_line_seq
		,nvl(l.parent_line_seq, -1) as parent_line_seq
		,IFF(l.retail_event_line_seq = min(l.retail_event_line_seq) over (partition by fd.cash_register_event_sid), TRUE, FALSE) as first_line_of_event_fg
		,e.retail_event_scenario_id as cash_register_event_scenario_id
		,l.retail_event_line_scenario_id
		,e.event_start_tmsp
		,e.event_end_tmsp
		,l.event_start_tmsp AS event_line_start_tmsp
		,l.event_end_tmsp   AS event_line_end_tmsp
		,l.bus_dt
		,l.store_sid
		,NULL AS store_nr
		,l.country_org_cd
		,l.cash_register_sid
		,NULL AS cash_register_nr
		,e.cashier_hash
		,e.auth_by_hash		as event_auth_by_hash
		,l.auth_by_hash		as line_auth_by_hash
		,l.prod_retail_line_type_cd
		,l.prod_variant_sid
		,l.local_prod_nr
		,l.prod_variant_input_nr
		,l.prod_variant_input_nr_type_cd
		,pv.PROD_NAME
		,l.prod_entry_method_cd
		,l.price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,l.return_txt
		,l.unit_price
		,l.prod_return_reason_sid
		,l.prod_variant_cnt
		,l.prod_variant_qty
		,l.base_gross_val
		,l.retail_line_gross_val
		,l.retail_line_vat_val
		,NULL AS local_paym_val
		,l.tax_pct
		,NULL as tax_line_gross_val
		,NULL as tax_line_val
		,fd.row_nr
		,l.discount_fg
		,iff(len(l.orig_sales_event_sid) = 34, char(substr(l.orig_sales_event_sid,9,2))||char(substr(l.orig_sales_event_sid,11 ,2)), NULL) 	as orig_country_org_cd
		,iff(len(l.orig_sales_event_sid) = 34, to_number(substr(l.orig_sales_event_sid,13,8)), NULL)									as orig_store_nr
		,iff(len(l.orig_sales_event_sid) = 34, to_date(substr(l.orig_sales_event_sid, 1, 8), 'YYYYMMDD'), NULL)						as orig_bus_dt
		,iff(len(l.orig_sales_event_sid) = 34, to_number(substr(l.orig_sales_event_sid,21,4)), NULL)									as orig_cash_register_nr
		,iff(len(l.orig_sales_event_sid) = 34, to_number(substr(l.orig_sales_event_sid,25)), NULL)									as orig_cash_register_event_nr
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_retail_event_1 e 
				ON fd.cash_register_event_sid = e.retail_event_sid 
				AND fd.bus_dt = e.bus_dt 
				AND fd.store_sid = e.store_sid 
				AND fd.cashier_hash = e.cashier_hash
		INNER JOIN core_rel.t_product_retail_line_1 l 
				ON fd.cash_register_event_sid = l.retail_event_sid 
				AND fd.bus_dt = l.bus_dt 
				AND fd.store_sid = l.store_sid 
				AND fd.cashier_hash = l.cashier_hash
		left join core_dim.T_DIM_SALES_VARIANT_1 pv
				on pv.sales_variant_sid = l.prod_variant_sid
				and pv.dwh_valid_fg = TRUE
	WHERE fd.EVENT_TYPE_CD = 'RE_1'

	UNION ALL

	--pick up the voided(storno) lines ( t_cancellation_line_1)
	SELECT 
		fd.cash_register_event_sid
		,e.cash_register_event_nr
		,cl.retail_event_line_seq
		,l.retail_event_line_seq AS parent_line_seq
		,FALSE	AS first_line_of_event_fg
		,e.retail_event_scenario_id as cash_register_event_scenario_id
		,cl.retail_event_line_scenario_id
		,e.event_start_tmsp
		,e.event_end_tmsp
		,cl.EVENT_TMSP 		AS event_line_start_tmsp
		,cl.EVENT_TMSP   	AS event_line_end_tmsp
		,cl.bus_dt
		,cl.store_sid
		,NULL AS store_nr
		,cl.country_org_cd
		,l.cash_register_sid
		,NULL AS cash_register_nr
		,e.cashier_hash
		,e.auth_by_hash			as event_auth_by_hash
		,cl.auth_by_hash		as line_auth_by_hash
		,l.prod_retail_line_type_cd
		,l.prod_variant_sid
		,l.local_prod_nr
		,l.prod_variant_input_nr
		,l.prod_variant_input_nr_type_cd
		,pv.PROD_NAME
		,l.prod_entry_method_cd
		,l.price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,l.return_txt
		,l.unit_price
		,l.prod_return_reason_sid
		,l.prod_variant_cnt * -1 AS prod_variant_cnt
		,l.prod_variant_qty * -1 AS prod_variant_qty
		,l.base_gross_val * -1 AS base_gross_val
		,l.retail_line_gross_val * -1 AS retail_line_gross_val
		,l.retail_line_vat_val * -1 AS retail_line_vat_val
		,NULL AS local_paym_val
		,l.tax_pct
		,NULL AS tax_line_gross_val
		,NULL AS tax_line_val
		,fd.row_nr
		,l.discount_fg
		,iff(len(l.orig_sales_event_sid) = 34, char(substr(l.orig_sales_event_sid,9,2))||char(substr(l.orig_sales_event_sid,11 ,2)), NULL) 	as orig_country_org_cd
		,iff(len(l.orig_sales_event_sid) = 34, to_number(substr(l.orig_sales_event_sid,13,8)), NULL)									as orig_store_nr
		,iff(len(l.orig_sales_event_sid) = 34, to_date(substr(l.orig_sales_event_sid, 1, 8), 'YYYYMMDD'), NULL)						as orig_bus_dt
		,iff(len(l.orig_sales_event_sid) = 34, to_number(substr(l.orig_sales_event_sid,21,4)), NULL)									as orig_cash_register_nr
		,iff(len(l.orig_sales_event_sid) = 34, to_number(substr(l.orig_sales_event_sid,25)), NULL)									as orig_cash_register_event_nr
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_retail_event_1 e 
				ON fd.cash_register_event_sid = e.retail_event_sid 
				AND fd.bus_dt = e.bus_dt 
				AND fd.store_sid = e.store_sid 
		INNER JOIN core_rel.t_product_retail_line_1 l 
				ON fd.cash_register_event_sid = l.retail_event_sid 
				AND fd.bus_dt = l.bus_dt 
				AND fd.store_sid = l.store_sid 
		INNER JOIN core_rel.t_cancellation_line_1 cl 
				ON fd.bus_dt = cl.bus_dt 
				AND fd.cash_register_event_sid = cl.retail_event_sid 
				AND l.cancel_line_seq = cl.retail_event_line_seq
				AND fd.store_sid = l.store_sid
		left join core_dim.T_DIM_SALES_VARIANT_1 pv
				on pv.sales_variant_sid = l.prod_variant_sid
				and pv.dwh_valid_fg = TRUE
	WHERE fd.EVENT_TYPE_CD = 'RE_1'

	UNION ALL

	--pick up the payment lines (t_payment_line_1)
	SELECT 
		fd.cash_register_event_sid
		,e.cash_register_event_nr
		,pl.retail_event_line_seq
		,-1 AS parent_line_seq
		,FALSE	AS first_line_of_event_fg
		,e.retail_event_scenario_id as cash_register_event_scenario_id
		,pl.retail_event_line_scenario_id
		,e.event_start_tmsp AS event_start_tmsp
		,e.event_end_tmsp AS event_end_tmsp
		,pl.paym_start_tmsp AS event_line_start_tmsp
		,pl.paym_end_tmsp   AS event_line_end_tmsp
		,pl.bus_dt
		,pl.store_sid
		,NULL AS store_nr
		,pl.country_org_cd
		,pl.cash_register_sid
		,NULL AS cash_register_nr
		,e.cashier_hash
		,e.auth_by_hash			as event_auth_by_hash
		,NULL					as line_auth_by_hash
		,NULL AS prod_retail_line_type_cd
		,NULL AS prod_variant_sid
		,NULL AS local_prod_nr
		,NULL AS prod_variant_input_nr
		,NULL AS prod_variant_input_nr_type_cd
		,NULL AS prod_name
		,NULL AS prod_entry_method_cd
		,NULL AS price_entry_method_cd
		,pl.paym_line_type_cd
		,pl.paym_type_id
		,NULL AS return_txt
		,NULL AS unit_price
		,NULL AS prod_return_reason_sid
		,NULL AS prod_variant_cnt
		,NULL AS prod_variant_qty
		,NULL AS base_gross_val
		,NULL AS retail_line_gross_val
		,NULL AS retail_line_vat_val
		,pl.local_paym_val
		,NULL AS tax_pct
		,NULL AS tax_line_gross_val
		,NULL AS tax_line_val
		,fd.row_nr
		,NULL as DISCOUNT_FG
		,NULL as orig_country_org_cd
		,NULL as orig_store_nr
		,NULL as orig_bus_dt
		,NULL as orig_cash_register_nr
		,NULL as orig_cash_register_event_nr
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_retail_event_1 e 
				ON fd.cash_register_event_sid = e.retail_event_sid 
				AND fd.bus_dt = e.bus_dt 
				AND fd.store_sid = e.store_sid 
		INNER JOIN core_rel.t_payment_line_1 pl 
				ON fd.cash_register_event_sid = pl.retail_event_sid 
				AND fd.bus_dt = pl.bus_dt 
				AND fd.store_sid = pl.store_sid
	WHERE fd.EVENT_TYPE_CD = 'RE_1'

	UNION ALL

	--pick up the subtotals(t_subtotal_line_1)
	SELECT
		fd.cash_register_event_sid
		,e.cash_register_event_nr
		,st.retail_event_line_seq
		,-1 AS parent_line_seq
		,FALSE	AS first_line_of_event_fg
		,e.retail_event_scenario_id as cash_register_event_scenario_id
		,850 AS retail_event_line_scenario_id
		,e.event_start_tmsp AS event_start_tmsp
		,e.event_end_tmsp AS event_end_tmsp
		,st.event_tmsp AS event_line_start_tmsp
		,st.event_tmsp AS event_line_end_tmsp
		,st.bus_dt
		,st.store_sid
		,NULL AS store_nr
		,st.country_org_cd
		,st.cash_register_sid
		,NULL AS cash_register_nr
		,st.cashier_hash
		,e.auth_by_hash			as event_auth_by_hash
		,NULL					as line_auth_by_hash
		,NULL AS prod_retail_line_type_cd
		,NULL AS prod_variant_sid
		,NULL AS local_prod_nr
		,NULL AS prod_variant_input_nr
		,NULL AS prod_variant_input_nr_type_cd
		,NULL AS prod_name
		,NULL AS prod_entry_method_cd
		,NULL AS price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,NULL AS return_txt
		,NULL AS unit_price
		,NULL AS prod_return_reason_sid
		,NULL AS prod_variant_cnt
		,NULL AS prod_variant_qty
		,NULL AS base_gross_val
		,NULL AS retail_line_gross_val
		,NULL AS retail_line_vat_val
		,NULL AS local_paym_val
		,NULL AS tax_pct
		,NULL AS tax_line_gross_val
		,NULL AS tax_line_val
		,fd.row_nr
		,NULL as discount_fg
		,NULL as orig_country_org_cd
		,NULL as orig_store_nr
		,NULL as orig_bus_dt
		,NULL as orig_cash_register_nr
		,NULL as orig_cash_register_event_nr		
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_retail_event_1 e 
			ON fd.cash_register_event_sid = e.retail_event_sid 
			AND fd.bus_dt = e.bus_dt 
			AND fd.store_sid = e.store_sid 
		INNER JOIN core_rel.t_subtotal_line_1 st 
			ON fd.cash_register_event_sid = st.retail_event_sid 
			AND fd.bus_dt = st.bus_dt 
			AND fd.store_sid = st.store_sid
	WHERE fd.EVENT_TYPE_CD = 'RE_1'

	UNION ALL

	--pick up the tax lines (t_tax_line_1)
	SELECT
		fd.cash_register_event_sid
		,e.cash_register_event_nr
		,tl.retail_event_line_seq
		,-1 AS parent_line_seq
		,FALSE	AS first_line_of_event_fg
		,e.retail_event_scenario_id as cash_register_event_scenario_id
		,855 AS retail_event_line_scenario_id
		,e.event_start_tmsp AS event_start_tmsp
		,e.event_end_tmsp AS event_end_tmsp
		,tl.event_tmsp AS event_line_start_tmsp
		,tl.event_tmsp AS event_line_end_tmsp
		,tl.bus_dt
		,tl.store_sid
		,NULL AS store_nr
		,tl.country_org_cd
		,tl.cash_register_sid
		,NULL AS cash_register_nr
		,tl.cashier_hash
		,e.auth_by_hash			as event_auth_by_hash
		,NULL					as line_auth_by_hash
		,NULL AS prod_retail_line_type_cd
		,NULL AS prod_variant_sid
		,NULL AS local_prod_nr
		,NULL AS prod_variant_input_nr
		,NULL AS prod_variant_input_nr_type_cd
		,NULL AS prod_name
		,NULL AS prod_entry_method_cd
		,NULL AS price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,NULL AS return_txt
		,NULL AS unit_price
		,NULL AS prod_return_reason_sid
		,NULL AS prod_variant_cnt
		,NULL AS prod_variant_qty
		,NULL AS base_gross_val
		,NULL AS retail_line_gross_val
		,NULL AS retail_line_vat_val
		,NULL AS local_paym_val
		,tl.TAX_PCT AS tax_pct
		,tl.gross_val AS tax_line_gross_val
		,tl.tax_val AS tax_line_val
		,fd.row_nr 
		,NULL as discount_fg
		,NULL as orig_country_org_cd
		,NULL as orig_store_nr
		,NULL as orig_bus_dt
		,NULL as orig_cash_register_nr
		,NULL as orig_cash_register_event_nr
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_retail_event_1 e 
			ON fd.cash_register_event_sid = e.retail_event_sid 
			AND fd.bus_dt = e.bus_dt 
			AND fd.store_sid = e.store_sid 
		INNER JOIN core_rel.t_tax_line_1 tl 
			ON fd.cash_register_event_sid = tl.retail_event_sid 
			AND fd.bus_dt = tl.bus_dt 
			AND fd.store_sid = tl.store_sid
	WHERE fd.EVENT_TYPE_CD = 'RE_1'
	
	UNION ALL

	--pick up the discount lines (t_discount_line_1)
	SELECT
		fd.cash_register_event_sid
		,e.cash_register_event_nr
		,dl.retail_event_line_seq
		,dl.discounted_line_seq AS parent_line_seq
		,FALSE	AS first_line_of_event_fg
		,e.retail_event_scenario_id as cash_register_event_scenario_id
		,dl.retail_event_line_scenario_id
		,e.event_start_tmsp AS event_start_tmsp
		,e.event_end_tmsp AS event_end_tmsp
		,dl.event_tmsp AS event_line_start_tmsp
		,dl.event_tmsp AS event_line_end_tmsp
		,dl.bus_dt
		,dl.store_sid
		,NULL AS store_nr
		,dl.country_org_cd
		,dl.cash_register_sid
		,NULL AS cash_register_nr
		,dl.cashier_hash
		,e.auth_by_hash			as event_auth_by_hash
		,dl.auth_by_hash		as line_auth_by_hash
		,NULL AS prod_retail_line_type_cd
		,dl.prod_variant_sid
		,NULL AS local_prod_nr
		,NULL AS prod_variant_input_nr
		,NULL AS prod_variant_input_nr_type_cd
		,NULL AS prod_name
		,NULL AS prod_entry_method_cd
		,NULL AS price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,NULL AS return_txt
		,NULL AS unit_price
		,NULL AS prod_return_reason_sid
		,dl.discounted_cnt AS prod_variant_cnt
		,dl.discounted_qty AS prod_variant_qty
		,NULL AS base_gross_val
		,dl.discount_val AS retail_line_gross_val
		,NULL AS retail_line_vat_val
		,NULL AS local_paym_val
		,NULL AS tax_pct
		,NULL AS tax_line_gross_val
		,NULL AS tax_line_val
		,fd.row_nr 
		,NULL as discount_fg
		,NULL as orig_country_org_cd
		,NULL as orig_store_nr
		,NULL as orig_bus_dt
		,NULL as orig_cash_register_nr
		,NULL as orig_cash_register_event_nr
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_retail_event_1 e 
			ON fd.cash_register_event_sid = e.retail_event_sid 
			AND fd.bus_dt = e.bus_dt 
			AND fd.store_sid = e.store_sid 
		INNER JOIN core_rel.t_discount_line_1 dl 
			ON fd.cash_register_event_sid = dl.retail_event_sid 
			AND fd.bus_dt = dl.bus_dt 
			AND fd.store_sid = dl.store_sid
	WHERE fd.EVENT_TYPE_CD = 'RE_1'
	
	UNION ALL
	
	--pick up the technical events
	SELECT 
		fd.cash_register_event_sid
		,tc.cash_register_event_nr
		,1 AS retail_event_line_seq
		,-1 AS parent_line_seq
		,TRUE	AS first_line_of_event_fg
		,tech_cash_register_event_type_cd as cash_register_event_scenario_id
		,tech_cash_register_event_type_cd AS retail_event_line_scenario_id
		,tc.event_tmsp AS event_start_tmsp
		,tc.event_tmsp AS event_end_tmsp
		,tc.event_tmsp AS event_line_start_tmsp
		,tc.event_tmsp AS event_line_end_tmsp
		,tc.bus_dt
		,tc.store_sid
		,NULL AS store_nr
		,tc.country_org_cd
		,tc.cash_register_sid
		,NULL AS cash_register_nr
		,tc.cashier_hash
		,NULL AS event_auth_by_hash
		,NULL AS line_auth_by_hash
		,NULL AS prod_retail_line_type_cd
		,NULL AS prod_variant_sid
		,NULL AS local_prod_nr
		,NULL AS prod_variant_input_nr
		,NULL AS prod_variant_input_nr_type_cd
		,NULL AS prod_name
		,NULL AS prod_entry_method_cd
		,NULL AS price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,NULL AS return_txt
		,NULL AS unit_price
		,NULL AS prod_return_reason_sid
		,NULL AS prod_variant_cnt
		,NULL AS prod_variant_qty
		,NULL AS base_gross_val
		,NULL AS retail_line_gross_val
		,NULL AS retail_line_vat_val
		,NULL AS local_paym_val
		,NULL AS tax_pct
		,NULL AS tax_line_gross_val
		,NULL AS tax_line_val
		,fd.row_nr
		,NULL as discount_fg
		,NULL as orig_country_org_cd
		,NULL as orig_store_nr
		,NULL as orig_bus_dt
		,NULL as orig_cash_register_nr
		,NULL as orig_cash_register_event_nr
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_technical_cash_register_event_1 tc 
				ON fd.cash_register_event_sid = tc.tech_cash_register_event_sid 
				AND fd.bus_dt = tc.bus_dt 
				AND fd.store_sid = tc.store_sid 

	UNION ALL

	--pick up the price info lines
	SELECT
		fd.cash_register_event_sid
		,pr.cash_register_event_nr
		,1 AS retail_event_line_seq -- price info is an independent event
		,-1 AS parent_line_seq
		,TRUE	AS first_line_of_event_fg
		,480 as cash_register_event_scenario_id
		,480 AS retail_event_line_scenario_id
		,pr.event_tmsp AS event_start_tmsp
		,pr.event_tmsp AS event_end_tmsp
		,pr.event_tmsp AS event_line_start_tmsp
		,pr.event_tmsp AS event_line_end_tmsp
		,pr.bus_dt
		,pr.store_sid
		,NULL AS store_nr
		,pr.country_org_cd
		,pr.cash_register_sid
		,NULL AS cash_register_nr
		,pr.cashier_hash
		,NULL AS event_auth_by_hash
		,NULL AS line_auth_by_hash
		,NULL AS prod_retail_line_type_cd
		,pr.prod_variant_sid AS prod_variant_sid
		,NULL AS local_prod_nr
		,NULL AS prod_variant_input_nr
		,NULL AS prod_variant_input_nr_type_cd
		,pv.PROD_NAME
		,NULL AS prod_entry_method_cd
		,NULL AS price_entry_method_cd
		,NULL AS paym_line_type_cd
		,NULL AS paym_type_id
		,NULL AS return_txt
		,pr.PROD_PRICE AS unit_price
		,NULL AS prod_return_reason_sid
		,NULL AS prod_variant_cnt
		,NULL AS prod_variant_qty
		,NULL AS base_gross_val
		,NULL AS retail_line_gross_val
		,NULL AS retail_line_vat_val
		,NULL AS local_paym_val
		,NULL AS tax_pct
		,NULL AS tax_line_gross_val
		,NULL AS tax_line_val
		,fd.row_nr
		,NULL as discount_fg
		,NULL as orig_country_org_cd
		,NULL as orig_store_nr
		,NULL as orig_bus_dt
		,NULL as orig_cash_register_nr
		,NULL as orig_cash_register_event_nr		
	FROM etl.tmp_relevant fd
		INNER JOIN core_rel.t_price_information_event_1 pr 
				ON fd.cash_register_event_sid = pr.price_info_event_sid 
				AND fd.bus_dt = pr.bus_dt 
				AND fd.store_sid = pr.store_sid
		left join core_dim.T_DIM_SALES_VARIANT_1 pv
				on pv.sales_variant_sid = pr.prod_variant_sid
				and pv.dwh_valid_fg = TRUE
	WHERE fd.EVENT_TYPE_CD = 'PIE'
)
SELECT
	 fd.cash_register_event_sid
	,fd.cash_register_event_nr
	,ch.cashier_nr
	,fd.retail_event_line_seq
	,e_ah.cashier_nr AS event_auth_by_nr
	,l_ah.cashier_nr AS line_auth_by_nr
	,fd.parent_line_seq
	,fd.first_line_of_event_fg
	,fd.cash_register_event_scenario_id
	,fd.retail_event_line_scenario_id
	,fd.event_start_tmsp
	,fd.event_end_tmsp
	,fd.event_line_start_tmsp
	,fd.event_line_end_tmsp
	,fd.bus_dt
	,fd.store_sid
	,o.curr_int_org_nr AS store_nr
	,fd.country_org_cd
	,rik.resource_item_nat_key_nr AS cash_register_nr
	,fd.prod_retail_line_type_cd
	,fd.prod_variant_sid
	,fd.local_prod_nr
	,fd.prod_variant_input_nr
	,fd.prod_variant_input_nr_type_cd
	,fd.prod_name
	,fd.prod_entry_method_cd
	,fd.price_entry_method_cd
	,fd.paym_line_type_cd
	,fd.paym_type_id
	,CASE WHEN s.cash_register_event_sid IS NOT NULL THEN 1 ELSE 0 end AS fraud_detection_relevant_fg
	,fd.prod_return_reason_sid
	,fd.return_txt
	,NULL AS parent_retail_event_sid
	,fd.unit_price
	,fd.prod_variant_cnt
	,fd.prod_variant_qty
	,fd.base_gross_val
	,fd.retail_line_gross_val
	,fd.retail_line_vat_val
	,fd.local_paym_val
	,fd.tax_line_gross_val
	,fd.tax_line_val
	,fd.tax_pct
	,fd.row_nr
	,fd.discount_fg
	,fd.orig_country_org_cd        
	,fd.orig_store_nr              
	,fd.orig_bus_dt                
	,fd.orig_cash_register_nr      
	,fd.orig_cash_register_event_nr
	,CURRENT_TIMESTAMP AS dwh_created_tmsp
	,CURRENT_TIMESTAMP AS dwh_updated_tmsp
	,${LOAD_ID} AS dwh_load_id
	,'MANUAL' AS dwh_node_cd
FROM receipts fd
	-- we want only rows with existing ch.cashier_hash, -- needed to handle data quality problems
	JOIN core_app_fraud_detection.t_cashier_encryption_1 ch 
			ON fd.cashier_hash = ch.cashier_hash
	LEFT JOIN core_app_fraud_detection.t_cashier_encryption_1 e_ah 
			ON fd.event_auth_by_hash = e_ah.cashier_hash
	LEFT JOIN core_app_fraud_detection.t_cashier_encryption_1 l_ah 
			ON fd.line_auth_by_hash = l_ah.cashier_hash
			
	LEFT JOIN core_dim.t_dim_internal_organization_1 o 
			ON fd.store_sid = o.int_org_sid 
			AND o.dwh_valid_fg = 1 
			AND o.int_org_type_cd = 'STORE'  
	LEFT JOIN meta.T_RESOURCE_ITEM_KEY_1 rik 
			ON fd.cash_register_sid = rik.resource_item_sid 
			AND rik.dwh_valid_fg = 1 
			AND rik.resource_item_key_type_cd = 'REG'
	LEFT JOIN core_dim.t_fact_fraud_detection_by_cash_register_event_1 s 
			ON fd.cash_register_event_sid = s.cash_register_event_sid
;
