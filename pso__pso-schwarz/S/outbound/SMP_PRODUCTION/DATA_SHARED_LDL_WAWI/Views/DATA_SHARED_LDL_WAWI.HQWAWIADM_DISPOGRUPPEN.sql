CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_dispogruppen (wawi_instanz_kzl, dispogrupnr,
dispogrupbez, datum, bediener, voraustage, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 dispogrupnr,
 dispogrupbez,
 datum,
 bediener,
 voraustage,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.dispogruppen;