--==============================================================
-- Table: l_dienstleister_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_dienstleister_2
   generated from Powerdesigner on Mittwoch, 17. Mai 2023 12:02:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_DIENSTLEISTER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   dienstleister_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID des Dienstleister, der bei online bestellten Waren beauftragt wird.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_DIENSTLEISTER PRIMARY KEY (mandant_id, dienstleister_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle zur dienstleister ID. Beinhaltet Dienstleister die bei online bestellten Waren beauftragt werden.
             Beladung erfolg manuell über CSV Datei.';