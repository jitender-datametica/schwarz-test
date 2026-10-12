/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_sup_supplier_hist_2 (client_id, supplier_id, supplier_name,
supplier_search_name, dat_rec_start, dat_rec_end, dat_valid_from, suppliergroup_id, delivery_item_cd, vat_id,
order_area_cd, currency_iso_cd, invoice_entry_fg, intercompany_cd, licence_cd, title_cd, vat_ident_nr, broken_item_limit
, finance_office, turnover_cd, dcw_supplier_nr, branch_id, branch_desc, region_id, region_desc, global_location_nr,
supplier_category_id, supplier_customer_nr, supplier_tax_cd, supplier_short_nr, supplier_name2, supplier_name3,
supplier_text_1, supplier_text_2, supplier_text_3, supplier_text_4, supplier_text_5, main_negot_cntry_cd,
agg_co_negot_cntry_cd) AS SELECT *
FROM ldl_p_lew_mart_msi.v_sup_supplier_hist_2;