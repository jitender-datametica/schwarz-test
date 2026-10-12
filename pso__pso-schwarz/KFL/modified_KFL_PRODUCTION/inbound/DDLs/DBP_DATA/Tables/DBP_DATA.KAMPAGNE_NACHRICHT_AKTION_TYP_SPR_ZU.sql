--==============================================================
-- Table: kampagne_nachricht_aktion_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_aktion_typ_spr_zu
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_TYP_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   nachricht_aktion_typ_id             INTEGER     NOT NULL COMMENT 'ID, die die Art der ausgeführten Aktion angibt.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
   nachricht_aktion_typ_bez            VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung des Absendungaktionen in unterschiedlichen Sprachen, z. B. Gesendet, Blockiert, Zugestellt, Bounced, Geöffnet, Feedback Loop, Link geklicked, usw.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_NACHRICHT_AKTION_TYP_SPR_ZU PRIMARY KEY (mandant_id, nachricht_aktion_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen der Aktionstypen für Marketingkampagnen - manuell versorgt.';
