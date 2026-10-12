CREATE OR REPLACE VIEW p_lew_mart_lead.v_elke_account_warehouse_1(
    CLIENT_ID COMMENT 'Identification of country_1',
	WH_ID COMMENT 'Identification of a warehouse',
	BUSYEAR COMMENT 'business year',
	CY_MONTH COMMENT 'calander month',
	CY_WEEK COMMENT 'calander week',
	DAT_DAYEND COMMENT 'Date where receipt was booked',
	CURRENCY_ISO_CD COMMENT 'currency used by the country_1',
	CURR_TOT_ID COMMENT 'Currency ID',
	LAGERUMSATZ_BRUTTO COMMENT 'Gutschrift minus Belastung',
	LAGERUMSATZ_BRUTTO_LJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the current year',
	LAGERUMSATZ_BRUTTO_VJ COMMENT 'warehouse revenue from previous year',
	LAGERUMSATZ_BRUTTO_VJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the previous year',
	RETOURENWERT_BRUTTO COMMENT 'The difference between Return and correction of return',
	RETOURENWERT_BRUTTO_LJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the current year',
	RETOURENWERT_BRUTTO_VJ COMMENT 'warehouse revenue from previous year',
	RETOURENWERT_BRUTTO_VJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the previous year',
	LAGERUMSATZ_NETTO_LJ COMMENT 'Gutschrift netto minus Belastung netto',
	LAGERUMSATZ_NETTO_LJ_AUFGELAUFEN COMMENT 'cumulative warehouse net revenue mapped to the current year',
	LAGERUMSATZ_NETTO_VJ COMMENT 'net warehouse revenue from previous year',
	LAGERUMSATZ_NETTO_VJ_AUFGELAUFEN COMMENT 'cumulative net warehouse revenue mapped to the previous year',
	RETOURENWERT_NETTO_LJ COMMENT 'the difference between return and correction of return in net value',
	RETOURENWERT_NETTO_LJ_AUFGELAUFEN COMMENT 'cumulative retour net value mapped to the current year',
	RETOURENWERT_NETTO_VJ COMMENT 'net retour value mapped to the previous year',
	RETOURENWERT_NETTO_VJ_AUFGELAUFEN COMMENT 'cumulative net retour value mapped to the previous year'
)
AS
WITH base_lagerumsatz_retourenwert AS (
SELECT 
     awh.client_id
    ,wh.src_wh_id AS wh_id
    ,awh.dayend_dt AS dat_dayend
    ,cur.currency_iso_cd
    ,CAST(CASE WHEN cur.currency_iso_cd = 'EUR' THEN 0
            WHEN cur.currency_iso_cd = 'GBP' THEN 40
            ELSE cur.client_id
             END AS SMALLINT) AS curr_tot_id
    ,SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.credit_val/cur.rate_currency_exchange ELSE 0 END) 
    - SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.debit_val/cur.rate_currency_exchange ELSE 0 END) AS lagerumsatz_brutto
    ,ABS((CASE WHEN awh.receipt_type_id = 131 
    	THEN lagerumsatz_brutto ELSE 0 END))
    	-(CASE WHEN awh.receipt_type_id = 141 
    	THEN lagerumsatz_brutto ELSE 0 END) AS retourenwert_brutto
    ,SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.credit_net_val/cur.rate_currency_exchange ELSE 0 END) 
    	- SUM(CASE WHEN awh.receipt_type_id IN (10,11,12,130,131,135,138,141,145,148,150,151,160,161) 
    	THEN awh.debit_net_val/cur.rate_currency_exchange ELSE 0 END) AS lagerumsatz_netto
    ,ABS((CASE WHEN awh.receipt_type_id = 131 
    	THEN lagerumsatz_netto ELSE 0 END))
    	-(CASE WHEN awh.receipt_type_id = 141 
    	THEN lagerumsatz_netto ELSE 0 END) AS retourenwert_netto
FROM p_lew_core_ac.v_account_warehouse_1 awh
INNER JOIN p_lew_bil_ac.v_warehouse_1 wh
ON awh.client_id = wh.client_id
AND awh.loc_sid_wh = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_wawi_ref_currency_act_1 cur
ON awh.client_id = cur.client_id
GROUP BY 
    awh.client_id
    ,wh.src_wh_id
    ,awh.receipt_type_id
    ,awh.dayend_dt
    ,cur.currency_iso_cd
    ,cur.client_id)
, fact_aggregation_mapping_lj AS (
    SELECT 
        b.client_id
        ,b.wh_id
        ,cal.busyear
        ,cal.cy_month
        ,cal.cy_week
        ,b.dat_dayend
        ,b.currency_iso_cd
        ,b.curr_tot_id
        ,SUM(b.lagerumsatz_brutto) AS lagerumsatz_brutto_lj
        ,SUM(lagerumsatz_brutto_lj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY b.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS lagerumsatz_brutto_lj_aufgelaufen
        ,SUM(b.retourenwert_brutto) AS retourenwert_brutto_lj
        ,SUM(retourenwert_brutto_lj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY b.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS retourenwert_brutto_lj_aufgelaufen
        ,SUM(b.lagerumsatz_netto) AS lagerumsatz_netto_lj
        ,SUM(lagerumsatz_netto_lj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY b.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS lagerumsatz_netto_lj_aufgelaufen
        ,SUM(b.retourenwert_netto) AS retourenwert_netto_lj
        ,SUM(retourenwert_netto_lj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY b.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS retourenwert_netto_lj_aufgelaufen
FROM base_lagerumsatz_retourenwert b
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
ON cal.cal_dt = b.dat_dayend
GROUP BY 
    b.client_id
    ,b.wh_id
    ,cal.busyear
    ,cal.cy_month
    ,cal.cy_week
    ,b.dat_dayend
    ,b.currency_iso_cd
    ,b.curr_tot_id)
,fact_aggregation_mapping_vj AS (
    SELECT 
        b.client_id
        ,b.wh_id
        ,cal.busyear
        ,cal.cy_month
        ,cal.cy_week
        ,cal.cal_dt AS dat_dayend
        ,b.currency_iso_cd
        ,b.curr_tot_id
        ,SUM(b.lagerumsatz_brutto) AS lagerumsatz_brutto_vj
        ,SUM(lagerumsatz_brutto_vj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY cal.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS lagerumsatz_brutto_vj_aufgelaufen
        ,SUM(b.retourenwert_brutto) AS retourenwert_brutto_vj
        ,SUM(retourenwert_brutto_vj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY cal.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS retourenwert_brutto_vj_aufgelaufen
        ,SUM(b.lagerumsatz_netto) AS lagerumsatz_netto_vj
        ,SUM(lagerumsatz_netto_vj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY cal.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS lagerumsatz_netto_vj_aufgelaufen
        ,SUM(b.retourenwert_netto) AS retourenwert_netto_vj
        ,SUM(retourenwert_netto_vj) OVER (PARTITION BY b.client_id, b.wh_id, cal.busyear, b.curr_tot_id ORDER BY cal.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS retourenwert_netto_vj_aufgelaufen
FROM base_lagerumsatz_retourenwert b
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
ON cal.cal_dt_prev_1y = b.dat_dayend
GROUP BY
    b.client_id
    ,b.wh_id
    ,cal.busyear
    ,cal.cy_month
    ,cal.cy_week
    ,cal.cal_dt
    ,b.currency_iso_cd
    ,b.curr_tot_id
)
SELECT 
    f.client_id
    ,f.wh_id
    ,f.busyear
    ,f.cy_month
    ,f.cy_week
    ,f.dat_dayend
    ,f.currency_iso_cd
    ,f.curr_tot_id
   ,f.lagerumsatz_brutto_lj AS lagerumsatz_brutto
   ,f.lagerumsatz_brutto_lj_aufgelaufen
   ,fp.lagerumsatz_brutto_vj
   ,fp.lagerumsatz_brutto_vj_aufgelaufen
   ,f.retourenwert_brutto_lj AS retourenwert_brutto
   ,f.retourenwert_brutto_lj_aufgelaufen
   ,fp.retourenwert_brutto_vj
   ,fp.retourenwert_brutto_vj_aufgelaufen
   ,f.lagerumsatz_netto_lj
   ,f.lagerumsatz_netto_lj_aufgelaufen
   ,fp.lagerumsatz_netto_vj
   ,fp.lagerumsatz_netto_vj_aufgelaufen
   ,f.retourenwert_netto_lj
   ,f.retourenwert_netto_lj_aufgelaufen
   ,fp.retourenwert_netto_vj
   ,fp.retourenwert_netto_vj_aufgelaufen
FROM fact_aggregation_mapping_lj f
FULL OUTER JOIN fact_aggregation_mapping_vj fp
ON f.client_id = fp.client_id
AND f.wh_id = fp.wh_id
AND f.currency_iso_cd = fp.currency_iso_cd
AND f.curr_tot_id = fp.curr_tot_id
AND f.dat_dayend = fp.dat_dayend
;