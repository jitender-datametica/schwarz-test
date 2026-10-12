CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_kjwo_aktion_thema_1 AS SELECT AAWZ.mandant_id,
 AAWZ.wup_id,
 AAWZ.nb_id,
 T.kjwo,
 AAWZ.art_id,
 AAWZ.aktion_thema_id,
 ATS.aktion_thema_bez
FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS AAWZ
 INNER JOIN kfl_production_dbp_view.v_aktion_1 AS A ON AAWZ.mandant_id = A.mandant_id AND AAWZ.aktion_id = A.aktion_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON A.dat_von = T.dat
 INNER JOIN kfl_production_dbp_view.v_aktion_thema_spr_zu_1 AS ATS ON AAWZ.mandant_id = ATS.mandant_id AND AAWZ.aktion_thema_id
     = ATS.aktion_thema_id AND ATS.spr_id = 22
WHERE A.mandant_id = 1
 AND AAWZ.dat_sperrung IS NULL
 AND A.preisaktiviert_fg = 1
 AND A.dat_von BETWEEN DATE '2016-01-01' AND (CURRENT_DATE)
 AND AAWZ.aktion_thema_id <> '0495'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(AAWZ.mandant_id AS STRING), CAST(AAWZ.wup_id AS STRING), CAST(AAWZ.nb_id AS STRING)
      , CAST(T.kjwo AS STRING), CAST(AAWZ.art_id AS STRING) ORDER BY AAWZ.aktion_id IS NULL, AAWZ.aktion_id)) = 1;