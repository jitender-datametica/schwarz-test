/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_SM_MAP_ITEM_CONTAINER_STR
#----------------------------------------------------------------------------
# History:
#  1.0  10.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#  1.1  17.03.2022    Bachmann, Torsten        Distribute assignment of orig_item_nr to all item_sid
#  1.2  29.03.2022    Bachmann, Torsten        deleted rows not marked as expected. So, implemented logic to filter those not delivered rows
#  1.3  30.03.2022    Białek, Aleksander       adding order by clause to ensure proper micro-partitions structure
#  1.4  31.05.2022    Bachmann, Torsten        INC4749429: exclude outdated/deleted Container-Store-Assignments (like Container-Item)
#  1.5  13.06.2022    Bachmann, Torsten        INC4810802: exclude overlapping Container-Store-Assignments periods
#  1.6  24.10.2023    Lysik, Martin            #541275: additional IN-filter for sids to lower data amount in a join
#  1.7  31.01.2024    Lysik, Martin            #578705: recommended adjusments to keep the runtime consistent
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_SM_MAP_ITEM_CONTAINER_STR(
   client_id         COMMENT 'Landeskennzeichen' 
,  item_sid          COMMENT 'Artikelnummer'
,  loc_sid_wh        COMMENT 'Surrogate Key LOCATION (eindeutig ueber alle Laender/Mandanten hinweg)'
,  wh_id             COMMENT 'WH ID from source (WAWI)'
,  container_id      COMMENT 'Surrogate Key container'
,  move_to_store_id  COMMENT 'Store-Nr'
,  aspect_id         COMMENT 'only 1= BGES'
,  dat_rec_start     COMMENT 'Gültigkeitsdatum von'
,  dat_rec_end       COMMENT 'Gültigkeitsdatum bis'
) AS
WITH sids AS
(
  SELECT
    client_id
  , item_sid
  , TRY_CAST(COALESCE(src_orig_item_nr, config_item_cd, src_matnr) AS DECIMAL(18,0)) AS orig_item_nr
  , COALESCE (src_dat_valid_from, DATE '9999-12-31')                                 AS dat_valid_from   /* this is NOT a validity date, but is part of the key of oin */
  FROM P_LEW_CORE_AC.v_item
  WHERE TRY_CAST(COALESCE(src_orig_item_nr, config_item_cd, src_matnr) AS DECIMAL(18,0)) IS NOT NULL
  ORDER BY Random() /* Recommended adjusment to keep the runtime in good boundaries */
),
base_waci AS
(
  SELECT * 
  FROM P_LEW_CORE_AC.v_warehouse_assortment_container_item
  WHERE deleted_fg = 0
    AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  /* row has to be updated in the last 7 days depending on the last dwh_updated per WH */
  QUALIFY dwh_updated > DATEADD (DAY, -7, MAX(dwh_updated) OVER (PARTITION BY client_id, loc_sid_wh)) 
),
wh_cont_item AS
(
  /* This part is needed because we don't have a clear flag in CORE data, if a row was deleted in Source System (not delivered anymore) */
  SELECT 
    t1.client_id
  , t1.item_sid
  , t1.loc_sid_wh
  /* if we have an overlap we use the most recent data based on load_id */
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.assortment_container_sid
         ELSE t2.assortment_container_sid
    END                                           AS assortment_container_sid
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.active_from_dt
         ELSE t2.active_from_dt
    END                                           AS active_from_dt
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.active_to_dt
         ELSE t2.active_to_dt
    END                                           AS active_to_dt
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.deleted_fg
         ELSE t2.deleted_fg
    END                                           AS deleted_fg
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.dwh_valid_from
         ELSE t2.dwh_valid_from
    END                                           AS dwh_valid_from
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.dwh_valid_to
         ELSE t2.dwh_valid_to
    END                                           AS dwh_valid_to
  FROM base_waci t1
    LEFT OUTER JOIN base_waci t2
      ON t1.client_id  = t2.client_id
     AND t1.item_sid   = t2.item_sid
     AND t1.loc_sid_wh = t2.loc_sid_wh
     AND ( /* similar logic as OVERLAPS */
               (t1.ACTIVE_FROM_DT > t2.ACTIVE_FROM_DT AND NOT (t1.ACTIVE_FROM_DT >= t2.ACTIVE_TO_DT AND t1.ACTIVE_TO_DT >= t2.ACTIVE_TO_DT))
            OR (t2.ACTIVE_FROM_DT > t1.ACTIVE_FROM_DT AND NOT (t2.ACTIVE_FROM_DT >= t1.ACTIVE_TO_DT AND t2.ACTIVE_TO_DT >= t1.ACTIVE_TO_DT))
            OR (t1.ACTIVE_FROM_DT = t2.ACTIVE_FROM_DT AND (t1.ACTIVE_TO_DT = t2.ACTIVE_TO_DT OR t1.ACTIVE_TO_DT <> t2.ACTIVE_TO_DT)) )
     AND (   t1.assortment_container_sid <> t2.assortment_container_sid     /* either container assignment differs */
          OR t1.active_from_dt           <> t2.active_from_dt)              /* or time period differs */
     /* we do NOT join on assortment_container_sid, because that can differ. Important is that one item can only be assigned to one container at a time per warehouse */
  GROUP BY
    t1.client_id
  , t1.item_sid
  , t1.loc_sid_wh
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.assortment_container_sid
         ELSE t2.assortment_container_sid
    END
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.active_from_dt
         ELSE t2.active_from_dt
    END
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.active_to_dt
         ELSE t2.active_to_dt
    END
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.deleted_fg
         ELSE t2.deleted_fg
    END
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.dwh_valid_from
         ELSE t2.dwh_valid_from
    END
  , CASE WHEN t2.client_id IS NULL
           OR t1.dwh_updated >= t2.dwh_updated
         THEN t1.dwh_valid_to
         ELSE t2.dwh_valid_to
    END
),
cont_item AS
(
  SELECT
    si.client_id
  , si.item_sid
  , coin.loc_sid_wh
  , coin.assortment_container_sid
  , coin.active_from_dt
  , coin.active_to_dt
  FROM sids AS si
    INNER JOIN
  (
    SELECT
        mic.client_id
      , s.orig_item_nr
      , s.dat_valid_from
      , mic.LOC_SID_WH
      , mic.assortment_container_sid
      , mic.active_from_dt
      , MIN(mic.active_to_dt)           AS active_to_dt
    FROM wh_cont_item mic
      INNER JOIN 
      (
            SELECT *
            FROM sids
            WHERE (client_id, item_sid) IN (SELECT DISTINCT client_id, item_sid FROM base_waci)
      )  AS s
        ON mic.client_id = s.client_id
       AND mic.item_sid  = s.item_sid
      /* use/filter the container assignment of the most recent item_sid according to item mapping 
       * This should be the most actual one */
      INNER JOIN P_LEW_PRECORE_AC.v_item_map_key_oin_wh_hist oinh
        ON mic.client_id  = oinh.client_id
       AND mic.loc_sid_wh = oinh.loc_sid_wh
       AND mic.item_sid   = oinh.item_sid
       AND CURRENT_DATE BETWEEN oinh.dwh_valid_from AND oinh.dwh_valid_to
    GROUP BY
        mic.client_id
      , s.orig_item_nr
      , s.dat_valid_from
      , mic.LOC_SID_WH
      , mic.assortment_container_sid
      , mic.active_from_dt
  ) AS coin
    ON si.client_id      = coin.client_id
   AND si.orig_item_nr   = coin.orig_item_nr
   AND si.dat_valid_from = coin.dat_valid_from
),
base_acs AS
(
  SELECT *
  FROM P_LEW_CORE_AC.v_assortment_container_store
  WHERE deleted_fg = 0
    AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  QUALIFY dwh_updated > DATEADD (DAY, -7, MAX(dwh_updated) OVER (PARTITION BY client_id, loc_sid_store)) 
),
cont_str AS
(
  SELECT
    client_id
  , assortment_container_sid
  , loc_sid_store
  , active_from_dt
  , LEAST (active_to_dt, LEAD(active_from_dt -1, 1, active_to_dt) OVER (PARTITION BY client_id, assortment_container_sid, loc_sid_store ORDER BY active_from_dt, active_to_dt)) AS active_to_dt
  , deleted_fg
  , dwh_valid_from
  , dwh_valid_to
  FROM
  (
    SELECT
      t1.client_id
    , t1.assortment_container_sid
    , t1.loc_sid_store
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.active_from_dt
           ELSE t2.active_from_dt
      END                                           AS active_from_dt
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.active_to_dt
           ELSE t2.active_to_dt
      END                                           AS active_to_dt
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.deleted_fg
           ELSE t2.deleted_fg
      END                                           AS deleted_fg
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.dwh_valid_from
           ELSE t2.dwh_valid_from
      END                                           AS dwh_valid_from
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.dwh_valid_to
           ELSE t2.dwh_valid_to
      END                                           AS dwh_valid_to
    FROM base_acs t1
      LEFT OUTER JOIN base_acs t2
        ON t1.client_id  = t2.client_id
       AND t1.loc_sid_store = t2.loc_sid_store
       AND t1.assortment_container_sid = t2.assortment_container_sid
       AND ( /* similar logic as OVERLAPS */
                 (t1.ACTIVE_FROM_DT > t2.ACTIVE_FROM_DT AND NOT (t1.ACTIVE_FROM_DT >= t2.ACTIVE_TO_DT AND t1.ACTIVE_TO_DT >= t2.ACTIVE_TO_DT))
              OR (t2.ACTIVE_FROM_DT > t1.ACTIVE_FROM_DT AND NOT (t2.ACTIVE_FROM_DT >= t1.ACTIVE_TO_DT AND t2.ACTIVE_TO_DT >= t1.ACTIVE_TO_DT))
              OR (t1.ACTIVE_FROM_DT = t2.ACTIVE_FROM_DT AND (t1.ACTIVE_TO_DT = t2.ACTIVE_TO_DT OR t1.ACTIVE_TO_DT <> t2.ACTIVE_TO_DT)) )
       AND (   t1.active_from_dt           <> t2.active_from_dt)              /* or time period differs */
    GROUP BY
      t1.client_id
    , t1.assortment_container_sid
    , t1.loc_sid_store
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.active_from_dt
           ELSE t2.active_from_dt
      END
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.active_to_dt
           ELSE t2.active_to_dt
      END
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.deleted_fg
           ELSE t2.deleted_fg
      END
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.dwh_valid_from
           ELSE t2.dwh_valid_from
      END
    , CASE WHEN t2.client_id IS NULL
             OR t1.dwh_updated >= t2.dwh_updated
           THEN t1.dwh_valid_to
           ELSE t2.dwh_valid_to
      END
  ) correct_hist
  QUALIFY active_from_dt <= LEAST (active_to_dt, LEAD(active_from_dt -1, 1, active_to_dt) OVER (PARTITION BY client_id, assortment_container_sid, loc_sid_store ORDER BY active_from_dt, active_to_dt))
),
mat AS
(
  SELECT
    mic.client_id
  , mic.item_sid
  , mic.LOC_SID_WH
  , bil_wh.src_wh_id                                  AS wh_id
  , mic.assortment_container_sid                      AS container_id
  , str.move_to_st_loc_sid                            AS move_to_store_id
  , str.aspect_id
  , GREATEST (mic.ACTIVE_FROM_DT, sca.ACTIVE_FROM_DT) AS dat_rec_start
  , LEAST (mic.ACTIVE_TO_DT, sca.ACTIVE_TO_DT)        AS dat_rec_end
  FROM cont_item AS mic
      /* Get WH_ID for loc_sid_wh */
    INNER JOIN P_LEW_BIL_AC.v_warehouse bil_wh
      ON mic.client_id        = bil_wh.client_id
     AND mic.loc_sid_wh       = bil_wh.loc_sid_wh
     AND bil_wh.dwh_actual_fg = 1
    INNER JOIN P_LEW_CORE_AC.v_wawi_org_all_store_merge_act str
      ON mic.client_id  = str.client_id
     AND mic.loc_sid_wh = str.wh_loc_sid
     AND str.aspect_id  = 1 /* limit to BGES hierarchy */
    INNER JOIN cont_str sca
      ON str.client_id                = sca.client_id
     AND str.move_to_st_loc_sid       = sca.LOC_SID_STORE
     AND mic.assortment_container_sid = sca.assortment_container_sid
      /* only use most recent one */
     AND CURRENT_DATE BETWEEN sca.dwh_valid_from AND sca.dwh_valid_to
     AND sca.deleted_fg = 0
     AND ( /* similar logic as OVERLAPS */
             (mic.ACTIVE_FROM_DT > sca.ACTIVE_FROM_DT AND NOT (mic.ACTIVE_FROM_DT >= sca.ACTIVE_TO_DT AND mic.ACTIVE_TO_DT >= sca.ACTIVE_TO_DT))
          OR (sca.ACTIVE_FROM_DT > mic.ACTIVE_FROM_DT AND NOT (sca.ACTIVE_FROM_DT >= mic.ACTIVE_TO_DT AND sca.ACTIVE_TO_DT >= mic.ACTIVE_TO_DT))
          OR (mic.ACTIVE_FROM_DT = sca.ACTIVE_FROM_DT AND (mic.ACTIVE_TO_DT = sca.ACTIVE_TO_DT OR mic.ACTIVE_TO_DT <> sca.ACTIVE_TO_DT)) )
  WHERE dat_rec_start <= dat_rec_end
)

SELECT
  client_id
, item_sid
, loc_sid_wh
, wh_id
, container_id
, move_to_store_id
, aspect_id
, dat_rec_start
, dat_rec_end
FROM
(
  SELECT
    client_id
  , item_sid
  , loc_sid_wh
  , wh_id
  , container_id
  , move_to_store_id
  , aspect_id
  , dat_rec_start
  , dat_rec_end
  FROM mat
    UNION ALL
    /* filling gaps between two rows */
  SELECT 
    client_id
  , item_sid
  , loc_sid_wh
  , wh_id
  , -99               AS container_id
  , move_to_store_id
  , aspect_id
  , dat_rec_end +1    AS dat_rec_start_gap
  , lead (dat_rec_start, 1, DATE '2200-01-01') OVER (PARTITION BY client_id, item_sid, move_to_store_id ORDER BY dat_rec_start) -1  AS dat_rec_end_gap
  FROM mat
  QUALIFY lead (dat_rec_start, 1, dat_rec_end) OVER (PARTITION BY client_id, item_sid, move_to_store_id ORDER BY dat_rec_start) - dat_rec_end > 1
    UNION ALL
    /* add row from '1900-01-01' till first entry */
  SELECT
    client_id
  , item_sid
  , loc_sid_wh
  , wh_id
  , -99                       AS container_id
  , move_to_store_id
  , aspect_id
  , DATE '1900-01-01'         AS dat_rec_start
  , first_dat_rec_start - 1   AS dat_rec_end
  FROM
  (
    SELECT
      client_id
    , item_sid
    , loc_sid_wh
    , wh_id
    , move_to_store_id
    , aspect_id
    , MIN(dat_rec_start) AS first_dat_rec_start
    FROM mat
    GROUP BY
      client_id
    , item_sid
    , loc_sid_wh
    , wh_id
    , move_to_store_id
    , aspect_id
    HAVING MIN(dat_rec_start) > DATE '1900-01-01'
  ) first_row
    UNION ALL
    /* add rows after last entry till '2200-01-01' */
  SELECT
    client_id
  , item_sid
  , loc_sid_wh
  , wh_id
  , -99                   AS container_id
  , move_to_store_id
  , aspect_id
  , last_dat_rec_end +1   AS dat_rec_start
  , DATE '2200-01-01'     AS dat_rec_end
  FROM
  (
    SELECT
      client_id
    , item_sid
    , loc_sid_wh
    , wh_id
    , move_to_store_id
    , aspect_id
    , MAX(dat_rec_end) AS last_dat_rec_end
    FROM mat
    GROUP BY
      client_id
    , item_sid
    , loc_sid_wh
    , wh_id
    , move_to_store_id
    , aspect_id
    HAVING MAX(dat_rec_end) < DATE '2200-01-01'
  ) last_row
    UNION ALL
    /* add all missing store, item combination */
  SELECT
    client_id
  , item_sid
  , loc_sid_wh
  , wh_id
  , -99                 AS container_id
  , move_to_store_id
  , aspect_id
  , DATE '1900-01-01'   AS dat_rec_start
  , DATE '2200-01-01'   AS dat_rec_end
  FROM
  (
    SELECT
      s.client_id
    , i.item_sid
    , bil_wh.LOC_SID_WH
    , bil_wh.src_wh_id      AS wh_id
    , s.move_to_st_loc_sid  AS move_to_store_id
    , s.aspect_id
    FROM P_LEW_CORE_AC.v_wawi_org_all_store_merge_act s
      INNER JOIN P_LEW_BIL_AC.v_warehouse bil_wh
        ON s.client_id          = bil_wh.client_id
       AND s.wh_loc_sid         = bil_wh.loc_sid_wh
       AND bil_wh.dwh_actual_fg = 1
       AND s.aspect_id          = 1 /* limit to BGES hierarchy */
      INNER JOIN
      (
            SELECT *
            FROM P_LEW_CORE_AC.v_item
            ORDER BY Random() /* Recommended adjusment to keep the runtime in good boundaries */
      ) i 
        ON s.client_id = i.client_id
    WHERE (s.client_id, s.move_to_st_loc_sid, i.item_sid) NOT IN
    (SELECT client_id, move_to_store_id, item_sid
     FROM mat
    )
      AND TRY_CAST(COALESCE(i.src_orig_item_nr, i.config_item_cd, i.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
  ) missing

) unioned_resultset
GROUP BY   client_id
, item_sid
, loc_sid_wh
, wh_id
, container_id
, move_to_store_id
, aspect_id
, dat_rec_start
, dat_rec_end

ORDER BY client_id, dat_rec_start, dat_rec_end, item_sid, move_to_store_id 
;