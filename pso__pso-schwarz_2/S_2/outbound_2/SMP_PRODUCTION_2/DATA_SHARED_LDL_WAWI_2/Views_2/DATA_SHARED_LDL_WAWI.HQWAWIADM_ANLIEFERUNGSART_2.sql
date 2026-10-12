CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_anlieferungsart_2 (wawi_instanz_kzl,
anlieferungsartkzl, anlieferungsart_2, datum, bediener, sv_formula, scn, delete_fg, extraction_tmsp) AS SELECT
 anlieferungsart.wawi_instanz_kzl,
 anlieferungsart.anlieferungsartkzl,
 anlieferungsart.anlieferungsart_2,
 anlieferungsart.datum,
 anlieferungsart.bediener,
 anlieferungsart.sv_formula,
 anlieferungsart.scn,
 anlieferungsart.delete_fg,
 anlieferungsart.extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.anlieferungsart_2 AS anlieferungsart_2;