CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_org_wh_sales AS
SELECT W.client_id,
 B.src_wh_id AS wh_id,
 W.dat_opening,
 W.costcenter_cd,
 W.company,
 W.order_buying_list_cd,
 W.vat_region_nr,
 W.region_cd,
 W.stock_plain,
 W.sponsion,
 W.global_location_nr,
 D.wh_desc,
 W.distribute_wh_fg,
 W.int_fg,
 W.hq_fg,
 W.prop_wh_fg,
 W.sales_wh_fg,
 W.supp_wh_fg,
 W.wawi_data_fg,
 W.ovis_data_fg,
 W.dat_rec_end,
 W.dat_rec_start
FROM ldl_p_lew_core_ac.v_wawi_org_wh_store AS S
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh AS W ON S.client_id = W.client_id AND S.wh_loc_sid = W.wh_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_desc AS D ON W.client_id = D.client_id AND W.wh_loc_sid = D.wh_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS B ON W.client_id = B.client_id AND W.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' -- Filialen

WHERE S.wh_type_id = 1
 AND CURRENT_DATE BETWEEN W.dat_rec_start AND W.dat_rec_end
GROUP BY W.client_id,
 wh_id,
 W.dat_opening,
 W.costcenter_cd,
 W.company,
 W.order_buying_list_cd,
 W.vat_region_nr,
 W.region_cd,
 W.stock_plain,
 W.sponsion,
 W.global_location_nr,
 D.wh_desc,
 W.distribute_wh_fg,
 W.int_fg,
 W.hq_fg,
 W.prop_wh_fg,
 W.sales_wh_fg,
 W.supp_wh_fg,
 W.wawi_data_fg,
 W.ovis_data_fg,
 W.dat_rec_end,
 W.dat_rec_start;