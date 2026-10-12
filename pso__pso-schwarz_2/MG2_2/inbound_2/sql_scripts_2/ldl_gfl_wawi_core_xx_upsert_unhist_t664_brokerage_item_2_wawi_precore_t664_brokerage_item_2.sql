TRUNCATE TABLE etl.t_wawi_precore_t664_brokerage_item_2;

INSERT INTO etl.t_wawi_precore_t664_brokerage_item_2
(
  c664_item,
  c664_moddate,
  c664_moduser,
  scn,
  ctrcode,
  extraction_tmsp,
  c664_group,
  c664_modset,
  c664_desc,
  c664_id,
  c664_std_flag,  
  dwh_created_tmsp,
  dwh_updated_tmsp,  
  dwh_load_id
)
SELECT 
  c664_item,
  c664_moddate,
  c664_moduser,
  scn,
  LEFT( ctrcode, 2) as ctrcode,
  extraction_tmsp,
  c664_group,
  c664_modset,
  c664_desc,
  c664_id,
  c664_std_flag,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  ${LOAD_ID}
FROM etl.t664_brokerage_item_2 src
INNER JOIN etl.wawi_control_table_2 ctrl ON ctrl.source_table_name = UPPER('etl.t664_brokerage_item_2')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY c664_id ORDER BY src.extraction_tmsp DESC ) = 1;
