CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t931_vat_convert (wawi_instanz_kzl, c931_storenr,
c931_vatcode_wawi, c931_vatcode_converted, c931_countrycode, c931_moddate, c931_moduser, c931_type, scn, delete_fg,
extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c931_storenr,
 c931_vatcode_wawi,
 c931_vatcode_converted,
 c931_countrycode,
 c931_moddate,
 c931_moduser,
 c931_type,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t931_vat_convert;