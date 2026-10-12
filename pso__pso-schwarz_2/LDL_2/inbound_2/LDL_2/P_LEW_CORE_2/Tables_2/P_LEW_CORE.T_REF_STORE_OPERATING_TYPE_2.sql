CREATE TABLE P_LEW_CORE.T_REF_STORE_OPERATING_TYPE_2 (
   store_operating_type_cd             VARCHAR(100)     NOT NULL COMMENT 'A code for an operating types for a store  ( regular opening , public holiday , permanent closure)',
   store_operating_type_descr          VARCHAR(250)     NOT NULL COMMENT 'A description for a store operating types',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_STORE_OPERATING_TYPE PRIMARY KEY (store_operating_type_cd) NOT ENFORCED 
)  COMMENT = 'A  reference table containing possible operating types for a store ( Regular opening , Sunday Opening , Permanent Closure , etc)';
