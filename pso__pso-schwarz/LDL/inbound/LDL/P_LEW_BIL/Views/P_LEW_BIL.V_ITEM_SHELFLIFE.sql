CREATE OR REPLACE VIEW p_lew_bil.v_item_shelflife
AS
   SELECT
   item.client_id,
   item.item_sid,
   item.item_name,
   COALESCE(imloh.dur_shelflife_day_cust, wiia.dur_shelflife_day_cust)   AS dur_shelflife_day_cust,
   COALESCE(imloh.dur_shelflife_day_store, wiia.dur_shelflife_day_store) AS dur_shelflife_day_store,
   COALESCE(imloh.dur_shelflife_day_wh, wiia.dur_shelflife_day_wh)       AS dur_shelflife_day_wh,
   COALESCE(wiia.period_id_shelflife_cust, -1)                           AS period_id_shelflife_cust,
   COALESCE(wiia.period_id_shelflife_store, -1)                          AS period_id_shelflife_store,
   COALESCE(wiia.period_id_shelflife_wh, -1)                             AS period_id_shelflife_wh
   FROM p_lew_core_ac.v_item item
   INNER JOIN p_lew_process_ac.v_sap_migration_client c
   ON item.client_id = c.client_id
   LEFT OUTER JOIN (SELECT
   it.client_id,
   it.item_sid,
   MIN( CASE
                          WHEN it.shelflife_cust_cd IS NULL THEN it.shelflife_cust_val
                          WHEN it.shelflife_cust_cd = 2     THEN it.shelflife_cust_val*30
                     END) dur_shelflife_day_cust,
   MIN( CASE
                          WHEN it.shelflife_loc_cd IS NULL THEN it.shelflife_loc_val
                          WHEN it.shelflife_loc_cd = 2     THEN it.shelflife_loc_val*30
                     END) dur_shelflife_day_store,
   MIN( CASE
                          WHEN it.shelflife_vz_cd IS NULL THEN it.shelflife_vz_val
                          WHEN it.shelflife_vz_cd = 2     THEN it.shelflife_vz_val*30
                      END) dur_shelflife_day_wh
   FROM p_lew_core_ac.v_item_info_per_location_hist it
   INNER JOIN p_lew_bil.v_warehouse wh
   ON wh.client_id = it.client_id
   AND wh.loc_sid_wh = it.loc_sid
   AND wh.bges_active_fg=1
   AND wh.dwh_actual_fg=1

   WHERE CURRENT_DATE BETWEEN it.dwh_valid_from AND it.dwh_valid_to
   AND  it.deleted_fg = 0

   GROUP BY 1,2
) imloh
   ON item.client_id = imloh.client_id
   AND item.item_sid = imloh.item_sid
   AND c.migrated_fg = 1
   LEFT OUTER JOIN (SELECT
   client_id,
   item_sid,
   dur_shelflife_day_cust,
   dur_shelflife_day_store,
   dur_shelflife_day_wh,
   period_id_shelflife_cust,
   period_id_shelflife_store,
   period_id_shelflife_wh
   FROM p_lew_core_ac.v_wawi_itm_item_act
          ) wiia
   ON item.client_id = wiia.client_id
   AND item.item_sid = wiia.item_sid

   WHERE imloh.client_id IS NOT NULL
   OR  wiia.client_id IS NOT NULL /*
   #DescStart#
   #$Revision: 13473 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Artikelstamm
   #DescEnd#
   */
   ;


