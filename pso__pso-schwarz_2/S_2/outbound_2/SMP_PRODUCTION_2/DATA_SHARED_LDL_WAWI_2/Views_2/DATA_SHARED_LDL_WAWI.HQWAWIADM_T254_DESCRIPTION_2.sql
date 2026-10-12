CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t254_description_2 (wawi_instanz_kzl, c254_orgdesc,
c254_translation, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c254_orgdesc,
 c254_translation,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t254_description_2;