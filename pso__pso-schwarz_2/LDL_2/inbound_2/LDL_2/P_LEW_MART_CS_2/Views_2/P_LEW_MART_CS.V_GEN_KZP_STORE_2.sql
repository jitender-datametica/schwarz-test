/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_KZP_STORE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021   Gunes Oguzhan                 Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1 04.06.2021    Gunes Oguzhan                 Normalize Convert for SNFLK
#  1.2 24.07.2023    Ulrich Ross                   remove mis_store_active_fg
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/506186
#  1.3 31.07.2023    Ulrich Ross                   Add opening flag per weekday
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/493379
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_KZP_STORE_2 AS
SELECT
     denorm.client_id
   , wh.src_wh_id
   , denorm.loc_sid_store
   , denorm.src_orig_store_nr
   , denorm.open_store_fg
   , denorm.closed_store_fg
   , denorm.loc_name
   , denorm.region_cd
   , denorm.mde_lang_cd
   , denorm.country_iso_cd
   , denorm.qty_min_dflt
   , denorm.opening_dt
   , denorm.closing_dt
   , denorm.real_opening_dt
   , denorm.dat_opening_ovis
   , denorm.dat_closing_ovis
   , denorm.dat_valid_from
   , denorm.dat_valid_until
   , IFF (lhist.mon_opening_tm IS NULL,0,1) AS is_mon_open
   , IFF (lhist.tue_opening_tm IS NULL,0,1) AS is_tue_open
   , IFF (lhist.wed_opening_tm IS NULL,0,1) AS is_wed_open
   , IFF (lhist.thu_opening_tm IS NULL,0,1) AS is_thu_open
   , IFF (lhist.fri_opening_tm IS NULL,0,1) AS is_fri_open
   , IFF (lhist.sat_opening_tm IS NULL,0,1) AS is_sat_open
   , IFF (lhist.sun_opening_tm IS NULL,0,1) AS is_sun_open
   
   , -1 AS dwh_load_id
   FROM (SELECT 
           client_id
          ,loc_sid_store
          ,src_orig_store_nr
          ,loc_name,region_cd
          ,mde_lang_cd
          ,country_iso_cd
          ,qty_min_dflt
          ,opening_dt
          ,closing_dt
          ,real_opening_dt
          ,dat_opening_ovis
          ,dat_closing_ovis
          ,open_store_fg
          ,closed_store_fg
          ,MIN(DWH_VALID_FROM) AS dat_VALID_FROM
          ,MAX(DWH_VALID_TO)   AS dat_VALID_until
       FROM
       ( 
          SELECT 
              t1.*
            , SUM(GroupStartFlag) OVER (PARTITION BY client_id,loc_sid_store,src_orig_store_nr,loc_name,region_cd,mde_lang_cd,country_iso_cd,qty_min_dflt
            , opening_dt,closing_dt,real_opening_dt,dat_opening_ovis,dat_closing_ovis,open_store_fg,closed_store_fg ORDER BY DWH_VALID_FROM ROWS UNBOUNDED PRECEDING) AS GroupID
          FROM
          (
            SELECT 
              client_id
              ,loc_sid_store
              ,src_orig_store_nr
              ,loc_name
              ,region_cd
              ,mde_lang_cd
              ,country_iso_cd
              ,qty_min_dflt
              ,opening_dt
              ,closing_dt
              ,real_opening_dt
              ,dat_opening_ovis
              ,dat_closing_ovis
              ,open_store_fg
              ,closed_store_fg
              ,DWH_VALID_FROM
              ,DWH_VALID_TO
              ,CASE WHEN (DWH_VALID_FROM-1<=LAG(DWH_VALID_TO) OVER (PARTITION BY client_id,loc_sid_store,src_orig_store_nr,loc_name,region_cd,mde_lang_cd,country_iso_cd,qty_min_dflt
                ,opening_dt,closing_dt,real_opening_dt,dat_opening_ovis,dat_closing_ovis,open_store_fg,closed_store_fg ORDER BY DWH_VALID_FROM)) THEN 0 ELSE 1 END                            AS GroupStartFlag
                 FROM  
                 (
                    SELECT 
                      client_id
                      ,loc_sid_store
                      ,src_orig_store_nr
                      ,loc_name
                      ,region_cd
                      ,mde_lang_cd
                      ,country_iso_cd
                      ,qty_min_dflt
                      ,opening_dt
                      ,closing_dt
                      ,real_opening_dt
                      ,dat_opening_ovis
                      ,dat_closing_ovis
                      ,open_store_fg
                      ,closed_store_fg
                      ,cal_dt             AS dwh_valid_from
                      ,MAX(cal_dt)        AS dwh_valid_to
                    FROM
                    (
                      SELECT
                           a.client_id
                         , a.loc_sid_store
                         , a.src_orig_store_nr
                         , a.loc_name
                         , a.region_cd
                         , a.mde_lang_cd
                         , b.country_iso_cd
                         , a.qty_min_dflt
                         , a.opening_dt
                         , a.closing_dt
                         , a.real_opening_dt
                         , a.dat_opening_ovis
                         , cal.cal_dt
                         , COALESCE(a.dat_closing_ovis, DATE'9999-12-31') AS dat_closing_ovis
                         , CASE WHEN (cal.cal_dt BETWEEN a.opening_dt AND a.dat_closing_ovis - 1) 
                                   OR (cal.cal_dt >= a.opening_dt AND a.dat_closing_ovis IS NULL)
                                THEN 1
                                ELSE 0
                              END AS open_store_fg
                         , CASE WHEN (cal.cal_dt BETWEEN a.opening_dt AND a.dat_closing_ovis - 1) 
                            OR (cal.cal_dt >= a.opening_dt AND a.dat_closing_ovis IS NULL)
                           THEN 0
                           ELSE 1
                           END AS closed_store_fg
                         ,(a.dwh_valid_from)      AS dwh_valid_from
                         ,(a.dwh_valid_to)+1      AS dwh_valid_to
                      FROM p_lew_bil_ac.v_store_2 a
                      INNER JOIN p_lew_bil_ac.v_ref_client_lead_2 b
                        ON (a.client_id = b.client_id)
                      FULL OUTER JOIN p_lew_core_ac.v_cal_calendarday_2 cal 
                        ON cal.cal_dt BETWEEN a.dwh_valid_from AND a.dwh_valid_to
                      WHERE a.test_store_fg = 0
                      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
                      ORDER BY a.dwh_valid_from
                    ) GROUP BY 
                        client_id
                        ,loc_sid_store
                        ,src_orig_store_nr
                        ,loc_name
                        ,region_cd
                        ,mde_lang_cd
                        ,country_iso_cd
                        ,qty_min_dflt
                        ,opening_dt
                        ,closing_dt
                        ,real_opening_dt
                        ,dat_opening_ovis
                        ,dat_closing_ovis
                        ,open_store_fg
                        ,closed_store_fg
                        ,cal_dt
                    ORDER BY 
                      client_id
                      ,loc_sid_store
                      ,src_orig_store_nr
                      ,loc_name,region_cd
                      ,mde_lang_cd
                      ,country_iso_cd,qty_min_dflt
                      ,opening_dt
                      ,closing_dt
                      ,real_opening_dt
                      ,dat_opening_ovis
                      ,dat_closing_ovis
                      ,open_store_fg
                      ,closed_store_fg
                      ,cal_dt)
          ) t1_2
        ) t2
    GROUP BY 
      client_id
      ,loc_sid_store
      ,src_orig_store_nr
      ,loc_name
      ,region_cd
      ,mde_lang_cd
      ,country_iso_cd
      ,qty_min_dflt
      ,opening_dt
      ,closing_dt
      ,real_opening_dt
      ,dat_opening_ovis
      ,dat_closing_ovis
      ,open_store_fg
      ,closed_store_fg
      ,GroupID
      ) denorm
    INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS wh
      ON denorm.client_id = wh.client_id
      AND denorm.loc_sid_store = wh.loc_sid_store
      AND wh.active_fg = 1
      AND wh.dwh_actual_fg = 1
    INNER JOIN p_lew_bil_ac.v_org_store_merge_2 AS osm
      ON  denorm.client_id = osm.client_id
      AND denorm.loc_sid_store = osm.loc_sid_store
    INNER JOIN p_lew_core_ac.v_location_hist_2  AS lhist
      ON denorm.client_id = lhist.client_id
      AND denorm.loc_sid_store = lhist.loc_sid
      AND CURRENT_DATE - 1 BETWEEN lhist.dwh_valid_from AND lhist.dwh_valid_to
    WHERE osm.aspect_id = 1

    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
    ORDER BY 
      client_id
      ,dat_valid_from
   ;