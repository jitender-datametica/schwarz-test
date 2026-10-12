TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t664_brokerage_item_2;




INSERT INTO ldl_data_production_etl.t_wawi_precore_t664_brokerage_item_2 (c664_item, c664_moddate, c664_moduser, scn,
 ctrcode, extraction_tmsp, c664_group, c664_modset, c664_desc, c664_id, c664_std_flag, dwh_created_tmsp,
 dwh_updated_tmsp, dwh_load_id)
(SELECT src.c664_item,
  src.c664_moddate,
  src.c664_moduser,
  src.scn,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.c664_group,
  src.c664_modset,
  src.c664_desc,
  src.c664_id,
  src.c664_std_flag,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST('${LOAD_ID}' AS BIGNUMERIC)
 FROM ldl_data_production_etl.t664_brokerage_item_2 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_2 AS ctrl ON ctrl.source_table_name = UPPER('etl.t664_brokerage_item_2'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(src.c664_id AS STRING) ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp
       DESC)) = 1);


