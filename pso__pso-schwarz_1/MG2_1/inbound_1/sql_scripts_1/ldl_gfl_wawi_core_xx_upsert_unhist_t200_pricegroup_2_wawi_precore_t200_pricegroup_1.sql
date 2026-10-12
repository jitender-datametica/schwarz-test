TRUNCATE TABLE etl.t_wawi_precore_t200_pricegroup_1;

INSERT INTO etl.t_wawi_precore_t200_pricegroup_1
(
  ctrcode,
  c200_groupnr, 
  c200_groupdesc, 
  c200_priority, 
  c200_warehouse, 
  c200_storenr, 
  c200_editedby, 
  c200_lastedited, 
  c200_datefrom, 
  c200_dateto, 
  c200_add_vatcode, 
  scn, 
  extraction_tmsp,
  dwh_created_tmsp,
  dwh_updated_tmsp,  
  dwh_load_id
)
SELECT 
  left( ctrcode, 2) as ctrcode,
  c200_groupnr, 
  c200_groupdesc, 
  c200_priority, 
  c200_warehouse, 
  c200_storenr, 
  c200_editedby, 
  c200_lastedited, 
  c200_datefrom, 
  c200_dateto, 
  c200_add_vatcode, 
  scn, 
  extraction_tmsp,  
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  ${LOAD_ID}
FROM etl.t200_pricegroup_1 src
INNER JOIN etl.wawi_control_table_1 ctrl ON ctrl.source_table_name = UPPER('etl.t200_pricegroup_1')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY left( ctrcode, 2),c200_groupnr,c200_storenr,c200_warehouse, c200_datefrom ORDER BY src.extraction_tmsp DESC ) = 1
;
