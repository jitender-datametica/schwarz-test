CREATE OR REPLACE VIEW smp_production_data_shared_ldl_wawi.hqwawiadm_t920_delitems_1 (wawi_instanz_kzl, c920_batchnr,
c920_batchdate, c920_batchitemnr, c920_itemnr_short, c920_state, c920_closed, c920_moddate, c920_moduser, c920_itemdesc
, c920_errortable, c920_error_message, c920_released_by, c920_created_by, scn, delete_fg, extraction_tmsp) AS SELECT
 wawi_instanz_kzl,
 c920_batchnr,
 c920_batchdate,
 c920_batchitemnr,
 c920_itemnr_short,
 c920_state,
 c920_closed,
 c920_moddate,
 c920_moduser,
 c920_itemdesc,
 c920_errortable,
 c920_error_message,
 c920_released_by,
 c920_created_by,
 scn,
 delete_fg,
 extraction_tmsp
FROM ldl_wawi_production_hqwawiadm.t920_delitems_1;