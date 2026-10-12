CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t306_spcondsubtype_2 (wawi_instanz_kzl, c306_spsubnr
, c306_spcondnr, c306_spsubtype, c306_spsubdesc, c306_spsubmatchabl, c306_spsubinclmarg, c306_spsubsign, c306_weightcond
, c306_assignspcond, c306_spsubcondtype, scn, c306_active_flag, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c306_spsubnr,
 c306_spcondnr,
 c306_spsubtype,
 c306_spsubdesc,
 c306_spsubmatchabl,
 c306_spsubinclmarg,
 c306_spsubsign,
 c306_weightcond,
 c306_assignspcond,
 c306_spsubcondtype,
 scn,
 c306_active_flag,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t306_spcondsubtype_2;