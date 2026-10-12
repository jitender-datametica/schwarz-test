--==============================================================
-- Table: kommunikationskanal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kommunikationskanal_spr_zu
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KOMMUNIKATIONSKANAL_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kommunikationskanal_id              INTEGER     NOT NULL COMMENT 'Eindeutige Kennung des Kommunikationskanals',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 ist Deutsch',
   kommunikationskanal_bez             VARCHAR(200)     NOT NULL COMMENT 'Übersetzung des Kanalnamens oder der Kanalbeschreibung in die jeweilige Sprache, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KOMMUNIKATIONSKANAL_SPR_ZU PRIMARY KEY (mandant_id, kommunikationskanal_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen der Kommunikationskanäle für Marketingkampagnen - manuell versorgt';
