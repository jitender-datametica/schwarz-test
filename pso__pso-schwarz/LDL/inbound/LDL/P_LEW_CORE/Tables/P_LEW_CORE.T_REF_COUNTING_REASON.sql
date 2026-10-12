/* --------------------------------------------------------------------------------
   DDL for table: t_ref_counting_reason
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_COUNTING_REASON (
   cnt_reason_id                       NUMBER(38,0)     NOT NULL COMMENT 'id of the counting reason for stock correction requests',
   cnt_reason_descr                    VARCHAR(100)     COMMENT 'description of the counting reason for stock correction requests',
   cnt_reason_descr_en                 VARCHAR(100)     COMMENT 'english description of the counting reason for stock correction requests',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_COUNTING_REASON PRIMARY KEY (cnt_reason_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. table contains known reasons for counting requests
             Source: static';

