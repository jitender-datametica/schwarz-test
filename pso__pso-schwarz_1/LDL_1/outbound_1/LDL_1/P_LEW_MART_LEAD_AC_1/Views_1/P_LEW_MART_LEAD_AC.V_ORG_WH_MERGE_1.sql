CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_org_wh_merge_1 (aspect_id, client_id, wh_id, loc_sid_wh, country_cd,
gl_region_id, dat_opening, costcenter_cd, company, order_buying_list_cd, vat_region_nr, region_cd, stock_plain, sponsion
, global_location_nr, wh_desc, distribute_wh_fg, int_fg, hq_fg, prop_wh_fg, sales_wh_fg, supp_wh_fg, wawi_data_fg,
ovis_data_fg, parent_wh_id, buying_region, street, city, phone_number) AS SELECT *
FROM ldl_p_lew_mart_lead.v_org_wh_merge_1;