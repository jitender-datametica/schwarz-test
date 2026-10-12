CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_org_wh_orig_2 AS
SELECT WH.client_id,
 WH.src_wh_id AS wh_id,
 COALESCE(WH.country_pol_cd, WH_WAWI.country_cd) AS country_cd,
 WH.opening_dt AS dat_opening,
 WH_WAWI.costcenter_cd,
 WH_WAWI.company,
 WH_WAWI.order_buying_list_cd,
 WH_WAWI.vat_region_nr,
 WH_WAWI.region_cd,
 WH_WAWI.stock_plain,
 WH_WAWI.sponsion,
 WH_WAWI.global_location_nr,
 WH.loc_name AS wh_desc,
 WH_WAWI.distribute_wh_fg,
 WH_WAWI.int_fg,
 WH_WAWI.hq_fg,
 WH_WAWI.prop_wh_fg,
 WH_WAWI.sales_wh_fg,
 WH_WAWI.supp_wh_fg,
 WH_WAWI.wawi_data_fg,
 WH_WAWI.ovis_data_fg
FROM ldl_p_lew_bil_ac.v_warehouse_2 AS WH
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_wh_2 AS WH_WAWI ON WH.loc_sid_wh = WH_WAWI.wh_loc_sid AND WH.client_id = WH_WAWI.client_id
     AND CURRENT_DATE BETWEEN WH_WAWI.dat_rec_start AND WH_WAWI.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON WH.client_id = MIG.client_id
WHERE WH.dwh_actual_fg = 1
 AND WH.src_wh_id > 0
 AND (WH_WAWI.wawi_data_fg = 1 OR CASE
     WHEN MIG.active_fg = 1 AND WH.global_loc_id_length = 7 AND WH.global_loc_type_cd = '9' AND WH_WAWI.country_cd
      IS NOT NULL
     THEN 1
     ELSE 0
     END = 1);