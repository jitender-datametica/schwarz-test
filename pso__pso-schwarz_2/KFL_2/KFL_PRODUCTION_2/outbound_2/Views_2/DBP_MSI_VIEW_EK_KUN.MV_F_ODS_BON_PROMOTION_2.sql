CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_f_ods_bon_promotion_2 (mandant_id, bon_id, wrg_id, wup_id,
bon_zeile, bonuskauf_id, konditionsart_id, promotion_lfd_nr, kl_art_id, start_bon_zeile, bon_dat, menge_promo,
umsatz_promo_brutto, betrag_promo_brutto) AS SELECT V01.mandant_id,
 V01.bon_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V300.nach_wrg_id
  ELSE V05.default_wrg
  END AS wrg_id,
 V01.wup_id,
 V01.bon_zeile,
 V01.bonuskauf_id,
 V01.konditionsart_id,
 V01.promotion_lfd_nr,
 V01.kl_art_id,
 V01.start_bon_zeile,
 FORMAT_DATETIME('%F', V01.start_bon_zeile) AS bon_dat,
 SUM(V01.menge_promo) AS menge_promo,
 SUM(CASE
   WHEN V02.wrg_id <> 'EUR' AND V05.default_wrg = 'EUR' OR V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN V01.umsatz_promo_brutto * V300.umrechnungskurs
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN V01.umsatz_promo_brutto * V400.umrechnungskurs
   ELSE V01.umsatz_promo_brutto
   END) AS umsatz_promo_brutto,
 SUM(CASE
   WHEN V02.wrg_id <> 'EUR' AND V05.default_wrg = 'EUR' OR V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_promo_brutto * V300.umrechnungskurs
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_promo_brutto * V400.umrechnungskurs
   ELSE V01.betrag_promo_brutto
   END) AS betrag_promo_brutto
FROM kfl_production_dbp_v_ods.v_ods_promotion_2 AS V01
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bon_id = V02.bon_id
      AND V01.wup_id = V02.wup_id AND V01.bon_dat = V02.bon_dat
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V03 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V02.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V400 ON V02.bon_dat BETWEEN V400.dat_von AND V400.dat_bis AND V02.wrg_id =
     V400.von_wrg_id AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V05 ON V01.mandant_id = V05.mandant_id
GROUP BY V01.mandant_id,
 V01.bon_id,
 V01.wup_id,
 V01.bon_zeile,
 V01.bonuskauf_id,
 V01.konditionsart_id,
 V01.promotion_lfd_nr,
 V01.kl_art_id,
 V01.start_bon_zeile,
 V300.nach_wrg_id,
 V05.default_wrg,
 V03.wrg_typ_id;