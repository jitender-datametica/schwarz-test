CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t271_packagetype_1 (wawi_instanz_kzl, c271_packnr,
c271_packdescript, c271_eks_link, c271_int_short, c271_int_desc, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c271_packnr,
 c271_packdescript,
 c271_eks_link,
 c271_int_short,
 c271_int_desc,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t271_packagetype_1;