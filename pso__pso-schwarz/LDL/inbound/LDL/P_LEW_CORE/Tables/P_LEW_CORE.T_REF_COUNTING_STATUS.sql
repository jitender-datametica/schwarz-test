CREATE TABLE P_LEW_CORE.T_REF_COUNTING_STATUS (
   CNT_STATUS_ID                       NUMBER(38,0)     NOT NULL COMMENT 'status of the counting of the item',
   CNT_STATUS_DESCR                    VARCHAR(100)     COMMENT 'Description of the status of the counting performed',
   CNT_STATUS_DESCR_EN                 VARCHAR(100)     COMMENT 'Description in english of the status of the counting performed',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'ID of the last load when the data was inserted or updated',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Date of the record creation',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Date when the data was updated',   
   CONSTRAINT PK_T_REF_COUNTING_STATUS PRIMARY KEY (CNT_STATUS_ID) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. table contains known count flag status
             Source: static T439_PART_INV_DET.C439_COUNTFLAG';
