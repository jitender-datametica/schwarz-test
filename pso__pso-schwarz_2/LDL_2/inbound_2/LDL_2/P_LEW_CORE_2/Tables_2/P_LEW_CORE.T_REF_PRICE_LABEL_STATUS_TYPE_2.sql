CREATE TABLE P_LEW_CORE.T_REF_PRICE_LABEL_STATUS_TYPE_2 (
   PRICE_LABEL_STATUS_TYPE_CD          VARCHAR(100)     NOT NULL COMMENT 'The code for the status_2 type of electronic price shields.',
   PRICE_LABEL_STATUS_TYPE_DESCR       VARCHAR(250)     COMMENT 'The status_2 type code description for the electronic price shield.',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_PRICE_LABEL_STATUS_TYPE PRIMARY KEY (PRICE_LABEL_STATUS_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'The list of possible status_2 types for a price label.
             - Lifecycle (Active, Inactive)
             - Warranty (Excluded Warranty, In Warranty, Out of Warranty)
             Source: Manual (ESL)';
