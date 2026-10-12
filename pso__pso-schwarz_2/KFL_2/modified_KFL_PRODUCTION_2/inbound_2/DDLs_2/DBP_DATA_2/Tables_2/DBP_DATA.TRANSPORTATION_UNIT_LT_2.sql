--==============================================================
-- Table: transportation_unit_lt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_lt_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:31:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_LT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       INTEGER     NOT NULL COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit',
   beleg_id                            VARCHAR(32)      NOT NULL COMMENT 'Beleg-ID',
   at_guid                             VARCHAR(32)      NOT NULL COMMENT 'Produkt',
   menge_defekt_tortausch              INTEGER     COMMENT 'Number of defective load carriers from direct exchange',
   menge_gesamt                        INTEGER     COMMENT 'Gesamtmenge',
   menge_gesamt_tortausch              INTEGER     COMMENT 'Total number of Loading Carriers from Direct Exchange',
   menge_einh_id                       VARCHAR(3)       COMMENT 'Mengeneinheit',
   datzeit_erstelliung                 TIMESTAMP_LTZ(9) COMMENT 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_LT PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, beleg_id, at_guid) NOT ENFORCED
)  COMMENT = 'Ermittelte Greenfield Tore';
