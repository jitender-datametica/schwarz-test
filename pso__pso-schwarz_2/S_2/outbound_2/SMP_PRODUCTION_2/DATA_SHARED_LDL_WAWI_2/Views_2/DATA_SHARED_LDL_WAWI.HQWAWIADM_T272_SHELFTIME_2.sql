CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t272_shelftime_2 (wawi_instanz_kzl, c272_shelft_nr,
c272_shelft_desc, c272_shelft_lt, c272_shelft_calc, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c272_shelft_nr,
 c272_shelft_desc,
 c272_shelft_lt,
 c272_shelft_calc,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t272_shelftime_2;