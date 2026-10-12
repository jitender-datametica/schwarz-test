CREATE TABLE CORE_REL.T_NFPO_PRICE_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_price_type_cd                  VARCHAR(100)     NOT NULL,
   nfpo_price_type_name                VARCHAR(100),
   nfpo_price_type_descr               VARCHAR(250),
   lob_fg                              BOOLEAN,
   nfpo_market_fg                      BOOLEAN,
   nfpo_incoterm_fg                    BOOLEAN,
   nfpo_org_fg                         BOOLEAN,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_PRICE_TYPE PRIMARY KEY (nfpo_price_type_cd) NOT ENFORCED 
)  COMMENT = 'price types used in the non food product development and ordering process';
