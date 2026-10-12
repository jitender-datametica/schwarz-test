CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t038_itemfamily_1 (wawi_instanz_kzl, c038_family_id,
c038_itemgrpnr, c038_prodgrpnr, c038_family_code, c038_desc_long, c038_desc_short, c038_mod_date, c038_mod_user,
c038_mmo_calculation_flag, c038_pst_print_flag, c038_mmo_modify_flag, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c038_family_id,
 c038_itemgrpnr,
 c038_prodgrpnr,
 c038_family_code,
 c038_desc_long,
 c038_desc_short,
 c038_mod_date,
 c038_mod_user,
 c038_mmo_calculation_flag,
 c038_pst_print_flag,
 c038_mmo_modify_flag,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t038_itemfamily_1;