CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_warehouse_order_line_1 AS WITH CTE_WAREHOUSE_PROCESSING_TABLE AS
  (SELECT FACT.wh_order_sid,
   FACT.wh_order_pos_nr,
   FACT.wh_sid,
   MAX(FACT.wh_task_confirm_tmsp) AS wh_task_confirm_tmsp,
   MAX(FACT.sort_track_name) AS sort_track_name,
   MAX(FACT.pack_sort_track_name) AS pack_sort_track_name,
   MAX(FACT.sort_trolley_name) AS sort_trolley_name,
   MAX(FACT.dest_storage_unit_nr) AS dest_storage_unit_nr,
   COALESCE(MAX(FACT.prod_qty), MAX(FACT.actual_pick_qty), MAX(FACT.max_wave_qty), MAX(FACT.tgt_pick_qty)) AS
   prod_qty_task
  FROM ldl_dig_lec_share.v_fact_warehouse_processing_1 AS FACT
   INNER JOIN (SELECT wh_order_sid,
     wh_order_pos_nr,
     wh_sid,
     MAX(wh_task_create_tmsp) AS wh_task_create_tmsp
    FROM ldl_dig_lec_share.v_fact_warehouse_processing_1
    WHERE dwh_valid_fg
    GROUP BY wh_order_sid,
     wh_order_pos_nr,
     wh_sid) AS MAX ON FACT.wh_order_sid = MAX.wh_order_sid AND FACT.wh_order_pos_nr = MAX.wh_order_pos_nr AND FACT.wh_sid
       = MAX.wh_sid AND FACT.wh_task_create_tmsp = MAX.wh_task_create_tmsp
  WHERE FACT.dwh_valid_fg
  GROUP BY FACT.wh_order_sid,
   FACT.wh_order_pos_nr,
   FACT.wh_sid) (SELECT L.wh_order_sid,
    CASE
    WHEN L.wshop_cd = ''
    THEN '-1'
    ELSE IFNULL(L.wshop_cd, '-1')
    END AS wshop_cd,
   L.dist_channel_cd,
   L.wh_order_nr,
   L.wh_order_pos_nr,
   IFNULL(L.wh_sid, -1) AS wh_sid,
   IFNULL(L.wh_cd, '-1') AS wh_cd,
   IFNULL(L.prod_variant_sid, -1) AS prod_variant_sid,
   L.out_invoice_dt,
    CASE
    WHEN L.wh_order_doc_type_cd = ''
    THEN '-1'
    ELSE IFNULL(L.wh_order_doc_type_cd, '-1')
    END AS wh_order_doc_type_cd,
    CASE
    WHEN L.wh_order_doc_type_cd IN ('ZPLW', 'ZEPL')
    THEN 'EPO'
    WHEN L.wh_order_doc_type_cd IN ('ZEPO', 'ZEPG', 'ZEPW')
    THEN 'MEPO'
    WHEN L.wh_order_doc_type_cd IN ('ZMPG', 'ZMPO', 'ZEPT', 'ZMPT', 'ZMPW')
    THEN 'BATCH'
    ELSE 'SONSTIGE'
    END AS wh_order_process,
    CASE
    WHEN L.wh_goods_issue_status_cd = ''
    THEN '-1'
    ELSE IFNULL(L.wh_goods_issue_status_cd, '-1')
    END AS wh_goods_issue_status_cd,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(L.wh_order_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
   AS wh_order_create_tmsp,
   L.wh_order_ship_type_name,
   IFNULL(LPS.wh_order_line_process_status_cd, 1) AS wh_order_line_process_status_cd,
   P.wh_task_confirm_tmsp,
   COALESCE(P.prod_qty_task, L.prod_qty) AS qty_pro_status,
   L.prod_qty AS ordered_prod_qty,
   P.sort_track_name,
   P.sort_trolley_name,
   L.is_order_in_progress_fg,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(L.outbound_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
    DATETIME) AS outbound_tmsp,
   EXTRACT(HOUR FROM P.wh_task_confirm_tmsp) AS wh_task_confirm_hour,
    CASE
    WHEN LEFT(P.pack_sort_track_name, 2) = 'SW'
    THEN 'BATCH'
    WHEN LEFT(P.pack_sort_track_name, 3) = 'EPO'
    THEN 'SINGLES'
    ELSE 'MEPO'
    END AS pack_sort_track_group,
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
    ELSE 'SONSTIGES'
    END AS sort_track_group,
    CASE
    WHEN P.dest_storage_unit_nr = ''
    THEN '-1'
    ELSE IFNULL(P.dest_storage_unit_nr, '-1')
    END AS dest_storage_unit_nr,
   NULL AS cust_order_sid,
   NULL AS cust_order_pos_nr,
   NULL AS actual_pick_qty,
   NULL AS is_task_in_progress_fg,
   NULL AS max_wave_qty,
   NULL AS order_pick_qty,
   NULL AS prod_qty,
   NULL AS tgt_pick_qty,
   NULL AS wh_order_process_sort_status_cd,
   IFNULL(LPS.storage_unit_nr, '-1') AS storage_unit_nr
  FROM ldl_dig_lec_share.v_fact_warehouse_order_line_1 AS L
   LEFT JOIN CTE_WAREHOUSE_PROCESSING_TABLE AS P ON L.wh_order_sid = P.wh_order_sid AND L.wh_order_pos_nr = P.wh_order_pos_nr
       AND L.wh_sid = P.wh_sid
   LEFT JOIN ldl_dig_lec_share.v_fact_warehouse_order_line_process_status_1 AS LPS ON L.wh_order_sid = LPS.wh_order_sid
     AND L.wh_order_pos_nr = LPS.wh_order_pos_nr AND L.wh_sid = LPS.wh_sid
  WHERE L.dwh_valid_fg);