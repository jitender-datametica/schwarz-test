CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t309_pricecond (wawi_instanz_kzl, c309_pricecondnr
, c309_spsubnr, c309_validfrom, c309_validuntil, c309_value, c309_currency, c309_moddate, c309_moduser, scn, delete_fg,
extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c309_pricecondnr,
 c309_spsubnr,
 c309_validfrom,
 c309_validuntil,
 c309_value,
 c309_currency,
 c309_moddate,
 c309_moduser,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t309_pricecond;