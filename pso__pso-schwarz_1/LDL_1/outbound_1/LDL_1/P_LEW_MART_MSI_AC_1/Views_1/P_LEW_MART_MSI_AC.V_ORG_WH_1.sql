CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_org_wh_1 (client_id, wh_id, country_cd, dat_opening, costcenter_cd, company
, order_buying_list_cd, vat_region_nr, region_cd, stock_plain, sponsion, global_location_nr, wh_desc, distribute_wh_fg,
int_fg, hq_fg, prop_wh_fg, sales_wh_fg, supp_wh_fg, wawi_data_fg, ovis_data_fg) AS SELECT *
FROM ldl_p_lew_mart_msi.v_org_wh_1;