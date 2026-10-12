TRUNCATE TABLE etl.t_wawi_precore_t815_pcwo_reason;

INSERT INTO etl.t_wawi_precore_t815_pcwo_reason
(
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
  extraction_tmsp ,  
  dwh_created_tmsp,
  dwh_updated_tmsp,  
  dwh_load_id
)
SELECT
  left( ctrcode, 2) as ctrcode,
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
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  ${LOAD_ID}
FROM etl.t815_pcwo_reason src
INNER JOIN etl.wawi_control_table ctrl ON ctrl.source_table_name = UPPER('etl.t815_pcwo_reason')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY ctrcode,wh_nr,c815_reason_id ORDER BY src.extraction_tmsp DESC ) = 1;
