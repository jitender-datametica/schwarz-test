INSERT INTO szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  trader_reference_nr,
  order_dt,
  item_position_seq,
  resource_item_sid,
  preference_indicator_fg,
  dwh_src_file_name,
  dwh_src_1_tmsp,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
SELECT
  br.trader_reference_nr,
  br.order_dt,
  br.item_position_seq,
  rk.resource_item_sid,
  logical_or(br.preference_indicator_fg),
  MAX(br.dwh_src_file_name),
  MAX(br.dwh_src_1_tmsp),
  current_timestamp() AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS deleted_fg,
  CAST('0' AS NUMERIC) AS record_id,
  'bei' AS filename
FROM (
  SELECT
    br_0.corder AS trader_reference_nr,
    coalesce(br_0.etd, br_0.etats) AS order_dt,
    row_number() OVER (
      PARTITION BY TRIM(corder, ' ')
      ORDER BY IF(TRIM(itvsy_id_no, ' ') IS NULL, 0, 1) DESC, TRIM(itvsy_id_no, ' ')
    ) AS item_position_seq, /* br.CORDER_ITEM as item_position_seq, */
    TRIM(sp.value, ' ') AS document_code,
    TRUE AS preference_indicator_fg,
    dwh_src_file_name,
    dwh_src_1_tmsp
  FROM szd_production.etl.t_cache_zgts_brimport_1 AS br_0
  CROSS JOIN sp
  WHERE
    NOT sp.value IS NULL
  UNION DISTINCT
  SELECT
    br_0.corder AS trader_reference_nr,
    coalesce(br_0.etd, br_0.etats) AS order_dt,
    row_number() OVER (
      PARTITION BY TRIM(corder, ' ')
      ORDER BY IF(TRIM(itvsy_id_no, ' ') IS NULL, 0, 1) DESC, TRIM(itvsy_id_no, ' ')
    ) AS item_position_seq, /* br.CORDER_ITEM as item_position_seq, */
    TRIM(sp.value, ' ') AS document_code,
    FALSE AS preference_indicator_fg,
    dwh_src_file_name,
    dwh_src_1_tmsp
  FROM szd_production.etl.t_cache_zgts_brimport_1 AS br_0
  CROSS JOIN sp
  WHERE
    NOT sp.value IS NULL
) AS br
INNER JOIN szd_production.meta.t_resource_item_key_1 AS rk
  ON CONCAT('GB|', upper(br.document_code)) = rk.resource_item_nat_key_nr
  AND rk.resource_item_key_type_cd = 'CUSTOMS_DOCUMENT'
WHERE
  NOT br.order_dt IS NULL
GROUP BY
  1,
  2,
  3,
  4;