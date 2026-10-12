CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTATION_UNIT_TOR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,transportation_unit_id                   COMMENT 'Transporteinheit (intern)'
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,transportation_unit_sr_act_id            COMMENT 'transportation_unit_sr_act_id'
  ,lagernummer_id                           COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie'
  ,tor_id                                   COMMENT 'Lagertor   '
  ,tor_sr_act_id                            COMMENT 'Warenannahme- und Versandaktivitätsnummer: Tor     '
  ,datzeit_start_ist                        COMMENT 'Ist-Startzeitstempel TE/Tor-Zuordnung       '
  ,datzeit_ende_ist                         COMMENT 'Ist-Endezeitstempel TE/Tor-Zuordnung   '
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID)'
  ,wup_id                                   COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,konsolidierungsgruppe_id                 COMMENT 'Consolidation Group'
  ,spur_kapazitaet                          COMMENT 'Kapazität vom Platz'
  ,spur_voll_fg                             COMMENT 'Kennzeichen: Bereitstellungsplatz ist voll'
  ,spur_planung_quittiert_fg                COMMENT 'Lane Planning Quittiert'
  ,spurgruppe_id                            COMMENT 'Spurgruppe'
)
COMMENT = 'Zuordnung EWM-Tour_1 zu Tor (/SCWM/TU_DOOR).'
 AS 
    SELECT 
        mandant_id,
        transportation_unit_id,
        kj_transportation_unit,
        transportation_unit_sr_act_id,
        lagernummer_id,
        tor_id,
        tor_sr_act_id,
        datzeit_start_ist,
        datzeit_ende_ist,
        gp_id,
        wup_id,
        nb_id,
        konsolidierungsgruppe_id,
        spur_kapazitaet,
        spur_voll_fg,
        spur_planung_quittiert_fg,
        spurgruppe_id

FROM DBP_DATA.TRANSPORTATION_UNIT_TOR_ZU_1 ;