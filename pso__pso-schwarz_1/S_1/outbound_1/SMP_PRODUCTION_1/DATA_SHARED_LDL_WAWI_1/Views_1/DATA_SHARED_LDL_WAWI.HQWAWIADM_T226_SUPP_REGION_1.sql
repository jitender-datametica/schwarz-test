CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t226_supp_region_1 (wawi_instanz_kzl, c226_id,
c226_country, c226_region, c226_desc, c226_sap_region, c226_mod_date, c226_mod_user, scn, delete_fg, extraction_tmsp) AS
SELECT wawi_instanz_kzl,
 c226_id,
 c226_country,
 c226_region,
 c226_desc,
 c226_sap_region,
 c226_mod_date,
 c226_mod_user,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t226_supp_region_1;