CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_zufriedenheit (geku_ticket_id, geku_notenvergabe_durch_id,
note_problem_geloest, note_bearbeitungszeit, note_freundlichkeit, note_inhalt, td_update, td_insert) AS SELECT
 geku_ticket_id,
 geku_notenvergabe_durch_id,
 note_problem_geloest,
 note_bearbeitungszeit,
 note_freundlichkeit,
 note_inhalt,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_zufriedenheit;