CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_meta_load_time_lager_cockpit_1 (wh_sid, wh_cd, max_src_file_tmsp,
max_dwh_updated_tmsp) AS SELECT wh_sid,
 wh_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MIN(max_src_file_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS max_src_file_tmsp,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(max_dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin'))
  AS DATETIME) AS max_dwh_updated_tmsp
FROM ((SELECT wh_sid,
     wh_cd,
     MAX(src_file_tmsp) AS max_src_file_tmsp,
     MAX(dwh_updated_tmsp) AS max_dwh_updated_tmsp
    FROM ldl_dig_lec_share.v_fact_warehouse_order_line_process_status_1
    GROUP BY wh_cd,
     wh_sid
    UNION DISTINCT
    SELECT wh_sid,
     wh_cd,
     MAX(src_file_tmsp) AS max_src_file_tmsp,
     MAX(dwh_updated_tmsp) AS max_dwh_updated_tmsp
    FROM ldl_dig_lec_share.v_fact_warehouse_processing_1
    GROUP BY wh_cd,
     wh_sid)
   UNION DISTINCT
   SELECT wh_sid,
    wh_cd,
    MAX(src_file_tmsp) AS max_src_file_tmsp,
    MAX(dwh_updated_tmsp) AS max_dwh_updated_tmsp
   FROM ldl_dig_lec_share.v_fact_warehouse_order_line_1
   GROUP BY wh_cd,
    wh_sid) AS t8
GROUP BY wh_cd,
 wh_sid;