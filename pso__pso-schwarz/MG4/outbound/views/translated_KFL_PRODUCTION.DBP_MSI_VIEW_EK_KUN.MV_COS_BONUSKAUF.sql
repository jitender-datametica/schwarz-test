CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuskauf (mandant_id, bonuskauf_id, bonuskauf_name,
bonuskauf_typ, bonuskauf_kategorie_bez, gamification_fg, wg_id, dat_von, dat_bis, bonuskauf_bez, max_einloesung,
aktiv_loyalty_gesamt_fg, voraktiviert_fg, dat_von_bedingung, dat_bis_bedingung, kauf_mit_punkte_fg, konditionsart_id,
bonuskauf_promotionstyp, geschaeftsvorfall_id, vk_brutto, vk_aktion_brutto_loyalty, betrag_promo_prozent,
vk_aktion_brutto, bonuskauf_partner_fg, reco_fg, bonuskauf_anbieter_name, bonuskauf_code_generierung_typ_id,
bonuskauf_code_typ_id, bonuskauf_vorteilsregeln_txt, bonuskauf_konditionen_txt, datzeit_bis_extern_einloesung,
datzeit_von_extern_einloesung) AS SELECT v01.mandant_id,
 v01.bonuskauf_id,
 v01.bonuskauf_name,
 v01.bonuskauf_typ,
 v01.bonuskauf_kategorie_bez,
 v01.gamification_fg,
 v01.wg_id,
 DATE(v01.dat_von) AS dat_von,
 DATE(v01.dat_bis) AS dat_bis,
 v01.bonuskauf_bez,
 v01.max_einloesung,
 v01.aktiv_loyalty_gesamt_fg,
 v01.voraktiviert_fg,
 DATE(v01.dat_von_bedingung) AS dat_von_bedingung,
 DATE(v01.dat_bis_bedingung) AS dat_bis_bedingung,
 v01.kauf_mit_punkte_fg,
 v01.konditionsart_id,
 v01.bonuskauf_promotionstyp,
 v01.geschaeftsvorfall_id,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0
  THEN CAST(v01.vk_brutto AS NUMERIC) * v300.umrechnungskurs
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1
  THEN CAST(v01.vk_brutto AS NUMERIC) * v400.umrechnungskurs
  ELSE CAST(v01.vk_brutto AS NUMERIC)
  END AS vk_brutto,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0
  THEN CAST(v01.vk_aktion_brutto_loyalty AS NUMERIC) * v300.umrechnungskurs
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1
  THEN CAST(v01.vk_aktion_brutto_loyalty AS NUMERIC) * v400.umrechnungskurs
  ELSE CAST(v01.vk_aktion_brutto_loyalty AS NUMERIC)
  END AS vk_aktion_brutto_loyalty,
 v01.betrag_promo_prozent,
 v01.vk_aktion_brutto,
 v01.bonuskauf_partner_fg,
  CASE
  WHEN v01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM')
  THEN 1
  ELSE 0
  END AS reco_fg,
 v01.bonuskauf_anbieter_name,
 v01.bonuskauf_code_generierung_typ_id,
 v01.bonuskauf_code_typ_id,
 v01.bonuskauf_vorteilsregeln_txt,
 v01.bonuskauf_konditionen_txt,
 DATE(v01.datzeit_bis_extern_einloesung) AS datzeit_bis_extern_einloesung,
 DATE(v01.datzeit_von_extern_einloesung) AS datzeit_von_extern_einloesung
FROM kfl_production_dbp_view.v_cos_bonuskauf AS v01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS v02 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS v300 ON v300.dat_bis = DATE '9999-12-31' AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3 AND v300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs AS v400 ON CURRENT_DATE BETWEEN v400.dat_von AND v400.dat_bis AND v01.wrg_id
     = v400.von_wrg_id AND v400.kurstyp_id = 3 AND v400.nach_wrg_id = 'EUR';