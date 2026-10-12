--==============================================================
-- Table: flw_schnitt_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITT_SPR_ZU_1 (
   schnitt_id                          INTEGER     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         INTEGER     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   schnitt_bez                         VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung aus txt40',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITT_SPR_ZU PRIMARY KEY (schnitt_id, sek_schl_typ_id, sek_schl_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnitt Texte aus cutkt';

