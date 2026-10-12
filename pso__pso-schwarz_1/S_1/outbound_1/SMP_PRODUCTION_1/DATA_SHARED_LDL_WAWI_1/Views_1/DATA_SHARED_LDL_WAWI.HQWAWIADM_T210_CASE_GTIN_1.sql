CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t210_case_gtin_1 (wawi_instanz_kzl, c210_itemno,
c210_case_gtin, c210_desc, c210_order_gtin, c210_moduser, c210_moddate, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c210_itemno,
 c210_case_gtin,
 c210_desc,
 c210_order_gtin,
 c210_moduser,
 c210_moddate,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t210_case_gtin_1;