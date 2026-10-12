CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t108_euro_umrechk_2 (wawi_instanz_kzl,
c108_waehrungsknz, c108_gueltig_ab, c108_einheit, c108_datum, c108_bediener, c108_umrechkurs, scn, delete_fg,
extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c108_waehrungsknz,
 c108_gueltig_ab,
 c108_einheit,
 c108_datum,
 c108_bediener,
 c108_umrechkurs,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t108_euro_umrechk_2;