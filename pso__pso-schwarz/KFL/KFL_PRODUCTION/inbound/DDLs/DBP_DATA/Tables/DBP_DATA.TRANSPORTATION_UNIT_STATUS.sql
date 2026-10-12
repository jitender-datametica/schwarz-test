--==============================================================
-- Table: transportation_unit_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_status
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:33:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_STATUS (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   transportation_unit_id              NUMBER(38,0)     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              NUMBER(38,0)     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       NUMBER(38,0)     NOT NULL COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit',
   status_id                           VARCHAR(5)       NOT NULL COMMENT 'Statusart',
   statuswert                          VARCHAR(1)       COMMENT 'Statuswert',
   datzeit_buchung                     TIMESTAMP_LTZ(9) COMMENT 'Buchungszeitstempel',
   statusgrund                         VARCHAR(4)       COMMENT 'Grund des Status im WA/V',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_STATUS PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, status_id) NOT ENFORCED
)  COMMENT = 'Transporteinheit Status';
