CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_kreditorengruppe_2 (wawi_instanz_kzl,
kreditorgruppennr, kreditorgruppenbez, datum, bediener, globalkreditor, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 kreditorgruppennr,
 kreditorgruppenbez,
 datum,
 bediener,
 globalkreditor,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.kreditorengruppe_2;