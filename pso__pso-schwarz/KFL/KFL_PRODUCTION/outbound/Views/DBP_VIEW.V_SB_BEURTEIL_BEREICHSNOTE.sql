CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sb_beurteil_bereichsnote AS SELECT bereichsnote_id,
 mandant_id,
 beurteilung_id,
 note_bereich,
 eindruck_bereich,
 beurteilung_bereich_id
FROM kfl_production_dbp_data.sb_beurteil_bereichsnote;