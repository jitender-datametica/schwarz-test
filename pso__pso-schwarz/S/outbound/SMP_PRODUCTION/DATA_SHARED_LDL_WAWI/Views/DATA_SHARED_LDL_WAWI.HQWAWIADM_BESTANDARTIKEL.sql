CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_bestandartikel (wawi_instanz_kzl, datum, artikelnr
, moving_stock, menge, retail_price, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 datum,
 artikelnr,
 moving_stock,
 menge,
 retail_price,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.bestandartikel;