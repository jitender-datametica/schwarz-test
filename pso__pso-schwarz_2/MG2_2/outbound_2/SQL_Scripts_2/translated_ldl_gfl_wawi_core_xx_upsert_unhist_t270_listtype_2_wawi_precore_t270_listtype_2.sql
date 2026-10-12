TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t270_listtype_2;



INSERT INTO ldl_data_production_etl.t_wawi_precore_t270_listtype_2 (ctrcode, c270_listnr, c270_listdescript, c270_eks_link
 , scn, c270_main_type, extraction_tmsp, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id)
(SELECT LEFT(src.ctrcode, 2) AS ctrcode,
  src.c270_listnr,
  src.c270_listdescript,
  src.c270_eks_link,
  src.scn,
  src.c270_main_type,
  src.extraction_tmsp,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  CAST('${LOAD_ID}' AS BIGNUMERIC) AS dwh_load_id
 FROM ldl_data_production_etl.t270_listtype_2 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_2 AS ctrl ON ctrl.source_table_name = UPPER('etl.t270_listtype_2')
    AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), src.c270_listnr ORDER BY src.extraction_tmsp IS NULL
       DESC, src.extraction_tmsp DESC)) = 1);


