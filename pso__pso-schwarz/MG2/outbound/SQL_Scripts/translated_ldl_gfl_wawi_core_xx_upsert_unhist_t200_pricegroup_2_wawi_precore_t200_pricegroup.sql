TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t200_pricegroup;


INSERT INTO ldl_data_production_etl.t_wawi_precore_t200_pricegroup (ctrcode, c200_groupnr, c200_groupdesc, c200_priority
 , c200_warehouse, c200_storenr, c200_editedby, c200_lastedited, c200_datefrom, c200_dateto, c200_add_vatcode, scn,
 extraction_tmsp, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id)
(SELECT LEFT(src.ctrcode, 2) AS ctrcode,
  src.c200_groupnr,
  src.c200_groupdesc,
  src.c200_priority,
  src.c200_warehouse,
  src.c200_storenr,
  src.c200_editedby,
  src.c200_lastedited,
  src.c200_datefrom,
  src.c200_dateto,
  src.c200_add_vatcode,
  src.scn,
  src.extraction_tmsp,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  cast('${LOAD_ID}' as bignumeric)
 FROM ldl_data_production_etl.t200_pricegroup AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table AS ctrl ON ctrl.source_table_name = UPPER('etl.t200_pricegroup'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), CAST(src.c200_groupnr AS STRING), CAST(src.c200_storenr AS STRING)
       , CAST(src.c200_warehouse AS STRING), src.c200_datefrom ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp
       DESC)) = 1);


