CREATE TABLE ETL.T_INVENTORY_PRODUCT_REASON_2 (
   inv_prod_reason_id                  NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the reason why an inventory was initiated for a certain product.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   inv_prod_reason_descr               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason why an inventory was initiated for a certain product.'
 )  COMMENT= 'This minor entity defines the reason why an inventory was initiated for a certain product.';