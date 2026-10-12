CREATE TABLE CORE_REL.T_NFPO_PRICE_SCENARIO_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_price_scenario_nr              NUMBER(38,0)     NOT NULL,
   nfpo_price_type_cd                  VARCHAR(100),
   lob_cd                              VARCHAR(100),
   nfpo_market_sid                     NUMBER(38,0),
   nfpo_incoterm_cd                    VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_PRICE_SCENARIO PRIMARY KEY (nfpo_price_scenario_nr) NOT ENFORCED 
)  COMMENT = 'price scenarios used in the non food product development and ordering process drived from price types and the used additional dimentsion lob, market
             prices which are differenciated by targeted intenal organisation are not included here';
