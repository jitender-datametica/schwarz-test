TRUNCATE TABLE etl.t_wawi_precore_dispogruppen_2;

INSERT INTO etl.t_wawi_precore_dispogruppen_2
(
  ctrcode, 
  dispogrupnr, 
  dispogrupbez, 
  datum, 
  bediener, 
  voraustage, 
  scn,
  extraction_tmsp,  
  dwh_created_tmsp,
  dwh_updated_tmsp,  
  dwh_load_id
)
SELECT 
  LEFT( ctrcode, 2) as ctrcode,
  dispogrupnr, 
  dispogrupbez, 
  datum, 
  bediener, 
  voraustage, 
  scn,
  extraction_tmsp,  
  CURRENT_TIMESTAMP dwh_created_tmsp,
  CURRENT_TIMESTAMP dwh_updated_tmsp,
  ${LOAD_ID} dwh_load_id
FROM etl.dispogruppen_2 src
INNER JOIN etl.wawi_control_table_2 ctrl ON ctrl.source_table_name = UPPER('etl.dispogruppen_2')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY ctrcode,dispogrupnr ORDER BY src.extraction_tmsp DESC ) = 1;
