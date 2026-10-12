CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t711_wgi_1 (wawi_instanz_kzl, c711_wgi_id,
c711_nat_wgi_id, c711_item_group, c711_date_from, c711_date_to, c711_version, c711_int_desc, c711_nat_desc, c711_remarks
, c711_moduser, c711_moddate, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c711_wgi_id,
 c711_nat_wgi_id,
 c711_item_group,
 c711_date_from,
 c711_date_to,
 c711_version,
 c711_int_desc,
 c711_nat_desc,
 c711_remarks,
 c711_moduser,
 c711_moddate,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t711_wgi_1;