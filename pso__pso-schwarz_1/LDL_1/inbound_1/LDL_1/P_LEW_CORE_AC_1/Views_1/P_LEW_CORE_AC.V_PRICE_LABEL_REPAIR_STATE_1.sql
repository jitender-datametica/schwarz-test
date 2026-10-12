CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PRICE_LABEL_REPAIR_STATE_1 (
   price_label_client_id                    COMMENT 'Surrogate Key CLIENT. Indicates from which country_1 price label was sent to repair'
  ,price_label_repair_batch_nr              COMMENT 'An identifier for the repair batch, grouping labels in the repair.'
  ,price_label_sid                          COMMENT 'Surrogate Key PRICE LABEL.'
  ,repair_start_dt                          COMMENT 'Start date of the label repair.'
  ,repair_end_dt                            COMMENT 'End date of the label repair.'
  ,price_label_producer_name                COMMENT 'The name of the company that manufactures price labels.'
  ,price_label_warranty_status_cd           COMMENT 'The code for the status_1 of electronic price shields.'
  ,price_label_repair_result_cd             COMMENT 'The code for the possible result of the label repair.'
  ,price_label_repair_origin_name           COMMENT 'Declaration if the price label damage is customer fault or producer fault.'
  ,defect_txt                               COMMENT 'Description of issue that das detected (Dispay Defect, Damage, etc.).'
  ,repair_process_name                      COMMENT 'Process that was started after the initial diagnostic (Scrap, Repair, etc.).'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The timestamp when the row was inserted.'
  ,dwh_updated                              COMMENT 'The timestamp when the row was updated the last time.'
)
COMMENT = 'Repair result for the damaged price label.
Source: Solum, Imagotag (ESL)'
AS SELECT
   price_label_client_id
  ,price_label_repair_batch_nr
  ,price_label_sid
  ,repair_start_dt
  ,repair_end_dt
  ,price_label_producer_name
  ,price_label_warranty_status_cd
  ,price_label_repair_result_cd
  ,price_label_repair_origin_name
  ,defect_txt
  ,repair_process_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_PRICE_LABEL_REPAIR_STATE_1
;