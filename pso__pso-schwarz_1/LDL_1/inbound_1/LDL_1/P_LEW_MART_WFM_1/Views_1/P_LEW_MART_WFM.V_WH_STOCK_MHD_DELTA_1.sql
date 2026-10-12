CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_WH_STOCK_MHD_DELTA_1
AS
/* WaWi Part */
SELECT
 mhd_wawi.client_id            AS client_id
   ,mhd_wawi.wh_id                AS wh_id
   ,mhd_wawi.orig_item_nr         AS item_1
   ,mhd_wawi.dat_formdate         AS stock_dat
   ,mhd_wawi.mhd_worst            AS mhd_worst
   ,mhd_wawi.mhd_best             AS mhd_best
   ,CAST(NULL AS INTEGER) AS load_id /* keep NULL for timestamp delta (load_id from export job will be inserted into log table) */
   FROM
   (
         SELECT
            rcv.client_id
   ,loc.src_wh_id                   AS wh_id
   ,CAST(COALESCE(TRY_CAST(itm.config_item_cd AS BIGINT),itm.src_orig_item_nr) AS BIGINT)  AS orig_item_nr -- Ã„nderung WFM Bugfix config_item_cd = 'EJR-Dummy_1'
   ,rcv.dat_formdate                AS dat_formdate
   ,MIN(rcv.dat_min_durability_rcv) AS mhd_worst
   ,MAX(rcv.dat_min_durability_rcv) AS mhd_best
         FROM
         (
           SELECT
              rcv1.client_id
   ,rcv1.wh_loc_sid
   ,rcv1.item_sid
   ,rcv1.dat_formdate
   ,rcv1.dat_min_durability_rcv
           FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving_1 rcv1
   INNER JOIN p_lew_core_ac.v_client_migration_per_1 m
   ON rcv1.client_id = m.client_id
   AND
   (
     rcv1.dat_entry_rcv < m.migration_dat_valid_from  /* Wawi Laender */
     OR rcv1.dat_entry_rcv > m.migration_dat_valid_to  /* eLWIS rollback Laender */
   )
   INNER JOIN /* Delta */
   (
     SELECT DISTINCT
        rcv0.client_id
   ,rcv0.wh_loc_sid
   ,rcv0.dat_formdate
             FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving_1 rcv0
   INNER JOIN p_lew_process_ac.v_wfm_last_export_1 lexp
   ON lexp.process_name = 'export_wfm_wh_stock_mhd'
   AND lexp.process_specification = 'delta'
   AND rcv0.timestamp_mod > lexp.last_export_tmsp
   INNER JOIN p_lew_process_ac.v_wfm_export_specification_1 expo_spec
   ON lexp.export_specification = expo_spec.export_specification
   AND rcv0.client_id = expo_spec.client_id

) delta_filter
   ON rcv1.client_id = delta_filter.client_id
   AND rcv1.wh_loc_sid = delta_filter.wh_loc_sid
   AND rcv1.dat_formdate = delta_filter.dat_formdate

 WHERE rcv1.dat_min_durability_rcv IS NOT NULL
) rcv
   INNER JOIN p_lew_core_ac.v_client_1 cl
   ON rcv.client_id = cl.client_id
   INNER JOIN p_lew_core_ac.v_item_1 itm
   ON rcv.client_id = itm.client_id
   AND rcv.item_sid = itm.item_sid
   INNER JOIN p_lew_core_ac.v_location_1 loc
   ON rcv.client_id = loc.client_id
   AND rcv.wh_loc_sid = loc.loc_sid
   AND loc.wh_store_mark = 'B'

 WHERE itm.src_orig_item_nr <> '@NON_ITEM'  -- UserStory757565+INC11325722: Eleminate non cast-able values to protect CAST in line17

 GROUP BY 1,2,3,4
) mhd_wawi
;