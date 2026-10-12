--==============================================================
-- Table: fipo_pruef_modul_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_pruef_modul_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_PRUEF_MODUL_SPR_ZU_1 (
   fipo_pruef_modul_id                 INTEGER     NOT NULL COMMENT 'eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   fipo_pruef_modul_bez                VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prüfmoduls, z.Bsp. Revision. Aus dem Quellfeld pmi_text',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_PRUEF_MODUL_SPR_ZU PRIMARY KEY (fipo_pruef_modul_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachabhängige Bezeichnung der Prüfmodule';

