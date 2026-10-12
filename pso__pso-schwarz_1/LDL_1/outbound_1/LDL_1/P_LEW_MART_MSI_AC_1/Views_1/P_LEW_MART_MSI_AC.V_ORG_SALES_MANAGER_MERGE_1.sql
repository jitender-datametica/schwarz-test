CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_org_sales_manager_merge_1 (aspect_id, client_id, wh_id, wh_id_exp,
sales_manager_id, account_manager_id, sales_manager_name, account_manager_name, country_cd, gl_region_id, dat_opening,
costcenter_cd, company, order_buying_list_cd, vat_region_nr, region_cd, stock_plain, sponsion, global_location_nr,
wh_desc, distribute_wh_fg, int_fg, hq_fg, prop_wh_fg, sales_wh_fg, supp_wh_fg, wawi_data_fg, ovis_data_fg, parent_wh_id
, buying_region, gl_region_desc, gl_last_name, gl_first_name, int_id, country_iso_cd, country_group_id, lisy_sort,
dashboard_relevant_fg, country_desc_at, country_desc_be, country_desc_be_fr, country_desc_bg, country_desc_ch,
country_desc_cy, country_desc_cz, country_desc, country_desc_dk, country_desc_ee, country_desc_es, country_desc_fi,
country_desc_fr, country_desc_gb, country_desc_gr, country_desc_hr, country_desc_hu, country_desc_ie, country_desc_it,
country_desc_lt, country_desc_lv, country_desc_ni, country_desc_nl, country_desc_de, country_desc_pl, country_desc_pt,
country_desc_ro, country_desc_se, country_desc_si, country_desc_sk, country_desc_cs, country_desc_mt, country_desc_us,
country_desc_rs, country_opening_date) AS SELECT *
FROM ldl_p_lew_mart_msi.v_org_sales_manager_merge_1;