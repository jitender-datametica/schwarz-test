CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t216_int_supplier_1 (wawi_instanz_kzl,
c216_int_suppnr, c216_suppnr, c216_int_suppdesc, c216_moddate, c216_moduser, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c216_int_suppnr,
 c216_suppnr,
 c216_int_suppdesc,
 c216_moddate,
 c216_moduser,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t216_int_supplier_1;