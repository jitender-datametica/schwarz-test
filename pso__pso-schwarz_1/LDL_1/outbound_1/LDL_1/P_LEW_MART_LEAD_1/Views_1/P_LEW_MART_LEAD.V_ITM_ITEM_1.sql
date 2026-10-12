/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead.v_itm_item_1
#----------------------------------------------------------------------------
# History:
#  1.0  16.11.2020    Białek, Aleksander           Initial
#  1.1  16.08.2021    Bachmann, Torsten            REP3-8664, PatchNo 2905: Add columns brand_type_id and listing_type_id
#  1.2  25.05.2022    Bachmann, Torsten            AP0130638: ADO 320075: combine t_itm_item_1 and MSI.t_itm_item_desc_1 to reduce join
#  1.3  18.07.2022    Bachmann, Torsten            AP0139596: ADO 350680: INC4996687 added column ITEM_DESC_BE_FR
#  1.4  03.01.2025    Yeddulapalli, Bharat         AP0097106: ADO 703883: Nettogewicht
#  1.5  27.01.2025    Bachmann, Torsten            AP0252180: ADO 723523: Add mdm_cust_need_type_cd for Attribute Bedürfniswelt
#  1.6  16.05.2025    Bachmann, Torsten            AP0269439: ADO 747012: Add mdm_cust_need_subtype_cd for Attribute Bedürfniskategorie
#----------------------------------------------------------------------------
*/


/* DescStart
$Revision: 17242 $, $LastChangedBy: tbachmann $
SubjectAreas: Artikelstamm
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_itm_item_1 (brand_1, buying_list_orderset_nr, case_size, client_id, country_cd
, dat_valid_from, item_id, orig_item_nr, orig_item_nr_int, add_docs_fg, additions, age_fg, beverage_tax, buyer_id,
buyer_name, buying_list_type_id, buying_list_type_desc, brand_type_id
OPTIONS(description='the type of brand_1 of an article (1=m, 2=em, 3=hm)'), listing_type_id
OPTIONS(description='the type of listing article (1=aktions-artikel_1, 2=ausgelistet, 3=neu-einlistung, 4=normalsortiment, 5=saison-artikel_1, 6=test_1-artikel_1)'),
case_dd, case_depth, case_euro, case_height, case_layer, case_plu_fg, case_volume, case_weight, case_width, commodity_cd
, consumption_tax_main_id, consumption_tax_sub_id, cont_deposit_item_nr, contract_country_cd, dangerous_goods_fg,
dat_adv, dat_delisting, dat_listing, dat_min_shelflifetest_fg, delisting_fg, delivery_temp, direct_delete_mde_fg,
discount_fg, dualsystem_fg, dur_shelflife_day_cust, dur_shelflife_day_store, dur_shelflife_day_wh, food_fg,
forwarding_item_nr, int_subitemgroup_id, item_actiongroup_id, item_familygroup_id, item_parts, item_parts_cd,
item_plu_nr, item_short_desc_1, item_short_desc_2, item_short_desc_3, item_sub_actiongroup_id, item_text_1, item_text_2
, item_text_3, item_version, lidl_buying_country_cd, listing_fg, logistic_unit_cd, max_receive_temp, mdessp_fg,
mdm_cust_need_subtype_cd
OPTIONS(description='''Code to classify the assortment by detailed customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'''),
mdm_cust_need_type_cd
OPTIONS(description='''Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'''),
min_case_dd, min_case_euro, min_case_layer, min_case_orderunit, min_receive_temp, minus_fg, net_case_weight,
net_piece_weight, order_area_cd, package_qty, packagetype_desc, packing, pct_consumption_tax, pct_discount,
period_id_shelflife_cust, period_id_shelflife_store, period_id_shelflife_wh, piece_depth, piece_height, piece_volume,
piece_weight, piece_width, piece_net_weight, poster_fg, price_sign_fg, price_strip_fg, qty_consumption_tax_add,
res_selltime, reusable_fg, scale_fg, season_fg, smallest_orderunit, smallest_unit, status_id_hq, stock_capacity,
subitemgroup_id, tax_refund_fg, taxation, type_cd, type_receive_temp_fg, unitsize, val_consumption_tax, val_deposit,
vat_id, wallow_nr, weight, weight_fg, wg_fg, write_off, buyer_name_int, case_size_dec, dur_shelflife_timeunits_cust,
dur_shelflife_timeunits_store, dur_shelflife_timeunits_wh, factor_period_cust, factor_period_store, factor_period_wh,
factor_shelflife_cust, factor_shelflife_store, factor_shelflife_wh, qty_min_piece_ordering, item_desc_at
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung AT'), item_desc_be
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung BE'), item_desc_be_fr
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung BE_FR'), item_desc_bg
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung BG'), item_desc_ch
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung CH'), item_desc_cy
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung CY'), item_desc_cz
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung CZ'), item_desc
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung'), item_desc_dk
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung DK'), item_desc_ee
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung EE'), item_desc_es
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung ES'), item_desc_fi
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung FI'), item_desc_fr
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung FR'), item_desc_gb
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung GB'), item_desc_gr
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung GR'), item_desc_hr
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung HR'), item_desc_hu
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung HU'), item_desc_ie
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung IE'), item_desc_it
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung IT'), item_desc_lt
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung LT'), item_desc_lv
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung LV'), item_desc_ni
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung NI'), item_desc_nl
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung NL'), item_desc_de
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung DE'), item_desc_pl
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung PL'), item_desc_pt
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung PT'), item_desc_ro
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung RO'), item_desc_se
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung SE'), item_desc_si
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung SI'), item_desc_sk
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung SK'), item_desc_cs
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung CS'), item_desc_mt
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung MT'), item_desc_us
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung US'), item_desc_rs
OPTIONS(description='Artikel_1 Landesspezifische Bezeichnung RS_1')) AS SELECT brand_1,
 buying_list_orderset_nr,
 case_size,
 client_id,
 country_cd,
 dat_valid_from,
 item_id,
 orig_item_nr,
 orig_item_nr_int,
 add_docs_fg,
 additions,
 age_fg,
 beverage_tax,
 buyer_id,
 buyer_name,
 buying_list_type_id,
 buying_list_type_desc,
 brand_type_id,
 listing_type_id,
 case_dd,
 case_depth,
 case_euro,
 case_height,
 case_layer,
 case_plu_fg,
 case_volume,
 case_weight,
 case_width,
 commodity_cd,
 consumption_tax_main_id,
 consumption_tax_sub_id,
 cont_deposit_item_nr,
 contract_country_cd,
 dangerous_goods_fg,
 dat_adv,
 dat_delisting,
 dat_listing,
 dat_min_shelflifetest_fg,
 delisting_fg,
 delivery_temp,
 direct_delete_mde_fg,
 discount_fg,
 dualsystem_fg,
 dur_shelflife_day_cust,
 dur_shelflife_day_store,
 dur_shelflife_day_wh,
 food_fg,
 forwarding_item_nr,
 int_subitemgroup_id,
 item_actiongroup_id,
 item_familygroup_id,
 item_parts,
 item_parts_cd,
 item_plu_nr,
 item_short_desc_1,
 item_short_desc_2,
 item_short_desc_3,
 item_sub_actiongroup_id,
 item_text_1,
 item_text_2,
 item_text_3,
 item_version,
 lidl_buying_country_cd,
 listing_fg,
 logistic_unit_cd,
 max_receive_temp,
 mdessp_fg,
 mdm_cust_need_subtype_cd,
 mdm_cust_need_type_cd,
 min_case_dd,
 min_case_euro,
 min_case_layer,
 min_case_orderunit,
 min_receive_temp,
 minus_fg,
 net_case_weight,
 net_piece_weight,
 order_area_cd,
 package_qty,
 packagetype_desc,
 packing,
 pct_consumption_tax,
 pct_discount,
 period_id_shelflife_cust,
 period_id_shelflife_store,
 period_id_shelflife_wh,
 piece_depth,
 piece_height,
 piece_volume,
 piece_weight,
 piece_width,
 piece_net_weight,
 poster_fg,
 price_sign_fg,
 price_strip_fg,
 qty_consumption_tax_add,
 res_selltime,
 reusable_fg,
 scale_fg,
 season_fg,
 smallest_orderunit,
 smallest_unit,
 status_id_hq,
 stock_capacity,
 subitemgroup_id,
 tax_refund_fg,
 taxation,
 type_cd,
 type_receive_temp_fg,
 unitsize,
 val_consumption_tax,
 val_deposit,
 vat_id,
 wallow_nr,
 weight,
 weight_fg,
 wg_fg,
 write_off,
 buyer_name_int,
 case_size_dec,
 dur_shelflife_timeunits_cust,
 dur_shelflife_timeunits_store,
 dur_shelflife_timeunits_wh,
 factor_period_cust,
 factor_period_store,
 factor_period_wh,
 factor_shelflife_cust,
 factor_shelflife_store,
 factor_shelflife_wh,
 qty_min_piece_ordering,
 item_desc_at,
 item_desc_be,
 item_desc_be AS item_desc_be_fr,
 item_desc_bg,
 item_desc_ch,
 item_desc_cy,
 item_desc_cz,
 item_desc,
 item_desc_dk,
 item_desc_ee,
 item_desc_es,
 item_desc_fi,
 item_desc_fr,
 item_desc_gb,
 item_desc_gr,
 item_desc_hr,
 item_desc_hu,
 item_desc_ie,
 item_desc_it,
 item_desc_lt,
 item_desc_lv,
 item_desc_ni,
 item_desc_nl,
 item_desc_de,
 item_desc_pl,
 item_desc_pt,
 item_desc_ro,
 item_desc_se,
 item_desc_si,
 item_desc_sk,
 item_desc_cs,
 item_desc_mt,
 item_desc_us,
 item_desc_rs
FROM ldl_p_lew_mart_lead.t_itm_item_1;