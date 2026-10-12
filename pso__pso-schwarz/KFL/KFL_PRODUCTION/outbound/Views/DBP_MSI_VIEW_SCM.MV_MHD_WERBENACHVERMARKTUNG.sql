CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_mhd_werbenachvermarktung (mandant_id, wup_id, art_id, kjwo,
werbe_typ_id, min_lfdat, min_mhd, nb_id) AS SELECT t.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 t.art_id,
 t.kjwo,
 t.werbe_typ_id,
 t.dat_lief_soll AS min_lfdat,
 t.dat_haltbarkeit AS min_mhd,
 0 AS nb_id
FROM (SELECT WKW.mandant_id,
   WKW.wup_id,
   WKW.art_id,
   WKW.kjwo,
   WKW.werbe_typ_id,
   bld.dat_lief_soll,
   bld.dat_haltbarkeit,
   ROW_NUMBER() OVER (PARTITION BY CAST(WKW.mandant_id AS STRING), CAST(WKW.wup_id AS STRING), CAST(WKW.art_id AS STRING)
      , CAST(WKW.kjwo AS STRING), CAST(WKW.werbe_typ_id AS STRING), A.dat_von, A.dat_bis ORDER BY bld.dat_lief_soll
      IS NULL, bld.dat_lief_soll, bld.dat_haltbarkeit IS NULL, bld.dat_haltbarkeit) AS row_num
  FROM kfl_production_dbp_view.v_werbung_kennzahlen_woche AS WKW
   INNER JOIN kfl_production_dbp_view.v_aktion_art_wup_zu AS AAW ON WKW.mandant_id = AAW.mandant_id AND WKW.art_id = AAW
         .art_id AND WKW.wup_id = AAW.wup_id AND AAW.dat_sperrung IS NULL AND AAW.dat_preisaktiviert >=
      DATE '1900-01-01' AND AAW.wrg_id IS NOT NULL
   INNER JOIN kfl_production_dbp_view.v_aktion AS A ON AAW.mandant_id = A.mandant_id AND AAW.aktion_id = A.aktion_id AND
     WKW.kjwo = A.kjwo_von
   LEFT JOIN (SELECT STPO.mandant_id,
     STPO.art_id,
     MAST.art_id AS art_id_display
    FROM kfl_production_dbp_view.v_stueckliste AS MAST
     INNER JOIN kfl_production_dbp_view.v_stueckliste_det AS STPO ON MAST.mandant_id = STPO.mandant_id AND MAST.stueckliste_id
          = STPO.stueckliste_id AND MAST.stueckliste_verwendung_id = 3 AND STPO.stueckliste_typ_id = 'M') AS stl ON WKW
     .mandant_id = stl.mandant_id AND WKW.art_id = stl.art_id
   LEFT JOIN (SELECT BL.mandant_id,
     BL.wup_id,
     BLD.art_id,
     BL.dat_lief_soll,
     BLD.dat_haltbarkeit
    FROM kfl_production_dbp_view.v_besch_lief AS BL
     INNER JOIN kfl_production_dbp_view.v_besch_lief_det AS BLD ON BL.mandant_id = BLD.mandant_id AND BL.lief_beleg_id =
        BLD.lief_beleg_id AND BL.dat_lief_soll = BLD.dat_lief_soll
    WHERE BL.lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')) AS bld ON WKW.mandant_id = bld.mandant_id AND
       bld.dat_lief_soll BETWEEN DATE_SUB(A.dat_von, INTERVAL 7 DAY) AND A.dat_bis AND WKW.wup_id = bld.wup_id AND bld.art_id
      = COALESCE(stl.art_id_display, WKW.art_id)
  WHERE COALESCE(WKW.avq_relevant_fg, 1) = 1
   AND WKW.kjwo IN (SELECT kjwo
     FROM kfl_production_dbp_view.v_tag
     WHERE akt_kj BETWEEN - 2 AND 1
     GROUP BY kjwo)) AS t
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON t.mandant_id = V05.mandant_id AND t.wup_id = V05.wup_id AND (V05.nb_id
       IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
WHERE t.row_num = 1;