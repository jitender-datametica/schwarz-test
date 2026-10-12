CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuskauf (mandant_id, bonuskauf_id, bonuskauf_name,
bonuskauf_typ, bonuskauf_kategorie_bez, gamification_fg, wg_id, dat_von, dat_bis, bonuskauf_bez, max_einloesung,
aktiv_loyalty_gesamt_fg, voraktiviert_fg, dat_von_bedingung, dat_bis_bedingung, kauf_mit_punkte_fg, konditionsart_id,
bonuskauf_promotionstyp, geschaeftsvorfall_id, vk_brutto, vk_aktion_brutto_loyalty, betrag_promo_prozent,
vk_aktion_brutto, bonuskauf_partner_fg, reco_fg, bonuskauf_anbieter_name, bonuskauf_code_generierung_typ_id,
bonuskauf_code_typ_id, bonuskauf_vorteilsregeln_txt, bonuskauf_konditionen_txt, datzeit_bis_extern_einloesung,
datzeit_von_extern_einloesung) AS SELECT V01.mandant_id,
 V01.bonuskauf_id,
 V01.bonuskauf_name,
 V01.bonuskauf_typ,
 V01.bonuskauf_kategorie_bez,
 V01.gamification_fg,
 V01.wg_id,
 DATE(V01.dat_von) AS dat_von,
 DATE(V01.dat_bis) AS dat_bis,
 V01.bonuskauf_bez,
 V01.max_einloesung,
 V01.aktiv_loyalty_gesamt_fg,
 V01.voraktiviert_fg,
 DATE(V01.dat_von_bedingung) AS dat_von_bedingung,
 DATE(V01.dat_bis_bedingung) AS dat_bis_bedingung,
 V01.kauf_mit_punkte_fg,
 V01.konditionsart_id,
 V01.bonuskauf_promotionstyp,
 V01.geschaeftsvorfall_id,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.vk_brutto AS BIGNUMERIC) * V300.umrechnungskurs
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN CAST(V01.vk_brutto AS BIGNUMERIC) * V400.umrechnungskurs
  ELSE CAST(V01.vk_brutto AS BIGNUMERIC)
  END AS vk_brutto,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.vk_aktion_brutto_loyalty AS BIGNUMERIC) * V300.umrechnungskurs
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN CAST(V01.vk_aktion_brutto_loyalty AS BIGNUMERIC) * V400.umrechnungskurs
  ELSE CAST(V01.vk_aktion_brutto_loyalty AS BIGNUMERIC)
  END AS vk_aktion_brutto_loyalty,
 V01.betrag_promo_prozent,
 V01.vk_aktion_brutto,
 V01.bonuskauf_partner_fg,
  CASE
  WHEN V01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM')
  THEN 1
  ELSE 0
  END AS reco_fg,
 V01.bonuskauf_anbieter_name,
 V01.bonuskauf_code_generierung_typ_id,
 V01.bonuskauf_code_typ_id,
 V01.bonuskauf_vorteilsregeln_txt,
 V01.bonuskauf_konditionen_txt,
 DATE(V01.datzeit_bis_extern_einloesung) AS datzeit_bis_extern_einloesung,
 DATE(V01.datzeit_von_extern_einloesung) AS datzeit_von_extern_einloesung
FROM kfl_production_dbp_view.v_cos_bonuskauf AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V02 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V01.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON CURRENT_DATE BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id
     = V400.von_wrg_id AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR';