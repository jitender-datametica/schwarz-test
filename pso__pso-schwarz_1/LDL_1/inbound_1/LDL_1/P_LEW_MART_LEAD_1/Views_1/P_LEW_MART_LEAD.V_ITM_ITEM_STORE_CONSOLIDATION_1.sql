CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_itm_item_store_consolidation_1 COMMENT='Item_1/Store consolidatio view'
(
        client_id
      , wh_id
      , aspect_id
      , store_id
      , item_id
      , itm_consgrp_id
      , cons_item_id
      , cons_orig_item_nr
      , cons_dat_valid_from_item
      , cons_fg
      , itm_consgrp_desc
      , item_desc
) AS
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2021       Michael Morris                Initial Version
#                                                      TeraData: 20210318_2789_itm_store_cons
#                                                      https://jira.schwarz/browse/INTMIG-779
#                                                      SF: https://jira.schwarz/browse/INTMIG-1399
#  1.1  10.05.2022       Michael Morsis                Item_1 SIDs now retrieved from v_item_map_key_1
#                                                      due to missing Item_1 SIDs in v_wawi_itm_item_wh.
#                                                      v_wawi_itm_item_wh_1 only used to obtain all the 
#                                                      current warehouse SIDs.
#                                                      Azure User Story: 323718
#----------------------------------------------------------------------------
*/
SELECT   client_id
        , wh_id
        , aspect_id
        , store_id
        , item_id
        , itm_consgrp_id
        , cons_item_id
        , cons_orig_item_nr
        , cons_dat_valid_from_item
        , cons_fg
        , itm_consgrp_desc
        , item_desc
  FROM (

        SELECT   i.client_id
               , whm.tr_wh_id                                                                     AS wh_id
               , whm.aspect_id                                                                    AS aspect_id
               , whm.store_id
               , i.item_sid                                                                       AS item_id
               , i.itm_consgrp_id
               , i.cons_item_id
               , CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr ELSE -1 END                  AS cons_orig_item_nr
               , CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END AS cons_dat_valid_from_item
               , CASE WHEN i.itm_consgrp_id = -1 THEN 0 ELSE 1 END                                AS cons_fg
               , cgp.itm_consgrp_desc
               , oid.item_desc
         FROM (
              SELECT
                         i1.client_id
                       , i1.wh_loc_sid
                       , i1.item_sid
                       , c1.itm_consgrp_id
                       , CAST(-1 AS INTEGER) AS cons_item_id
               FROM (     /* old source: P_LEW_CORE_AC.v_wawi_itm_item_wh_1  */
                     SELECT DISTINCT ikm.client_id, w.wh_loc_sid, ikm.item_sid_map AS item_sid
                       FROM P_LEW_CORE_AC.v_item_map_key_1                           AS ikm
                      INNER JOIN (
                                  SELECT DISTINCT client_id, wh_loc_sid
                                    FROM P_LEW_CORE_AC.v_wawi_itm_item_wh_1 
                                   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
                                  )                                                AS w
                         ON ikm.client_id = w.client_id
                      WHERE ikm.active_fg = 1
        	        )                                                  AS i1
              INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_consolidation_1 AS c1
                 ON i1.client_id   = c1.client_id
                AND i1.item_sid    =  c1.item_sid
                AND i1.wh_loc_sid  =  c1.wh_loc_sid
              WHERE CURRENT_DATE BETWEEN c1.dat_rec_start AND c1.dat_rec_end
              UNION ALL
              SELECT
                         i2.client_id
                       , i2.wh_loc_sid
                       , i2.item_sid
                       , CAST(-1 AS INTEGER) AS itm_consgrp_id
                       , i2.item_sid         AS cons_item_sid
               FROM (    /* Old source: P_LEW_CORE_AC.v_wawi_itm_item_wh_1 */
                      SELECT DISTINCT ikm.client_id, w.wh_loc_sid, ikm.item_sid_map AS item_sid
                        FROM P_LEW_CORE_AC.v_item_map_key_1                           AS ikm
                       INNER JOIN (
                                   SELECT DISTINCT client_id, wh_loc_sid
                                     FROM P_LEW_CORE_AC.v_wawi_itm_item_wh_1 
                                    WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
                                   )                                                AS w
                          ON ikm.client_id = w.client_id
                       WHERE ikm.active_fg = 1
                    )                                               AS i2
              WHERE NOT EXISTS
                           (
                           SELECT 1
                             FROM P_LEW_CORE_AC.v_wawi_itm_item_consolidation_1 AS c2
                            WHERE i2.client_id   = c2.client_id
                              AND i2.item_sid    = c2.item_sid
                              AND i2.wh_loc_sid  = c2.wh_loc_sid
                              AND CURRENT_DATE BETWEEN c2.dat_rec_start AND c2.dat_rec_end
                           )
              ) AS i
          /* Auflösung WH  */
         INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
            ON wh.client_id     = i.client_id
           AND wh.loc_sid_wh    = i.wh_loc_sid
           AND wh.dwh_actual_fg = 1
        
         INNER JOIN (
                     SELECT DISTINCT   k.client_id
                                     , k.wh_id            AS k_wh_id
                                     , k.store_id
                                     , tr.aspect_id
                                     , tr.wh_id           AS tr_wh_id
                     FROM P_LEW_MART_LEAD_AC.v_org_store_merge_1       AS k
                     INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_1 AS tr
                        ON k.client_id      = tr.client_id
                       AND k.store_id       = tr.store_id
                       AND tr.aspect_id    IN (1, 2)
                     WHERE k.test_store_fg  = 0
                      AND k.aspect_id       = 1
                      AND k.wh_id          IS NOT NULL
                      AND k.wh_id           > 0
                      AND tr.wh_id         IS NOT NULL
                    ) AS whm
            ON i.client_id  = whm.client_id
           AND wh.src_wh_id = whm.k_wh_id
        
         INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act_1 AS a
            ON a.client_id = i.client_id
           AND a.item_sid  =  i.item_sid
        
         LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_consolidationgroup_1 AS cgp
           ON cgp.client_id       = i.client_id
          AND cgp.wh_loc_sid      =  i.wh_loc_sid
          AND cgp.itm_consgrp_id  = i.itm_consgrp_id
          AND CURRENT_DATE BETWEEN cgp.dat_rec_start AND cgp.dat_rec_end
        
         INNER JOIN P_LEW_CORE_AC.v_wawi_itm_orig_item_desc_act_1 AS oid
            ON  i.client_id      = oid.client_id
           AND a.orig_item_nr    = oid.orig_item_nr
           AND a.dat_valid_from  = oid.dat_valid_from
           AND oid.language_id   = i.client_id
        )
;
