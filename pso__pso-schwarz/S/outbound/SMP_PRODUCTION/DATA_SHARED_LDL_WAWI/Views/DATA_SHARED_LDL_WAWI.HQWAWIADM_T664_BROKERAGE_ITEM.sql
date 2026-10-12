CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t664_brokerage_item (wawi_instanz_kzl, c664_group,
c664_desc, c664_item, c664_std_flag, c664_modset, c664_moddate, c664_moduser, scn, c664_id, delete_fg, extraction_tmsp)
AS SELECT wawi_instanz_kzl,
 c664_group,
 c664_desc,
 c664_item,
 c664_std_flag,
 c664_modset,
 c664_moddate,
 c664_moduser,
 scn,
 c664_id,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t664_brokerage_item;