CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t200_pricegroup (wawi_instanz_kzl, c200_groupnr,
c200_groupdesc, c200_priority, c200_warehouse, c200_storenr, c200_editedby, c200_lastedited, c200_datefrom, c200_dateto
, c200_add_vatcode, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c200_groupnr,
 c200_groupdesc,
 c200_priority,
 c200_warehouse,
 c200_storenr,
 c200_editedby,
 c200_lastedited,
 c200_datefrom,
 c200_dateto,
 c200_add_vatcode,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t200_pricegroup;