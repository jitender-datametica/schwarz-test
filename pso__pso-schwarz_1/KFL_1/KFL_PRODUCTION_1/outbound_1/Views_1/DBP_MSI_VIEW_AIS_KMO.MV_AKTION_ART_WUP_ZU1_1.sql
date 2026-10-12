CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_aktion_art_wup_zu1_1 (aktion_id, mandant_id, art_id,
bewart_id, wup_id, nb_id, vk_aktion_brutto, bezugsweg_id, in_aktion_fg, wrg_id, aktion_thema_id, vk_vor_aktion_brutto)
AS SELECT V04.aktion_id,
 V01.mandant_id,
 V01.art_id,
 V01.bewart_id,
 V01.wup_id,
 V01.nb_id,
 CAST(CASE
   WHEN V05.wrg_typ_id = 1
   THEN COALESCE(V01.vk_aktion_brutto, 0)
   WHEN V05.wrg_typ_id = 0 AND V05.berichtskurs_typ_id = 0
   THEN COALESCE(V01.vk_aktion_brutto, 0) * V300.umrechnungskurs
   WHEN V05.wrg_typ_id = 0 AND V05.berichtskurs_typ_id = 1
   THEN COALESCE(V01.vk_aktion_brutto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS vk_aktion_brutto,
 V01.bezugsweg_id,
  CASE
  WHEN V01.grund_sperrung IS NULL
  THEN 1
  ELSE 0
  END AS in_aktion_fg,
 V01.wrg_id,
 V01.aktion_thema_id,
 CAST(CASE
   WHEN V05.wrg_typ_id = 1
   THEN COALESCE(V01.vk_vor_aktion_brutto, 0)
   WHEN V05.wrg_typ_id = 0 AND V05.berichtskurs_typ_id = 0
   THEN COALESCE(V01.vk_vor_aktion_brutto, 0) * V300.umrechnungskurs
   WHEN V05.wrg_typ_id = 0 AND V05.berichtskurs_typ_id = 1
   THEN COALESCE(V01.vk_vor_aktion_brutto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS vk_vor_aktion_brutto
FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
 INNER JOIN kfl_production_dbp_view.v_aktion_1 AS V04 ON V01.aktion_id = V04.aktion_id AND V01.mandant_id = V04.mandant_id
   
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V05 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON V01.wrg_id = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V400 ON V04.dat_bis BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id =
   V400.von_wrg_id
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V01.mandant_id <> 1;