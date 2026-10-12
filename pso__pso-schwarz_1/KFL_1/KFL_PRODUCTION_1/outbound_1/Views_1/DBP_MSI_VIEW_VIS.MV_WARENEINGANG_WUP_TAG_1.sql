CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wareneingang_wup_tag_1 AS WITH WEWA_1 AS (SELECT mandant_id,
   wup_id,
   wewa_jahr,
   dat_buch,
   art_id,
   wrg_id,
   lager_bewart_id,
   gp_id,
   SUM(CASE
     WHEN CAST(lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND nb_id = 0
     THEN menge_basis
     ELSE 0
     END) AS menge_dz,
   SUM(CASE
     WHEN CAST(lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND nb_id = 0
     THEN menge_basis
     ELSE 0
     END) AS menge_ret_dz,
   SUM(CASE
     WHEN CAST(lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 161, 162) AND nb_id = 0
     THEN betrag_vk_netto
     ELSE 0
     END) AS betrag_vk_netto_dz,
   'wewa_1' AS quelle
  FROM kfl_production_dbp_view.v_wewa_1
  WHERE mandant_id <> 1
   AND CAST(lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 161, 162)
   AND nb_id = 0
   AND dat_buch BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
   AND art_id >= 0
  GROUP BY mandant_id,
   wup_id,
   wewa_jahr,
   dat_buch,
   art_id,
   wrg_id,
   lager_bewart_id,
   gp_id), LAGER AS (SELECT mandant_id,
   wup_id,
   kj,
   dat_buch,
   art_id,
   wrg_id,
   lager_bewart_id,
   gp_id,
   SUM(CASE
     WHEN lager_bewart_id IN ('641', '647', '301', '311')
     THEN ABS(menge_lagerbew_bme)
     ELSE 0
     END) AS menge_zl,
   SUM(CASE
     WHEN lager_bewart_id IN ('642', '648', '302', '312')
     THEN ABS(menge_lagerbew_bme) * - 1
     ELSE 0
     END) AS menge_ret_zl,
   SUM(CASE
     WHEN lager_bewart_id IN ('641', '647', '301', '311')
     THEN ABS(betrag_vk_netto)
     WHEN lager_bewart_id IN ('642', '648', '302', '312')
     THEN ABS(betrag_vk_netto) * - 1
     ELSE 0
     END) AS betrag_vk_netto_zl,
   'lagerbew_det_1' AS quelle
  FROM kfl_production_dbp_view.v_lagerbew_det_1 AS LAGER
  WHERE mandant_id <> 1
   AND lager_bewart_id IN ('641', '647', '301', '311', '642', '648', '302', '312')
   AND dat_buch BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
   AND art_id >= 0
  GROUP BY mandant_id,
   wup_id,
   kj,
   dat_buch,
   art_id,
   wrg_id,
   lager_bewart_id,
   gp_id), FACTS_WEWA_LAGER AS (SELECT w.mandant_id,
    w.wup_id,
    w.wewa_jahr AS jahr,
    w.dat_buch,
    w.art_id,
    w.wrg_id,
    w.lager_bewart_id,
    w.gp_id,
    w.menge_dz,
    w.menge_ret_dz,
    w.betrag_vk_netto_dz,
    IFNULL(l.menge_zl, 0) AS menge_zl,
    IFNULL(l.menge_ret_zl, 0) AS menge_ret_zl,
    IFNULL(l.betrag_vk_netto_zl, 0) AS betrag_vk_netto_zl,
    w.quelle
   FROM WEWA_1 AS w
    LEFT JOIN LAGER AS l ON w.mandant_id = l.mandant_id AND w.wup_id = l.wup_id AND w.wewa_jahr = l.kj AND w.dat_buch =
          l.dat_buch AND w.art_id = l.art_id AND w.wrg_id = l.wrg_id AND w.lager_bewart_id = l.lager_bewart_id AND w.gp_id
       = l.gp_id
   UNION ALL
   SELECT l.mandant_id,
    l.wup_id,
    l.kj AS jahr,
    l.dat_buch,
    l.art_id,
    l.wrg_id,
    l.lager_bewart_id,
    l.gp_id,
    IFNULL(w.menge_dz, 0) AS menge_dz,
    IFNULL(w.menge_ret_dz, 0) AS menge_ret_dz,
    IFNULL(w.betrag_vk_netto_dz, 0) AS betrag_vk_netto_dz,
    l.menge_zl,
    l.menge_ret_zl,
    l.betrag_vk_netto_zl,
    l.quelle
   FROM LAGER AS l
    LEFT JOIN WEWA_1 AS w ON l.mandant_id = w.mandant_id AND l.wup_id = w.wup_id AND l.kj = w.wewa_jahr AND l.dat_buch = w
          .dat_buch AND l.art_id = w.art_id AND l.wrg_id = w.wrg_id AND l.lager_bewart_id = w.lager_bewart_id AND l.gp_id
       = w.gp_id
   WHERE w.mandant_id IS NULL), WUP_1 AS (SELECT mandant_id,
   wup_id,
   aktuell_wup_id
  FROM kfl_production_dbp_view.v_wup_1) (SELECT f.mandant_id,
   w.aktuell_wup_id AS wup_id,
   f.jahr,
   f.dat_buch AS dat,
   f.art_id,
   K.nach_wrg_id AS wrg_id,
   f.lager_bewart_id,
   f.gp_id,
   f.menge_dz,
   f.menge_ret_dz,
    f.betrag_vk_netto_dz * K.umrechnungskurs AS betrag_vk_netto_dz,
   f.menge_zl,
   f.menge_ret_zl,
    f.betrag_vk_netto_zl * K.umrechnungskurs AS betrag_vk_netto_zl,
   f.quelle
  FROM FACTS_WEWA_LAGER AS f
   INNER JOIN WUP_1 AS w ON f.mandant_id = w.mandant_id AND f.wup_id = w.wup_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_1 AS K ON f.wrg_id = K.von_wrg_id);