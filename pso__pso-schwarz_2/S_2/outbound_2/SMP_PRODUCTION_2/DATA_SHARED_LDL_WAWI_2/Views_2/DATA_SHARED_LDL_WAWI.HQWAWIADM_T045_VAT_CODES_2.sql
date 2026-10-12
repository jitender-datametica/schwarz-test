CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t045_vat_codes_2 (wawi_instanz_kzl, c045_vatcode,
c045_countrycode, c045_vatdesc, c045_moddate, c045_moduser, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl
 ,
 c045_vatcode,
 c045_countrycode,
 c045_vatdesc,
 c045_moddate,
 c045_moduser,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t045_vat_codes_2;