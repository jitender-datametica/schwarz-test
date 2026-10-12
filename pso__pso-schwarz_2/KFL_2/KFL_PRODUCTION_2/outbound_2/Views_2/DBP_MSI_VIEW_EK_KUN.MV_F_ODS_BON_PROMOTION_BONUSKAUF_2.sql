CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_f_ods_bon_promotion_bonuskauf_2 (mandant_id, bonuskauf_id,
bon_dat, wrg_id, menge_promo, umsatz_promo_brutto) AS SELECT V01.mandant_id,
 V01.bonuskauf_id,
 DATE(V01.start_bon_zeile) AS bon_dat,
  CASE
  WHEN V04.wrg_typ_id = 0
  THEN V05.nach_wrg_id
  ELSE V06.default_wrg
  END AS wrg_id,
 SUM(CASE
   WHEN V03.bonuskauf_partner_fg = 0
   THEN V01.menge_promo
   ELSE 0
   END) AS menge_promo,
 SUM(CASE
   WHEN V02.wrg_id <> 'EUR' AND V06.default_wrg = 'EUR' AND V03.bonuskauf_partner_fg = 0 OR V04.wrg_typ_id = 0 AND V03.bonuskauf_partner_fg
       = 0
   THEN V01.umsatz_promo_brutto * V05.umrechnungskurs
   WHEN V04.wrg_typ_id = 1 AND V03.bonuskauf_partner_fg = 0
   THEN V01.umsatz_promo_brutto
   ELSE 0
   END) AS umsatz_promo_brutto
FROM kfl_production_dbp_v_ods.v_ods_promotion_2 AS V01
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bon_id = V02.bon_id
      AND V01.wup_id = V02.wup_id AND V01.bon_dat = V02.bon_dat
 INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.bonuskauf_id = V03
   .bonuskauf_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V04 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V05 ON V02.bon_dat BETWEEN V05.dat_von AND V05.dat_bis AND V02.wrg_id =
     V05.von_wrg_id AND V05.kurstyp_id = 9 AND V05.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V06 ON V01.mandant_id = V06.mandant_id
GROUP BY V01.mandant_id,
 V01.bonuskauf_id,
 V01.start_bon_zeile,
 V05.nach_wrg_id,
 V06.default_wrg,
 V04.wrg_typ_id,
 V03.bonuskauf_partner_fg;