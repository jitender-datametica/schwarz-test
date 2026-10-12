CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t215_int_itemnr_1 (wawi_instanz_kzl, c215_int_itemnr
, c215_itemnr, c215_int_itemdesc, c215_casesize, c215_moddate, c215_moduser, c215_int_itemnrsho, c215_active,
c215_is_main_link, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c215_int_itemnr,
 c215_itemnr,
 c215_int_itemdesc,
 c215_casesize,
 c215_moddate,
 c215_moduser,
 c215_int_itemnrsho,
 c215_active,
 c215_is_main_link,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t215_int_itemnr_1;