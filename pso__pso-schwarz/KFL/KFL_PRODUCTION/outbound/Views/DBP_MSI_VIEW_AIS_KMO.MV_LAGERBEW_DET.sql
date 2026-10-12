CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_lagerbew_det (mandant_id, wup_id, nb_id, vz_id,
mandant_id_empfaenger, empfaenger_wup_id, empfaenger_nb_id, art_id, gp_id, dat, lager_bewart_id, lagerort_id,
menge_lagerbew_bme, wa_vz_menge, wa_vz_menge_ret, wa_vz_gld, wa_vz_gld_ret, wa_vz_ek_n_4, wa_vz_ek_n_4_ret) AS SELECT
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.wup_id AS vz_id,
 V01.mandant_id_empfaenger,
 V01.empfaenger_id AS empfaenger_wup_id,
 V03.nb_id AS empfaenger_nb_id,
 V01.art_id,
 V01.gp_id_zl AS gp_id,
 V01.dat_buch AS dat,
 V01.lager_bewart_id,
 V01.lagerort_id,
 V01.menge_lagerbew_bme,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('641', '647')
   THEN ABS(V01.menge_lagerbew_bme)
   WHEN V01.lager_bewart_id IN ('642', '648')
   THEN - 1 * ABS(V01.menge_lagerbew_bme)
   ELSE NULL
   END, 0) AS wa_vz_menge,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('301', '311')
   THEN - 1 * ABS(V01.menge_lagerbew_bme)
   WHEN V01.lager_bewart_id IN ('302', '312')
   THEN ABS(V01.menge_lagerbew_bme)
   ELSE NULL
   END, 0) AS wa_vz_menge_ret,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('642', '648') AND V04.wrg_typ_id = 1
   THEN - 1 * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('642', '648') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN - 1 * V300.umrechnungskurs * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('642', '648') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN - 1 * V400.umrechnungskurs * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('641', '647') AND V04.wrg_typ_id = 1
   THEN ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('641', '647') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN V300.umrechnungskurs * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('641', '647') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN V400.umrechnungskurs * ABS(V01.betrag_lagerbew)
   ELSE NULL
   END, 0) AS wa_vz_gld,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('301', '311') AND V04.wrg_typ_id = 1
   THEN - 1 * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN - 1 * V300.umrechnungskurs * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN - 1 * V400.umrechnungskurs * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('302', '312') AND V04.wrg_typ_id = 1
   THEN ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN V300.umrechnungskurs * ABS(V01.betrag_lagerbew)
   WHEN V01.lager_bewart_id IN ('302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN V400.umrechnungskurs * ABS(V01.betrag_lagerbew)
   ELSE NULL
   END, 0) AS wa_vz_gld_ret,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('642', '648') AND V04.wrg_typ_id = 1
   THEN - 1 * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('642', '648') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN - 1 * V300.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('642', '648') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN - 1 * V400.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('641', '647') AND V04.wrg_typ_id = 1
   THEN ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('641', '647') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN V300.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('641', '647') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN V400.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   ELSE NULL
   END, 0) AS wa_vz_ek_n_4,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('301', '311') AND V04.wrg_typ_id = 1
   THEN - 1 * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN - 1 * V300.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN - 1 * V400.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('302', '312') AND V04.wrg_typ_id = 1
   THEN ABS(V01.betrag_einstandspreis)
   WHEN V01.lager_bewart_id IN ('302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0 OR V01.lager_bewart_id
        IN ('302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN V300.umrechnungskurs * ABS(V01.betrag_einstandspreis)
   ELSE NULL
   END, 0) AS wa_vz_ek_n_4_ret
FROM kfl_production_dbp_view.v_lagerbew_det AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id AND (V01
      .lager_bewart_id IN ('641', '642', '647', '648') OR V01.lager_bewart_id IN ('301', '302', '311', '312') AND V01.lagerort_id
        = '0019') AND (IFNULL(CASE
       WHEN V01.lager_bewart_id IN ('641', '647')
       THEN ABS(V01.menge_lagerbew_bme)
       WHEN V01.lager_bewart_id IN ('642', '648')
       THEN - 1 * ABS(V01.menge_lagerbew_bme)
       ELSE NULL
       END, 0) <> 0 OR IFNULL(CASE
       WHEN V01.lager_bewart_id IN ('301', '311')
       THEN - 1 * ABS(V01.menge_lagerbew_bme)
       WHEN V01.lager_bewart_id IN ('302', '312')
       THEN ABS(V01.menge_lagerbew_bme)
       ELSE NULL
       END, 0) <> 0)
 INNER JOIN kfl_production_dbp_view.v_wup AS V03 ON V01.mandant_id_empfaenger = V03.mandant_id AND V01.empfaenger_id =
    V03.wup_id AND (V01.nb_id = - 111 OR V03.nb_id = - 111)
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V04 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V01.wrg_id = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V01.dat_buch BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id
   = V400.von_wrg_id
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V01.mandant_id <> 1;