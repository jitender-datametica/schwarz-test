--==============================================================
-- Table: geku_dwh_artikel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_dwh_artikel_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_DWH_ARTIKEL_SPR_ZU (
   geku_dwh_artikel_id                 NUMBER(38,0)     NOT NULL COMMENT 'Eine weitere ID, die Vergleichbarkeit der Artikel über alle Länder ermöglichen soll',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   geku_artikel_uid                    NUMBER(18,0)     COMMENT 'Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel besitzt keine Referenz zum Kaufland-Artikel',
   geku_dwh_artikel_bez                VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung des GEKU-DWH-Artikels',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_DWH_ARTIKEL_SPR_ZU PRIMARY KEY (geku_dwh_artikel_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der GEKU-DWH-Artikel';

