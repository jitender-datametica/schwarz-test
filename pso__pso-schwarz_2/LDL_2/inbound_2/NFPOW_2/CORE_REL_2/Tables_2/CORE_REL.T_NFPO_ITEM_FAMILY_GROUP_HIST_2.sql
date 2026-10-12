/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_family_group_hist_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:23:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_FAMILY_GROUP_HIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_fam_grp_sid               NUMBER(38,0)     NOT NULL,
   nfpo_sub_item_grp_cd                VARCHAR(100),
   nfpo_assortment_area_id             NUMBER(38,0),
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_2 angenommen.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_FAMILY_GROUP_HIST PRIMARY KEY (nfpo_item_fam_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
