CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_kzp_store AS SELECT denorm.client_id,
 WH.src_wh_id,
 denorm.loc_sid_store,
 denorm.src_orig_store_nr,
 denorm.open_store_fg,
 denorm.closed_store_fg,
 denorm.loc_name,
 denorm.region_cd,
 denorm.mde_lang_cd,
 denorm.country_iso_cd,
 denorm.qty_min_dflt,
 denorm.opening_dt,
 denorm.closing_dt,
 denorm.real_opening_dt,
 denorm.dat_opening_ovis,
 denorm.dat_closing_ovis,
 denorm.dat_valid_from,
 denorm.dat_valid_until,
 IF(LHIST.mon_opening_tm IS NULL, 0, 1) AS is_mon_open,
 IF(LHIST.tue_opening_tm IS NULL, 0, 1) AS is_tue_open,
 IF(LHIST.wed_opening_tm IS NULL, 0, 1) AS is_wed_open,
 IF(LHIST.thu_opening_tm IS NULL, 0, 1) AS is_thu_open,
 IF(LHIST.fri_opening_tm IS NULL, 0, 1) AS is_fri_open,
 IF(LHIST.sat_opening_tm IS NULL, 0, 1) AS is_sat_open,
 IF(LHIST.sun_opening_tm IS NULL, 0, 1) AS is_sun_open,
 - 1 AS dwh_load_id
FROM (SELECT client_id,
   loc_sid_store,
   src_orig_store_nr,
   loc_name,
   region_cd,
   mde_lang_cd,
   country_iso_cd,
   qty_min_dflt,
   opening_dt,
   closing_dt,
   real_opening_dt,
   dat_opening_ovis,
   dat_closing_ovis,
   open_store_fg,
   closed_store_fg,
   MIN(dwh_valid_from) AS dat_valid_from,
   MAX(dwh_valid_to) AS dat_valid_until
  FROM (SELECT client_id,
     loc_sid_store,
     src_orig_store_nr,
     loc_name,
     region_cd,
     mde_lang_cd,
     country_iso_cd,
     qty_min_dflt,
     opening_dt,
     closing_dt,
     real_opening_dt,
     dat_opening_ovis,
     dat_closing_ovis,
     open_store_fg,
     closed_store_fg,
     SUM(groupstartflag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING), CAST(src_orig_store_nr AS STRING)
        , loc_name, region_cd, mde_lang_cd, country_iso_cd, CAST(qty_min_dflt AS STRING), opening_dt, closing_dt,
        real_opening_dt, dat_opening_ovis, dat_closing_ovis, open_store_fg, closed_store_fg ORDER BY dwh_valid_from
        IS NULL, dwh_valid_from ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
     dwh_valid_from,
     dwh_valid_to
    FROM (SELECT client_id,
       loc_sid_store,
       src_orig_store_nr,
       loc_name,
       region_cd,
       mde_lang_cd,
       country_iso_cd,
       qty_min_dflt,
       opening_dt,
       closing_dt,
       real_opening_dt,
       dat_opening_ovis,
       dat_closing_ovis,
       open_store_fg,
       closed_store_fg,
       cal_dt AS dwh_valid_from,
       MAX(cal_dt) AS dwh_valid_to,
        CASE
        WHEN DATE_SUB(cal_dt, INTERVAL 1 DAY) <= (LAG(MAX(cal_dt)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING)
             , CAST(src_orig_store_nr AS STRING), loc_name, region_cd, mde_lang_cd, country_iso_cd, CAST(qty_min_dflt AS STRING)
             , opening_dt, closing_dt, real_opening_dt, dat_opening_ovis, dat_closing_ovis, open_store_fg,
             closed_store_fg ORDER BY cal_dt IS NULL, cal_dt))
        THEN 0
        ELSE 1
        END AS groupstartflag
      FROM (SELECT 
       client_id,
         loc_sid_store,
         src_orig_store_nr,
         loc_name,
         region_cd,
         mde_lang_cd,
         country_iso_cd0 AS country_iso_cd,
         qty_min_dflt,
         opening_dt,
         closing_dt,
         real_opening_dt,
         dat_opening_ovis,
         cal_dt,
         COALESCE(dat_closing_ovis, DATE '9999-12-31') AS dat_closing_ovis,
          CASE
          WHEN cal_dt BETWEEN opening_dt AND (DATE_SUB(dat_closing_ovis, INTERVAL 1 DAY)) OR cal_dt >= opening_dt AND
            dat_closing_ovis IS NULL
          THEN 1
          ELSE 0
          END AS open_store_fg,
          CASE
          WHEN cal_dt BETWEEN opening_dt AND (DATE_SUB(dat_closing_ovis, INTERVAL 1 DAY)) OR cal_dt >= opening_dt AND
            dat_closing_ovis IS NULL
          THEN 1
          ELSE 0
          END AS closed_store_fg,
         dwh_valid_from,
         DATE_ADD(dwh_valid_to, INTERVAL 1 DAY) AS dwh_valid_to
        FROM (
          SELECT 
            A.client_id,
            A.loc_sid_store,
            A.src_orig_store_nr,
            A.loc_name,
            A.region_cd,
            A.mde_lang_cd,
            A.country_iso_cd AS country_iso_cd0, 
            A.qty_min_dflt,
            A.opening_dt,
            A.closing_dt,
            A.real_opening_dt,
            A.dat_opening_ovis,
            A.dat_closing_ovis,
            A.test_store_fg,
            A.dwh_valid_from,
            A.dwh_valid_to,
            CAL.cal_dt
          FROM ldl_p_lew_bil_ac.v_store AS A
          INNER JOIN ldl_p_lew_bil_ac.v_ref_client_lead AS B ON A.client_id = B.client_id
          LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN A.dwh_valid_from AND A.dwh_valid_to
             
          UNION ALL
          SELECT 
            A.client_id,
            A.loc_sid_store,
            A.src_orig_store_nr,
            A.loc_name,
            A.region_cd,
            A.mde_lang_cd,
            A.country_iso_cd,
            A.qty_min_dflt,
            A.opening_dt,
            A.closing_dt,
            A.real_opening_dt,
            A.dat_opening_ovis,
            A.dat_closing_ovis,
            A.test_store_fg,
            A.dwh_valid_from,
            A.dwh_valid_to,
            CAL.cal_dt
          FROM ldl_p_lew_bil_ac.v_store AS A
          INNER JOIN ldl_p_lew_bil_ac.v_ref_client_lead AS B ON A.client_id = B.client_id
          RIGHT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN A.dwh_valid_from AND A.dwh_valid_to
           WHERE A.client_id IS NULL
            AND A.country_iso_cd IS NULL
            AND (A.loc_sid_store IS NULL AND A.src_werks IS NULL)
            AND (A.src_orig_store_nr IS NULL AND A.src_store_id IS NULL AND (A.src_wh_id IS NULL AND (A.loc_name IS NULL
                  AND A.loc_name2 IS NULL)))
            AND (A.global_loc_id IS NULL AND A.country_pol_sid IS NULL AND (A.country_pol_cd IS NULL AND A.storetype_mark
                 IS NULL) AND (A.closing_dt IS NULL AND A.opening_dt IS NULL AND (A.real_opening_dt IS NULL AND (A.global_loc_type_cd
                    IS NULL AND A.addr_sid IS NULL))))
            AND (A.test_store_fg IS NULL AND A.deleted_fg IS NULL AND (A.dwh_valid_from IS NULL AND A.dwh_valid_to
                  IS NULL) AND (A.region_cd IS NULL AND A.mde_lang_cd IS NULL AND (A.qty_min_dflt IS NULL AND (A.dat_opening_ovis
                     IS NULL AND A.dat_closing_ovis IS NULL))) AND (A.dummy_store_fg IS NULL AND A.pseudo_store_fg
                  IS NULL AND (A.dwh_actual_fg IS NULL AND A.active_fg IS NULL) AND (A.active_future_fg IS NULL AND B.int_id
                   IS NULL AND (B.client_id IS NULL AND (B.country_iso_cd IS NULL AND B.country_group_id IS NULL)))))
            AND (B.lisy_sort IS NULL AND B.dashboard_relevant_fg IS NULL AND (B.country_desc_at IS NULL AND B.country_desc_be
                   IS NULL) AND (B.country_desc_be_fr IS NULL AND B.country_desc_bg IS NULL AND (B.country_desc_ch
                    IS NULL AND (B.country_desc_cy IS NULL AND B.country_desc_cz IS NULL))) AND (B.country_desc IS NULL
                   AND B.country_desc_dk IS NULL AND (B.country_desc_ee IS NULL AND B.country_desc_es IS NULL) AND (B.country_desc_fi
                    IS NULL AND B.country_desc_fr IS NULL AND (B.country_desc_gb IS NULL AND (B.country_desc_gr IS NULL
                       AND B.country_desc_hr IS NULL)))) AND (B.country_desc_hu IS NULL AND B.country_desc_ie IS NULL
                  AND (B.country_desc_it IS NULL AND B.country_desc_lt IS NULL) AND (B.country_desc_ni IS NULL AND B.country_desc_nl
                    IS NULL AND (B.country_desc_de IS NULL AND (B.country_desc_lv IS NULL AND B.country_desc_pl IS NULL
                      ))) AND (B.country_desc_pt IS NULL AND B.country_desc_ro IS NULL AND (B.country_desc_se IS NULL
                     AND (B.country_desc_si IS NULL AND B.country_desc_sk IS NULL)) AND (B.country_desc_cs IS NULL AND B
                     .country_desc_mt IS NULL AND (B.country_desc_us IS NULL AND (B.country_desc_rs IS NULL AND B.country_opening_date
                        IS NULL))))))) AS t0
        WHERE test_store_fg = 0
        GROUP BY client_id,
         loc_sid_store,
         src_orig_store_nr,
         loc_name,
         region_cd,
         mde_lang_cd,
         country_iso_cd,
         qty_min_dflt,
         opening_dt,
         closing_dt,
         real_opening_dt,
         dat_opening_ovis,
         cal_dt,
         dat_closing_ovis,
         open_store_fg,
         closed_store_fg,
         dwh_valid_from,
         dwh_valid_to
        ORDER BY dwh_valid_from NULLS LAST) AS t5
      GROUP BY client_id,
       loc_sid_store,
       src_orig_store_nr,
       loc_name,
       region_cd,
       mde_lang_cd,
       country_iso_cd,
       qty_min_dflt,
       opening_dt,
       closing_dt,
       real_opening_dt,
       dat_opening_ovis,
       dat_closing_ovis,
       open_store_fg,
       closed_store_fg,
       dwh_valid_from
      ORDER BY client_id NULLS LAST,
       loc_sid_store NULLS LAST,
       src_orig_store_nr NULLS LAST,
       loc_name NULLS LAST,
       region_cd NULLS LAST,
       mde_lang_cd NULLS LAST,
       country_iso_cd NULLS LAST,
       qty_min_dflt NULLS LAST,
       opening_dt NULLS LAST,
       closing_dt NULLS LAST,
       real_opening_dt NULLS LAST,
       dat_opening_ovis NULLS LAST,
       dat_closing_ovis NULLS LAST,
       open_store_fg NULLS LAST,
       closed_store_fg NULLS LAST,
       dwh_valid_from NULLS LAST) AS t1) AS t2
  GROUP BY client_id,
   loc_sid_store,
   src_orig_store_nr,
   loc_name,
   region_cd,
   mde_lang_cd,
   country_iso_cd,
   qty_min_dflt,
   opening_dt,
   closing_dt,
   real_opening_dt,
   dat_opening_ovis,
   dat_closing_ovis,
   open_store_fg,
   closed_store_fg,
   groupid) AS denorm
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS WH ON denorm.client_id = WH.client_id AND denorm.loc_sid_store
      = WH.loc_sid_store AND WH.active_fg = 1 AND WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge AS OSM ON denorm.client_id = OSM.client_id AND denorm.loc_sid_store = OSM
   .loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LHIST ON denorm.client_id = LHIST.client_id AND denorm.loc_sid_store =
    LHIST.loc_sid AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN LHIST.dwh_valid_from AND LHIST.dwh_valid_to
WHERE OSM.aspect_id = 1
GROUP BY denorm.client_id,
 WH.src_wh_id,
 denorm.loc_sid_store,
 denorm.src_orig_store_nr,
 denorm.open_store_fg,
 denorm.closed_store_fg,
 denorm.loc_name,
 denorm.region_cd,
 denorm.mde_lang_cd,
 denorm.country_iso_cd,
 denorm.qty_min_dflt,
 denorm.opening_dt,
 denorm.closing_dt,
 denorm.real_opening_dt,
 denorm.dat_opening_ovis,
 denorm.dat_closing_ovis,
 denorm.dat_valid_from,
 denorm.dat_valid_until,
 is_mon_open,
 is_tue_open,
 is_wed_open,
 is_thu_open,
 is_fri_open,
 is_sat_open,
 is_sun_open
ORDER BY denorm.client_id NULLS LAST,
 denorm.dat_valid_from NULLS LAST;

