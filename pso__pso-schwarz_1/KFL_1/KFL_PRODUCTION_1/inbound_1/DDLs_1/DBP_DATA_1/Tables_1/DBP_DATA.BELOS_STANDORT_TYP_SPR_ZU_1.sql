--==============================================================
-- Table: belos_standort_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_standort_typ_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_STANDORT_TYP_SPR_ZU_1 (
   belos_standort_typ_id               NUMBER(38,0)     NOT NULL COMMENT 'ID des Belos_standorttyps. Wird im DWH vergeben',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   belos_standort_typ_bez              VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Belos-Standorttyps, z.Bsp. Palettenhändler',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_STANDORT_TYP_SPR_ZU PRIMARY KEY (belos_standort_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnung der Standorttypen. Manuell befüllte Tabelle, ohne SST zu Vorsystem';

