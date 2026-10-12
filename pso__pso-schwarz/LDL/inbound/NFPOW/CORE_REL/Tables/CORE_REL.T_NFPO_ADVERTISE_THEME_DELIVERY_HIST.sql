CREATE TABLE CORE_REL.T_NFPO_ADVERTISE_THEME_DELIVERY_HIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_adv_theme_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_adv_theme_deliv_seq            NUMBER(38,0)     NOT NULL,
   nfpo_adv_theme_deliv_cal_week       NUMBER(38,0),
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status angenommen.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ADVERTISE_THEME_DELIVERY_HIST PRIMARY KEY (nfpo_adv_theme_sid, nfpo_adv_theme_deliv_seq, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'planned delivery weeks for NFPO advertising themes
             CBX: CTM_PROJECT';
