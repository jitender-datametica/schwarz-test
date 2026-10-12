TRUNCATE TABLE etl.t_wawi_precore_t270_listtype_1;

INSERT INTO etl.t_wawi_precore_t270_listtype_1
(
  ctrcode, 
  c270_listnr, 
  c270_listdescript, 
  c270_eks_link, 
  scn, 
  c270_main_type, 
  extraction_tmsp,  
  dwh_created_tmsp,
  dwh_updated_tmsp,  
  dwh_load_id
)
SELECT 
  left( ctrcode, 2) as ctrcode, 
  c270_listnr, 
  c270_listdescript, 
  c270_eks_link, 
  scn, 
  c270_main_type, 
  extraction_tmsp,  
  CURRENT_TIMESTAMP dwh_created_tmsp,
  CURRENT_TIMESTAMP dwh_updated_tmsp,
  ${LOAD_ID} dwh_load_id
FROM etl.t270_listtype_1 src
INNER JOIN etl.wawi_control_table_1 ctrl ON ctrl.source_table_name = UPPER('etl.t270_listtype_1')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY ctrcode,c270_listnr ORDER BY src.extraction_tmsp DESC ) = 1;
