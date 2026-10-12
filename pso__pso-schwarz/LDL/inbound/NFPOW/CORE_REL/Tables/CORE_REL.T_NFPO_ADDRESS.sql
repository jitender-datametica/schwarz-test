CREATE TABLE CORE_REL.T_NFPO_ADDRESS DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_addr_sid                       NUMBER(38,0)     NOT NULL,
   nfpo_sup_nr                         VARCHAR(100),
   nfpo_country_sid                    NUMBER(38,0),
   nfpo_country_cd                     VARCHAR(100),
   street_name                         VARCHAR(100),
   city_name                           VARCHAR(100),
   zip                                 VARCHAR(15),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ADDRESS PRIMARY KEY (nfpo_addr_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Addresses related primarily to Buildings, but also to Suppliers or any other feasible entity';
