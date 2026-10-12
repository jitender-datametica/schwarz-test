/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_lead.v_mat_itm_orig_item
#----------------------------------------------------------------------------
# History:
#  1.0  05.10.2020    Torsten Bachmann        Initial Version
#                                             Patch: 2457
#                                             IDMO: IDMO-2938, REP3-6441
#  1.1  26.04.2021    Torsten Bachmann        REP3-7959, PatchNo 2693: Adjust logic for orig_item_nr_int (IAN)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_itm_orig_item (client_id, orig_item_nr, dat_valid_from,
orig_item_nr_int, item_fam_grp_sid, item_familygroup_id, sub_item_grp_sid, subitemgroup_id, dwh_updated)
OPTIONS(DESCRIPTION = `MAT-VIEW FOR UNQIUE LOOKUP TABLE FOR ORIG_ITEM_NR`) AS /* probably some dummy item_family */
SELECT oi.client_id,
 CAST(oi.orig_item_nr AS BIGNUMERIC) AS orig_item_nr,
 oi.dat_valid_from,
 CAST(oi.orig_item_nr_int AS BIGNUMERIC) AS orig_item_nr_int,
 oi.item_fam_grp_sid,
 oi.item_familygroup_id,
 SIG.sub_item_grp_sid,
 CAST(ROUND(SAFE_CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) AS subitemgroup_id,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM (SELECT client_id,
   orig_item_nr,
   dat_valid_from,
   item_fam_grp_sid,
   item_familygroup_id,
   hist_last_change,
   prio,
   MAX(orig_item_nr_int) AS orig_item_nr_int,
   SUM(freq) AS freq
  FROM (SELECT ITM.client_id,
     COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC
        ), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0)) AS orig_item_nr,
     COALESCE(WAWI.dat_valid_from, ITM.src_dat_valid_from, ITMAP.src_dat_valid_from, dwf1.dat_valid_from, dwf2.dat_valid_from
      , DATE '9999-12-31') AS dat_valid_from,
      CASE
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid) > 0
      THEN ihist.item_fam_grp_sid
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid, - 9999) < 0 AND wii.item_familygroup_id IS NOT NULL
      THEN wii_fam.item_fam_grp_sid
      ELSE ihist.item_fam_grp_sid
      END AS item_fam_grp_sid,
      CASE
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid) > 0
      THEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid)
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid, - 9999) < 0 AND wii.item_familygroup_id IS NOT NULL
      THEN WAWI.item_familygroup_id
      ELSE COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid)
      END AS item_familygroup_id,
      CASE
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid) > 0
      THEN ihist.hist_last_change
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid, - 9999) < 0 AND wii.item_familygroup_id IS NOT NULL
      THEN wii.dat_rec_start
      ELSE ihist.hist_last_change
      END AS hist_last_change,
      CASE
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid) > 0
      THEN 1
      WHEN COALESCE(FAM.src_familygrp_id, FAM.item_fam_grp_sid, - 9999) < 0 AND wii.item_familygroup_id IS NOT NULL
      THEN 2
      ELSE 3 /* probably some dummy item_family */
      END AS prio,
     MAX(CASE
       WHEN CURRENT_DATE BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to /* eLwis countries */
       THEN COALESCE(ROUND(SAFE_CAST(ITM.item_eks_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITMAP.item_eks_cd AS BIGNUMERIC
          ), 0))
       ELSE WAWI.orig_item_nr_int /* WaWi and/or Rollback countries */
       END) AS orig_item_nr_int,
     COUNT(DISTINCT ITM.item_sid) AS freq
    FROM ldl_p_lew_core_ac.v_item AS ITM
     INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS MKEY ON ITM.client_id = MKEY.client_id AND ITM.item_sid = MKEY.item_sid
       
     INNER JOIN ldl_p_lew_core_ac.v_item AS ITMAP ON MKEY.client_id = ITMAP.client_id AND MKEY.item_sid_map = ITMAP.item_sid
       
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON ITM.client_id = MIG.client_id
     LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS WAWI ON ITM.client_id = WAWI.client_id AND MKEY.item_sid_map =
       WAWI.item_sid /* similar logic as in v_mat_itm_item */
     LEFT JOIN (SELECT A.client_id,
       A.item_sid,
       B.src_dat_valid_from AS dat_valid_from
      FROM ldl_p_lew_core_ac.v_item AS A
       INNER JOIN ldl_p_lew_core_ac.v_item AS B ON A.client_id = B.client_id AND B.item_sid_config = COALESCE(A.item_sid_config
           , A.item_sid) AND B.src_dat_valid_from IS NOT NULL
      WHERE NOT EXISTS (SELECT 1
        FROM ldl_p_lew_core_ac.v_item AS C
        WHERE client_id = A.client_id
         AND item_sid_config = COALESCE(A.item_sid_config, A.item_sid)
         AND (src_dat_valid_from > A.src_dat_valid_from OR src_dat_valid_from = A.src_dat_valid_from AND item_sid > A.item_sid
              ))) AS dwf1 ON ITM.client_id = dwf1.client_id AND ITM.item_sid = dwf1.item_sid
     LEFT JOIN (SELECT client_id,
       ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
       MAX(src_dat_valid_from) AS dat_valid_from
      FROM ldl_p_lew_core_ac.v_item
      WHERE src_dat_valid_from IS NOT NULL
       AND CAST(src_case_size AS FLOAT64) >= 0
      GROUP BY client_id,
       origi) AS dwf2 ON ITM.client_id = dwf2.client_id AND dwf2.origi = CAST(COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0)) AS BIGNUMERIC)
         AND ITM.log_var_cd IS NOT NULL
     INNER JOIN (SELECT client_id,
       item_sid,
       item_fam_grp_sid,
       hist_last_change,
       hist_prio
      FROM (SELECT t9.client_id,
          t9.item_sid,
          t9.item_fam_grp_sid,
          t9.hist_last_change,
          t9.hist_prio
         FROM (SELECT ITM1.client_id,
            ITM1.item_sid,
            HIST1.item_fam_grp_sid,
            HIST1.dwh_valid_from AS hist_last_change,
            2 AS hist_prio,
            HIST1.dwh_valid_to,
            HIST1.client_id AS client_id0,
            HIST1.item_sid AS item_sid0
           FROM ldl_p_lew_core_ac.v_item AS ITM1
            INNER JOIN ldl_p_lew_core_ac.v_item_hist AS HIST1 ON ITM1.client_id = HIST1.client_id AND ITM1.item_sid =
              HIST1.item_sid
              /* exclude those entries, which only exist to show when an item was not delivered anymore */
           WHERE HIST1.deleted_fg = 0 /* get only most recent entry */
           QUALIFY HIST1.dwh_valid_to = (MAX(HIST1.dwh_valid_to) OVER (PARTITION BY CAST(client_id0 AS STRING), CAST(item_sid0 AS STRING)
                 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t9
         UNION ALL
         SELECT t16.client_id,
          t16.item_sid,
          t16.item_fam_grp_sid,
          t16.hist_last_change,
          t16.hist_prio
         FROM (SELECT ITM2.client_id,
            ITM2.item_sid,
            HIST2.item_fam_grp_sid,
            HIST2.dwh_valid_from AS hist_last_change,
             CASE
             WHEN COALESCE(chk_del.deleted_fg, 0) = 1
             THEN 3
             ELSE 1
             END AS hist_prio,
            HIST2.dwh_valid_to,
            HIST2.client_id AS client_id0,
            HIST2.item_sid AS item_sid0
           FROM ldl_p_lew_core_ac.v_item AS ITM2
            INNER JOIN ldl_p_lew_core_ac.v_item_hist AS HIST2 ON ITM2.client_id = HIST2.client_id AND ITM2.item_sid_config
               = HIST2.item_sid /* Check if latest hist-Entry for item_sid_config is marked deleted */
            LEFT JOIN (SELECT client_id,
              item_sid,
              deleted_fg
             FROM ldl_p_lew_core_ac.v_item_hist
             QUALIFY dwh_valid_to = (MAX(dwh_valid_to) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
                   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS chk_del ON ITM2.client_id = chk_del.client_id
               AND ITM2.item_sid_config = chk_del.item_sid
              /* exclude those entries, which only exist to show when an item was not delivered anymore */
           WHERE HIST2.deleted_fg = 0 /* get only most recent entry */
           QUALIFY HIST2.dwh_valid_to = (MAX(HIST2.dwh_valid_to) OVER (PARTITION BY CAST(client_id0 AS STRING), CAST(item_sid0 AS STRING)
                 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t16) AS hist_tmp
      GROUP BY client_id,
       item_sid,
       item_fam_grp_sid,
       hist_last_change,
       hist_prio
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING) ORDER BY hist_prio
            IS NULL, hist_prio)) = 1) AS ihist ON ITM.client_id = ihist.client_id AND ITM.item_sid = ihist.item_sid
     LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup AS FAM ON ITM.client_id = FAM.client_id AND ihist.item_fam_grp_sid =
       FAM.item_fam_grp_sid
     LEFT JOIN (SELECT client_id,
       item_sid,
       item_familygroup_id,
       dat_rec_start
      FROM ldl_p_lew_core_ac.v_wawi_itm_item
      QUALIFY dat_rec_end = (MAX(dat_rec_end) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS wii ON ITM.client_id = wii.client_id AND WAWI
       .item_sid = wii.item_sid
     LEFT JOIN (SELECT client_id,
       src_familygrp_id,
       MIN(item_fam_grp_sid) AS item_fam_grp_sid
      FROM ldl_p_lew_core_ac.v_item_familygroup
      WHERE src_familygrp_id IS NOT NULL
      GROUP BY client_id,
       src_familygrp_id) AS wii_fam ON ITM.client_id = wii_fam.client_id AND wii.item_familygroup_id = wii_fam.src_familygrp_id
       
    WHERE COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS
        BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0)) IS NOT NULL
    GROUP BY ITM.client_id,
     orig_item_nr,
     dat_valid_from,
     item_fam_grp_sid,
     item_familygroup_id,
     hist_last_change,
     prio) AS tmp
  GROUP BY client_id,
   orig_item_nr,
   dat_valid_from,
   item_fam_grp_sid,
   item_familygroup_id,
   hist_last_change,
   prio) AS oi
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS ITMFGH ON oi.client_id = ITMFGH.client_id AND oi.item_fam_grp_sid
     = ITMFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH.dwh_valid_from AND ITMFGH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SIG ON oi.client_id = SIG.client_id AND ITMFGH.sub_item_grp_sid = SIG.sub_item_grp_sid
   /* Basistabelle Unterwarengruppen */
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(oi.client_id AS STRING), CAST(oi.orig_item_nr AS STRING), oi.dat_valid_from
      ORDER BY oi.prio IS NULL, oi.prio, oi.hist_last_change IS NULL, oi.hist_last_change, oi.freq IS NULL, oi.freq, oi
      .item_familygroup_id IS NULL, oi.item_familygroup_id)) = 1;