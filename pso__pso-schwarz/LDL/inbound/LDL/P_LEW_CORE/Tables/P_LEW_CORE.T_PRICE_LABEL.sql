CREATE TABLE P_LEW_CORE.T_PRICE_LABEL (
   CLIENT_ID                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT.',
   PRICE_LABEL_SID                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PRICE LABEL.',
   PRICE_LABEL_NR                      VARCHAR(100)     COMMENT 'A natural business identifier for a price label.',
   ELECTRONIC_PRICE_LABEL_TYPE_CD      VARCHAR(100)     COMMENT 'The code indicating the price label type.',
   PRICE_LABEL_PRODUCER_NAME           VARCHAR(100)     COMMENT 'The name of the company that manufactures this price label.',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_PRICE_LABEL PRIMARY KEY (PRICE_LABEL_SID) NOT ENFORCED 
)  COMMENT = 'Contains data about electronic price label shields - physical objects that are meant to display the current price of the items. Now contains data only about electronic price shields from source systems Solum and Imagotag.
             Source: Solum, Imagotag (ESL)';
