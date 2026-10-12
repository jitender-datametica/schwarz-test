CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_umrechkurs_1 (wawi_instanz_kzl, waehrungsknz_1,
gueltig_ab, einheit, datum, bediener, umrechnungskurs, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 waehrungsknz_1,
 gueltig_ab,
 einheit,
 datum,
 bediener,
 umrechnungskurs,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.umrechkurs_1;