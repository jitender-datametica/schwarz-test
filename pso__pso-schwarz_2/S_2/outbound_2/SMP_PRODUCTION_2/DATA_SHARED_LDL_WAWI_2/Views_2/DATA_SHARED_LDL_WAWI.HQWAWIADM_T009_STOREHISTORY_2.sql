CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t009_storehistory_2 (wawi_instanz_kzl, c009_storeno,
c009_warehouseno, c009_datefrom, c009_dateuntil, c009_moduser, c009_moddate, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c009_storeno,
 c009_warehouseno,
 c009_datefrom,
 c009_dateuntil,
 c009_moduser,
 c009_moddate,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t009_storehistory_2;