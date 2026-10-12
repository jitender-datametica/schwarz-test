CREATE OR REPLACE VIEW P_LEW_MART_SDL.V_SDL_BUILDING_KPI_MONTH AS
WITH pmd AS ( /* Last Month Days */
              SELECT cy, cal_dt, cy_month, cal_dt_prev_yd, DENSE_RANK() OVER (ORDER BY cy_month DESC) AS rnk
              FROM P_LEW_CORE_AC.v_cal_calendarday
              WHERE cal_dt <= CURRENT_DATE
              QUALIFY rnk = 2
            ),

     pypmd AS ( /* Previous Year Previous Month Days: All days of the last month in the previous year */
                SELECT cy, cal_dt, cy_month, DENSE_RANK() OVER (ORDER BY cy_month DESC) AS rnk
                FROM P_LEW_CORE_AC.v_cal_calendarday
                WHERE cal_dt <= ADD_MONTHS(CURRENT_DATE, -12)
                QUALIFY rnk = 2
              ),

     pd AS (  /* Periods Days: All days of the last month, accompagned by the corersponding day of the last year */
             SELECT COALESCE(pmd.cy, pypmd.cy + 1)                    AS cy
                  , COALESCE(pmd.cy_month, pypmd.cy_month)            AS period0
                  , TRIM(period0 - TRUNCATE(period0/100,0)*100)       AS period  /* Extract only the month number from cy_month and trim leading zeros */
                  , MIN(pmd.cal_dt) OVER (PARTITION BY pmd.cy_month)  AS period_start_dt
                  , MAX(pmd.cal_dt) OVER (PARTITION BY pmd.cy_month)  AS period_end_dt
                  , pmd.cal_dt                                        AS cal_dt
                  , pypmd.cal_dt                                      AS cal_dt_py
              FROM pmd
              FULL OUTER JOIN pypmd
                           ON pypmd.cal_dt = pmd.cal_dt_prev_yd
           )

SELECT 300                                                                                AS version
     , cy                                                                                 AS kalenderjahr
     , period                                                                             AS kalendermonat
     , sdl_country_code                                                                   AS land
     , curr_cd                                                                            AS landeswaehrung
     , SUM(val_rtl_net)                                                                   AS umsatz_netto
     , SUM(CASE WHEN basis_fg = 1 THEN val_rtl_net ELSE 0 END)                            AS basisumsatz_lj
     , SUM(CASE WHEN basis_fg = 1 THEN val_rtl_net_py ELSE 0 END)                         AS basisumsatz_vj
     , SUM(CASE WHEN bereinigt_fg = 1 THEN val_rtl_net ELSE 0 END)                        AS bereinigter_umsatz
     , SUM(cnt_customer)                                                                  AS kundenanzahl
     , SUM(CASE WHEN basis_fg = 1 THEN cnt_customer ELSE 0 END)                           AS basiskundenanzahl_lj
     , SUM(CASE WHEN basis_fg = 1 THEN cnt_customer_py ELSE 0 END)                        AS basiskundenanzahl_vj
     , SUM(CASE WHEN bereinigt_fg = 1 THEN cnt_customer ELSE 0 END)                       AS bereinigte_kundenanzahl
     , COUNT(DISTINCT(CASE WHEN regular_fg = 1 THEN building_sid ELSE NULL END))          AS anzahl_filialen
     , NULL                                                                               AS basisanzahl_filialen_vj
     , NULL                                                                               AS basisanzahl_filialen_lj
     , COUNT(DISTINCT(CASE WHEN bereinigt_fg = 1 THEN building_sid ELSE NULL END))        AS bereinigte_filialanzahl
     , SUM(CASE WHEN val_rtl_net > 1000 THEN 1 ELSE 0 END)                                AS verkaufstage
     , SUM(CASE WHEN regular_fg = 1 THEN sdl_sales_area_in_meas_effective ELSE 0 END)     AS verkaufsflaeche
     , NULL                                                                               AS basisverkaufsflaeche_lj
     , NULL                                                                               AS basisverkaufsflaeche_vj
     , SUM(CASE WHEN bereinigt_fg = 1 THEN sdl_sales_area_in_meas_effective ELSE 0 END)   AS bereinigte_verkaufsflaeche
     , COUNT(DISTINCT(CASE WHEN new_opening_fg = 1 THEN building_sid ELSE NULL END))      AS anzahl_filialen_neueroeffnung
     , COUNT(DISTINCT(CASE WHEN replacement_fg = 1 THEN building_sid ELSE NULL END))      AS anzahl_filialen_ersatz
     , COUNT(DISTINCT(CASE WHEN closure_fg = 1 THEN building_sid ELSE NULL END))          AS anzahl_filialen_schliessung
     , COUNT(DISTINCT(CASE WHEN rebuild_fg = 1 THEN building_sid ELSE NULL END))          AS anzahl_filialen_abrissneubau

FROM (
       SELECT b.sdl_country_code
            , c.curr_cd
            , b.building_sid
            , pd.cy
            , pd.period0
            , pd.period

            , turn.val_rtl_net
            , turn.cnt_customer
            , turn_py.val_rtl_net  AS val_rtl_net_py
            , turn_py.cnt_customer AS cnt_customer_py

            , CASE WHEN ROW_NUMBER() OVER (PARTITION BY pd.cy, pd.period, b.client_id, b.building_sid ORDER BY 1) = 1
                   THEN b.sdl_sales_area_in_meas_effective ELSE 0
              END sdl_sales_area_in_meas_effective /* Leave sales area set only on the first store record, so that the SUM() in the parent select doesn't sum the store-area multiple times */

            , CASE WHEN b.sdl_opening_dt_effective <= pd.period_end_dt AND (b.sdl_closing_dt_effective >= pd.period_start_dt OR b.sdl_closing_dt_effective IS NULL)
                   THEN 1 ELSE 0
              END AS regular_fg     /* Stores being opened before or within and closed within or after the reporting period */

            , CASE WHEN (b.sdl_opening_dt_effective < pd.period_start_dt AND (b.sdl_closing_dt_effective > pd.period_end_dt OR b.sdl_closing_dt_effective IS NULL))
                   OR b.sdl_replacement_to_dt_effective   BETWEEN pd.period_start_dt AND pd.period_end_dt
                   OR b.sdl_replacement_from_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                   THEN 1 ELSE 0
              END AS bereinigt_fg /* Stores that are open during the entire reporting period, or being replaced by or replacing another store within the reporting period  */

            , CASE WHEN b.sdl_opening_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                    AND (b.sdl_replacement_to_dt_effective NOT BETWEEN pd.period_start_dt AND pd.period_end_dt OR b.sdl_replacement_to_dt_effective IS NULL)
                   THEN 1 ELSE 0
              END AS new_opening_fg /* Stores that opened within reporting period (Neueröffnungen), but not replacing another store */

            , CASE WHEN b.sdl_opening_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                    AND b.sdl_replacement_to_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                    AND b.sdl_rebuild_fg_effective = 0
                    THEN 1 ELSE 0
              END AS replacement_fg /* Stores that replace other stores in reporting period (Ersatz) */

            , CASE WHEN b.sdl_opening_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                    AND b.sdl_replacement_to_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                    AND b.sdl_rebuild_fg_effective = 1
                    THEN 1 ELSE 0
              END AS rebuild_fg /* Stores that were rebuilt in reporting period (Abriss/Neubau) */

            , CASE WHEN b.sdl_closing_dt_effective BETWEEN pd.period_start_dt AND pd.period_end_dt
                    AND (b.sdl_replacement_from_dt_effective NOT BETWEEN pd.period_start_dt AND pd.period_end_dt OR b.sdl_replacement_from_dt_effective IS NULL)
                   THEN 1 ELSE 0
              END AS closure_fg     /* Stores that closed within reporting period (Schließungen) */

            , CASE WHEN (pd.cal_dt >=  st_pre.dat_calc_start_py AND st_pre.move_fg = 1)
                     OR (pd.cal_dt BETWEEN st_pre.dat_calc_start_py AND st_pre.dat_calc_end_py)
                     OR (pd.cal_dt >=  st_pre.dat_calc_start_py AND st_pre.dat_calc_end_py IS NULL)
                   THEN 1 ELSE 0
              END AS basis_fg       /* Stores having the "basis" characteristic, as reversed engineered from MSI LEAD Reports */

       FROM pd /* Periods Days */
       CROSS JOIN (
                     /* Extract the relevant SDL Buildings with their effective values for reporting. Translate specific values to NULL, as maintained in Exception List XLS */
                     SELECT client_id
                          , sdl_country_code
                          , building_sid
                          , COALESCE(sdl_sales_area_in_meas_co_override, sdl_sales_area_in_meas) AS sdl_sales_area_in_meas_effective
                          , CASE WHEN sdl_opening_dt_co_override = DATE '9999-12-31' THEN NULL ELSE COALESCE(sdl_opening_dt_co_override, sdl_opening_dt) END AS sdl_opening_dt_effective
                          , CASE WHEN sdl_closing_dt_co_override = DATE '9999-12-31' THEN NULL ELSE COALESCE(sdl_closing_dt_co_override, sdl_closing_dt) END AS sdl_closing_dt_effective
                          , CASE WHEN sdl_replacement_to_dt_co_override = DATE '9999-12-31' THEN NULL ELSE COALESCE(sdl_replacement_to_dt_co_override, sdl_replacement_to_dt) END AS sdl_replacement_to_dt_effective
                          , CASE WHEN sdl_replacement_from_dt_co_override = DATE '9999-12-31' THEN NULL ELSE COALESCE(sdl_replacement_from_dt_co_override, sdl_replacement_from_dt) END AS sdl_replacement_from_dt_effective
                          , COALESCE(sdl_rebuild_fg_co_override, sdl_rebuild_fg) sdl_rebuild_fg_effective
                     FROM P_LEW_CORE_AC.v_ref_sdl_building_hist
                     WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
                       AND deleted_fg = 0
                       AND sdl_ignore_fg = 0
                  ) AS b
       INNER JOIN P_LEW_CORE_AC.v_client AS c
               ON c.client_id = b.client_id
       INNER JOIN P_LEW_CORE_AC.v_location_building_hist AS lbh
               ON lbh.client_id = b.client_id
              AND lbh.building_sid = b.building_sid
              AND CURRENT_DATE BETWEEN lbh.dwh_valid_from AND lbh.dwh_valid_to
              AND lbh.deleted_fg = 0
       LEFT OUTER JOIN p_lew_bil_ac.v_agg_store_day_turnover_ext AS turn
                    ON turn.client_id = lbh.client_id
                   AND turn.loc_sid_store = lbh.loc_sid
                   AND turn.currency_iso_cd = c.curr_cd
                   AND turn.dat_formdate = pd.cal_dt
       LEFT OUTER JOIN p_lew_bil_ac.v_agg_store_day_turnover_ext AS turn_py
                    ON turn_py.client_id = lbh.client_id
                   AND turn_py.loc_sid_store = lbh.loc_sid
                   AND turn_py.currency_iso_cd = c.curr_cd
                   AND turn_py.dat_formdate = pd.cal_dt_py
       LEFT OUTER JOIN p_lew_mart_msi_ac.v_org_store_pre AS st_pre
                    ON st_pre.client_id = lbh.client_id
                   AND st_pre.store_id = lbh.loc_sid
    ) s
GROUP BY Version
       , Kalenderjahr
       , Kalendermonat
       , Land
       , Landeswaehrung
;