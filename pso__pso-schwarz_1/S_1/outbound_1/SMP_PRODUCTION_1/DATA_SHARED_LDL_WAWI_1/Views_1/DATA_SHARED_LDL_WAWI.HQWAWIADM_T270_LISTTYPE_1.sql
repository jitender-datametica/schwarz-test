CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t270_listtype_1 (wawi_instanz_kzl, c270_listnr,
c270_listdescript, c270_eks_link, scn, c270_main_type, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c270_listnr,
 c270_listdescript,
 c270_eks_link,
 scn,
 c270_main_type,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t270_listtype_1;