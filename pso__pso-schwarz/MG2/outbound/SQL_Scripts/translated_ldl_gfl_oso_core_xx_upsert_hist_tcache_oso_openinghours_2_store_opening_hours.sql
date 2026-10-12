INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
  store_natural_key,
  store_key_type_cd,
  day_of_week,
  open_tm,
  close_tm,
  break_start_tm,
  break_end_tm,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
WITH oso_parsed AS (
  SELECT
      ods.countrycode,
      JSON_EXTRACT_SCALAR(flat, '$.date') AS cal_dt,
      JSON_EXTRACT_SCALAR(flat, '$.isOpen') = 'true' AS open_fg,
      JSON_EXTRACT_SCALAR(flat, '$.timeRanges[0].fromTime') AS open_from_tmsp,
      COALESCE(
        JSON_EXTRACT_SCALAR(flat, '$.timeRanges[1].toTime'),
        JSON_EXTRACT_SCALAR(flat, '$.timeRanges[0].toTime')
      ) AS open_until_tmsp,
      CASE 
        WHEN JSON_EXTRACT_SCALAR(flat, '$.timeRanges[1].fromTime') IS NOT NULL 
        THEN JSON_EXTRACT_SCALAR(flat, '$.timeRanges[0].toTime')
        ELSE NULL
      END AS break_start_tm,
      CASE 
        WHEN JSON_EXTRACT_SCALAR(flat, '$.timeRanges[1].fromTime') IS NOT NULL 
        THEN JSON_EXTRACT_SCALAR(flat, '$.timeRanges[1].fromTime')
        ELSE NULL
      END AS break_end_tm,
      JSON_EXTRACT_SCALAR(flat, '$.weekday') AS weekday,
      ods.storeorganumber
      , ods.extraction_timestamp
  FROM etl.t_tcache_oso_openinghours AS ods,
       UNNEST(
         JSON_QUERY_ARRAY(ods.openinghours)
       ) AS flat
  WHERE JSON_EXTRACT_SCALAR(flat, '$.isOpen') = 'true'
),
oso_ranked AS (
  SELECT
      countrycode,
      storeorganumber,
      cal_dt,
      open_from_tmsp,
      open_until_tmsp,
      break_start_tm,
      break_end_tm,
      weekday,
      extraction_timestamp,
      ROW_NUMBER() OVER (
        PARTITION BY countrycode, cal_dt, storeorganumber
        ORDER BY extraction_timestamp DESC
      ) AS rn
  FROM oso_parsed
)
SELECT 
      CONCAT(countrycode, '|', storeorganumber) AS store_natural_key,
      'STORE' AS store_key_type_cd,
      CASE
        WHEN weekday = 'MONDAY' THEN 1
        WHEN weekday = 'TUESDAY' THEN 2
        WHEN weekday = 'WEDNESDAY' THEN 3
        WHEN weekday = 'THURSDAY' THEN 4
        WHEN weekday = 'FRIDAY' THEN 5
        WHEN weekday = 'SATURDAY' THEN 6
        WHEN weekday = 'SUNDAY' THEN 7
      END AS day_of_week,
      open_from_tmsp AS open_tm,
      open_until_tmsp AS close_tm,
      break_start_tm,
      break_end_tm,
      'OSO' AS source_system,
      CURRENT_DATE() AS extraction_dt,
      MIN(cal_dt) AS dwh_mapping_tmsp,
      0 AS tf_error_fg,
      0 AS deleted_fg,
      0 AS record_id,
      't_${SRC_INPUT_TABLE}' AS filename,
      'OSO' AS dwh_node_cd,
      '${LOAD_ID}' AS dwh_load_id
FROM oso_ranked r
JOIN core_rel.t_internal_organization io
  ON CONCAT(r.countrycode, r.storeorganumber) = io.int_org_nr
  AND io.dwh_valid_fg
WHERE r.rn = 1
GROUP BY
      store_natural_key,
      day_of_week,
      open_tm,
      close_tm,
      break_start_tm,
      break_end_tm;
