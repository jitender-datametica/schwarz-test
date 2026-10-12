CREATE OR REPLACE VIEW kfl_production_dbp_view.v_paletten_kontrolle_gewicht_2 AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 handling_unit_id,
 handling_unit_id_traeger,
 status_id,
 gewicht_ist,
 gewicht_soll
FROM kfl_production_dbp_data.paletten_kontrolle_gewicht_2;