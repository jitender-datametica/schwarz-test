CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_item (brand, buying_list_orderset_nr, case_size, client_id,
country_cd, dat_valid_from, item_id, orig_item_nr, orig_item_nr_int, add_docs_fg, additions, age_fg, beverage_tax,
buyer_id, buyer_name, buying_list_type_id, buying_list_type_desc, brand_type_id
OPTIONS(description='the type of brand of an article (1=M, 2=EM, 3=HM)'), listing_type_id
OPTIONS(description='the type of listing article (1=Aktions-Artikel, 2=Ausgelistet, 3=Neu-Einlistung, 4=Normalsortiment, 5=Saison-Artikel, 6=Test-Artikel)'),
case_dd, case_depth, case_euro, case_height, case_layer, case_plu_fg, case_volume, case_weight, case_width, commodity_cd
, consumption_tax_main_id, consumption_tax_sub_id, cont_deposit_item_nr, contract_country_cd, dangerous_goods_fg,
dat_adv, dat_delisting, dat_listing, dat_min_shelflifetest_fg, delisting_fg, delivery_temp, direct_delete_mde_fg,
discount_fg, dualsystem_fg, dur_shelflife_day_cust, dur_shelflife_day_store, dur_shelflife_day_wh, food_fg,
forwarding_item_nr, int_subitemgroup_id, item_actiongroup_id, item_familygroup_id, item_parts, item_parts_cd,
item_plu_nr, item_short_desc_1, item_short_desc_2, item_short_desc_3, item_sub_actiongroup_id, item_text_1, item_text_2
, item_text_3, item_version, lidl_buying_country_cd, listing_fg, logistic_unit_cd, max_receive_temp, mdessp_fg,
mdm_cust_need_subtype_cd
OPTIONS(description='Code to classify the assortment by detailed customer needs.\n            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'),
mdm_cust_need_type_cd
OPTIONS(description='Code to classify the assortment by general customer needs.\n            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'),
min_case_dd, min_case_euro, min_case_layer, min_case_orderunit, min_receive_temp, minus_fg, net_case_weight,
net_piece_weight, order_area_cd, package_qty, packagetype_desc, packing, pct_consumption_tax, pct_discount,
period_id_shelflife_cust, period_id_shelflife_store, period_id_shelflife_wh, piece_depth, piece_height, piece_volume,
piece_weight, piece_width, piece_net_weight, poster_fg, price_sign_fg, price_strip_fg, qty_consumption_tax_add,
res_selltime, reusable_fg, scale_fg, season_fg, smallest_orderunit, smallest_unit, status_id_hq, stock_capacity,
subitemgroup_id, tax_refund_fg, taxation, type_cd, type_receive_temp_fg, unitsize, val_consumption_tax, val_deposit,
vat_id, wallow_nr, weight, weight_fg, wg_fg, write_off, buyer_name_int, case_size_dec, dur_shelflife_timeunits_cust,
dur_shelflife_timeunits_store, dur_shelflife_timeunits_wh, factor_period_cust, factor_period_store, factor_period_wh,
factor_shelflife_cust, factor_shelflife_store, factor_shelflife_wh, qty_min_piece_ordering, item_desc_at
OPTIONS(description='Artikel Landesspezifische Bezeichnung AT'), item_desc_be
OPTIONS(description='Artikel Landesspezifische Bezeichnung BE'), item_desc_be_fr
OPTIONS(description='Artikel Landesspezifische Bezeichnung BE_FR'), item_desc_bg
OPTIONS(description='Artikel Landesspezifische Bezeichnung BG'), item_desc_ch
OPTIONS(description='Artikel Landesspezifische Bezeichnung CH'), item_desc_cy
OPTIONS(description='Artikel Landesspezifische Bezeichnung CY'), item_desc_cz
OPTIONS(description='Artikel Landesspezifische Bezeichnung CZ'), item_desc
OPTIONS(description='Artikel Landesspezifische Bezeichnung'), item_desc_dk
OPTIONS(description='Artikel Landesspezifische Bezeichnung DK'), item_desc_ee
OPTIONS(description='Artikel Landesspezifische Bezeichnung EE'), item_desc_es
OPTIONS(description='Artikel Landesspezifische Bezeichnung ES'), item_desc_fi
OPTIONS(description='Artikel Landesspezifische Bezeichnung FI'), item_desc_fr
OPTIONS(description='Artikel Landesspezifische Bezeichnung FR'), item_desc_gb
OPTIONS(description='Artikel Landesspezifische Bezeichnung GB'), item_desc_gr
OPTIONS(description='Artikel Landesspezifische Bezeichnung GR'), item_desc_hr
OPTIONS(description='Artikel Landesspezifische Bezeichnung HR'), item_desc_hu
OPTIONS(description='Artikel Landesspezifische Bezeichnung HU'), item_desc_ie
OPTIONS(description='Artikel Landesspezifische Bezeichnung IE'), item_desc_it
OPTIONS(description='Artikel Landesspezifische Bezeichnung IT'), item_desc_lt
OPTIONS(description='Artikel Landesspezifische Bezeichnung LT'), item_desc_lv
OPTIONS(description='Artikel Landesspezifische Bezeichnung LV'), item_desc_ni
OPTIONS(description='Artikel Landesspezifische Bezeichnung NI'), item_desc_nl
OPTIONS(description='Artikel Landesspezifische Bezeichnung NL'), item_desc_de
OPTIONS(description='Artikel Landesspezifische Bezeichnung DE'), item_desc_pl
OPTIONS(description='Artikel Landesspezifische Bezeichnung PL'), item_desc_pt
OPTIONS(description='Artikel Landesspezifische Bezeichnung PT'), item_desc_ro
OPTIONS(description='Artikel Landesspezifische Bezeichnung RO'), item_desc_se
OPTIONS(description='Artikel Landesspezifische Bezeichnung SE'), item_desc_si
OPTIONS(description='Artikel Landesspezifische Bezeichnung SI'), item_desc_sk
OPTIONS(description='Artikel Landesspezifische Bezeichnung SK'), item_desc_cs
OPTIONS(description='Artikel Landesspezifische Bezeichnung CS'), item_desc_mt
OPTIONS(description='Artikel Landesspezifische Bezeichnung MT'), item_desc_us
OPTIONS(description='Artikel Landesspezifische Bezeichnung US'), item_desc_rs
OPTIONS(description='Artikel Landesspezifische Bezeichnung RS')) AS SELECT *
FROM ldl_p_lew_mart_lead.v_itm_item;