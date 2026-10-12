 CREATE TABLE ETL.T_INVENTORY_RESULT_STATUS_TYPE (
   inv_result_status_type_id           NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the counting status of an inventory result. It shows, if the product could be counted.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   inv_result_status_type_descr        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the counting status of an inventory result. It shows, if the product could be counted.'
 )  COMMENT= 'This minor entity defines the counting status of an inventory result. It shows, if the product could be counted.';