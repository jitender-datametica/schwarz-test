CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t83_formreason_2 (wawi_instanz_kzl, c83_formtype,
c83_reason, c83_shortdesc, c83_desc, c83_artgroup, c83_wgroup, c83_moduser, c83_moddate, c83_pcwo_reason, scn, delete_fg
, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c83_formtype,
 c83_reason,
 c83_shortdesc,
 c83_desc,
 c83_artgroup,
 c83_wgroup,
 c83_moduser,
 c83_moddate,
 c83_pcwo_reason,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t83_formreason_2;