CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_list_zu_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 bezugsweg_id,
 kdis,
 listung_id,
  CASE
  WHEN listung_id = 1
  THEN CASE
   WHEN bezugsweg_id = 1
   THEN CASE
    WHEN kdis = 0
    THEN 1
    ELSE 5
    END
   WHEN bezugsweg_id = 4
   THEN CASE
    WHEN kdis = 0
    THEN 4
    ELSE 8
    END
   ELSE 0
   END
  ELSE 0
  END AS listung_markt
FROM kfl_production_dbp_view.v_art_wup_zu_per_1
WHERE dat_bis = DATE '9999-12-31'
 AND nb_id <> 99;