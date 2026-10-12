CREATE OR REPLACE VIEW kfl_production_dbp_view.v_beurteilung_bereichsnote_2 AS SELECT bereichsnote_id,
 mandant_id,
 beurteilung_bereich_id,
 beurteilung_id,
 note_bereich,
 eindruck_bereich
FROM kfl_production_dbp_data.beurteilung_bereichsnote_2;