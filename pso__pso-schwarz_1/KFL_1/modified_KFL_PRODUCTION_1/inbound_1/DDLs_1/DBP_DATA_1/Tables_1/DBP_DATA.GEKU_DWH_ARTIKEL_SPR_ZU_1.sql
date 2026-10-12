--==============================================================
-- Table: geku_dwh_artikel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_dwh_artikel_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_DWH_ARTIKEL_SPR_ZU_1 (
   geku_dwh_artikel_id                 INTEGER     NOT NULL COMMENT 'Eine_1 weitere ID, die Vergleichbarkeit der Artikel_1 über alle Länder ermöglichen soll',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   geku_artikel_uid                    INTEGER     COMMENT 'Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel_1 besitzt keine Referenz zum Kaufland-Artikel_1',
   geku_dwh_artikel_bez                VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung des GEKU-DWH-Artikels',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_DWH_ARTIKEL_SPR_ZU PRIMARY KEY (geku_dwh_artikel_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der GEKU-DWH-Artikel_1';

