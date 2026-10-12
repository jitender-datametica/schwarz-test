--==============================================================
-- Table: flw_transport_hu_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_hu_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRANSPORT_HU_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   tour_id                             INTEGER     NOT NULL COMMENT 'LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM',
   handling_unit_id_ext                VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Externe Handling Unit Identifikation aus Feld NVE',
   verlade_lief_beleg_id               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Verladelieferschein Nummer aus Feld ZZVLSNUM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRANSPORT_HU_ZU PRIMARY KEY (mandant_id, tour_id, handling_unit_id_ext) NOT ENFORCED
)  COMMENT = 'FLW - LKW-Positionsdaten (Transport) - SAP FLW (P21) - ZFW_TR_POS';

