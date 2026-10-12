CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_besch_best_materialtyp (mandant_id, best_beleg_id,
materialtyp_id) AS SELECT t3.mandant_id,
 t3.best_beleg_id,
 t3.materialtyp_id
FROM (SELECT V010.mandant_id,
   V010.best_beleg_id,
    CASE
    WHEN V012.hauptgruppe_id = 'HAWA'
    THEN 1
    WHEN V012.hauptgruppe_id = 'HISTO'
    THEN 2
    ELSE 3
    END AS materialtyp_id,
   COUNT(*) AS anz
  FROM kfl_production_dbp_view.v_flw_besch_best_det AS V010
   INNER JOIN kfl_production_dbp_view.v_flw_art AS V011 ON V010.mandant_id = V011.mandant_id AND V010.flw_art_id = V011
     .flw_art_id
   INNER JOIN kfl_production_dbp_view.v_flw_produktgruppe AS V012 ON V011.produktgruppe_id = V012.produktgruppe_id AND
     V011.mandant_id = V012.mandant_id
   INNER JOIN kfl_production_dbp_view.v_flw_besch_best AS V013 ON V010.best_beleg_id = V013.best_beleg_id AND V010.mandant_id
      = V013.mandant_id
  WHERE V010.mandant_id IN (1, 2)
   AND V013.einkaufsorganisation_id IN (5000, 5013, 5014)
  GROUP BY V010.mandant_id,
   V010.best_beleg_id,
   materialtyp_id
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V010.mandant_id AS STRING), V010.best_beleg_id ORDER BY anz IS NULL, anz
        , materialtyp_id IS NULL, materialtyp_id)) = 1) AS t3;