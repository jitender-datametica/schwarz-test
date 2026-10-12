--==============================================================
-- Table: sok_abteilung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sok_abteilung_spr_zu_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:27:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SOK_ABTEILUNG_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   sok_abteilung_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID der SOK Abteilung. Fasst die SOK Fima Bausteine zu einer übergeordneten Berichtshierarchie-Ebene zusammen.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   sok_abteilung_bez                   VARCHAR(100)     COMMENT 'Bezeichnung der SOK Abteilung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SOK_ABTEILUNG_SPR_ZU PRIMARY KEY (mandant_id, sok_abteilung_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der SOK Abteilung in unterschiedliche Sprachen.';
