--==============================================================
-- Table: l_kommunikationskanal_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_kommunikationskanal_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_KOMMUNIKATIONSKANAL_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   kommunikationskanal_id              INTEGER     NOT NULL COMMENT 'Eindeutige Kennung des Kommunikationskanals, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_KOMMUNIKATIONSKANAL PRIMARY KEY (mandant_id, kommunikationskanal_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die verfügbaren Kommunikationskanäle für Marketingkampagnen.';
