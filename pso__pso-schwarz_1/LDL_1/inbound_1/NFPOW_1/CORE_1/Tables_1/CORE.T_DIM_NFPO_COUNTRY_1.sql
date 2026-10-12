/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_country_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_COUNTRY_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_country_sid                    NUMBER(38,0)     NOT NULL,
   nfpo_country_cd                     VARCHAR(100)     NOT NULL,
   nfpo_country_name                   VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_COUNTRY PRIMARY KEY (nfpo_country_sid) NOT ENFORCED 
)  COMMENT = 'List of political countries used by NFPO.
             CBX: CNT_CODELIST_1, code list "COUNTRY_1"
             LDL: P_LEW_CORE.T_COUNTRY_POLITICAL_1
             CORE_REL: T_NFPO_COUNTRY_1';
