CREATE TABLE P_LEW_CORE.T_PRICE_LABEL_REPAIR_STATE_2 (
   price_label_client_id               NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT. Indicates from which country_2 price label was sent to repair',
   price_label_repair_batch_nr         VARCHAR(100)     NOT NULL COMMENT 'An identifier for the repair batch, grouping labels in the repair.',
   price_label_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PRICE LABEL.',
   repair_start_dt                     DATE             NOT NULL COMMENT 'Start date of the label repair.',
   repair_end_dt                       DATE             COMMENT 'End date of the label repair.',
   price_label_producer_name           VARCHAR(100)     COMMENT 'The name of the company that manufactures price labels.',
   price_label_warranty_status_cd      VARCHAR(100)     COMMENT 'The code for the status_2 of electronic price shields.',
   price_label_repair_result_cd        VARCHAR(100)     COMMENT 'The code for the possible result of the label repair.',
   price_label_repair_origin_name      VARCHAR(100)     COMMENT 'Declaration if the price label damage is customer fault or producer fault.',
   defect_txt                          VARCHAR(1000)    COMMENT 'Description of issue that das detected (Dispay Defect, Damage, etc.).',
   repair_process_name                 VARCHAR(100)     COMMENT 'Process that was started after the initial diagnostic (Scrap, Repair, etc.).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_PRICE_LABEL_REPAIR_STATE PRIMARY KEY (price_label_repair_batch_nr, price_label_sid, repair_start_dt) NOT ENFORCED 
)  COMMENT = 'Repair result for the damaged price label.
             Source: Solum, Imagotag (ESL)';