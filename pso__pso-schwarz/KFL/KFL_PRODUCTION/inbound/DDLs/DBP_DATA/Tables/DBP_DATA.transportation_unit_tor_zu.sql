--==============================================================
-- Table: transportation_unit_tor_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_tor_zu
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:35:26
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_TOR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   transportation_unit_id              NUMBER(38,0)     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              NUMBER(38,0)     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_sr_act_id       NUMBER(38,0)     NOT NULL COMMENT 'transportation_unit_sr_act_id',
   lagernummer_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   tor_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Lagertor   ',
   tor_sr_act_id                       NUMBER(38,0)     NOT NULL COMMENT 'Warenannahme- und Versandaktivitätsnummer: Tor     ',
   datzeit_start_ist                   TIMESTAMP_LTZ(9) COMMENT 'Ist-Startzeitstempel TE/Tor-Zuordnung       ',
   datzeit_ende_ist                    TIMESTAMP_LTZ(9) COMMENT 'Ist-Endezeitstempel TE/Tor-Zuordnung   ',
   gp_id                               NUMBER(38,0)     COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   wup_id                              NUMBER(38,0)     COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   konsolidierungsgruppe_id            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Consolidation Group',
   spur_kapazitaet                     NUMBER(11,3)     COMMENT 'Kapazität vom Platz',
   spur_voll_fg                        NUMBER(38,0)     COMMENT 'Kennzeichen: Bereitstellungsplatz ist voll',
   spur_planung_quittiert_fg           NUMBER(38,0)     COMMENT 'Lane Planning Quittiert',
   spurgruppe_id                       NUMBER(38,0)     COMMENT 'Spurgruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_TOR_ZU PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, lagernummer_id, tor_id, tor_sr_act_id) NOT ENFORCED
)  COMMENT = 'Zuordnung EWM-Tour zu Tor (/SCWM/TU_DOOR).';
