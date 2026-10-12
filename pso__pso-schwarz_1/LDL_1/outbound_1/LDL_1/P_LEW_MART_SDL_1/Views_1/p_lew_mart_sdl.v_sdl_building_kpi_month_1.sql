CREATE OR REPLACE VIEW ldl_p_lew_mart_sdl.v_sdl_building_kpi_month_1 AS WITH PMD AS (SELECT cy,
   cal_dt,
   cy_month,
   cal_dt_prev_yd,
   DENSE_RANK() OVER (ORDER BY cy_month IS NULL DESC, cy_month DESC) AS rnk
  FROM ldl_p_lew_core_ac.v_cal_calendarday_1
  WHERE cal_dt <= CURRENT_DATE
  QUALIFY (DENSE_RANK() OVER (ORDER BY cy_month IS NULL DESC, cy_month DESC)) = 2), PYPMD AS (SELECT cy,
   cal_dt,
   cy_month,
   DENSE_RANK() OVER (ORDER BY cy_month IS NULL DESC, cy_month DESC) AS rnk
  FROM ldl_p_lew_core_ac.v_cal_calendarday_1
  WHERE cal_dt <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 12 MONTH)),
     DATE_ADD(CURRENT_DATE, INTERVAL - 12 MONTH))
  QUALIFY (DENSE_RANK() OVER (ORDER BY cy_month IS NULL DESC, cy_month DESC)) = 2), PD_1 AS (SELECT COALESCE(t2.cy, t6.cy
     + 1) AS cy,
   COALESCE(t2.cy_month, t6.cy_month) AS period0,
   TRIM(SUBSTR(CAST(COALESCE(t2.cy_month, t6.cy_month) - TRUNC(COALESCE(t2.cy_month, t6.cy_month) / 100, 0) * 100 AS STRING)
     , 1, 39)) AS period,
   MIN(t2.cal_dt) OVER (PARTITION BY CAST(t2.cy_month AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS period_start_dt,
   MAX(t2.cal_dt) OVER (PARTITION BY CAST(t2.cy_month AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS period_end_dt,
   t2.cal_dt,
   t6.cal_dt AS cal_dt_py
  FROM PMD AS t2
   FULL JOIN PYPMD AS t6 ON t2.cal_dt_prev_yd = t6.cal_dt) (/* Last Month Days */
  /* Previous Year Previous Month Days: All days of the last month in the previous year */
  /* Periods Days: All days of the last month, accompagned by the corersponding day of the last year */
  /* Extract only the month number from cy_month and trim leading zeros */
  /* Leave sales_1 area set only on the first store record, so that the SUM() in the parent select doesn't sum the store-area multiple times */
  /* Stores being opened before or within and closed within or after the reporting period */
  /* Stores that are open during the entire reporting period, or being replaced by or replacing another store within the reporting period */
  /* Stores that opened within reporting period (Neueröffnungen), but not replacing another store */
  /* Stores that replace other stores in reporting period (Ersatz) */
  /* Stores that were rebuilt in reporting period (Abriss/Neubau) */
  /* Stores that closed within reporting period (Schließungen) */
  /* Stores having the "basis" characteristic, as reversed engineered from MSI LEAD Reports */ /* Periods Days */
  /* Extract the relevant SDL Buildings with their effective values for reporting. Translate specific values to NULL, as maintained in Exception List XLS */
  SELECT t11.version,
   t11.kalenderjahr,
   t11.kalendermonat,
   t11.land_1,
   t11.landeswaehrung,
   SUM(t11.val_rtl_net) AS umsatz_netto,
   SUM(CASE
     WHEN t11.basis_fg = 1
     THEN t11.val_rtl_net
     ELSE 0
     END) AS basisumsatz_lj,
   SUM(CASE
     WHEN t11.basis_fg = 1
     THEN t11.val_rtl_net_py
     ELSE 0
     END) AS basisumsatz_vj,
   SUM(CASE
     WHEN t11.bereinigt_fg = 1
     THEN t11.val_rtl_net
     ELSE 0
     END) AS bereinigter_umsatz,
   SUM(t11.cnt_customer) AS kundenanzahl,
   SUM(CASE
     WHEN t11.basis_fg = 1
     THEN t11.cnt_customer
     ELSE 0
     END) AS basiskundenanzahl_lj,
   SUM(CASE
     WHEN t11.basis_fg = 1
     THEN t11.cnt_customer_py
     ELSE 0
     END) AS basiskundenanzahl_vj,
   SUM(CASE
     WHEN t11.bereinigt_fg = 1
     THEN t11.cnt_customer
     ELSE 0
     END) AS bereinigte_kundenanzahl,
   COUNT(DISTINCT CASE
     WHEN t11.regular_fg = 1
     THEN t11.building_sid
     ELSE NULL
     END) AS anzahl_filialen,
   NULL AS basisanzahl_filialen_vj,
   NULL AS basisanzahl_filialen_lj,
   COUNT(DISTINCT CASE
     WHEN t11.bereinigt_fg = 1
     THEN t11.building_sid
     ELSE NULL
     END) AS bereinigte_filialanzahl,
   SUM(CASE
     WHEN t11.val_rtl_net > 1000
     THEN 1
     ELSE 0
     END) AS verkaufstage,
   SUM(CASE
     WHEN t11.regular_fg = 1
     THEN t11.sdl_sales_area_in_meas_effective
     ELSE 0
     END) AS verkaufsflaeche,
   NULL AS basisverkaufsflaeche_lj,
   NULL AS basisverkaufsflaeche_vj,
   SUM(CASE
     WHEN t11.bereinigt_fg = 1
     THEN t11.sdl_sales_area_in_meas_effective
     ELSE 0
     END) AS bereinigte_verkaufsflaeche,
   COUNT(DISTINCT CASE
     WHEN t11.new_opening_fg = 1
     THEN t11.building_sid
     ELSE NULL
     END) AS anzahl_filialen_neueroeffnung,
   COUNT(DISTINCT CASE
     WHEN t11.replacement_fg = 1
     THEN t11.building_sid
     ELSE NULL
     END) AS anzahl_filialen_ersatz,
   COUNT(DISTINCT CASE
     WHEN t11.closure_fg = 1
     THEN t11.building_sid
     ELSE NULL
     END) AS anzahl_filialen_schliessung,
   COUNT(DISTINCT CASE
     WHEN t11.rebuild_fg = 1
     THEN t11.building_sid
     ELSE NULL
     END) AS anzahl_filialen_abrissneubau
  FROM (SELECT 300 AS version,
     t8.cy AS kalenderjahr,
     t8.period AS kalendermonat,
     b.sdl_country_code AS land_1,
     C.curr_cd AS landeswaehrung,
     TURN.val_rtl_net,
      CASE
      WHEN t8.cal_dt >= ST_PRE.dat_calc_start_py AND ST_PRE.move_fg = 1 OR t8.cal_dt BETWEEN ST_PRE.dat_calc_start_py
         AND ST_PRE.dat_calc_end_py OR t8.cal_dt >= ST_PRE.dat_calc_start_py AND ST_PRE.dat_calc_end_py IS NULL
      THEN 1
      ELSE 0
      END AS basis_fg,
     TURN_PY.val_rtl_net AS val_rtl_net_py,
      CASE
      WHEN b.sdl_opening_dt_effective < t8.period_start_dt AND (b.sdl_closing_dt_effective > t8.period_end_dt OR b.sdl_closing_dt_effective
           IS NULL) OR b.sdl_replacement_to_dt_effective BETWEEN t8.period_start_dt AND t8.period_end_dt OR b.sdl_replacement_from_dt_effective
        BETWEEN t8.period_start_dt AND t8.period_end_dt
      THEN 1
      ELSE 0
      END AS bereinigt_fg,
     TURN.cnt_customer,
     TURN_PY.cnt_customer AS cnt_customer_py,
      CASE
      WHEN b.sdl_opening_dt_effective <= t8.period_end_dt AND (b.sdl_closing_dt_effective >= t8.period_start_dt OR b.sdl_closing_dt_effective
         IS NULL)
      THEN 1
      ELSE 0
      END AS regular_fg,
     b.building_sid,
     NULL AS basisanzahl_filialen_lj,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t8.cy AS STRING), t8.period, CAST(b.client_id AS STRING), CAST(b.building_sid AS STRING)
           ORDER BY 1 IS NULL, 1)) = 1
      THEN b.sdl_sales_area_in_meas_effective
      ELSE 0
      END AS sdl_sales_area_in_meas_effective,
     NULL AS basisverkaufsflaeche_lj,
     NULL AS basisverkaufsflaeche_vj,
      CASE
      WHEN b.sdl_opening_dt_effective BETWEEN t8.period_start_dt AND t8.period_end_dt AND (b.sdl_replacement_to_dt_effective
          NOT BETWEEN t8.period_start_dt AND t8.period_end_dt OR b.sdl_replacement_to_dt_effective IS NULL)
      THEN 1
      ELSE 0
      END AS new_opening_fg,
      CASE
      WHEN b.sdl_opening_dt_effective BETWEEN t8.period_start_dt AND t8.period_end_dt AND b.sdl_replacement_to_dt_effective
         BETWEEN t8.period_start_dt AND t8.period_end_dt AND b.sdl_rebuild_fg_effective = 0
      THEN 1
      ELSE 0
      END AS replacement_fg,
      CASE
      WHEN b.sdl_closing_dt_effective BETWEEN t8.period_start_dt AND t8.period_end_dt AND (b.sdl_replacement_from_dt_effective
          NOT BETWEEN t8.period_start_dt AND t8.period_end_dt OR b.sdl_replacement_from_dt_effective IS NULL)
      THEN 1
      ELSE 0
      END AS closure_fg,
      CASE
      WHEN b.sdl_opening_dt_effective BETWEEN t8.period_start_dt AND t8.period_end_dt AND b.sdl_replacement_to_dt_effective
         BETWEEN t8.period_start_dt AND t8.period_end_dt AND b.sdl_rebuild_fg_effective = 1
      THEN 1
      ELSE 0
      END AS rebuild_fg,
     300 AS z0,
     t8.cy AS z00,
     t8.period AS z01,
     b.sdl_country_code AS z02,
     C.curr_cd AS z03
    FROM PD_1 AS t8
     INNER JOIN (SELECT client_id,
       sdl_country_code,
       building_sid,
       COALESCE(sdl_sales_area_in_meas_co_override, sdl_sales_area_in_meas) AS sdl_sales_area_in_meas_effective,
        CASE
        WHEN sdl_opening_dt_co_override = DATE '9999-12-31'
        THEN NULL
        ELSE COALESCE(sdl_opening_dt_co_override, sdl_opening_dt)
        END AS sdl_opening_dt_effective,
        CASE
        WHEN sdl_closing_dt_co_override = DATE '9999-12-31'
        THEN NULL
        ELSE COALESCE(sdl_closing_dt_co_override, sdl_closing_dt)
        END AS sdl_closing_dt_effective,
        CASE
        WHEN sdl_replacement_to_dt_co_override = DATE '9999-12-31'
        THEN NULL
        ELSE COALESCE(sdl_replacement_to_dt_co_override, sdl_replacement_to_dt)
        END AS sdl_replacement_to_dt_effective,
        CASE
        WHEN sdl_replacement_from_dt_co_override = DATE '9999-12-31'
        THEN NULL
        ELSE COALESCE(sdl_replacement_from_dt_co_override, sdl_replacement_from_dt)
        END AS sdl_replacement_from_dt_effective,
       COALESCE(sdl_rebuild_fg_co_override, sdl_rebuild_fg) AS sdl_rebuild_fg_effective
      FROM ldl_p_lew_core_ac.v_ref_sdl_building_hist_1
      WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
       AND deleted_fg = 0
       AND sdl_ignore_fg = 0) AS b ON TRUE
     INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON b.client_id = C.client_id
     INNER JOIN ldl_p_lew_core_ac.v_location_building_hist_1 AS LBH ON b.client_id = LBH.client_id AND b.building_sid =
         LBH.building_sid AND CURRENT_DATE BETWEEN LBH.dwh_valid_from AND LBH.dwh_valid_to AND LBH.deleted_fg = 0
     LEFT JOIN ldl_p_lew_bil_ac.v_agg_store_day_turnover_ext_1 AS TURN ON LBH.client_id = TURN.client_id AND LBH.loc_sid =
         TURN.loc_sid_store AND C.curr_cd = TURN.currency_iso_cd AND t8.cal_dt = TURN.dat_formdate
     LEFT JOIN ldl_p_lew_bil_ac.v_agg_store_day_turnover_ext_1 AS TURN_PY ON LBH.client_id = TURN_PY.client_id AND LBH.loc_sid
          = TURN_PY.loc_sid_store AND C.curr_cd = TURN_PY.currency_iso_cd AND t8.cal_dt_py = TURN_PY.dat_formdate
     LEFT JOIN ldl_p_lew_mart_msi_ac.v_org_store_pre_1 AS ST_PRE ON LBH.client_id = ST_PRE.client_id AND LBH.loc_sid =
       ST_PRE.store_id) AS t11
  GROUP BY t11.version,
   t11.kalenderjahr,
   t11.kalendermonat,
   t11.land_1,
   t11.landeswaehrung);