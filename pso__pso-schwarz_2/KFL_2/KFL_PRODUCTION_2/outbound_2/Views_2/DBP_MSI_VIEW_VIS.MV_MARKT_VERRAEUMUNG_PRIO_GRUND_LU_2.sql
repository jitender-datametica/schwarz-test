CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_markt_verraeumung_prio_grund_lu_2 AS WITH `LOOKUP` AS (SELECT
   verraeumung_prio_grund_id AS id
  FROM kfl_production_dbp_view.v_l_markt_verraeumung_prio_grund_2
  GROUP BY id), SPRACHE AS (SELECT verraeumung_prio_grund_id AS id,
   IF(spr_id = 22, verraeumung_prio_grund_bez, NULL) AS de,
   IF(spr_id = 124, verraeumung_prio_grund_bez, NULL) AS cz,
   IF(spr_id = 108, verraeumung_prio_grund_bez, NULL) AS sk,
   IF(spr_id = 65, verraeumung_prio_grund_bez, NULL) AS hr,
   IF(spr_id = 90, verraeumung_prio_grund_bez, NULL) AS pl,
   IF(spr_id = 95, verraeumung_prio_grund_bez, NULL) AS ro,
   IF(spr_id = 18, verraeumung_prio_grund_bez, NULL) AS bg
  FROM kfl_production_dbp_view.v_markt_verraeumung_prio_grund_spr_zu_2
  GROUP BY id,
   de,
   cz,
   sk,
   hr,
   pl,
   ro,
   bg) (SELECT t2.id AS verraeumung_prio_grund_id,
   COALESCE(t6.de, t6.cz, t6.sk, t6.hr, t6.pl, t6.ro, t6.bg, '-') AS verraeumung_prio_grund_bez_de,
   COALESCE(t6.cz, t6.de, t6.sk, t6.hr, t6.pl, t6.ro, t6.bg, '-') AS verraeumung_prio_grund_bez_cz,
   COALESCE(t6.sk, t6.de, t6.cz, t6.hr, t6.pl, t6.ro, t6.bg, '-') AS verraeumung_prio_grund_bez_sk,
   COALESCE(t6.hr, t6.de, t6.cz, t6.sk, t6.pl, t6.ro, t6.bg, '-') AS verraeumung_prio_grund_bez_hr,
   COALESCE(t6.pl, t6.de, t6.cz, t6.sk, t6.hr, t6.ro, t6.bg, '-') AS verraeumung_prio_grund_bez_pl,
   COALESCE(t6.ro, t6.de, t6.cz, t6.sk, t6.hr, t6.pl, t6.bg, '-') AS verraeumung_prio_grund_bez_ro,
   COALESCE(t6.bg, t6.de, t6.cz, t6.sk, t6.hr, t6.pl, t6.ro, '-') AS verraeumung_prio_grund_bez_bg,
   COALESCE(t6.de, t6.cz, t6.sk, t6.hr, t6.pl, t6.ro, t6.bg, '-') AS verraeumung_prio_grund_bez
  FROM `LOOKUP` AS t2
   LEFT JOIN SPRACHE AS t6 ON t2.id = t6.id);