--==============================================================
-- Table: sok_fima_baustein_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sok_fima_baustein_spr_zu_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 12:08:05
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SOK_FIMA_BAUSTEIN_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   sok_fima_baustein_id                INTEGER     NOT NULL COMMENT 'ID des SOK FIMA Baustein - im DWH generierter numerischer Schlüssel. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache.',
   sok_fima_baustein_bez               VARCHAR(100)     COMMENT 'Bezeichnung des SOK FIMA Baustein.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SOK_FIMA_BAUSTEIN_SPR_ZU PRIMARY KEY (mandant_id, sok_fima_baustein_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der SOK FIMA Bausteine in unterschiedlichen Sprachen.';
