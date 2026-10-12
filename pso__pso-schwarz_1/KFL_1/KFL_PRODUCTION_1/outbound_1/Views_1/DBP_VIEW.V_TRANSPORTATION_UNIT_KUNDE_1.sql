CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_kunde_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), kunde_id OPTIONS(description='Markt'), kunde_num_id
OPTIONS(description='Markt (numerisch für CROSS JOIN mit wup_1-Tabelle)'), dat_tour
OPTIONS(description='Tour_1 Lieferdatum'), wup_id OPTIONS(description='Betrieb'), plantour_id
OPTIONS(description='Plantournummer'), transportation_unit_id OPTIONS(description='Transportnummer'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), tour_pos_id
OPTIONS(description='Tournummer (entspricht Position)'), zeit_plan_ankunft OPTIONS(description='Anlieferzeit'))
OPTIONS(DESCRIPTION = `SRS geplante Tourdaten`) AS SELECT mandant_id,
 kunde_id,
 kunde_num_id,
 dat_tour,
 wup_id,
 plantour_id,
 transportation_unit_id,
 kj_transportation_unit,
 tour_pos_id,
 zeit_plan_ankunft
FROM kfl_production_dbp_data.transportation_unit_kunde_1;