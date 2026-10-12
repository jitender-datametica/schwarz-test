CREATE TABLE CORE_REL.T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_pack_list_sid             NUMBER(38,0)     NOT NULL,
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL,
   nfpo_org_nr                         VARCHAR(100)     NOT NULL,
   nfpo_org_grp_id                     NUMBER(38,0)     NOT NULL,
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_2 angenommen.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST PRIMARY KEY (nfpo_item_pack_list_sid, nfpo_org_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'relation of packing lists and local NFPO''s
             CBX: LDL_ITEM_PACKING_METHOD_2';
