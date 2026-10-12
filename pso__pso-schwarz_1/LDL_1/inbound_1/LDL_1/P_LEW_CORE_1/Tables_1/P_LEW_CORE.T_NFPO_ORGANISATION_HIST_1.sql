CREATE TABLE P_LEW_CORE.T_NFPO_ORGANISATION_HIST_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key internal organisation
            CBX: CNT_CODELIST.NAME (code list ''LIDL_COUNTRY'')',
   display_seq                         NUMBER(38,0)    COMMENT 'defines the order of NFPO''s in reports
            CBX: CNT_CODELIST.seq_no (code list ''LIDL_COUNTRY'')',
   active_fg                           NUMBER(38,0)    COMMENT 'indicates whether an NFPO is no longer usable in the system
            CBX: CNT_CODELIST.disabled (code list ''LIDL_COUNTRY'')
            ',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',

   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_NFPO_ORGANISATION_HIST PRIMARY KEY (int_org_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Thist table contains historised information about non food puchase organization units.
             CBX:CNT_CODELIST_1 (code list ''LIDL_COUNTRY'')
             ';
