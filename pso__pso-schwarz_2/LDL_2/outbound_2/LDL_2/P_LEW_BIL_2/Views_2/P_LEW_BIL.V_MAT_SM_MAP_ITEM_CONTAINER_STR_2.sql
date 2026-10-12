/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_SM_MAP_ITEM_CONTAINER_STR_2
#----------------------------------------------------------------------------
# History:
#  1.0  10.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#  1.1  17.03.2022    Bachmann, Torsten        Distribute assignment of orig_item_nr to all item_sid
#  1.2  29.03.2022    Bachmann, Torsten        deleted rows not marked as expected. So, implemented logic to filter those not delivered rows
#  1.3  30.03.2022    Białek, Aleksander       adding order by clause to ensure proper micro-partitions structure
#  1.4  31.05.2022    Bachmann, Torsten        INC4749429: exclude outdated/deleted Container-Store-Assignments (like Container-Item_2)
#  1.5  13.06.2022    Bachmann, Torsten        INC4810802: exclude overlapping Container-Store-Assignments periods
#  1.6  24.10.2023    Lysik, Martin            #541275: additional IN-filter for sids to lower data amount in a CROSS JOIN
#  1.7  31.01.2024    Lysik, Martin            #578705: recommended adjusments to keep the runtime consistent
#----------------------------------------------------------------------------
*/


/* if we have an overlap we use the most recent data based on load_id */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_sm_map_item_container_str_2 (client_id OPTIONS(description='Landeskennzeichen'),
item_sid OPTIONS(description='Artikelnummer'), loc_sid_wh
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)'), wh_id
OPTIONS(description='WH ID from source (WAWI)'), container_id OPTIONS(description='Surrogate Key container'),
move_to_store_id OPTIONS(description='Store-Nr'), aspect_id OPTIONS(description='only 1= BGES'), dat_rec_start
OPTIONS(description='Gültigkeitsdatum von'), dat_rec_end OPTIONS(description='Gültigkeitsdatum bis')) AS WITH SIDS AS (SELECT
   client_id,
   item_sid,
   orig_item_nr,
   dat_valid_from
  FROM (SELECT client_id,
     item_sid,
     ROUND(SAFE_CAST(COALESCE(src_orig_item_nr, config_item_cd, src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
     COALESCE(src_dat_valid_from, DATE '9999-12-31') AS dat_valid_from,
     CAST((RAND() - 0.5) * POWER(10, 18) AS INTEGER)
    FROM ldl_p_lew_core_ac.v_item_2
    ORDER BY CAST((RAND() - 0.5) * POWER(10, 18) AS INTEGER) NULLS LAST) AS t0), BASE_WACI AS (SELECT client_id,
   item_sid,
   loc_sid_wh,
   assortment_container_sid,
   active_from_dt,
   active_to_dt,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core_ac.v_warehouse_assortment_container_item_2
  WHERE deleted_fg = 0
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
    /* row has to be updated in the last 7 days depending on the last dwh_updated per WH */
  QUALIFY dwh_updated > DATETIME_ADD((MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_wh AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), INTERVAL - 7 DAY)), WH_CONT_ITEM AS (SELECT t5
   .client_id,
   t5.item_sid,
   t5.loc_sid_wh,
    CASE
    WHEN t9.client_id IS NULL OR t5.dwh_updated >= t9.dwh_updated
    THEN t5.assortment_container_sid
    ELSE t9.assortment_container_sid
    END AS assortment_container_sid,
    CASE
    WHEN t9.client_id IS NULL OR t5.dwh_updated >= t9.dwh_updated
    THEN t5.active_from_dt
    ELSE t9.active_from_dt
    END AS active_from_dt,
    CASE
    WHEN t9.client_id IS NULL OR t5.dwh_updated >= t9.dwh_updated
    THEN t5.active_to_dt
    ELSE t9.active_to_dt
    END AS active_to_dt,
    CASE
    WHEN t9.client_id IS NULL OR t5.dwh_updated >= t9.dwh_updated
    THEN t5.deleted_fg
    ELSE t9.deleted_fg
    END AS deleted_fg,
    CASE
    WHEN t9.client_id IS NULL OR t5.dwh_updated >= t9.dwh_updated
    THEN t5.dwh_valid_from
    ELSE t9.dwh_valid_from
    END AS dwh_valid_from,
    CASE
    WHEN t9.client_id IS NULL OR t5.dwh_updated >= t9.dwh_updated
    THEN t5.dwh_valid_to
    ELSE t9.dwh_valid_to
    END AS dwh_valid_to
  FROM BASE_WACI AS t5
   LEFT JOIN BASE_WACI AS t9 ON t5.client_id = t9.client_id AND t5.item_sid = t9.item_sid AND t5.loc_sid_wh = t9.loc_sid_wh
        AND (t5.active_from_dt > t9.active_from_dt AND (t5.active_from_dt < t9.active_to_dt OR t5.active_to_dt < t9.active_to_dt
            ) OR t5.active_from_dt < t9.active_from_dt AND (t5.active_to_dt > t9.active_from_dt OR t5.active_to_dt > t9
            .active_to_dt) OR t5.active_from_dt = t9.active_from_dt AND (t5.active_to_dt = t9.active_to_dt OR t5.active_to_dt
            <> t9.active_to_dt)) AND (t5.assortment_container_sid <> t9.assortment_container_sid
       /* either container assignment differs */ OR t5.active_from_dt <> t9.active_from_dt)
  GROUP BY t5.client_id,
   t5.item_sid,
   t5.loc_sid_wh,
   assortment_container_sid,
   active_from_dt,
   active_to_dt,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to), CONT_ITEM AS (SELECT si.client_id,
   si.item_sid,
   coin.loc_sid_wh,
   coin.assortment_container_sid,
   coin.active_from_dt,
   coin.active_to_dt
  FROM SIDS AS si
   INNER JOIN (SELECT mic.client_id,
     s.orig_item_nr,
     s.dat_valid_from,
     mic.loc_sid_wh,
     mic.assortment_container_sid,
     mic.active_from_dt,
     MIN(mic.active_to_dt) AS active_to_dt
    FROM WH_CONT_ITEM AS mic
     INNER JOIN (SELECT client_id,
       item_sid,
       orig_item_nr,
       dat_valid_from
      FROM SIDS) AS s ON mic.client_id = s.client_id AND mic.item_sid = s.item_sid
       /* use/filter the container assignment of the most recent item_sid according to item_2 mapping 
       * This should be the most actual one */
       
     INNER JOIN ldl_p_lew_precore_ac.v_item_map_key_oin_wh_hist_2 AS OINH ON mic.client_id = OINH.client_id AND mic.loc_sid_wh
          = OINH.loc_sid_wh AND mic.item_sid = OINH.item_sid AND CURRENT_DATE BETWEEN OINH.dwh_valid_from AND OINH.dwh_valid_to
       
    GROUP BY mic.client_id,
     mic.loc_sid_wh,
     mic.assortment_container_sid,
     mic.active_from_dt,
     s.orig_item_nr,
     s.dat_valid_from) AS coin ON si.client_id = coin.client_id AND si.orig_item_nr = coin.orig_item_nr AND si.dat_valid_from
      = coin.dat_valid_from), BASE_ACS AS (SELECT client_id,
   assortment_container_sid,
   loc_sid_store,
   active_from_dt,
   active_to_dt,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core_ac.v_assortment_container_store_2
  WHERE deleted_fg = 0
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  QUALIFY dwh_updated > DATETIME_ADD((MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), INTERVAL - 7 DAY)), CONT_STR AS (SELECT t38.client_id
   ,
   t38.assortment_container_sid,
   t38.loc_sid_store,
   t38.active_from_dt,
   LEAST(t38.active_to_dt, LEAD(DATE_SUB(t38.active_from_dt, INTERVAL 1 DAY), 1, t38.active_to_dt) OVER (PARTITION BY CAST(t38.client_id AS STRING)
       , CAST(t38.assortment_container_sid AS STRING), CAST(t38.loc_sid_store AS STRING) ORDER BY t38.active_from_dt
       IS NULL, t38.active_from_dt, t38.active_to_dt IS NULL, t38.active_to_dt)) AS active_to_dt,
   t38.deleted_fg,
   t38.dwh_valid_from,
   t38.dwh_valid_to
  FROM (SELECT t32.client_id,
     t32.assortment_container_sid,
     t32.loc_sid_store,
      CASE
      WHEN t36.client_id IS NULL OR t32.dwh_updated >= t36.dwh_updated
      THEN t32.active_from_dt
      ELSE t36.active_from_dt
      END AS active_from_dt,
      CASE
      WHEN t36.client_id IS NULL OR t32.dwh_updated >= t36.dwh_updated
      THEN t32.active_to_dt
      ELSE t36.active_to_dt
      END AS active_to_dt,
      CASE
      WHEN t36.client_id IS NULL OR t32.dwh_updated >= t36.dwh_updated
      THEN t32.deleted_fg
      ELSE t36.deleted_fg
      END AS deleted_fg,
      CASE
      WHEN t36.client_id IS NULL OR t32.dwh_updated >= t36.dwh_updated
      THEN t32.dwh_valid_from
      ELSE t36.dwh_valid_from
      END AS dwh_valid_from,
      CASE
      WHEN t36.client_id IS NULL OR t32.dwh_updated >= t36.dwh_updated
      THEN t32.dwh_valid_to
      ELSE t36.dwh_valid_to
      END AS dwh_valid_to
    FROM BASE_ACS AS t32
     LEFT JOIN BASE_ACS AS t36 ON t32.client_id = t36.client_id AND t32.loc_sid_store = t36.loc_sid_store AND t32.assortment_container_sid
          = t36.assortment_container_sid AND (t32.active_from_dt > t36.active_from_dt AND (t32.active_from_dt < t36.active_to_dt
               OR t32.active_to_dt < t36.active_to_dt) OR t32.active_from_dt < t36.active_from_dt AND (t32.active_to_dt
              > t36.active_from_dt OR t32.active_to_dt > t36.active_to_dt) OR t32.active_from_dt = t36.active_from_dt
          AND (t32.active_to_dt = t36.active_to_dt OR t32.active_to_dt <> t36.active_to_dt)) AND t32.active_from_dt <>
       t36.active_from_dt
    GROUP BY t32.client_id,
     t32.assortment_container_sid,
     t32.loc_sid_store,
     active_from_dt,
     active_to_dt,
     deleted_fg,
     dwh_valid_from,
     dwh_valid_to) AS t38
  QUALIFY t38.active_from_dt <= LEAST(t38.active_to_dt, LEAD(DATE_SUB(t38.active_from_dt, INTERVAL 1 DAY), 1, t38.active_to_dt
      ) OVER (PARTITION BY CAST(t38.client_id AS STRING), CAST(t38.assortment_container_sid AS STRING), CAST(t38.loc_sid_store AS STRING)
        ORDER BY t38.active_from_dt IS NULL, t38.active_from_dt, t38.active_to_dt IS NULL, t38.active_to_dt))), MAT AS (SELECT
   mic.client_id,
   mic.item_sid,
   mic.loc_sid_wh,
   BIL_WH.src_wh_id AS wh_id,
   mic.assortment_container_sid AS container_id,
   STR.move_to_st_loc_sid AS move_to_store_id,
   STR.aspect_id,
   GREATEST(mic.active_from_dt, sca.active_from_dt) AS dat_rec_start,
   LEAST(mic.active_to_dt, sca.active_to_dt) AS dat_rec_end
  FROM CONT_ITEM AS mic
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS BIL_WH ON mic.client_id = BIL_WH.client_id AND mic.loc_sid_wh = BIL_WH.loc_sid_wh
       AND BIL_WH.dwh_actual_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS STR ON mic.client_id = STR.client_id AND mic.loc_sid_wh
       = STR.wh_loc_sid AND STR.aspect_id = 1 /* limit to BGES hierarchy_2 */
   INNER JOIN CONT_STR AS sca ON STR.client_id = sca.client_id AND STR.move_to_st_loc_sid = sca.loc_sid_store AND mic.assortment_container_sid
         = sca.assortment_container_sid /* only use most recent one */ AND CURRENT_DATE BETWEEN sca.dwh_valid_from AND
       sca.dwh_valid_to AND sca.deleted_fg = 0 AND (mic.active_from_dt > sca.active_from_dt AND (mic.active_from_dt <
           sca.active_to_dt OR mic.active_to_dt < sca.active_to_dt) OR mic.active_from_dt < sca.active_from_dt AND (mic
           .active_to_dt > sca.active_from_dt OR mic.active_to_dt > sca.active_to_dt) OR mic.active_from_dt = sca.active_from_dt
         AND (mic.active_to_dt = sca.active_to_dt OR mic.active_to_dt <> sca.active_to_dt))
  WHERE GREATEST(mic.active_from_dt, sca.active_from_dt) <= LEAST(mic.active_to_dt, sca.active_to_dt)) (/* this is NOT a validity_2 date, but is part of the key of oin */
  /* Recommended adjusment to keep the runtime in good boundaries */
  /* This part is needed because we don't have a clear flag in CORE data, if a row was deleted in Source System (not delivered anymore) */
  /* similar logic as OVERLAPS */ /* or time period differs */
  /* we do NOT CROSS JOIN on assortment_container_sid, because that can differ. Important is that one item_2 can only be assigned to one container at a time per warehouse */
  /* similar logic as OVERLAPS */ /* or time period differs */ /* Get WH_ID for loc_sid_wh */
  /* similar logic as OVERLAPS */ /* filling gaps between two rows */ /* add row from '1900-01-01' till first entry */
  /* add rows after last entry till '2200-01-01' */ /* add all missing store, item_2 combination */
  /* Recommended adjusment to keep the runtime in good boundaries */ SELECT client_id,
   item_sid,
   loc_sid_wh,
   wh_id,
   container_id,
   move_to_store_id,
   aspect_id,
   dat_rec_start,
   dat_rec_end
  FROM (SELECT client_id,
      item_sid,
      loc_sid_wh,
      wh_id,
      container_id,
      move_to_store_id,
      aspect_id,
      dat_rec_start,
      dat_rec_end
     FROM MAT
     UNION ALL
     SELECT client_id,
      item_sid,
      loc_sid_wh,
      wh_id,
      - 99 AS container_id,
      move_to_store_id,
      aspect_id,
      DATE_ADD(dat_rec_end, INTERVAL 1 DAY) AS dat_rec_start_gap,
      DATE_SUB(LEAD(dat_rec_start, 1, DATE '2200-01-01') OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
          , CAST(move_to_store_id AS STRING) ORDER BY dat_rec_start IS NULL, dat_rec_start), INTERVAL 1 DAY) AS
      dat_rec_end_gap
     FROM MAT
     QUALIFY DATE_DIFF((LEAD(dat_rec_start, 1, dat_rec_end) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
            , CAST(move_to_store_id AS STRING) ORDER BY dat_rec_start IS NULL, dat_rec_start)), dat_rec_end, DAY) > 1
     UNION ALL
     SELECT client_id,
      item_sid,
      loc_sid_wh,
      wh_id,
      - 99 AS container_id,
      move_to_store_id,
      aspect_id,
      DATE '1900-01-01' AS dat_rec_start,
      DATE_SUB(first_dat_rec_start, INTERVAL 1 DAY) AS dat_rec_end
     FROM (SELECT client_id,
        item_sid,
        loc_sid_wh,
        wh_id,
        move_to_store_id,
        aspect_id,
        MIN(dat_rec_start) AS first_dat_rec_start
       FROM MAT
       GROUP BY client_id,
        item_sid,
        loc_sid_wh,
        wh_id,
        move_to_store_id,
        aspect_id
       HAVING first_dat_rec_start > DATE '1900-01-01') AS t139
     UNION ALL
     SELECT client_id,
      item_sid,
      loc_sid_wh,
      wh_id,
      - 99 AS container_id,
      move_to_store_id,
      aspect_id,
      DATE_ADD(last_dat_rec_end, INTERVAL 1 DAY) AS dat_rec_start,
      DATE '2200-01-01' AS dat_rec_end
     FROM (SELECT client_id,
        item_sid,
        loc_sid_wh,
        wh_id,
        move_to_store_id,
        aspect_id,
        MAX(dat_rec_end) AS last_dat_rec_end
       FROM MAT
       GROUP BY client_id,
        item_sid,
        loc_sid_wh,
        wh_id,
        move_to_store_id,
        aspect_id
       HAVING last_dat_rec_end < DATE '2200-01-01') AS t187
     UNION ALL
     SELECT S.client_id,
      i.item_sid,
      BIL_WH.loc_sid_wh,
      BIL_WH.src_wh_id AS wh_id,
      - 99 AS container_id,
      S.move_to_st_loc_sid AS move_to_store_id,
      S.aspect_id,
      DATE '1900-01-01' AS dat_rec_start,
      DATE '2200-01-01' AS dat_rec_end
     FROM ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS S
      INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS BIL_WH ON S.client_id = BIL_WH.client_id AND S.wh_loc_sid = BIL_WH.loc_sid_wh
           AND BIL_WH.dwh_actual_fg = 1 AND S.aspect_id = 1 /* limit to BGES hierarchy_2 */
      INNER JOIN (SELECT client_id,
        item_sid,
        src_matnr,
        src_orig_item_nr,
        src_dat_valid_from,
        src_case_size,
        item_sid_config,
        item_name,
        log_var_cd,
        config_item_cd,
        item_eks_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated
       FROM (SELECT client_id,
          item_sid,
          src_matnr,
          src_orig_item_nr,
          src_dat_valid_from,
          src_case_size,
          item_sid_config,
          item_name,
          log_var_cd,
          config_item_cd,
          item_eks_cd,
          dwh_load_id,
          dwh_created,
          dwh_updated,
          CAST((RAND() - 0.5) * POWER(10, 18) AS INTEGER) AS `A118614`
         FROM ldl_p_lew_core_ac.v_item_2
         ORDER BY `A118614` NULLS LAST) AS t190) AS i ON S.client_id = i.client_id
     WHERE (S.client_id, S.move_to_st_loc_sid, i.item_sid) NOT IN (SELECT (mic.client_id, STR.move_to_st_loc_sid, mic.item_sid
          )
        FROM CONT_ITEM AS mic
         INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS BIL_WH0 ON mic.client_id = BIL_WH0.client_id AND mic.loc_sid_wh =
            BIL_WH0.loc_sid_wh AND BIL_WH0.dwh_actual_fg = 1
         INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS STR ON mic.client_id = STR.client_id AND mic.loc_sid_wh
             = STR.wh_loc_sid AND STR.aspect_id = 1
         INNER JOIN CONT_STR AS sca ON STR.client_id = sca.client_id AND STR.move_to_st_loc_sid = sca.loc_sid_store AND
              mic.assortment_container_sid = sca.assortment_container_sid AND CURRENT_DATE BETWEEN sca.dwh_valid_from
             AND sca.dwh_valid_to AND sca.deleted_fg = 0 AND (mic.active_from_dt > sca.active_from_dt AND (mic.active_from_dt
                  < sca.active_to_dt OR mic.active_to_dt < sca.active_to_dt) OR mic.active_from_dt < sca.active_from_dt
              AND (mic.active_to_dt > sca.active_from_dt OR mic.active_to_dt > sca.active_to_dt) OR mic.active_from_dt =
              sca.active_from_dt AND (mic.active_to_dt = sca.active_to_dt OR mic.active_to_dt <> sca.active_to_dt))
        WHERE GREATEST(mic.active_from_dt, sca.active_from_dt) <= LEAST(mic.active_to_dt, sca.active_to_dt))) AS
   unioned_resultset
  GROUP BY client_id,
   item_sid,
   loc_sid_wh,
   wh_id,
   container_id,
   move_to_store_id,
   aspect_id,
   dat_rec_start,
   dat_rec_end
  ORDER BY client_id NULLS LAST,
   dat_rec_start NULLS LAST,
   dat_rec_end NULLS LAST,
   item_sid NULLS LAST,
   move_to_store_id NULLS LAST);