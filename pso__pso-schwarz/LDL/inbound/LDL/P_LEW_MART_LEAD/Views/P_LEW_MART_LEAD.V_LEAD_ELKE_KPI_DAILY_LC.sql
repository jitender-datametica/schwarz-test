create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_LEAD_ELKE_KPI_DAILY_LC(
	""CLIENT ID"" COMMENT 'ID of country',
	""COUNTRY ISO CODE"" COMMENT 'Abbreviation of the country',
	""WH ID"" COMMENT 'the ID of warehouse',
	DATUM COMMENT 'calendar date',
	""WE PALETTEN"" COMMENT 'the amount of incoming pallets - sum of euro pallets + düsseldorf pallets/pallet factor',
	""AUSGELIEFERTE KOLLI"" COMMENT 'delivery cases',
	""LAGERUMSATZ BRUTTO"" COMMENT 'warehouse revenue gross value',
	""RETOURENWERT BRUTTO"" COMMENT 'gross retour value',
	""LAGERUMSATZ NETTO"" COMMENT 'net value of warehouse revenue',
	""RETOURENWERT NETTO"" COMMENT 'net retour value',
	""KOMMISSIONIERTE KOLLI"" COMMENT 'picked cases',
	""KOMMISSIONIERZEIT SEC"" COMMENT 'picking time in sec',
	""CURRENCY ISO CODE"" COMMENT 'currency iso code'
) as
WITH time_limitation AS (
    SELECT
    cal_dt
    ,busyear
    ,cy_month
    ,cy_week
FROM p_lew_core_ac.v_cal_calendarday
WHERE 
	  cal_dt >= '2025-03-01'
AND cy_day_seq <= 0
)
,country_warehouse_combination AS (
    SELECT 
    client_id 
    ,country_iso_cd
    ,wh_id
FROM p_lew_mart_msi.v_org_wh_merge
WHERE aspect_id =1
AND wh_id >0
)
,fact_we_paletten AS (
    SELECT 
        client_id
        ,wh_id
        ,dat_entry_rcv
        ,CEIL(SUM(euro_pal) + SUM(dd_pal/2),0) AS we_paletten
    FROM p_lew_mart_lead.v_egin_we_paletten_nach_anlieferbereich
    GROUP BY 
        client_id
        ,wh_id
        ,dat_entry_rcv
    ORDER BY dat_entry_rcv    
)
, fact_ausgelieferte_kolli AS (
    SELECT
    client_id
    ,wh_id
    ,dat_formdate
    ,TRUNCATE(SUM(IFNULL(qty_del_case,0)) + SUM(IFNULL(qty_ord_case,0)),0) AS ausgelieferte_kolli
    FROM p_lew_mart_lead.t_agg_store_day_pick_deliv
    GROUP BY
        client_id
        ,wh_id
        ,dat_formdate
    ORDER BY dat_formdate
)
,base_lagerumsatz_retourenwert AS (
     SELECT 
     awh.client_id
    ,wh.src_wh_id AS wh_id
    ,awh.dayend_dt AS dat_dayend
    ,SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.credit_val ELSE 0 END) 
    - SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.debit_val ELSE 0 END) AS lagerumsatz_brutto
    ,ABS((CASE WHEN awh.receipt_type_id = 131 
    	THEN lagerumsatz_brutto ELSE 0 END))
    	-(CASE WHEN awh.receipt_type_id = 141 
    	THEN lagerumsatz_brutto ELSE 0 END) AS retourenwert_brutto
    ,SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.credit_net_val ELSE 0 END) 
    	- SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.debit_net_val ELSE 0 END) AS lagerumsatz_netto
    ,ABS((CASE WHEN awh.receipt_type_id = 131 
    	THEN lagerumsatz_netto ELSE 0 END))
    	-(CASE WHEN awh.receipt_type_id = 141 
    	THEN lagerumsatz_netto ELSE 0 END) AS retourenwert_netto
    ,cur.currency_iso_cd
FROM p_lew_core_ac.v_account_warehouse awh
INNER JOIN p_lew_bil_ac.v_warehouse wh
ON awh.client_id = wh.client_id
AND awh.loc_sid_wh = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_mart_lead.v_ref_currency cur
ON awh.client_id = cur.client_id
AND cur.local_currency_fg = 1
GROUP BY 
    awh.client_id
    ,wh.src_wh_id
    ,awh.receipt_type_id
    ,awh.dayend_dt
    ,cur.currency_iso_cd
)
, fact_aggregation_lagerumsatz_retourenwert AS (
    SELECT 
    client_id
    ,wh_id
    ,dat_dayend
    ,currency_iso_cd
    ,TRUNC(SUM(lagerumsatz_brutto),2) AS lagerumsatz_brutto
    ,TRUNC(SUM(retourenwert_brutto),2) AS retourenwert_brutto
    ,TRUNC(SUM(lagerumsatz_netto),2) AS lagerumsatz_netto
    ,TRUNC(SUM(retourenwert_netto),2) AS retourenwert_netto
FROM base_lagerumsatz_retourenwert
GROUP BY 
    client_id
    ,wh_id
    ,dat_dayend
    ,currency_iso_cd
ORDER BY dat_dayend
)
, fact_wamas_ewm_picked_case AS (
    SELECT 
        client_id
        ,wh_id
        ,dat_calendar
        ,SUM(picked_cases) AS kommissionierte_kolli
        ,SUM(qty_sum_working_time_sec) AS kommissionierzeit_sec
    FROM p_lew_mart_lead_ac.v_agg_picking_performance_day_wamas_ewm
    GROUP BY 
        client_id
        ,wh_id
        ,dat_calendar
)
SELECT 
    cwc.client_id AS ""CLIENT ID""
   ,cwc.country_iso_cd AS ""COUNTRY ISO CODE""
   ,cwc.wh_id AS ""WH ID""
   ,tl.cal_dt AS ""DATUM""
   ,wp.we_paletten AS ""WE PALETTEN""
   ,ak.ausgelieferte_kolli AS ""AUSGELIEFERTE KOLLI""
   ,lr.lagerumsatz_brutto AS ""LAGERUMSATZ BRUTTO""
   ,lr.retourenwert_brutto AS ""RETOURENWERT BRUTTO""
   ,lr.lagerumsatz_netto AS ""LAGERUMSATZ NETTO""
   ,lr.retourenwert_netto AS ""RETOURENWERT NETTO""
   ,wepc.kommissionierte_kolli AS ""KOMMISSIONIERTE KOLLI""
   ,wepc.kommissionierzeit_sec AS ""Kommissionierzeit Sec""
   ,lr.currency_iso_cd AS ""CURRENCY ISO CODE""
FROM country_warehouse_combination cwc
CROSS JOIN time_limitation tl
LEFT JOIN fact_we_paletten wp
ON cwc.client_id = wp.client_id
AND cwc.wh_id = wp.wh_id
AND tl.cal_dt = wp.dat_entry_rcv
LEFT JOIN fact_ausgelieferte_kolli ak
ON cwc.client_id = ak.client_id
AND cwc.wh_id = ak.wh_id
AND tl.cal_dt = ak.dat_formdate
LEFT JOIN fact_aggregation_lagerumsatz_retourenwert lr
ON cwc.client_id = lr.client_id
AND cwc.wh_id = lr.wh_id
AND tl.cal_dt = lr.dat_dayend
LEFT JOIN fact_wamas_ewm_picked_case wepc
ON cwc.client_id = wepc.client_id
AND cwc.wh_id = wepc.wh_id
AND tl.cal_dt = wepc.dat_calendar
ORDER BY 1,2,3,4
;
