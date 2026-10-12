CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t308_dependent_sp_2 (wawi_instanz_kzl, c308_id,
c308_head_id, c308_detail_id, c308_subtype_head, c308_subtype_detail, c308_moduser, c308_moddate, scn, delete_fg,
extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c308_id,
 c308_head_id,
 c308_detail_id,
 c308_subtype_head,
 c308_subtype_detail,
 c308_moduser,
 c308_moddate,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t308_dependent_sp_2;