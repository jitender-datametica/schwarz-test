CREATE OR REPLACE VIEW kfl_production_dbp_view.v_beurteilung AS SELECT beurteilung_id,
 wup_id,
 nb_id,
 mandant_id,
 eindruck_gesamt,
 note_gesamt,
 dat
FROM kfl_production_dbp_data.beurteilung;