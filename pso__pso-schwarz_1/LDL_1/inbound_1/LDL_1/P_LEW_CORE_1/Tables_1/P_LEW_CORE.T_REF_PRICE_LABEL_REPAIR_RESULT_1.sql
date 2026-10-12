
CREATE TABLE P_LEW_CORE.T_REF_PRICE_LABEL_REPAIR_RESULT_1 (
   price_label_repair_result_cd        VARCHAR(100)     NOT NULL COMMENT 'The code for the possible result of the label repair.',
   price_label_producer_name           VARCHAR(100)     COMMENT 'The name of the company that manufactures price labels.',
   price_label_repair_result_descr     VARCHAR(250)     COMMENT 'The description for the possible result of the label repair.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_PRICE_LABEL_REPAIR_RESULT PRIMARY KEY (price_label_repair_result_cd, price_label_producer_name) NOT ENFORCED 
)  COMMENT = 'The list of possible repair outcomes (Recycling, Credit note, Returned functional). 
             Source: manuall filled (ESL)';
