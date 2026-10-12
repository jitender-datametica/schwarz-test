CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_cc_bestand_2 AS
/* 2020-12-17 nwag2310: performance-optimization, moved country_2+storeId creation here */
-- Artikelliste vom Fachbereich + WKL1 Listung
 -- Letzter Marktbestand eoB.

-- 2020-11-16 nwag2310: performance-optimization

-- Nicht-Stornierte Verkaufsbons vom auf den eoB-Bestand folgenden Tag_2

-- 2020-11-16 nwag2310: performance-optimization

/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
-- Marktlieferungen vom auf den eoB-Bestand folgenden Tag_2

-- 2021-03-03 nwag2310: performance-optimization (dat_lief_soll in joinkey)
 SELECT grundmenge.country_2,
 grundmenge.storeid,
 RIGHT('00000000' || TRIM(SUBSTR(CAST(grundmenge.kl_art_id AS STRING), 1, 7)), 8) AS klnr,
   COALESCE(BESTAND.menge_lgbest_erp_frei_bme, 0) + COALESCE(we.we_heute, 0) - COALESCE(bon.menge_bon, 0) AS stock
FROM (SELECT L.mandant_id,
   L.wup_id,
   L.art_id,
   A.kl_art_id,
    CASE
    WHEN M.mandant_kbez = 'D'
    THEN 'DE'
    ELSE M.mandant_kbez
    END AS country_2,
     CASE
     WHEN M.mandant_kbez = 'D'
     THEN 'DE'
     ELSE M.mandant_kbez
     END || SUBSTR(CAST(L.wup_id AS STRING), 1, 4) AS storeid
  FROM kfl_production_dbp_view.v_art_list_wup_zu_per_2 AS L
   INNER JOIN kfl_production_dbp_view.v_art_2 AS A ON L.mandant_id = A.mandant_id AND L.art_id = A.art_id
   INNER JOIN kfl_production_dbp_data_center.cc_artikel_2 AS GM ON A.mandant_id = GM.mandant_id AND A.kl_art_id = GM.kl_art_id
     
   INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON GM.mandant_id = M.mandant_id -- Laenderbezeichnung

  WHERE L.dat_bis = PARSE_DATE('%F', '9999-12-31')
  GROUP BY L.mandant_id,
   L.wup_id,
   L.art_id,
   A.kl_art_id,
   country_2,
   storeid) AS grundmenge
 INNER JOIN kfl_production_dbp_view.v_marktbestand_erp_delta_2 AS BESTAND ON grundmenge.mandant_id = BESTAND.mandant_id
   AND grundmenge.wup_id = BESTAND.wup_id AND grundmenge.art_id = BESTAND.art_id
 LEFT JOIN (SELECT VK.mandant_id,
   VK.wup_id,
   VK.kl_art_id,
   VK.bon_dat,
   SUM(VK.menge) AS menge_bon
  FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf_2 AS VK_2
   INNER JOIN kfl_production_dbp_data_center.cc_artikel_2 AS GM0 ON VK.mandant_id = GM0.mandant_id AND VK.kl_art_id = GM0
     .kl_art_id -- 2020-12-17 nwag2310: performance-optimization

   INNER JOIN kfl_production_dbp_view.v_art_2 AS A0 ON GM0.mandant_id = A0.mandant_id AND GM0.kl_art_id = A0.kl_art_id
   INNER JOIN kfl_production_dbp_view.v_marktbestand_erp_delta_2 AS MB ON VK.mandant_id = MB.mandant_id AND A0.art_id = MB
       .art_id AND VK.wup_id = MB.wup_id AND VK.bon_dat = DATE_ADD(MB.dat, INTERVAL 1 DAY)
  WHERE VK.bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
   AND (VK.mandant_id, VK.wup_id, VK.bon_id, VK.bon_dat) NOT IN (SELECT (mandant_id, wup_id, bon_id, bon_dat)
     FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2)
  GROUP BY VK.mandant_id,
   VK.wup_id,
   VK.bon_dat,
   VK.kl_art_id) AS bon ON grundmenge.mandant_id = bon.mandant_id AND grundmenge.wup_id = bon.wup_id AND grundmenge.kl_art_id
    = bon.kl_art_id
 LEFT JOIN (SELECT BL.mandant_id,
   ROUND(CAST(TRUNC(CAST(BL.kunde_id AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS wup_id,
   BLD.art_id,
   BLD.dat_lief_soll,
   SUM(BLD.menge_lief_ist_bme) AS we_heute
  FROM kfl_production_dbp_view.v_besch_lief_det_2 AS BLD
   INNER JOIN kfl_production_dbp_view.v_besch_lief_2 AS BL ON BLD.mandant_id = BL.mandant_id AND BLD.lief_beleg_id = BL.lief_beleg_id
       AND BLD.dat_lief_soll -- 2020-12-17 nwag2310: performance-optimization
 = BL.dat_lief_soll
   INNER JOIN kfl_production_dbp_view.v_art_2 AS A1 ON BLD.mandant_id = A1.mandant_id AND BLD.art_id = A1.art_id
   INNER JOIN kfl_production_dbp_data_center.cc_artikel_2 AS GM1 ON BLD.mandant_id = GM1.mandant_id AND A1.kl_art_id = GM1
     .kl_art_id
   INNER JOIN kfl_production_dbp_view.v_marktbestand_erp_delta_2 AS MB0 ON BLD.mandant_id = MB0.mandant_id AND BLD.art_id
       = MB0.art_id AND ROUND(SAFE_CAST(BL.kunde_id AS BIGNUMERIC), 0) = MB0.wup_id AND BLD.dat_lief_soll = DATE_ADD(MB0
      .dat, INTERVAL 1 DAY)
  WHERE BLD.dat_lief_soll BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
  GROUP BY BL.mandant_id,
   wup_id,
   BLD.art_id,
   BLD.dat_lief_soll) AS we ON grundmenge.mandant_id = we.mandant_id AND grundmenge.wup_id = we.wup_id AND grundmenge.art_id
    = we.art_id;