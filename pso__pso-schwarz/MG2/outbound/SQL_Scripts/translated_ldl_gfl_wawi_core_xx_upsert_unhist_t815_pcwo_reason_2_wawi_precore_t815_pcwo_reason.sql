TRUNCATE TABLE   ldl_data_production.etl.t_wawi_precore_t815_pcwo_reason;

INSERT INTO ldl_data_production.etl.t_wawi_precore_t815_pcwo_reason (
  ctrcode,
  wh_nr,
  c815_reason_id,
  c815_reason_id_int,
  c815_grp_id,
  c815_reason_desc_int,
  c815_reason_desc_nat,
  c815_grp_desc,
  c815_active_flag,
  c815_bnl_grp,
  c815_new_grp,
  c815_moddate,
  c815_moduser,
  scn,
  c815_displaytype,
  extraction_tmsp,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id
)
SELECT
  left(ctrcode, 2) AS ctrcode,
  wh_nr,
  c815_reason_id,
  c815_reason_id_int,
  c815_grp_id,
  c815_reason_desc_int,
  c815_reason_desc_nat,
  c815_grp_desc,
  c815_active_flag,
  c815_bnl_grp,
  c815_new_grp,
  c815_moddate,
  c815_moduser,
  scn,
  c815_displaytype,
  extraction_tmsp,
  current_timestamp(),
  current_timestamp(),
  ${load_id}
FROM ldl_data_production.etl.t815_pcwo_reason AS src
INNER JOIN ldl_data_production.etl.wawi_control_table AS ctrl
  ON ctrl.source_table_name = upper('etl.t815_pcwo_reason')
  AND ctrl.source_status = 'A'
  AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
QUALIFY
  row_number() OVER (
    PARTITION BY ctrcode, wh_nr, c815_reason_id
    ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
  ) = CAST('1' AS NUMERIC);