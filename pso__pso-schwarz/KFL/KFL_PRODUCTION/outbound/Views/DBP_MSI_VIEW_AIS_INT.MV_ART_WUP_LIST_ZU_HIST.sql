CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_art_wup_list_zu_hist (mandant_id, wup_id, nb_id, art_id,
bezugsweg_id, dat_von, dat_bis, kdis, listung_id, listung_markt) AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 bezugsweg_id,
 dat_von,
 dat_bis,
 kdis,
 listung_id,
  CASE
  WHEN listung_id = 1
  THEN CASE
   WHEN bezugsweg_id = 1
   THEN CASE
    WHEN kdis = 0
    THEN '1'
    ELSE '5'
    END
   WHEN bezugsweg_id = 4
   THEN CASE
    WHEN kdis = 0
    THEN '4'
    ELSE '8'
    END
   ELSE 'ausgelistet'
   END
  ELSE 'ausgelistet'
  END AS listung_markt
FROM kfl_production_dbp_view.v_art_wup_zu_per
WHERE nb_id <> 99;