--==============================================================
-- Table: transportation_unit_lagertor_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_lagertor_zu_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 14:02:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_LAGERTOR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   transportation_unit_id              NUMBER(38,0)     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              NUMBER(38,0)     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       NUMBER(38,0)     NOT NULL COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit',
   ladegruppe_versandstelle_id         VARCHAR(4)       NOT NULL COMMENT 'Versandstelle/Warenannahmestelle      ',
   lagertor_id                         VARCHAR(4)       NOT NULL COMMENT 'Lagertor ',
   datzeit_erstelliung                 TIMESTAMP_LTZ(9) COMMENT 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) ',
   tor_distanz_gewichtung              NUMBER(13,3)     COMMENT 'Distanz Gewichtung  ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_LAGERTOR_ZU PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, ladegruppe_versandstelle_id, lagertor_id) NOT ENFORCED
)  COMMENT = 'Ermittelte Greenfield Tore';
