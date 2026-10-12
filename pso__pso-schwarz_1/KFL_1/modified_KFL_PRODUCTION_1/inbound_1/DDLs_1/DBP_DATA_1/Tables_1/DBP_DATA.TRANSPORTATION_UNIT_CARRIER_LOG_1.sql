--==============================================================
-- Table: transportation_unit_carrier_log_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_carrier_log_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:29:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_CARRIER_LOG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transportnummer',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       INTEGER     NOT NULL COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit',
   beleg_id                            INTEGER     NOT NULL COMMENT 'Belegnummer',
   handling_unit_guid                  VARCHAR(32)      NOT NULL COMMENT 'Handling Unit_1 GUID',
   art_guid                            VARCHAR(32)      NOT NULL COMMENT 'Product',
   ladungstraeger_status_id            VARCHAR(2)       COMMENT 'Load Carrier: Log Status_1',
   anz_ladungstraeger                  INTEGER     COMMENT 'Load Carrier Log: Good Quantity Received',
   anz_ladungstraeger_defekt           INTEGER     COMMENT 'Load Carrier Log: Defect Quantity Received',
   anz_ladungstraeger_tausch           INTEGER     COMMENT 'Load Carrier Log: Good Quantity Exchanged',
   anz_ladungstraeger_defekt_tausch    INTEGER     COMMENT 'Load Carrier Log: Defect Quantity Exchanged',
   ladungstraeger_einh_id              VARCHAR(3)       COMMENT 'Mengeneinheit',
   datzeit_erstellung                  TIMESTAMP_LTZ(9) COMMENT 'Angelegt Am',
   datzeit_aenderung                   TIMESTAMP_LTZ(9) COMMENT 'Geändert Am',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_CARRIER_LOG PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, beleg_id, handling_unit_guid, art_guid) NOT ENFORCED
)  COMMENT = 'Load Carriers Log';
