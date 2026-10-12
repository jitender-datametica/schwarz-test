CREATE TABLE CORE_REL.T_NFPO_SUPPLIER_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_sup_sid                        NUMBER(38,0)     NOT NULL,
   nfpo_sup_nr                         VARCHAR(100)     NOT NULL,
   eks_sup_nr                          VARCHAR(100),
   nfpo_sup_name                       VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_SUPPLIER PRIMARY KEY (nfpo_sup_sid) NOT ENFORCED 
)  COMMENT = 'NFPO related vendor definition
             CBX: CNT_VENDOR_1, CTM_VENDOR_1';