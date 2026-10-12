CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_art_wup_zu_int (mandant_id, aktion_id, akt_dat_von,
akt_dat_bis, dat, kjwo_von, art_id, vk_aktion_brutto, vk_vor_aktion_brutto, wrg_id, dat_preisaktiviert, grund_sperrung,
wup_id, nb_id, listung_id, vk_brutto, dat_von, dat_bis, kdis, bezugsweg_id) AS SELECT AKT0.mandant_id,
 AKT0.aktion_id,
 AKT0.dat_von AS akt_dat_von,
 AKT0.dat_bis AS akt_dat_bis,
 CURRENT_DATE AS dat,
 AKT0.kjwo_von,
 AKT_ART.art_id,
  AKT_ART.vk_aktion_brutto * krs.umrechnungskurs AS vk_aktion_brutto,
  AKT_ART.vk_vor_aktion_brutto * krs.umrechnungskurs AS vk_vor_aktion_brutto,
 krs.nach_wrg_id AS wrg_id,
 AKT_ART.dat_preisaktiviert,
 AKT_ART.grund_sperrung,
 ART_WUP.wup_id,
 AKT_ART.nb_id,
 ART_WUP.listung_id,
  ART_WUP.vk_brutto * krs.umrechnungskurs AS vk_brutto,
 ART_WUP.dat_von,
 ART_WUP.dat_bis,
 ART_WUP.kdis,
 ART_WUP.bezugsweg_id
FROM kfl_production_dbp_view.v_aktion AS AKT0
 INNER JOIN kfl_production_dbp_view.v_aktion_art_wup_zu AS AKT_ART ON AKT0.aktion_id = AKT_ART.aktion_id AND AKT0.mandant_id
    = AKT_ART.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wup_zu_per AS ART_WUP ON AKT_ART.art_id = ART_WUP.art_id AND AKT_ART.mandant_id
       = ART_WUP.mandant_id AND AKT_ART.wup_id = ART_WUP.wup_id AND AKT_ART.wrg_id = ART_WUP.wrg_id AND AKT0.dat_von
   BETWEEN ART_WUP.dat_von AND ART_WUP.dat_bis
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS nach_wrg_id,
    1.00000 AS umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')) AS krs ON AKT_ART.wrg_id = krs.von_wrg_id
WHERE AKT_ART.grund_sperrung IS NULL
 AND AKT0.dat_von BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE);