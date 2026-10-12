CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t227_supp_branch (wawi_instanz_kzl, c227_id,
c227_desc, c227_sap_branch, c227_mod_date, c227_mod_user, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c227_id,
 c227_desc,
 c227_sap_branch,
 c227_mod_date,
 c227_mod_user,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t227_supp_branch;