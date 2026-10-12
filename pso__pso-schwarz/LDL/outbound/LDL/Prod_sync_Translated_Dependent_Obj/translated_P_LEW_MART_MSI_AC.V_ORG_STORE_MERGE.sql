CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_org_store_merge (store_id, client_id, dat_opening, dat_real_opening,
dat_closing, dat_valid_from, object_nr, licence_nr, pst_lang_cd, mde_print_cd, closed_fg, mde_lang_cd,
ord_unit_valid_store_cd, test_store_fg, transfer_fg, store_desc, orig_store_nr, wh_id, cnt_open_days, qty_min_dflt,
dat_calc_start_py, dat_calc_end_py, dat_calc_start_ppy, dat_opening_ovis, dat_closing_ovis, objectstatus_id,
mis_store_active_fg, move_to_store_id, move_fg, aspect_id, zipcode, city, street, postbox, phone, fax, zipcode_postbox,
modem, move_store_desc, wh_id_exp, sales_manager_id, longitude, latitude, account_manager_id, sales_manager_name,
account_manager_name, country_cd, gl_region_id, costcenter_cd, company, order_buying_list_cd, vat_region_nr, region_cd,
stock_plain, sponsion, global_location_nr, wh_desc, distribute_wh_fg, int_fg, hq_fg, prop_wh_fg, sales_wh_fg, supp_wh_fg
, wawi_data_fg, ovis_data_fg, parent_wh_id, buying_region, gl_region_desc, gl_last_name, gl_first_name, int_id,
country_iso_cd, country_group_id, lisy_sort, dashboard_relevant_fg, country_desc_at, country_desc_be, country_desc_be_fr
, country_desc_bg, country_desc_ch, country_desc_cy, country_desc_cz, country_desc, country_desc_dk, country_desc_ee,
country_desc_es, country_desc_fi, country_desc_fr, country_desc_gb, country_desc_gr, country_desc_hr, country_desc_hu,
country_desc_ie, country_desc_it, country_desc_lt, country_desc_lv, country_desc_ni, country_desc_nl, country_desc_de,
country_desc_pl, country_desc_pt, country_desc_ro, country_desc_se, country_desc_si, country_desc_sk, country_desc_cs,
country_desc_mt, country_desc_us, country_desc_rs, country_opening_date) AS SELECT *
FROM ldl_p_lew_mart_msi.v_org_store_merge;