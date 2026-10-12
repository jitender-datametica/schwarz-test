CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_mutter_wb_2 (mandant_id, art_id, art_mutter_wb_id,
art_mutter_display_id, mwb_basismenge_einh_id, mwb_verpart_id, art_mutter_wb_nr, art_mutter_wb_bez, art_mutter_wb_fg,
art_mutter_saison_id, posten_id, art_mutter_posten_fg, posten_fg, art_mutter_bezugsweg) AS SELECT A.mandant_id,
 A.art_id,
 COALESCE(A.mutter_wb_id, A.art_id) AS art_mutter_wb_id,
  CASE
  WHEN MWB.artikeltyp_id = 12
  THEN MWB.artikeltyp_id
  ELSE MWB.display_id
  END AS art_mutter_display_id,
 MWB.basismenge_einh_id AS mwb_basismenge_einh_id,
 COALESCE(MWB.verpart_id, ' ') AS mwb_verpart_id,
 TRIM(CAST(CASE
    WHEN A.mandant_id = 1
    THEN COALESCE(A.mutter_wb_id, A.art_id) / 100
    ELSE COALESCE(A.mutter_wb_id, A.art_id) / 10
    END AS STRING FORMAT '00000000')) AS art_mutter_wb_nr,
 MSZ.art_bez AS art_mutter_wb_bez,
 CAST(CASE
   WHEN A.mutter_wb_id IS NULL
   THEN 0
   ELSE 1
   END AS BIGNUMERIC) AS art_mutter_wb_fg,
 MWB.saison_id AS art_mutter_saison_id,
 MWB.posten_id,
  CASE
  WHEN MWB.posten_kz_sap <> ''
  THEN 1
  ELSE 0
  END AS art_mutter_posten_fg,
  CASE
  WHEN A.posten_kz_sap <> ''
  THEN 1
  ELSE 0
  END AS posten_fg,
 COALESCE(bzw.art_mutter_bezugsweg, 4) AS art_mutter_bezugsweg
FROM kfl_production_dbp_view.v_art_2 AS A
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_2 AS MSZ ON A.mandant_id = MSZ.mandant_id AND MSZ.art_id = COALESCE(A.mutter_wb_id
     , A.art_id) AND MSZ.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_art_2 AS MWB ON A.mandant_id = MWB.mandant_id AND MWB.art_id = COALESCE(A.mutter_wb_id
     , A.art_id) AND MWB.dat_bis = DATE '9999-12-31'
 LEFT JOIN (SELECT mandant_id,
   art_id AS art_mutter_id,
    CASE
    WHEN SUM(CASE
       WHEN bezugsweg_id = 4
       THEN 1
       ELSE 0
       END) > 0
    THEN 4
    ELSE 1
    END AS art_mutter_bezugsweg
  FROM kfl_production_dbp_view.v_art_wup_status_per_2
  WHERE dat_bis = DATE '9999-12-31'
   AND (mandant_id, wup_id, art_id) IN (SELECT (mandant_id, wup_id, art_id)
     FROM kfl_production_dbp_view.v_art_list_wup_zu_per_2
     WHERE nb_id = 0
      AND dat_bis >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
     GROUP BY mandant_id,
      wup_id,
      art_id)
  GROUP BY mandant_id,
   art_mutter_id) AS bzw ON A.mandant_id = bzw.mandant_id AND COALESCE(A.mutter_wb_id, A.art_id) = bzw.art_mutter_id;