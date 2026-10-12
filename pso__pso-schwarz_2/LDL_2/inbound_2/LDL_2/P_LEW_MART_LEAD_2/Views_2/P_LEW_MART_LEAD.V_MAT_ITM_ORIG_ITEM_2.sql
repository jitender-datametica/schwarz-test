/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_lead.v_mat_itm_orig_item_2
#----------------------------------------------------------------------------
# History:
#  1.0  05.10.2020    Torsten Bachmann        Initial Version
#                                             Patch: 2457
#                                             IDMO: IDMO-2938, REP3-6441
#  1.1  26.04.2021    Torsten Bachmann        REP3-7959, PatchNo 2693: Adjust logic for orig_item_nr_int (IAN)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_ITM_ORIG_ITEM_2 COMMENT = 'Mat-View for Unqiue lookup table for orig_item_nr'
(
  client_id
, orig_item_nr
, dat_valid_from
, orig_item_nr_int
, item_fam_grp_sid
, item_familygroup_id
, sub_item_grp_sid
, subitemgroup_id
, dwh_updated
)
AS
SELECT
  oi.client_id
, CAST (oi.orig_item_nr AS DECIMAL(18,0))               AS orig_item_nr
, oi.dat_valid_from
, CAST (oi.orig_item_nr_int AS DECIMAL(9,0))            AS orig_item_nr_int
, oi.item_fam_grp_sid
, oi.item_familygroup_id
, sig.sub_item_grp_sid
, CAST(TRY_TO_NUMBER(sig.src_subitemgrp_cd) AS INTEGER) AS subitemgroup_id
, CURRENT_TIMESTAMP(6)                                  AS dwh_updated
FROM
(
  SELECT
    client_id
  , orig_item_nr
  , dat_valid_from
  , item_fam_grp_sid
  , item_familygroup_id
  , hist_last_change
  , prio
  , MAX(orig_item_nr_int)      AS orig_item_nr_int
  , SUM(freq)                  AS freq
  FROM
  (
    SELECT
      itm.client_id
    , COALESCE (TRY_TO_NUMBER(itm.src_orig_item_nr), TRY_TO_NUMBER(itm.config_item_cd), TRY_TO_NUMBER(itm.src_matnr))                               AS orig_item_nr
    , COALESCE (wawi.dat_valid_from, itm.src_dat_valid_from, itmap.src_dat_valid_from, dwf1.dat_valid_from, dwf2.dat_valid_from, DATE '9999-12-31') AS dat_valid_from
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN ihist.item_fam_grp_sid
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN wii_fam.item_fam_grp_sid
           ELSE ihist.item_fam_grp_sid
      END                                                                                                                                           AS item_fam_grp_sid
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid)
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN wawi.item_familygroup_id
           ELSE COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid)
      END                                                                                                                                           AS item_familygroup_id
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN ihist.hist_last_change
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN wii.dat_rec_start
           ELSE ihist.hist_last_change
      END                                                                                                                                           AS hist_last_change
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN 1
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN 2
           ELSE 3   /* probably some dummy_2 item_family */
      END                                                                                                                                           AS prio
    , MAX(CASE WHEN CURRENT_DATE BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to   /* eLwis countries */ 
               THEN COALESCE (TRY_TO_NUMBER(itm.item_eks_cd), TRY_TO_NUMBER(itmap.item_eks_cd))
               ELSE wawi.orig_item_nr_int                                                             /* WaWi and/or Rollback countries */
          END)                                                                                                                                      AS orig_item_nr_int
    , COUNT(DISTINCT itm.item_sid)                                                                                                                  AS freq
    FROM P_LEW_CORE_AC.v_item_2 AS itm
    
      INNER JOIN P_LEW_CORE_AC.v_item_map_key_2 AS mkey 
       ON itm.client_id = mkey.client_id 
      AND itm.item_sid  = mkey.item_sid
    
      INNER JOIN P_LEW_CORE_AC.v_item_2 AS itmap 
       ON mkey.client_id    = itmap.client_id 
      AND mkey.item_sid_map = itmap.item_sid
    
      INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
       ON itm.client_id = mig.client_id

      LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act_2 wawi
       ON itm.client_id     = wawi.client_id
      AND mkey.item_sid_map = wawi.item_sid
    
      LEFT OUTER JOIN   /* similar logic as in v_mat_itm_item_2 */
      (
        SELECT
          a.client_id
        , a.item_sid
        , b.src_dat_valid_from AS  dat_valid_from
        FROM P_LEW_CORE_AC.v_item_2 AS a
          INNER JOIN P_LEW_CORE_AC.v_item_2 AS b
           ON b.client_id       = a.client_id
          AND b.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
          AND b.src_dat_valid_from IS NOT NULL
          AND NOT EXISTS
          ( SELECT
              1
            FROM P_LEW_CORE_AC.v_item_2 AS c
            WHERE c.client_id       = a.client_id
              AND c.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
              AND (c.src_dat_valid_from > b.src_dat_valid_from
                  OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid))
          )
      ) AS dwf1
       ON dwf1.client_id = itm.client_id
      AND dwf1.item_sid  = itm.item_sid
    
      LEFT OUTER JOIN
      (
        SELECT
          client_id
        , TRY_CAST(src_orig_item_nr AS INTEGER) AS origi
        , MAX(src_dat_valid_from) AS dat_valid_from
        FROM P_LEW_CORE_AC.v_item_2
        WHERE src_dat_valid_from IS NOT NULL
          AND origi IS NOT NULL
          AND src_case_size >= 0
        GROUP BY 1,2
      ) AS dwf2
       ON dwf2.client_id = itm.client_id
      AND dwf2.origi     = CAST(COALESCE(TRY_TO_NUMBER(itm.src_orig_item_nr), TRY_TO_NUMBER(itm.config_item_cd), TRY_TO_NUMBER(itm.src_matnr)) AS DECIMAL(18,0))
      AND itm.log_var_cd IS NOT NULL
      
      INNER JOIN
      (
        SELECT
          client_id
        , item_sid
        , item_fam_grp_sid
        , hist_last_change
        , hist_prio
        FROM
        (
          SELECT
            itm1.client_id
          , itm1.item_sid
          , hist1.item_fam_grp_sid
          , hist1.dwh_valid_from   AS hist_last_change
          , 2                      AS hist_prio
          FROM P_LEW_CORE_AC.v_item_2 itm1
            INNER JOIN P_LEW_CORE_AC.v_item_hist_2 hist1
             ON itm1.client_id = hist1.client_id
            AND itm1.item_sid  = hist1.item_sid
          /* exclude those entries, which only exist to show when an item_2 was not delivered anymore */
          WHERE hist1.deleted_fg = 0
            /* get only most recent entry */
          QUALIFY hist1.dwh_valid_to = MAX(hist1.dwh_valid_to) OVER (PARTITION BY hist1.client_id, hist1.item_sid)
            UNION ALL
          SELECT
            itm2.client_id
          , itm2.item_sid
          , hist2.item_fam_grp_sid
          , hist2.dwh_valid_from   AS hist_last_change
          , CASE WHEN COALESCE(chk_del.deleted_fg,0) = 1
                 THEN 3
                 ELSE 1
            END                      AS hist_prio
          FROM P_LEW_CORE_AC.v_item_2 itm2
            INNER JOIN P_LEW_CORE_AC.v_item_hist_2 hist2
             ON itm2.client_id        = hist2.client_id
            AND itm2.item_sid_config  = hist2.item_sid
            /* Check if latest hist-Entry for item_sid_config is marked deleted */
            LEFT OUTER JOIN
            (SELECT 
               client_id
             , item_sid
             , deleted_fg
             FROM P_LEW_CORE_AC.v_item_hist_2
             QUALIFY dwh_valid_to = MAX(dwh_valid_to) OVER (PARTITION BY client_id, item_sid)
            ) chk_del
             ON itm2.client_id        = chk_del.client_id
            AND itm2.item_sid_config  = chk_del.item_sid
            
          /* exclude those entries, which only exist to show when an item_2 was not delivered anymore */
          WHERE hist2.deleted_fg = 0
            /* get only most recent entry */
          QUALIFY hist2.dwh_valid_to = MAX(hist2.dwh_valid_to) OVER (PARTITION BY hist2.client_id, hist2.item_sid)
        ) hist_tmp
        GROUP BY
          client_id
        , item_sid
        , item_fam_grp_sid
        , hist_last_change
        , hist_prio
        QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, item_sid ORDER BY hist_prio) = 1

      ) ihist
       ON itm.client_id  = ihist.client_id
      AND itm.item_sid   = ihist.item_sid
    
      LEFT OUTER JOIN P_LEW_CORE_AC.v_item_familygroup_2 fam
       ON itm.client_id          = fam.client_id
      AND ihist.item_fam_grp_sid = fam.item_fam_grp_sid
    
      LEFT OUTER JOIN 
      (SELECT
         client_id
       , item_sid
       , item_familygroup_id
       , dat_rec_start
       FROM P_LEW_CORE_AC.v_wawi_itm_item_2
       QUALIFY dat_rec_end = MAX(dat_rec_end) OVER (PARTITION BY client_id, item_sid)
      ) wii
       ON itm.client_id     = wii.client_id
      AND wawi.item_sid     = wii.item_sid

      LEFT OUTER JOIN
      (SELECT
         client_id
       , src_familygrp_id
       , MIN(item_fam_grp_sid)   AS item_fam_grp_sid
       FROM P_LEW_CORE_AC.v_item_familygroup_2
       WHERE src_familygrp_id IS NOT NULL
       GROUP BY 
         client_id
       , src_familygrp_id
      ) wii_fam
       ON itm.client_id           = wii_fam.client_id
      AND wii.item_familygroup_id = wii_fam.src_familygrp_id

    WHERE COALESCE (TRY_TO_NUMBER(itm.src_orig_item_nr), TRY_TO_NUMBER(itm.config_item_cd), TRY_TO_NUMBER(itm.src_matnr)) IS NOT NULL
    GROUP BY
      itm.client_id
    , COALESCE (TRY_TO_NUMBER(itm.src_orig_item_nr), TRY_TO_NUMBER(itm.config_item_cd), TRY_TO_NUMBER(itm.src_matnr))
    , COALESCE (wawi.dat_valid_from, itm.src_dat_valid_from, itmap.src_dat_valid_from, dwf1.dat_valid_from, dwf2.dat_valid_from, DATE '9999-12-31')
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN ihist.item_fam_grp_sid
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN wii_fam.item_fam_grp_sid
           ELSE ihist.item_fam_grp_sid
      END
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid)
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN wawi.item_familygroup_id
           ELSE COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid)
      END
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN ihist.hist_last_change
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN wii.dat_rec_start
           ELSE ihist.hist_last_change
      END
    , CASE WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid) > 0
           THEN 1
           WHEN COALESCE(fam.src_familygrp_id, fam.item_fam_grp_sid, -9999) < 0
                AND wii.item_familygroup_id IS NOT NULL
           THEN 2
           ELSE 3   /* probably some dummy_2 item_family */
      END

  ) tmp
  GROUP BY
    client_id
  , orig_item_nr
  , dat_valid_from
  , item_fam_grp_sid
  , item_familygroup_id
  , hist_last_change
  , prio
) oi
  INNER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_2 AS itmfgh
   ON oi.client_id        = itmfgh.client_id
  AND oi.item_fam_grp_sid = itmfgh.item_fam_grp_sid
  AND CURRENT_DATE BETWEEN itmfgh.dwh_valid_from AND itmfgh.dwh_valid_to
   
  INNER JOIN P_LEW_CORE_AC.v_subitemgroup_2 AS sig /* Basistabelle Unterwarengruppen */
   ON oi.client_id            = sig.client_id
  AND itmfgh.sub_item_grp_sid = sig.sub_item_grp_sid
QUALIFY ROW_NUMBER () OVER (PARTITION BY oi.client_id, oi.orig_item_nr, oi.dat_valid_from
                            ORDER BY oi.prio, oi.hist_last_change DESC NULLS LAST, oi.freq DESC NULLS LAST, oi.item_familygroup_id DESC NULLS LAST
                           ) = 1
;
