CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_markt_lagerbereich_lu_2 AS WITH `LOOKUP` AS (SELECT mandant_id,
   markt_lagerbereich_id AS id
  FROM kfl_production_dbp_view.v_l_markt_lagerbereich_2), SPRACHE AS (SELECT mandant_id,
   markt_lagerbereich_id AS id,
   IF(spr_id = 22, markt_lagerbereich_bez, NULL) AS de,
   IF(spr_id = 124, markt_lagerbereich_bez, NULL) AS cz,
   IF(spr_id = 108, markt_lagerbereich_bez, NULL) AS sk,
   IF(spr_id = 65, markt_lagerbereich_bez, NULL) AS hr,
   IF(spr_id = 90, markt_lagerbereich_bez, NULL) AS pl,
   IF(spr_id = 95, markt_lagerbereich_bez, NULL) AS ro,
   IF(spr_id = 18, markt_lagerbereich_bez, NULL) AS bg
  FROM kfl_production_dbp_view.v_markt_lagerbereich_spr_zu_2) (SELECT t0.mandant_id,
   t0.id AS markt_lagerbereich_id,
   COALESCE(t2.de, t2.cz, t2.sk, t2.hr, t2.pl, t2.ro, t2.bg, '-') AS markt_lagerbereich_bez_de,
   COALESCE(t2.cz, t2.de, t2.sk, t2.hr, t2.pl, t2.ro, t2.bg, '-') AS markt_lagerbereich_bez_cz,
   COALESCE(t2.sk, t2.de, t2.cz, t2.hr, t2.pl, t2.ro, t2.bg, '-') AS markt_lagerbereich_bez_sk,
   COALESCE(t2.hr, t2.de, t2.cz, t2.sk, t2.pl, t2.ro, t2.bg, '-') AS markt_lagerbereich_bez_hr,
   COALESCE(t2.pl, t2.de, t2.cz, t2.sk, t2.hr, t2.ro, t2.bg, '-') AS markt_lagerbereich_bez_pl,
   COALESCE(t2.ro, t2.de, t2.cz, t2.sk, t2.hr, t2.pl, t2.bg, '-') AS markt_lagerbereich_bez_ro,
   COALESCE(t2.bg, t2.de, t2.cz, t2.sk, t2.hr, t2.pl, t2.ro, '-') AS markt_lagerbereich_bez_bg,
   COALESCE(t2.de, t2.cz, t2.sk, t2.hr, t2.pl, t2.ro, t2.bg, '-') AS markt_lagerbereich_bez
  FROM `LOOKUP` AS t0
   LEFT JOIN SPRACHE AS t2 ON t0.mandant_id = t2.mandant_id AND t0.id = t2.id);