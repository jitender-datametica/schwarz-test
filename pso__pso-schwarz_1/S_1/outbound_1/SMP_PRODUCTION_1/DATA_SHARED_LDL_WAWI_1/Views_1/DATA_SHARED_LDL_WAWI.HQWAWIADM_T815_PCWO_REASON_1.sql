CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t815_pcwo_reason_1 (wawi_instanz_kzl, c815_reason_id
, c815_reason_id_int, c815_grp_id, c815_reason_desc_int, c815_reason_desc_nat, c815_grp_desc, c815_active_flag,
c815_bnl_grp, c815_new_grp, c815_moddate, c815_moduser, scn, c815_displaytype, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c815_reason_id,
 c815_reason_id_int,
 c815_grp_id,
 c815_reason_desc_int,
 c815_reason_desc_nat,
 c815_grp_desc,
 c815_active_flag,
 c815_bnl_grp,
 c815_new_grp,
 c815_moddate,
 c815_moduser,
 scn,
 c815_displaytype,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t815_pcwo_reason_1;