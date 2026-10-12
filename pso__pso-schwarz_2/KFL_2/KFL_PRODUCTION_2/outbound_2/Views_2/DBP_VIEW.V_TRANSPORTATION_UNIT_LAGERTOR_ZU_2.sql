CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_lagertor_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), transportation_unit_id OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'), ladegruppe_versandstelle_id
OPTIONS(description='Versandstelle/Warenannahmestelle      '), lagertor_id OPTIONS(description='Lagertor '),
datzeit_erstelliung OPTIONS(description='UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) '), tor_distanz_gewichtung
OPTIONS(description='Distanz Gewichtung  ')) OPTIONS(DESCRIPTION = `ERMITTELTE GREENFIELD TORE`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 ladegruppe_versandstelle_id,
 lagertor_id,
 datzeit_erstelliung,
 tor_distanz_gewichtung
FROM kfl_production_dbp_data.transportation_unit_lagertor_zu_2;