-- 13.01.2015 twie: note_inhalt nur ausgeben, wenn Problem nicht gelöst

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_f_geku_zufriedenheit_1 (geku_ticket_id, geku_notenvergabe_durch_id, dat_start
, dat_ende, note_problem_geloest, note_bearbeitungszeit, note_freundlichkeit, note_inhalt) AS SELECT t1.geku_ticket_id,
 t1.geku_notenvergabe_durch_id,
 t2.dat_start,
 t2.dat_ende,
 t1.note_problem_geloest,
 t1.note_bearbeitungszeit,
 t1.note_freundlichkeit -- note_problem_geloest = -1 oder NULL -> nicht gelöst, note_inhalt ausgeben

 -- note_problem_geloest = 0 -> gelöst, note_inhalt nicht ausgeben
,
  CASE
  WHEN t1.note_problem_geloest = 0
  THEN NULL
  ELSE t1.note_inhalt
  END AS note_inhalt
FROM kfl_production_dbp_view.v_geku_zufriedenheit_1 AS t1_1
 INNER JOIN kfl_production_dbp_view.v_geku_ticket_1 AS t2 ON t1.geku_ticket_id = t2.geku_ticket_id;