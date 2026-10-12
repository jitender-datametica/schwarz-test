CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_elke_account_warehouse_1 (client_id
OPTIONS(description='Identification of country_1'), wh_id OPTIONS(description='Identification of a warehouse'), busyear
OPTIONS(description='business year'), cy_month OPTIONS(description='calander month'), cy_week
OPTIONS(description='calander week'), dat_dayend OPTIONS(description='Date where receipt was booked'), currency_iso_cd
OPTIONS(description='currency used by the country_1'), curr_tot_id OPTIONS(description='Currency ID'), lagerumsatz_brutto
OPTIONS(description='Gutschrift minus Belastung'), lagerumsatz_brutto_lj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the current year'), lagerumsatz_brutto_vj
OPTIONS(description='warehouse revenue from previous year'), lagerumsatz_brutto_vj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the previous year'), retourenwert_brutto
OPTIONS(description='The difference between Return and correction of return'), retourenwert_brutto_lj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the current year'), retourenwert_brutto_vj
OPTIONS(description='warehouse revenue from previous year'), retourenwert_brutto_vj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the previous year'), lagerumsatz_netto_lj
OPTIONS(description='Gutschrift netto minus Belastung netto'), lagerumsatz_netto_lj_aufgelaufen
OPTIONS(description='cumulative warehouse net revenue mapped to the current year'), lagerumsatz_netto_vj
OPTIONS(description='net warehouse revenue from previous year'), lagerumsatz_netto_vj_aufgelaufen
OPTIONS(description='cumulative net warehouse revenue mapped to the previous year'), retourenwert_netto_lj
OPTIONS(description='the difference between return and correction of return in net value'),
retourenwert_netto_lj_aufgelaufen OPTIONS(description='cumulative retour net value mapped to the current year'),
retourenwert_netto_vj OPTIONS(description='net retour value mapped to the previous year'),
retourenwert_netto_vj_aufgelaufen OPTIONS(description='cumulative net retour value mapped to the previous year')) AS
WITH BASE_LAGERUMSATZ_RETOURENWERT AS (SELECT t0.client_id,
   t0.wh_id,
   t0.dat_dayend,
   t0.currency_iso_cd,
   CAST(CASE
     WHEN t0.currency_iso_cd = 'EUR'
     THEN 0
     WHEN t0.currency_iso_cd = 'GBP'
     THEN 40
     ELSE t0.client_id1
     END AS BIGNUMERIC) AS curr_tot_id,
    t0.a0 - t0.a0_0 AS lagerumsatz_brutto,
    ABS(CASE
      WHEN t0.receipt_type_id = 131
      THEN t0.a0 - t0.a0_0
      ELSE 0
      END) - CASE
     WHEN t0.receipt_type_id = 141
     THEN t0.a0 - t0.a0_0
     ELSE 0
     END AS retourenwert_brutto,
    t0.a0_1 - t0.a0_2 AS lagerumsatz_netto,
    ABS(CASE
      WHEN t0.receipt_type_id = 131
      THEN t0.a0_1 - t0.a0_2
      ELSE 0
      END) - CASE
     WHEN t0.receipt_type_id = 141
     THEN t0.a0_1 - t0.a0_2
     ELSE 0
     END AS retourenwert_netto
  FROM (SELECT AWH.client_id,
     WH.src_wh_id AS wh_id,
     AWH.receipt_type_id,
     AWH.dayend_dt AS dat_dayend,
     CUR.currency_iso_cd,
     CUR.client_id AS client_id1,
     SUM(CASE
       WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
       THEN AWH.credit_val / CUR.rate_currency_exchange
       ELSE 0
       END) AS a0,
     SUM(CASE
       WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
       THEN AWH.debit_val / CUR.rate_currency_exchange
       ELSE 0
       END) AS a0_0,
     SUM(CASE
       WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
       THEN AWH.credit_net_val / CUR.rate_currency_exchange
       ELSE 0
       END) AS a0_1,
     SUM(CASE
       WHEN AWH.receipt_type_id IN (10, 11, 12, 130, 131, 135, 138, 141, 145, 148, 150, 151, 160, 161)
       THEN AWH.debit_net_val / CUR.rate_currency_exchange
       ELSE 0
       END) AS a0_2
    FROM ldl_p_lew_core_ac.v_account_warehouse_1 AS AWH
     INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON AWH.client_id = WH.client_id AND AWH.loc_sid_wh = WH.loc_sid_wh
      AND WH.dwh_actual_fg = 1
     INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_currency_act_1 AS CUR ON AWH.client_id = CUR.client_id
    GROUP BY AWH.client_id,
     wh_id,
     AWH.receipt_type_id,
     dat_dayend,
     CUR.currency_iso_cd,
     client_id1) AS t0), FACT_AGGREGATION_MAPPING_LJ AS (SELECT t3.client_id,
   t3.wh_id,
   t3.busyear,
   t3.cy_month,
   t3.cy_week,
   t3.dat_dayend,
   t3.currency_iso_cd,
   t3.curr_tot_id,
   t3.lagerumsatz_brutto_lj,
   SUM(t3.lagerumsatz_brutto_lj) OVER (PARTITION BY CAST(t3.client_id AS STRING), t3.wh_id, CAST(t3.busyear AS STRING), CAST(t3.curr_tot_id AS STRING)
      ORDER BY t3.dat_dayend IS NULL, t3.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   lagerumsatz_brutto_lj_aufgelaufen,
   t3.retourenwert_brutto_lj,
   SUM(t3.retourenwert_brutto_lj) OVER (PARTITION BY CAST(t3.client_id AS STRING), t3.wh_id, CAST(t3.busyear AS STRING)
      , CAST(t3.curr_tot_id AS STRING) ORDER BY t3.dat_dayend IS NULL, t3.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS retourenwert_brutto_lj_aufgelaufen,
   t3.lagerumsatz_netto_lj,
   SUM(t3.lagerumsatz_netto_lj) OVER (PARTITION BY CAST(t3.client_id AS STRING), t3.wh_id, CAST(t3.busyear AS STRING), CAST(t3.curr_tot_id AS STRING)
      ORDER BY t3.dat_dayend IS NULL, t3.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   lagerumsatz_netto_lj_aufgelaufen,
   t3.retourenwert_netto_lj,
   SUM(t3.retourenwert_netto_lj) OVER (PARTITION BY CAST(t3.client_id AS STRING), t3.wh_id, CAST(t3.busyear AS STRING), CAST(t3.curr_tot_id AS STRING)
      ORDER BY t3.dat_dayend IS NULL, t3.dat_dayend ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   retourenwert_netto_lj_aufgelaufen
  FROM (SELECT b.client_id,
     b.wh_id,
     CAL.busyear,
     CAL.cy_month,
     CAL.cy_week,
     b.dat_dayend,
     b.currency_iso_cd,
     b.curr_tot_id,
     SUM(b.lagerumsatz_brutto) AS lagerumsatz_brutto_lj,
     SUM(b.retourenwert_brutto) AS retourenwert_brutto_lj,
     SUM(b.lagerumsatz_netto) AS lagerumsatz_netto_lj,
     SUM(b.retourenwert_netto) AS retourenwert_netto_lj
    FROM BASE_LAGERUMSATZ_RETOURENWERT AS b
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON b.dat_dayend = CAL.cal_dt
    GROUP BY b.client_id,
     b.wh_id,
     b.dat_dayend,
     b.currency_iso_cd,
     b.curr_tot_id,
     CAL.cy_week,
     CAL.cy_month,
     CAL.busyear) AS t3), FACT_AGGREGATION_MAPPING_VJ AS (SELECT b.client_id,
   b.wh_id,
   CAL0.busyear,
   CAL0.cy_month,
   CAL0.cy_week,
   CAL0.cal_dt AS dat_dayend,
   b.currency_iso_cd,
   b.curr_tot_id,
   SUM(b.lagerumsatz_brutto) AS lagerumsatz_brutto_vj,
   SUM(SUM(b.lagerumsatz_brutto)) OVER (PARTITION BY CAST(b.client_id AS STRING), b.wh_id, CAST(CAL0.busyear AS STRING)
      , CAST(b.curr_tot_id AS STRING) ORDER BY CAL0.cal_dt IS NULL, CAL0.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS lagerumsatz_brutto_vj_aufgelaufen,
   SUM(b.retourenwert_brutto) AS retourenwert_brutto_vj,
   SUM(SUM(b.retourenwert_brutto)) OVER (PARTITION BY CAST(b.client_id AS STRING), b.wh_id, CAST(CAL0.busyear AS STRING)
      , CAST(b.curr_tot_id AS STRING) ORDER BY CAL0.cal_dt IS NULL, CAL0.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS retourenwert_brutto_vj_aufgelaufen,
   SUM(b.lagerumsatz_netto) AS lagerumsatz_netto_vj,
   SUM(SUM(b.lagerumsatz_netto)) OVER (PARTITION BY CAST(b.client_id AS STRING), b.wh_id, CAST(CAL0.busyear AS STRING), CAST(b.curr_tot_id AS STRING)
      ORDER BY CAL0.cal_dt IS NULL, CAL0.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   lagerumsatz_netto_vj_aufgelaufen,
   SUM(b.retourenwert_netto) AS retourenwert_netto_vj,
   SUM(SUM(b.retourenwert_netto)) OVER (PARTITION BY CAST(b.client_id AS STRING), b.wh_id, CAST(CAL0.busyear AS STRING)
      , CAST(b.curr_tot_id AS STRING) ORDER BY CAL0.cal_dt IS NULL, CAL0.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS retourenwert_netto_vj_aufgelaufen
  FROM BASE_LAGERUMSATZ_RETOURENWERT AS b
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL0 ON b.dat_dayend = CAL0.cal_dt_prev_1y
  GROUP BY b.client_id,
   b.wh_id,
   CAL0.busyear,
   CAL0.cy_month,
   CAL0.cy_week,
   dat_dayend,
   b.currency_iso_cd,
   b.curr_tot_id) (SELECT f.client_id,
   f.wh_id,
   f.busyear,
   f.cy_month,
   f.cy_week,
   f.dat_dayend,
   f.currency_iso_cd,
   f.curr_tot_id,
   f.lagerumsatz_brutto_lj AS lagerumsatz_brutto,
   f.lagerumsatz_brutto_lj_aufgelaufen,
   fp.lagerumsatz_brutto_vj,
   fp.lagerumsatz_brutto_vj_aufgelaufen,
   f.retourenwert_brutto_lj AS retourenwert_brutto,
   f.retourenwert_brutto_lj_aufgelaufen,
   fp.retourenwert_brutto_vj,
   fp.retourenwert_brutto_vj_aufgelaufen,
   f.lagerumsatz_netto_lj,
   f.lagerumsatz_netto_lj_aufgelaufen,
   fp.lagerumsatz_netto_vj,
   fp.lagerumsatz_netto_vj_aufgelaufen,
   f.retourenwert_netto_lj,
   f.retourenwert_netto_lj_aufgelaufen,
   fp.retourenwert_netto_vj,
   fp.retourenwert_netto_vj_aufgelaufen
  FROM FACT_AGGREGATION_MAPPING_LJ AS f
   FULL JOIN FACT_AGGREGATION_MAPPING_VJ AS fp ON f.client_id = fp.client_id AND f.wh_id = fp.wh_id AND f.currency_iso_cd
        = fp.currency_iso_cd AND f.curr_tot_id = fp.curr_tot_id AND f.dat_dayend = fp.dat_dayend);