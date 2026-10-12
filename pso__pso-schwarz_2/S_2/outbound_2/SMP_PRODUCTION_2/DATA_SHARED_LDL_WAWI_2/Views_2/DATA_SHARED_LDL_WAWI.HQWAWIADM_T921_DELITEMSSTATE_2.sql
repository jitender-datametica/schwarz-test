CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t921_delitemsstate_2 (wawi_instanz_kzl, c921_batchnr
, c921_batchitemnr, c921_itemnr, c921_desc_long, c921_state, c921_moddate, c921_moduser, c921_whnr, c921_itemnr_short,
c921_errortable, c921_error_message, scn, delete_fg, extraction_tmsp) AS SELECT wawi_instanz_kzl,
 c921_batchnr,
 c921_batchitemnr,
 c921_itemnr,
 c921_desc_long,
 c921_state,
 c921_moddate,
 c921_moduser,
 c921_whnr,
 c921_itemnr_short,
 c921_errortable,
 c921_error_message,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t921_delitemsstate_2;