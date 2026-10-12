--==============================================================
-- Table: geku_eingangskanal_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_eingangskanal_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_EINGANGSKANAL_SPR_ZU_1 (
   geku_eingangskanal_id               INTEGER     NOT NULL COMMENT 'GeKu Eingangskanal, z.Bsp. Fax, Telefon',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   geku_eingangskanal_bez              VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des GeKu-Eingangskanals, z.Bsp. Brief; Fax',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_EINGANGSKANAL_SPR_ZU PRIMARY KEY (geku_eingangskanal_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der Eingangskanäle';

