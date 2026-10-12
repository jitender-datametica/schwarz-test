CREATE TABLE P_LEW_CORE.T_REF_PRICE_LABEL_PRODUCER_2 (
   PRICE_LABEL_PRODUCER_NAME           VARCHAR(100)     NOT NULL COMMENT 'The name of the company that manufactures price labels.',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_PRICE_LABEL_PRODUCER PRIMARY KEY (PRICE_LABEL_PRODUCER_NAME) NOT ENFORCED 
)  COMMENT = 'This reference table contains data about companies that manufacture price labels (Solum, Imagotag).
             Sources: manually filled (ESL)';
