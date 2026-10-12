CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_dispoeinheit_2 (wawi_instanz_kzl, disponr,
dispoeinheit_2, datum, bediener, sql_beziehung, shortdesc, scn, delete_fg, extraction_tmsp) AS SELECT dispoeinheit.wawi_instanz_kzl
 ,
 dispoeinheit.disponr,
 dispoeinheit.dispoeinheit_2,
 dispoeinheit.datum,
 dispoeinheit.bediener,
 dispoeinheit.sql_beziehung,
 dispoeinheit.shortdesc,
 dispoeinheit.scn,
 dispoeinheit.delete_fg,
 dispoeinheit.extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.dispoeinheit_2 AS dispoeinheit_2;