CREATE TABLE ETL.T_INVENTORY_REASON_1 (
   inv_reason_id                       NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the reason why an inventory was initiated.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   inv_reason_descr                    VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason why an inventory was initiated.'
 )  COMMENT= 'This minor entity defines the reason why an inventory was initiated.';