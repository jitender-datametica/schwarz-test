--==============================================================
-- Table: transportation_unit_tor_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_tor_zu_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:35:26
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_TOR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       INTEGER     NOT NULL COMMENT 'transportation_unit_sr_act_id',
   lagernummer_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   tor_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Lagertor   ',
   tor_sr_act_id                       INTEGER     NOT NULL COMMENT 'Warenannahme- und Versandaktivitätsnummer: Tor     ',
   datzeit_start_ist                   TIMESTAMP_LTZ(9) COMMENT 'Ist-Startzeitstempel TE/Tor-Zuordnung       ',
   datzeit_ende_ist                    TIMESTAMP_LTZ(9) COMMENT 'Ist-Endezeitstempel TE/Tor-Zuordnung   ',
   gp_id                               INTEGER     COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   wup_id                              INTEGER     COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   konsolidierungsgruppe_id            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Consolidation Group',
   spur_kapazitaet                     NUMBER(29,3)     COMMENT 'Kapazität vom Platz',
   spur_voll_fg                        INTEGER     COMMENT 'Kennzeichen: Bereitstellungsplatz ist voll',
   spur_planung_quittiert_fg           INTEGER     COMMENT 'Lane Planning Quittiert',
   spurgruppe_id                       INTEGER     COMMENT 'Spurgruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_TOR_ZU PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, lagernummer_id, tor_id, tor_sr_act_id) NOT ENFORCED
)  COMMENT = 'Zuordnung EWM-Tour_2 zu Tor (/SCWM/TU_DOOR).';
