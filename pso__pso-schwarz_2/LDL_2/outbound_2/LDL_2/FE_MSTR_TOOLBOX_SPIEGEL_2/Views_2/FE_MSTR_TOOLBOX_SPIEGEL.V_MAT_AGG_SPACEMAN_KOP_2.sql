CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_spaceman_kop_2 AS WITH MAIN AS (SELECT DISTINCT SEC.int_org_sid
   ,
   STORE.client_id,
   ITEM.subitemgroup_id,
   SPIT.spaceman_item_sid,
   POSHIST.item_merchandising_type_cd,
   OM.metric_system_id,
   SPITHIST.src_case_size,
   POSHIST.case_orientation_cd,
   0.05 AS kolli_deviation_percent,
    CASE
    WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
    THEN 'Palette - DD'
    WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (133, 80), (SHELFHIST
         .shelf_width_meas, 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas)
       IN ((46, 48))
    THEN 'Palette - EP/GMA'
    WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas <= 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
        <= 24.40945
    THEN 'Regal - Mittel_Oberzug'
    WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas > 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
        > 24.40945
    THEN 'Regal - Podest'
    ELSE '0'
    END AS pbt_placing,
   COUNT(STORE.move_to_store_id) OVER (PARTITION BY CAST(SEC.int_org_sid AS STRING), CAST(STORE.client_id AS STRING), CAST(ITEM.subitemgroup_id AS STRING)
      , CAST(SPIT.spaceman_item_sid AS STRING), POSHIST.item_merchandising_type_cd, CAST(OM.metric_system_id AS STRING)
      , CAST(SPITHIST.src_case_size AS STRING), POSHIST.case_orientation_cd, CASE
       WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
       THEN 'Palette - DD'
       WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (133, 80)
           , (SHELFHIST.shelf_width_meas, 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas
           ) IN ((46, 48))
       THEN 'Palette - EP/GMA'
       WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas <= 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
           <= 24.40945
       THEN 'Regal - Mittel_Oberzug'
       WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas > 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
           > 24.40945
       THEN 'Regal - Podest'
       ELSE '0'
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_store,
    CASE
    WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end', 'end front'
       )
    THEN SPITHIST.case_width_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end', 'end side')
    THEN SPITHIST.case_depth_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end', 'end front'
       )
    THEN SPITHIST.item_width_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end', 'end side')
    THEN SPITHIST.item_depth_meas * OM.factor
    ELSE 0
    END AS kolli_breite,
    CASE
    WHEN SEC.int_org_sid <> 85 AND POSHIST.item_merchandising_type_cd = 'Case' AND (CASE
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.case_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.case_depth_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.item_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.item_depth_meas * OM.factor
               ELSE 0
               END BETWEEN 10 - 10 * 0.05 AND (10 + 10 * 0.05) OR CASE
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.case_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.case_depth_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.item_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.item_depth_meas * OM.factor
               ELSE 0
               END BETWEEN 15 - 15 * 0.05 AND (15 + 15 * 0.05) OR CASE
              WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                 'end front')
              THEN SPITHIST.case_width_meas * OM.factor
              WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                 'end side')
              THEN SPITHIST.case_depth_meas * OM.factor
              WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                 'end front')
              THEN SPITHIST.item_width_meas * OM.factor
              WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                 'end side')
              THEN SPITHIST.item_depth_meas * OM.factor
              ELSE 0
              END BETWEEN 20 - 20 * 0.05 AND (20 + 20 * 0.05) OR CASE
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.case_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.case_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.item_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.item_depth_meas * OM.factor
             ELSE 0
             END BETWEEN 30 - 30 * 0.05 AND (30 + 30 * 0.05) OR CASE
            WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
               'end front')
            THEN SPITHIST.case_width_meas * OM.factor
            WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
               'end side')
            THEN SPITHIST.case_depth_meas * OM.factor
            WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
               'end front')
            THEN SPITHIST.item_width_meas * OM.factor
            WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
               'end side')
            THEN SPITHIST.item_depth_meas * OM.factor
            ELSE 0
            END BETWEEN 40 - 40 * 0.05 AND (40 + 40 * 0.05) OR CASE
           WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
              'end front')
           THEN SPITHIST.case_width_meas * OM.factor
           WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
              'end side')
           THEN SPITHIST.case_depth_meas * OM.factor
           WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
              'end front')
           THEN SPITHIST.item_width_meas * OM.factor
           WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
              'end side')
           THEN SPITHIST.item_depth_meas * OM.factor
           ELSE 0
           END BETWEEN 60 - 60 * 0.05 AND (60 + 60 * 0.05)) OR SEC.int_org_sid = 85 AND POSHIST.item_merchandising_type_cd
          = 'Case' AND (CASE
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.case_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.case_depth_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.item_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.item_depth_meas * OM.factor
               ELSE 0
               END BETWEEN 3.93701 - 3.93701 * 0.05 AND (3.93701 + 3.93701 * 0.05) OR CASE
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.case_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.case_depth_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                  'end front')
               THEN SPITHIST.item_width_meas * OM.factor
               WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                  'end side')
               THEN SPITHIST.item_depth_meas * OM.factor
               ELSE 0
               END BETWEEN 5.90551 - 5.90551 * 0.05 AND (5.90551 + 5.90551 * 0.05) OR CASE
              WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                 'end front')
              THEN SPITHIST.case_width_meas * OM.factor
              WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                 'end side')
              THEN SPITHIST.case_depth_meas * OM.factor
              WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                 'end front')
              THEN SPITHIST.item_width_meas * OM.factor
              WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                 'end side')
              THEN SPITHIST.item_depth_meas * OM.factor
              ELSE 0
              END BETWEEN 7.87402 - 7.87402 * 0.05 AND (7.87402 + 7.87402 * 0.05) OR CASE
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.case_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.case_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.item_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.item_depth_meas * OM.factor
             ELSE 0
             END BETWEEN 11.811 - 11.811 * 0.05 AND (11.811 + 11.811 * 0.05) OR CASE
            WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
               'end front')
            THEN SPITHIST.case_width_meas * OM.factor
            WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
               'end side')
            THEN SPITHIST.case_depth_meas * OM.factor
            WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
               'end front')
            THEN SPITHIST.item_width_meas * OM.factor
            WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
               'end side')
            THEN SPITHIST.item_depth_meas * OM.factor
            ELSE 0
            END BETWEEN 15.748 - 15.748 * 0.05 AND (15.748 + 15.748 * 0.05) OR CASE
           WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
              'end front')
           THEN SPITHIST.case_width_meas * OM.factor
           WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
              'end side')
           THEN SPITHIST.case_depth_meas * OM.factor
           WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
              'end front')
           THEN SPITHIST.item_width_meas * OM.factor
           WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
              'end side')
           THEN SPITHIST.item_depth_meas * OM.factor
           ELSE 0
           END BETWEEN 23.622 - 23.622 * 0.05 AND (23.622 + 23.622 * 0.05)) OR POSHIST.item_merchandising_type_cd =
      'Hand'
    THEN 1
    ELSE 0
    END AS target_kolli_breite,
    CASE
    WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end', 'end front'
       )
    THEN SPITHIST.case_depth_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end', 'end side')
    THEN SPITHIST.case_width_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end', 'end front'
       )
    THEN SPITHIST.item_depth_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end', 'end side')
    THEN SPITHIST.item_width_meas * OM.factor
    ELSE 0
    END AS kolli_tiefe,
    CASE
    WHEN SEC.int_org_sid <> 85 AND POSHIST.item_merchandising_type_cd = 'Case' AND CASE
            WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
            THEN 'Palette - DD'
            WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (133
                 , 80), (SHELFHIST.shelf_width_meas, 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas,
                SHELFHIST.shelf_depth_meas) IN ((46, 48))
            THEN 'Palette - EP/GMA'
            WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas <= 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
                <= 24.40945
            THEN 'Regal - Mittel_Oberzug'
            WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas > 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
                > 24.40945
            THEN 'Regal - Podest'
            ELSE '0'
            END = 'Regal - Mittel_Oberzug' AND (CASE
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.case_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.case_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.item_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.item_width_meas * OM.factor
             ELSE 0
             END BETWEEN 20 - 20 * 0.05 AND 20 OR CASE
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.case_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.case_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.item_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.item_width_meas * OM.factor
             ELSE 0
             END BETWEEN 30 - 30 * 0.05 AND 30) OR SEC.int_org_sid = 85 AND POSHIST.item_merchandising_type_cd = 'Case'
          AND CASE
            WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
            THEN 'Palette - DD'
            WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (133
                 , 80), (SHELFHIST.shelf_width_meas, 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas,
                SHELFHIST.shelf_depth_meas) IN ((46, 48))
            THEN 'Palette - EP/GMA'
            WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas <= 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
                <= 24.40945
            THEN 'Regal - Mittel_Oberzug'
            WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas > 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
                > 24.40945
            THEN 'Regal - Podest'
            ELSE '0'
            END = 'Regal - Mittel_Oberzug' AND (CASE
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.case_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.case_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.item_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.item_width_meas * OM.factor
             ELSE 0
             END BETWEEN 7.87402 - 7.87402 * 0.05 AND 7.87402 OR CASE
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.case_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.case_width_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
                'end front')
             THEN SPITHIST.item_depth_meas * OM.factor
             WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
                'end side')
             THEN SPITHIST.item_width_meas * OM.factor
             ELSE 0
             END BETWEEN 11.811 - 11.811 * 0.05 AND 11.811) OR SEC.int_org_sid <> 85 AND POSHIST.item_merchandising_type_cd
            = 'Case' AND CASE
           WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
           THEN 'Palette - DD'
           WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (133,
                80), (SHELFHIST.shelf_width_meas, 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas,
               SHELFHIST.shelf_depth_meas) IN ((46, 48))
           THEN 'Palette - EP/GMA'
           WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas <= 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
               <= 24.40945
           THEN 'Regal - Mittel_Oberzug'
           WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas > 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
               > 24.40945
           THEN 'Regal - Podest'
           ELSE '0'
           END = 'Regal - Podest' AND CASE
          WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
             'end front')
          THEN SPITHIST.case_depth_meas * OM.factor
          WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
             'end side')
          THEN SPITHIST.case_width_meas * OM.factor
          WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
             'end front')
          THEN SPITHIST.item_depth_meas * OM.factor
          WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
             'end side')
          THEN SPITHIST.item_width_meas * OM.factor
          ELSE 0
          END BETWEEN 40 - 40 * 0.05 AND 40 OR SEC.int_org_sid = 85 AND POSHIST.item_merchandising_type_cd = 'Case' AND
          CASE
          WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
          THEN 'Palette - DD'
          WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (133,
               80), (SHELFHIST.shelf_width_meas, 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas,
              SHELFHIST.shelf_depth_meas) IN ((46, 48))
          THEN 'Palette - EP/GMA'
          WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas <= 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
              <= 24.40945
          THEN 'Regal - Mittel_Oberzug'
          WHEN SEC.int_org_sid <> 85 AND SHELFHIST.shelf_depth_meas > 62 OR SEC.int_org_sid = 85 AND SHELFHIST.shelf_depth_meas
              > 24.40945
          THEN 'Regal - Podest'
          ELSE '0'
          END = 'Regal - Podest' AND CASE
         WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
            'end front')
         THEN SPITHIST.case_depth_meas * OM.factor
         WHEN POSHIST.item_merchandising_type_cd = 'Case' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
            'end side')
         THEN SPITHIST.case_width_meas * OM.factor
         WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('front end',
            'end front')
         THEN SPITHIST.item_depth_meas * OM.factor
         WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND LOWER(POSHIST.case_orientation_cd) IN ('side end',
            'end side')
         THEN SPITHIST.item_width_meas * OM.factor
         ELSE 0
         END BETWEEN 15.748 - 15.748 * 0.05 AND 15.748 OR POSHIST.item_merchandising_type_cd = 'Hand'
    THEN 1
    ELSE 0
    END AS target_kolli_tiefe,
    CASE
    WHEN POSHIST.item_merchandising_type_cd = 'Case'
    THEN SPITHIST.case_high_meas * OM.factor
    WHEN POSHIST.item_merchandising_type_cd = 'Hand'
    THEN SPITHIST.item_hight_meas * OM.factor
    ELSE NULL
    END AS act_height,
    SPITHIST.case_weight_kg_qty * OM.factor_weight AS case_weight_kg_qty,
   SPITHIST.case_orientation_front_end_fg,
   SPITHIST.case_orientation_side_end_fg /* METRIC PRODUKTANSICHT AKTUELL */,
   SPITHIST.case_item_orientation_txt
   /* METRIC Show the ID of shelves on which the article is placed and has CASES = 1 */,
    CASE
    WHEN POSHIST.total_case_qty = 1
    THEN STRING_AGG(SHELF.src_section_nr, ', ') OVER (PARTITION BY CAST(SPIT.spaceman_item_sid AS STRING), CAST(POSHIST.total_case_qty AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    ELSE NULL
    END AS shelf_id_qty,
    CASE
    WHEN POSHIST.total_case_qty = 1
    THEN COUNT(SHELF.src_section_nr) OVER (PARTITION BY CAST(SPIT.spaceman_item_sid AS STRING), CAST(POSHIST.total_case_qty AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    ELSE NULL
    END AS shelf_id_amnt
  FROM ldl_p_lew_core_ac.v_spaceman_section_2 AS SEC
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_hist_2 AS SECHIST ON SEC.spaceman_section_sid = SECHIST.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_2 AS SHELF ON SEC.spaceman_section_sid = SHELF.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_hist_2 AS SHELFHIST ON SHELF.shelf_sid = SHELFHIST.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_2 AS POS ON SHELF.shelf_sid = POS.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_hist_2 AS POSHIST ON POS.shelf_position_sid = POSHIST.shelf_position_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_2 AS SPIT ON POSHIST.spaceman_item_sid = SPIT.spaceman_item_sid
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_item_spaceman_item_2 AS ISI ON SPIT.spaceman_item_sid = ISI.spaceman_item_sid
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_2 AS ITEM_2 ON ISI.client_id = ITEM.client_id AND ISI.item_sid = ITEM.item_id
     
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_hist_2 AS SPITHIST ON SPIT.spaceman_item_sid = SPITHIST.spaceman_item_sid
    /* CLIENT_ID/STORE */
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_2 AS SECSTORE ON SEC.spaceman_section_sid = SECSTORE.spaceman_section_sid
    
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_vges_2 AS STORE ON SECSTORE.loc_sid_store = STORE.store_id
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_aisle_2 AS SSA ON SECSTORE.spaceman_section_sid = SSA.spaceman_section_sid
      AND STORE.move_to_store_id = SSA.move_to_store_id /* CM/IN */
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_2 AS OM ON SEC.int_org_sid = OM.int_org_sid
  WHERE CURRENT_DATE BETWEEN SECHIST.dwh_valid_from AND SECHIST.dwh_valid_to
   AND SECHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SHELFHIST.dwh_valid_from AND SHELFHIST.dwh_valid_to
   AND SHELFHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN POSHIST.dwh_valid_from AND POSHIST.dwh_valid_to
   AND POSHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SPITHIST.dwh_valid_from AND SPITHIST.dwh_valid_to
   AND SPITHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SPIT.active_from_dt AND SPIT.active_to_dt
   AND LOWER(POSHIST.item_merchandising_type_cd) IN ('case', 'hand')), SEC_ITM_HGHT AS (SELECT DISTINCT SEC0.spaceman_section_sid
   ,
   SEC0.int_org_sid,
   POSHIST0.item_merchandising_type_cd,
   POSHIST0.case_orientation_cd,
   OM0.metric_system_id,
   SPIT0.spaceman_item_sid /* PBT PLACING LOGIC IMPLEMENTATION: */,
    CASE
    WHEN (SHELFHIST0.shelf_width_meas, SHELFHIST0.shelf_depth_meas) IN ((60, 80), (80, 60))
    THEN 'Palette - DD'
    WHEN SEC0.int_org_sid <> 85 AND (SHELFHIST0.shelf_width_meas, SHELFHIST0.shelf_depth_meas) IN ((120, 80), (SHELFHIST0
         .shelf_width_meas, 120)) OR SEC0.int_org_sid = 85 AND (SHELFHIST0.shelf_width_meas, SHELFHIST0.shelf_depth_meas
        ) IN ((46, 48))
    THEN 'Palette - EP/GMA'
    WHEN SEC0.int_org_sid <> 85 AND SHELFHIST0.shelf_depth_meas <= 62 OR SEC0.int_org_sid = 85 AND SHELFHIST0.shelf_depth_meas
        <= 24.40945
    THEN 'Regal - Mittel_Oberzug'
    WHEN SEC0.int_org_sid <> 85 AND SHELFHIST0.shelf_depth_meas > 62 OR SEC0.int_org_sid = 85 AND SHELFHIST0.shelf_depth_meas
        > 24.40945
    THEN 'Regal - Podest'
    ELSE '0'
    END AS pbt_placing,
    CASE
    WHEN POSHIST0.item_merchandising_type_cd = 'Case'
    THEN SPITHIST0.case_high_meas * OM0.factor
    WHEN POSHIST0.item_merchandising_type_cd = 'Hand'
    THEN SPITHIST0.item_hight_meas * OM0.factor
    ELSE 0
    END AS act_height
  FROM ldl_p_lew_core_ac.v_spaceman_section_2 AS SEC0
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_hist_2 AS SECHIST0 ON SEC0.spaceman_section_sid = SECHIST0.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_2 AS SHELF0 ON SEC0.spaceman_section_sid = SHELF0.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_hist_2 AS SHELFHIST0 ON SHELF0.shelf_sid = SHELFHIST0.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_2 AS POS0 ON SHELF0.shelf_sid = POS0.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_hist_2 AS POSHIST0 ON POS0.shelf_position_sid = POSHIST0.shelf_position_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_2 AS SPIT0 ON POSHIST0.spaceman_item_sid = SPIT0.spaceman_item_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_hist_2 AS SPITHIST0 ON SPIT0.spaceman_item_sid = SPITHIST0.spaceman_item_sid
    
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_2 AS OM0 ON SEC0.int_org_sid = OM0.int_org_sid
  WHERE CURRENT_DATE BETWEEN SECHIST0.dwh_valid_from AND SECHIST0.dwh_valid_to
   AND SECHIST0.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SHELFHIST0.dwh_valid_from AND SHELFHIST0.dwh_valid_to
   AND SHELFHIST0.deleted_fg = 0
   AND CURRENT_DATE BETWEEN POSHIST0.dwh_valid_from AND POSHIST0.dwh_valid_to
   AND POSHIST0.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SPITHIST0.dwh_valid_from AND SPITHIST0.dwh_valid_to
   AND SPITHIST0.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SPIT0.active_from_dt AND SPIT0.active_to_dt
   AND LOWER(POSHIST0.item_merchandising_type_cd) IN ('case', 'hand')), SEC_ITM_HGHT_AGG AS (SELECT spaceman_section_sid
   ,
   spaceman_item_sid,
   item_merchandising_type_cd,
   case_orientation_cd,
   pbt_placing,
   metric_system_id,
   SUM(act_height) OVER (PARTITION BY CAST(spaceman_section_sid AS STRING), item_merchandising_type_cd,
      case_orientation_cd, pbt_placing, CAST(metric_system_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS sum_height_lvl,
   COUNT(spaceman_item_sid) OVER (PARTITION BY CAST(spaceman_section_sid AS STRING), item_merchandising_type_cd,
      case_orientation_cd, pbt_placing, CAST(metric_system_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS cnt_items_lvl
  FROM SEC_ITM_HGHT AS t5), ITM_HGHT_AGG AS (SELECT spaceman_item_sid,
   item_merchandising_type_cd,
   case_orientation_cd,
   pbt_placing,
   metric_system_id,
   SUM(sum_height_lvl) AS itm_agg_height,
   SUM(cnt_items_lvl) AS itm_agg_cnt,
    SUM(sum_height_lvl) / SUM(cnt_items_lvl) AS avg_height
  FROM SEC_ITM_HGHT_AGG
  GROUP BY spaceman_item_sid,
   item_merchandising_type_cd,
   case_orientation_cd,
   pbt_placing,
   metric_system_id) (/* GETTING ACT_HEIGHT on ITEM_2/SECTION/ORIENTATION/MERCH_METHOD/PLACING/METRIC_ID LEVEL */
  /* METRIC KOLLI-HÖHE IN CM (IST), DURCHSCHNITTLICHE KOLLI-HÖHE */
  /* AGGREGATING THE HEIGHT AND ITEM_2 COUNT ON SECTION/ORIENTATION/MERCH_METHOD/PLACING/METRIC_ID LEVEL */
  /* AGGREGATING THE AGGREGATED HEIGHT AND ITEM_2 COUNT ON ITEM_2/ORIENTATION/MERCH_METHOD/PLACING/METRIC_ID LEVEL */
  /* DEVIATION PERCENTAGE FOR TARGET_KOLLI_BREITE AND TARGET_KOLLI_TIEFE = 5% */ /* PBT PLACING LOGIC: */
  /* COUNT STORES */ /* METRIC KOLLI_BREITE IN CM (IST) */ /* METRIC KOLLI_BREITE IN CM (SOLL) BZW. ABWEICHUNG */
  /* METRIC KOLLI_TIEFE IN CM (IST) */ /* METRIC KOLLI_TIEFE IN CM (SOLL) BZW. ABWEICHUNG */
  /* METRIC KOLLI-HÖHE IN CM (IST), DURCHSCHNITTLICHE KOLLI-HÖHE */ /* METRIC KOLLI-GEWICHT */
  /* HOW CAN THE ARTICLE BE PLACED (SIDE END VS. FRONT END) */
  /* METRIC amount shelves on which the article is placed and has CASES = 1 */ SELECT M.int_org_sid,
   M.client_id,
   M.subitemgroup_id,
   M.spaceman_item_sid,
   M.item_merchandising_type_cd,
   M.metric_system_id,
   M.src_case_size,
   M.case_orientation_cd,
   M.kolli_deviation_percent,
   M.pbt_placing,
   M.cnt_store,
   M.kolli_breite,
   M.target_kolli_breite,
   M.kolli_tiefe,
   M.target_kolli_tiefe,
   M.act_height,
   IHA.itm_agg_height,
   IHA.itm_agg_cnt,
   IHA.avg_height,
   M.case_weight_kg_qty,
   M.case_orientation_front_end_fg,
   M.case_orientation_side_end_fg,
   M.case_item_orientation_txt,
   M.shelf_id_qty,
   M.shelf_id_amnt
  FROM MAIN AS M
   INNER JOIN ITM_HGHT_AGG AS IHA ON M.spaceman_item_sid = IHA.spaceman_item_sid AND M.item_merchandising_type_cd = IHA
        .item_merchandising_type_cd AND M.case_orientation_cd = IHA.case_orientation_cd AND M.pbt_placing = IHA.pbt_placing
       AND M.metric_system_id = IHA.metric_system_id);