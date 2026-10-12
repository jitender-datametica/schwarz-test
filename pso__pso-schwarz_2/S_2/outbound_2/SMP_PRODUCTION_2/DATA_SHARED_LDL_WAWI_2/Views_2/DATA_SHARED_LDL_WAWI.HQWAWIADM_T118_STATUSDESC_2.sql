CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t118_statusdesc_2 (wawi_instanz_kzl, c118_status,
c118_statusdesc, c118_hq, c118_wh, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c118_status,
 c118_statusdesc,
 c118_hq,
 c118_wh,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t118_statusdesc_2;