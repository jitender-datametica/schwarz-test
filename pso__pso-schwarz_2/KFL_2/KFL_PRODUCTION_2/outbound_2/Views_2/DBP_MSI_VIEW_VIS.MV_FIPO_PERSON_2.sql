CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_person_2 AS SELECT fipo_person_id,
 mandant_id,
 fipo_pos_id,
 rev_fb_id,
 fipo_person_organisation,
 fipo_person_name,
 fipo_person_vorname,
 fipo_person_anrede,
   fipo_person_name || ', ' || fipo_person_vorname AS fipo_person_name_lang,
  CASE
  WHEN fipo_person_organisation = 'TESTKUNDE'
  THEN 'Testkunde'
  ELSE fipo_person_name || ', ' || fipo_person_vorname
  END AS fipo_person_name_anonym,
 dat_bis
FROM kfl_production_dbp_view.v_fipo_person_2 AS V01
WHERE fipo_person_organisation IS NOT NULL;