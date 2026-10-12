--==============================================================
-- Table: monat_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: monat_spr_zu_1
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:42:07
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MONAT_SPR_ZU_1 (
   mo_id                               INTEGER     NOT NULL COMMENT 'Nummer des Monats (zwischen 1 und 12)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mo_bez                              VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung eines Kalendermonats',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MONAT_SPR_ZU PRIMARY KEY (mo_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnung der Monate in den DWH-Sprachen';
