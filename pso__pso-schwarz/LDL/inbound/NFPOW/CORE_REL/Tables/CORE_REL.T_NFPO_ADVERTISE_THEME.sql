CREATE TABLE CORE_REL.T_NFPO_ADVERTISE_THEME DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_adv_theme_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_adv_theme_nr                   VARCHAR(100)     NOT NULL,
   nfpo_adv_theme_name                 VARCHAR(100),
   nfpo_adv_theme_week_cd              VARCHAR(100),
   nfpo_adv_theme_alt_nr               NUMBER(38,0),
   nfpo_adv_theme_bus_year             NUMBER(38,0),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ADVERTISE_THEME PRIMARY KEY (nfpo_adv_theme_sid) NOT ENFORCED 
)  COMMENT = 'NFPO advertising themes
             CBX: CNT_PROJECT';
