--==============================================================
-- Table: sok_kategorie_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sok_kategorie_spr_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 11:55:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SOK_KATEGORIE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   sok_kategorie_id                    INTEGER     NOT NULL COMMENT 'ID der SOK Kategorie. Fasst mehrere primäre Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache.',
   sok_kategorie_bez                   VARCHAR(100)     COMMENT 'Bezeichnung der SOK Kategorie.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SOK_KATEGORIE_SPR_ZU PRIMARY KEY (mandant_id, sok_kategorie_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der SOK Kategorie in unterschiedlichen Sprachen.';
