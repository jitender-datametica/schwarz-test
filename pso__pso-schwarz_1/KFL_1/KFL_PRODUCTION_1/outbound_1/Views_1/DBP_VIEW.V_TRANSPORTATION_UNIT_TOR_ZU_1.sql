CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_tor_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), transportation_unit_id OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='transportation_unit_sr_act_id'), lagernummer_id
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'), tor_id OPTIONS(description='Lagertor   '),
tor_sr_act_id OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Tor     '), datzeit_start_ist
OPTIONS(description='Ist-Startzeitstempel TE/Tor-Zuordnung       '), datzeit_ende_ist
OPTIONS(description='Ist-Endezeitstempel TE/Tor-Zuordnung   '), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
konsolidierungsgruppe_id OPTIONS(description='Consolidation Group'), spur_kapazitaet
OPTIONS(description='Kapazität vom Platz'), spur_voll_fg
OPTIONS(description='Kennzeichen: Bereitstellungsplatz ist voll'), spur_planung_quittiert_fg
OPTIONS(description='Lane Planning Quittiert'), spurgruppe_id OPTIONS(description='Spurgruppe'))
OPTIONS(DESCRIPTION = `ZUORDNUNG EWM-TOUR_1 ZU TOR (/SCWM/TU_DOOR).`) AS SELECT mandant_id,
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
FROM kfl_production_dbp_data.transportation_unit_tor_zu_1;