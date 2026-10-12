CREATE OR REPLACE VIEW kfl_production_dbp_view.v_plantour_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 plantour_id,
 tour_id,
 trailer_fg,
 trailer_id,
 dat_trailer,
 zeit_trailer
FROM kfl_production_dbp_data.plantour_2;