CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_f_geku_zufriedenheit_1 (geku_ticket_id,
geku_notenvergabe_durch_id, dat_start, dat_ende, note_problem_geloest, note_bearbeitungszeit, note_freundlichkeit,
note_inhalt) AS SELECT T1.geku_ticket_id,
 T1.geku_notenvergabe_durch_id,
 T2.dat_start,
 T2.dat_ende,
 T1.note_problem_geloest,
 T1.note_bearbeitungszeit,
 T1.note_freundlichkeit,
  CASE
  WHEN T1.note_problem_geloest = 0
  THEN NULL
  ELSE T1.note_inhalt
  END AS note_inhalt
FROM kfl_production_dbp_view.v_geku_zufriedenheit_1 AS T1_1
 INNER JOIN kfl_production_dbp_view.v_geku_ticket_1 AS T2 ON T1.geku_ticket_id = T2.geku_ticket_id;