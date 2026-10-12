CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_lead_elke_kpi_daily_lc_1 (client_id OPTIONS(description='ID of country_1'),
country_iso_code OPTIONS(description='Abbreviation of the country_1'), 
wh_id OPTIONS(description='the ID of warehouse'),
datum OPTIONS(description='calendar_1 date'), 
we_paletten OPTIONS(description='the amount of incoming pallets - sum of euro pallets + düsseldorf pallets/pallet factor'),
ausgelieferte_kolli OPTIONS(description='delivery cases'),
lagerumsatz_brutto OPTIONS(description='warehouse revenue gross value'), 
retourenwert_brutto OPTIONS(description='gross retour value'), 
lagerumsatz_netto OPTIONS(description='net value of warehouse revenue'),
retourenwert_netto OPTIONS(description='net retour value'), 
kommissionierte_kolli OPTIONS(description='picked cases'),
kommissionierzeit_sec OPTIONS(description='picking time in sec'), 
currency_iso_code OPTIONS(description='currency iso code')) 
AS WITH COUNTRY_WAREHOUSE_COMBINATION AS (SELECT client_id,
   country_iso_cd,
   wh_id
  FROM ldl_p_lew_mart_msi.v_org_wh_merge_1
  WHERE aspect_id = 1
   AND wh_id > 0), TIME_LIMITATION AS (SELECT cal_dt,
   busyear,
   cy_month,
   cy_week
  FROM ldl_p_lew_core_ac.v_cal_calendarday_1
  WHERE cal_dt >= DATE '2025-03-01'
   AND cy_day_seq <= 0), FACT_WE_PALETTEN AS (SELECT client_id,
   wh_id,
   dat_entry_rcv,
   CEIL(SUM(euro_pal) + SUM(dd_pal / 2)) AS we_paletten 
  FROM ldl_p_lew_mart_lead.v_egin_we_paletten_nach_anlieferbereich_1
  GROUP BY client_id,
   wh_id,
   dat_entry_rcv
  ORDER BY dat_entry_rcv NULLS LAST), FACT_AUSGELIEFERTE_KOLLI AS (SELECT client_id,
   wh_id,
   dat_formdate,
   TRUNC(SUM(IFNULL(qty_del_case, 0)) + SUM(IFNULL(qty_ord_case, 0)), 0) AS ausgelieferte_kolli
  FROM ldl_p_lew_mart_lead.t_agg_store_day_pick_deliv_1
  GROUP BY client_id,
   wh_id,
   dat_formdate
  ORDER BY dat_formdate NULLS LAST), BASE_LAGERUMSATZ_RETOURENWERT AS (SELECT AWH.client_id,
   WH.src_wh_id AS wh_id,
   AWH.dayend_dt AS dat_dayend,
    SUM(CASE
      WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
      THEN AWH.credit_val
      ELSE 0
      END) - SUM(CASE
      WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
      THEN AWH.debit_val
      ELSE 0
      END) AS lagerumsatz_brutto,
    ABS(CASE
      WHEN AWH.receipt_type_id = 131
      THEN SUM(CASE
         WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
         THEN AWH.credit_val
         ELSE 0
         END) - SUM(CASE
         WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
         THEN AWH.debit_val
         ELSE 0
         END)
      ELSE 0
      END) - CASE
     WHEN AWH.receipt_type_id = 141
     THEN SUM(CASE
        WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
        THEN AWH.credit_val
        ELSE 0
        END) - SUM(CASE
        WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
        THEN AWH.debit_val
        ELSE 0
        END)
     ELSE 0
     END AS retourenwert_brutto,
    SUM(CASE
      WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
      THEN AWH.credit_net_val
      ELSE 0
      END) - SUM(CASE
      WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
      THEN AWH.debit_net_val
      ELSE 0
      END) AS lagerumsatz_netto,
    ABS(CASE
      WHEN AWH.receipt_type_id = 131
      THEN SUM(CASE
         WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
         THEN AWH.credit_net_val
         ELSE 0
         END) - SUM(CASE
         WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
         THEN AWH.debit_net_val
         ELSE 0
         END)
      ELSE 0
      END) - CASE
     WHEN AWH.receipt_type_id = 141
     THEN SUM(CASE
        WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
        THEN AWH.credit_net_val
        ELSE 0
        END) - SUM(CASE
        WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
        THEN AWH.debit_net_val
        ELSE 0
        END)
     ELSE 0
     END AS retourenwert_netto,
   CUR.currency_iso_cd
  FROM ldl_p_lew_core_ac.v_account_warehouse_1 AS AWH
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON AWH.client_id = WH.client_id AND AWH.loc_sid_wh = WH.loc_sid_wh AND
     WH.dwh_actual_fg = 1
   INNER JOIN ldl_p_lew_mart_lead.v_ref_currency_1 AS CUR ON AWH.client_id = CUR.client_id AND CUR.local_currency_fg = 1
  GROUP BY AWH.client_id,
   wh_id,
   AWH.receipt_type_id,
   dat_dayend,
   CUR.currency_iso_cd), FACT_AGGREGATION_LAGERUMSATZ_RETOURENWERT AS (SELECT client_id,
   wh_id,
   dat_dayend,
   currency_iso_cd,
   TRUNC(CAST(SUM(lagerumsatz_brutto) AS BIGNUMERIC), 2) AS lagerumsatz_brutto,
   TRUNC(CAST(SUM(retourenwert_brutto) AS BIGNUMERIC), 2) AS retourenwert_brutto,
   TRUNC(CAST(SUM(lagerumsatz_netto) AS BIGNUMERIC), 2) AS lagerumsatz_netto,
   TRUNC(CAST(SUM(retourenwert_netto) AS BIGNUMERIC), 2) AS retourenwert_netto
  FROM BASE_LAGERUMSATZ_RETOURENWERT
  GROUP BY client_id,
   wh_id,
   dat_dayend,
   currency_iso_cd
  ORDER BY dat_dayend NULLS LAST), FACT_WAMAS_EWM_PICKED_CASE AS (SELECT client_id,
   wh_id,
   dat_calendar,
   SUM(picked_cases) AS kommissionierte_kolli,
   SUM(qty_sum_working_time_sec) AS kommissionierzeit_sec
  FROM ldl_p_lew_mart_lead_ac.v_agg_picking_performance_day_wamas_ewm_1
  GROUP BY client_id,
   wh_id,
   dat_calendar) (
 SELECT cwc.client_id,
   cwc.country_iso_cd AS country_iso_code,
   cwc.wh_id,
   tl.cal_dt AS datum,
   wp.we_paletten AS we_paletten,
   ak.ausgelieferte_kolli,
   lr.lagerumsatz_brutto,
   lr.retourenwert_brutto,
   lr.lagerumsatz_netto,
   lr.retourenwert_netto,
   wepc.kommissionierte_kolli,
   wepc.kommissionierzeit_sec,
   lr.currency_iso_cd AS currency_iso_code
  FROM COUNTRY_WAREHOUSE_COMBINATION AS cwc
   INNER JOIN TIME_LIMITATION AS tl ON TRUE
   LEFT JOIN FACT_WE_PALETTEN AS wp ON cwc.client_id = wp.client_id AND cwc.wh_id = wp.wh_id AND tl.cal_dt = wp.dat_entry_rcv
     
   LEFT JOIN FACT_AUSGELIEFERTE_KOLLI AS ak ON cwc.client_id = ak.client_id AND cwc.wh_id = ak.wh_id AND tl.cal_dt = ak
     .dat_formdate
   LEFT JOIN FACT_AGGREGATION_LAGERUMSATZ_RETOURENWERT AS lr ON cwc.client_id = lr.client_id AND cwc.wh_id = lr.wh_id
    AND tl.cal_dt = lr.dat_dayend
   LEFT JOIN FACT_WAMAS_EWM_PICKED_CASE AS wepc ON cwc.client_id = wepc.client_id AND cwc.wh_id = wepc.wh_id AND tl.cal_dt
      = wepc.dat_calendar
  ORDER BY 1 NULLS LAST,
   2 NULLS LAST,
   3 NULLS LAST,
   4 NULLS LAST);