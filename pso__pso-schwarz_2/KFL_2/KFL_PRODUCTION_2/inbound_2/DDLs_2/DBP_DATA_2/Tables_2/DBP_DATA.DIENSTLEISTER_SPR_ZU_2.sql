--==============================================================
-- Table: dienstleister_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dienstleister_spr_zu_2
   generated from Powerdesigner on Mittwoch, 17. Mai 2023 12:03:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DIENSTLEISTER_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   dienstleister_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID des Dienstleister, der bei online bestellten Waren beauftragt wird.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   dienstleister_bez                   VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung des Dienstleister',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DIENSTLEISTER_SPR_ZU PRIMARY KEY (mandant_id, dienstleister_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachzuordnungstabelle der Dienstleister, die für online bestellte Ware beauftragt werden.
             Beladung erfolgt manuell über CSV Datei.';