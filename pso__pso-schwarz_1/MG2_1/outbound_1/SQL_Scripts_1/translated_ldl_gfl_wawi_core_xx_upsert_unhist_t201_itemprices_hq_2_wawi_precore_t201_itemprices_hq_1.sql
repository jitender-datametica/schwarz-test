TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t201_itemprices_hq_1;



INSERT INTO ldl_data_production_etl.t_wawi_precore_t201_itemprices_hq_1 (ctrcode, c201_groupnr, c201_itemdesc,
 c201_vatcode, c201_editedby, c201_lastedited, c201_datefrom, c201_dateto, c201_beverage_tax, c201_price,
 c201_containerdep, c201_tarecode, c201_itemno, c201_itemnr, c201_reason_id, c201_refdate, c201_pv_flag, scn,
 c201_linked_deposit_item, extraction_tmsp, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id)
(SELECT LEFT(src.ctrcode, 2) AS ctrcode,
  src.c201_groupnr,
  src.c201_itemdesc,
  src.c201_vatcode,
  src.c201_editedby,
  src.c201_lastedited,
  src.c201_datefrom,
  src.c201_dateto,
  src.c201_beverage_tax,
  src.c201_price,
  src.c201_containerdep,
  src.c201_tarecode,
  src.c201_itemno,
  src.c201_itemnr,
  src.c201_reason_id,
  src.c201_refdate,
  src.c201_pv_flag,
  src.scn,
  src.c201_linked_deposit_item,
  src.extraction_tmsp,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST('${LOAD_ID}' AS BIGNUMERIC)
 FROM ldl_data_production_etl.t201_itemprices_hq_1 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('etl.t201_itemprices_hq_1'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), CAST(src.c201_groupnr AS STRING), CAST(src.c201_itemnr AS STRING)
       , src.c201_datefrom ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1);



