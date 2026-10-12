CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_warehouse_processing_1 (wh_order_pos_nr, wh_order_nr, wave_id,
task_id, wh_process_type_cd, wh_task_status_cd, wh_task_confirm_tmsp, wh_task_confirm_hour, wh_task_create_tmsp,
sort_track_name, sort_track_group, pack_sort_track_name, pack_sort_track_group, dest_storage_unit_nr, prod_qty, wh_sid,
tgt_pick_qty, max_wave_qty, actual_pick_qty, wshop_cd, dist_channel_cd, wh_order_process, out_invoice_dt,
wh_order_ship_type_name, is_order_in_progress_fg, wh_task_processing_status_cd, is_task_in_progress_fg) AS SELECT L.wh_order_pos_nr
 ,
 L.wh_order_nr,
 P.wave_id,
 P.task_id,
  CASE
  WHEN P.wh_process_type_cd = ''
  THEN '-1'
  ELSE IFNULL(P.wh_process_type_cd, '-1')
  END AS wh_process_type_cd,
  CASE
  WHEN P.wh_task_status_cd = ''
  THEN '-1'
  ELSE IFNULL(P.wh_task_status_cd, '-1')
  END AS wh_task_status_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(P.wh_task_confirm_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS wh_task_confirm_tmsp,
 EXTRACT(HOUR FROM P.wh_task_confirm_tmsp) AS wh_task_confirm_hour,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(P.wh_task_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS wh_task_create_tmsp,
 P.sort_track_name,
  CASE
  WHEN LEFT(P.sort_track_name, 2) = 'P0'
  THEN 'P0'
  WHEN LEFT(P.sort_track_name, 2) = 'P1'
  THEN 'P1'
  WHEN LEFT(P.sort_track_name, 2) = 'P2'
  THEN 'P2'
  WHEN LEFT(P.sort_track_name, 2) = 'P3'
  THEN 'P3'
  WHEN LEFT(P.sort_track_name, 2) = 'P4'
  THEN 'P4'
  WHEN LEFT(P.sort_track_name, 2) = 'P5'
  THEN 'P5'
  WHEN LEFT(P.sort_track_name, 2) = 'P6'
  THEN 'P6'
  WHEN LEFT(P.sort_track_name, 2) = 'P7'
  THEN 'P7'
  WHEN LEFT(P.sort_track_name, 2) = 'P8'
  THEN 'P8'
  ELSE 'Sonstiges'
  END AS sort_track_group,
  CASE
  WHEN P.pack_sort_track_name = ''
  THEN '-1'
  ELSE IFNULL(P.pack_sort_track_name, '-1')
  END AS pack_sort_track_name,
  CASE
  WHEN LEFT(P.pack_sort_track_name, 2) = 'SW'
  THEN 'Batch'
  WHEN LEFT(P.pack_sort_track_name, 3) = 'EPO'
  THEN 'Singles'
  ELSE 'MEPO'
  END AS pack_sort_track_group,
  CASE
  WHEN P.dest_storage_unit_nr = ''
  THEN '-1'
  ELSE IFNULL(P.dest_storage_unit_nr, '-1')
  END AS dest_storage_unit_nr,
 P.prod_qty,
 P.wh_sid,
 P.tgt_pick_qty,
 P.max_wave_qty,
 P.actual_pick_qty,
  CASE
  WHEN L.wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(L.wshop_cd, '-1')
  END AS wshop_cd,
 L.dist_channel_cd,
  CASE
  WHEN L.wh_order_doc_type_cd IN ('ZPLW', 'ZEPL')
  THEN 'EPO'
  WHEN L.wh_order_doc_type_cd IN ('ZEPO', 'ZEPG', 'ZEPW')
  THEN 'MEPO'
  WHEN L.wh_order_doc_type_cd IN ('ZMPG', 'ZMPO', 'ZEPT', 'ZMPT', 'ZMPW')
  THEN 'Batch'
  ELSE 'Sonstige'
  END AS wh_order_process,
 L.out_invoice_dt,
 L.wh_order_ship_type_name,
 L.is_order_in_progress_fg,
 P.wh_task_processing_status_cd,
 NULL AS is_task_in_progress_fg
FROM ldl_dig_lec_share.v_fact_warehouse_processing_1 AS P
 INNER JOIN ldl_dig_lec_share.v_fact_warehouse_order_line_1 AS L ON P.wh_order_sid = L.wh_order_sid AND P.wh_order_pos_sid
    = L.wh_order_pos_sid
WHERE L.dwh_valid_fg
 AND P.dwh_valid_fg;