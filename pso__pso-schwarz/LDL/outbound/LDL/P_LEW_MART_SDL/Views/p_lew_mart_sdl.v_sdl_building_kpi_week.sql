CREATE OR REPLACE VIEW ldl_p_lew_mart_sdl.v_sdl_building_kpi_week AS WITH PWD AS (SELECT cal_dt,
   cal_dt_swday_prev_1y,
   cy,
    cy_week - CAST(TRUNC(cy_week / 100, 0) * 100 AS BIGNUMERIC) AS week_no,
     CASE
     WHEN busyear < cy
     THEN 'TWI'
     ELSE 'TWII'
     END || CAST(cy_week - CAST(TRUNC(cy_week / 100, 0) * 100 AS BIGNUMERIC) AS STRING) AS period,
   COUNT(1) OVER (PARTITION BY CAST(busyear AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS nb_of_week_days,
   MIN(cal_dt) OVER (PARTITION BY CAST(cy AS STRING), CASE
        WHEN busyear < cy
        THEN 'TWI'
        ELSE 'TWII'
        END || CAST(cy_week - CAST(TRUNC(cy_week / 100, 0) * 100 AS BIGNUMERIC) AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS period_start_dt,
   MAX(cal_dt) OVER (PARTITION BY CAST(cy AS STRING), CASE
        WHEN busyear < cy
        THEN 'TWI'
        ELSE 'TWII'
        END || CAST(cy_week - CAST(TRUNC(cy_week / 100, 0) * 100 AS BIGNUMERIC) AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS period_end_dt,
   DENSE_RANK() OVER (ORDER BY cy_week IS NULL DESC, cy_week DESC) AS rnk
  FROM ldl_p_lew_core_ac.v_cal_calendarday
  WHERE cal_dt <= CURRENT_DATE
  QUALIFY (DENSE_RANK() OVER (ORDER BY cy_week IS NULL DESC, cy_week DESC)) >= 2 AND (DENSE_RANK() OVER (ORDER BY
          cy_week IS NULL DESC, cy_week DESC)) <= 9 AND (COUNT(1) OVER (PARTITION BY CAST(busyear AS STRING), CAST(cy_week AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) < 7), EWD AS (SELECT cal_dt,
   cal_dt_swday_prev_1y,
   TRUNC(cy_week / 100, 0) AS cy,
    cy_week - TRUNC(cy_week / 100, 0) * 100 AS period,
   MIN(cal_dt) OVER (PARTITION BY CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   period_start_dt,
   MAX(cal_dt) OVER (PARTITION BY CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   period_end_dt,
   DENSE_RANK() OVER (ORDER BY cy_week IS NULL DESC, cy_week DESC) AS rnk
  FROM ldl_p_lew_core_ac.v_cal_calendarday
  WHERE cal_dt <= CURRENT_DATE
  QUALIFY (DENSE_RANK() OVER (ORDER BY cy_week IS NULL DESC, cy_week DESC)) >= 2 AND (DENSE_RANK() OVER (ORDER BY
         cy_week IS NULL DESC, cy_week DESC)) <= 9), PD AS (SELECT pd.cy,
   pd.period,
   pd.period_start_dt,
   pd.period_end_dt,
   pd.cal_dt,
   PD_PY.cal_dt AS cal_dt_py
  FROM (SELECT cal_dt,
      cal_dt_swday_prev_1y,
      cy,
      period,
      period_start_dt,
      period_end_dt
     FROM PWD
     UNION ALL
     SELECT cal_dt,
      cal_dt_swday_prev_1y,
      cy,
      CAST(period AS STRING) AS period,
      period_start_dt,
      period_end_dt
     FROM EWD) AS pd
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS PD_PY ON pd.cal_dt_swday_prev_1y = PD_PY.cal_dt) (/* Entiew Weeks Days: All days of the last 8 entire weeks */
  /* Partial Weeks Days: Days of the partial weeks (Teilwochen) within the last 8 weeks */
  /* Leave sales area set only on the first store record, so that the SUM() in the parent select doesn't sum the store-area multiple times */
  /* Stores being opened before or within and closed within or after the reporting period */
  /* Stores that are open during the entire reporting period, or being replaced by or replacing another store within the reporting period */
  /* Stores that opened within reporting period (Neueröffnungen), but not replacing another store */
  /* Stores that replace other stores in reporting period (Ersatz) */
  /* Stores that were rebuilt in reporting period (Abriss/Neubau) */
  /* Stores that closed within reporting period (Schließungen) */
  /* Stores having the "basis" characteristic, as reversed engineered from MSI LEAD Reports */ /* Periods Days */
  /* Extract the relevant SDL Buildings with their effective values for reporting. Translate specific values to NULL, as maintained in Exception List XLS */
  SELECT t14.version,
   t14.kalenderjahr,
   t14.kalenderwoche,
   t14.land,
   t14.landeswaehrung,
   SUM(t14.val_rtl_net) AS umsatz_netto,
   SUM(CASE
     WHEN t14.basis_fg = 1
     THEN t14.val_rtl_net
     ELSE 0
     END) AS basisumsatz_lj,
   SUM(CASE
     WHEN t14.basis_fg = 1
     THEN t14.val_rtl_net_py
     ELSE 0
     END) AS basisumsatz_vj,
   SUM(CASE
     WHEN t14.bereinigt_fg = 1
     THEN t14.val_rtl_net
     ELSE 0
     END) AS bereinigter_umsatz,
   SUM(t14.cnt_customer) AS kundenanzahl,
   SUM(CASE
     WHEN t14.basis_fg = 1
     THEN t14.cnt_customer
     ELSE 0
     END) AS basiskundenanzahl_lj,
   SUM(CASE
     WHEN t14.basis_fg = 1
     THEN t14.cnt_customer_py
     ELSE 0
     END) AS basiskundenanzahl_vj,
   SUM(CASE
     WHEN t14.bereinigt_fg = 1
     THEN t14.cnt_customer
     ELSE 0
     END) AS bereinigte_kundenanzahl,
   COUNT(DISTINCT CASE
     WHEN t14.regular_fg = 1
     THEN t14.building_sid
     ELSE NULL
     END) AS anzahl_filialen,
   NULL AS basisanzahl_filialen_vj,
   NULL AS basisanzahl_filialen_lj,
   COUNT(DISTINCT CASE
     WHEN t14.bereinigt_fg = 1
     THEN t14.building_sid
     ELSE NULL
     END) AS bereinigte_filialanzahl,
   SUM(CASE
     WHEN t14.val_rtl_net > 1000
     THEN 1
     ELSE 0
     END) AS verkaufstage,
   SUM(CASE
     WHEN t14.regular_fg = 1
     THEN t14.sdl_sales_area_in_meas_effective
     ELSE 0
     END) AS verkaufsflaeche,
   NULL AS basisverkaufsflaeche_lj,
   NULL AS basisverkaufsflaeche_vj,
   SUM(CASE
     WHEN t14.bereinigt_fg = 1
     THEN t14.sdl_sales_area_in_meas_effective
     ELSE 0
     END) AS bereinigte_verkaufsflaeche,
   COUNT(DISTINCT CASE
     WHEN t14.new_opening_fg = 1
     THEN t14.building_sid
     ELSE NULL
     END) AS anzahl_filialen_neueroeffnung,
   COUNT(DISTINCT CASE
     WHEN t14.replacement_fg = 1
     THEN t14.building_sid
     ELSE NULL
     END) AS anzahl_filialen_ersatz,
   COUNT(DISTINCT CASE
     WHEN t14.closure_fg = 1
     THEN t14.building_sid
     ELSE NULL
     END) AS anzahl_filialen_schliessung,
   COUNT(DISTINCT CASE
     WHEN t14.rebuild_fg = 1
     THEN t14.building_sid
     ELSE NULL
     END) AS anzahl_filialen_abrissneubau
  FROM (SELECT 300 AS version,
     t11.cy AS kalenderjahr,
     t11.period AS kalenderwoche,
     b.sdl_country_code AS land,
     C.curr_cd AS landeswaehrung,
     TURN.val_rtl_net,
      CASE
      WHEN t11.cal_dt >= ST_PRE.dat_calc_start_py AND ST_PRE.move_fg = 1 OR t11.cal_dt BETWEEN ST_PRE.dat_calc_start_py
         AND ST_PRE.dat_calc_end_py OR t11.cal_dt >= ST_PRE.dat_calc_start_py AND ST_PRE.dat_calc_end_py IS NULL
      THEN 1
      ELSE 0
      END AS basis_fg,
     TURN_PY.val_rtl_net AS val_rtl_net_py,
      CASE
      WHEN b.sdl_opening_dt_effective < t11.period_start_dt AND (b.sdl_closing_dt_effective > t11.period_end_dt OR b.sdl_closing_dt_effective
           IS NULL) OR b.sdl_replacement_to_dt_effective BETWEEN t11.period_start_dt AND t11.period_end_dt OR b.sdl_replacement_from_dt_effective
        BETWEEN t11.period_start_dt AND t11.period_end_dt
      THEN 1
      ELSE 0
      END AS bereinigt_fg,
     TURN.cnt_customer,
     TURN_PY.cnt_customer AS cnt_customer_py,
      CASE
      WHEN b.sdl_opening_dt_effective <= t11.period_end_dt AND (b.sdl_closing_dt_effective >= t11.period_start_dt OR b.sdl_closing_dt_effective
         IS NULL)
      THEN 1
      ELSE 0
      END AS regular_fg,
     b.building_sid,
     NULL AS basisanzahl_filialen_lj,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t11.cy AS STRING), t11.period, CAST(b.client_id AS STRING), CAST(b.building_sid AS STRING)
           ORDER BY 1 IS NULL, 1)) = 1
      THEN b.sdl_sales_area_in_meas_effective
      ELSE 0
      END AS sdl_sales_area_in_meas_effective,
     NULL AS basisverkaufsflaeche_lj,
     NULL AS basisverkaufsflaeche_vj,
      CASE
      WHEN b.sdl_opening_dt_effective BETWEEN t11.period_start_dt AND t11.period_end_dt AND (b.sdl_replacement_to_dt_effective
          NOT BETWEEN t11.period_start_dt AND t11.period_end_dt OR b.sdl_replacement_to_dt_effective IS NULL)
      THEN 1
      ELSE 0
      END AS new_opening_fg,
      CASE
      WHEN b.sdl_opening_dt_effective BETWEEN t11.period_start_dt AND t11.period_end_dt AND b.sdl_replacement_to_dt_effective
         BETWEEN t11.period_start_dt AND t11.period_end_dt AND b.sdl_rebuild_fg_effective = 0
      THEN 1
      ELSE 0
      END AS replacement_fg,
      CASE
      WHEN b.sdl_closing_dt_effective BETWEEN t11.period_start_dt AND t11.period_end_dt AND (b.sdl_replacement_from_dt_effective
          NOT BETWEEN t11.period_start_dt AND t11.period_end_dt OR b.sdl_replacement_from_dt_effective IS NULL)
      THEN 1
      ELSE 0
      END AS closure_fg,
      CASE
      WHEN b.sdl_opening_dt_effective BETWEEN t11.period_start_dt AND t11.period_end_dt AND b.sdl_replacement_to_dt_effective
         BETWEEN t11.period_start_dt AND t11.period_end_dt AND b.sdl_rebuild_fg_effective = 1
      THEN 1
      ELSE 0
      END AS rebuild_fg,
     300 AS z0,
     t11.cy AS z00,
     t11.period AS z01,
     b.sdl_country_code AS z02,
     C.curr_cd AS z03
    FROM PD AS t11
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
      FROM ldl_p_lew_core_ac.v_ref_sdl_building_hist
      WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
       AND deleted_fg = 0
       AND sdl_ignore_fg = 0) AS b ON TRUE
     INNER JOIN ldl_p_lew_core_ac.v_client AS C ON b.client_id = C.client_id
     INNER JOIN ldl_p_lew_core_ac.v_location_building_hist AS LBH ON b.client_id = LBH.client_id AND b.building_sid =
         LBH.building_sid AND CURRENT_DATE BETWEEN LBH.dwh_valid_from AND LBH.dwh_valid_to AND LBH.deleted_fg = 0
     LEFT JOIN ldl_p_lew_bil_ac.v_agg_store_day_turnover_ext AS TURN ON LBH.client_id = TURN.client_id AND LBH.loc_sid =
         TURN.loc_sid_store AND C.curr_cd = TURN.currency_iso_cd AND t11.cal_dt = TURN.dat_formdate
     LEFT JOIN ldl_p_lew_bil_ac.v_agg_store_day_turnover_ext AS TURN_PY ON LBH.client_id = TURN_PY.client_id AND LBH.loc_sid
          = TURN_PY.loc_sid_store AND C.curr_cd = TURN_PY.currency_iso_cd AND t11.cal_dt_py = TURN_PY.dat_formdate
     LEFT JOIN ldl_p_lew_mart_msi_ac.v_org_store_pre AS ST_PRE ON LBH.client_id = ST_PRE.client_id AND LBH.loc_sid =
       ST_PRE.store_id) AS t14
  GROUP BY t14.version,
   t14.kalenderjahr,
   t14.kalenderwoche,
   t14.land,
   t14.landeswaehrung);