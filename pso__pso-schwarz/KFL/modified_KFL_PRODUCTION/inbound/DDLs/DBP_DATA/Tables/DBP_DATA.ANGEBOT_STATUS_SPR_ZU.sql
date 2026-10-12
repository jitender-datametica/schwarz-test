--==============================================================
-- Table: angebot_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_status_spr_zu
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:51:02
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT_STATUS_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   angebot_status_id                   INTEGER     NOT NULL COMMENT 'ID des Angebotsstatus',
   angebot_status_bez                  VARCHAR(200)     NOT NULL COMMENT 'Sprachabhängige Bezeichnung des Angebotsstatus.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT_STATUS_SPR_ZU PRIMARY KEY (mandant_id, spr_id, angebot_status_id) NOT ENFORCED
)  COMMENT = 'Tabelle für sprachabhängige Bezeichnungen des Angebotsstatus.';
