CREATE TABLE P_LEW_CORE.T_REF_ELECTRONIC_PRICE_LABEL_TYPE_2 (
   ELECTRONIC_PRICE_LABEL_TYPE_CD      VARCHAR(100)     NOT NULL COMMENT 'The code indicating the price label type.',
   PRICE_LABEL_PRODUCER_NAME           VARCHAR(100)     NOT NULL COMMENT 'The name of the company that manufactures price labels.',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_ELECTRONIC_PRICE_LABEL_TYPE PRIMARY KEY (ELECTRONIC_PRICE_LABEL_TYPE_CD, PRICE_LABEL_PRODUCER_NAME) NOT ENFORCED 
)  COMMENT = 'A reference table containing the different types of the electronic price labels. Different producers usualy have different types.
             Sources: Solum, Imagotag (ESL)';
