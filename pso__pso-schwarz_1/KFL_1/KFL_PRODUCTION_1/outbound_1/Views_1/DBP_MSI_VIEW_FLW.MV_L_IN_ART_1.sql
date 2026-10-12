CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_art_1 (mandant_id, in_art_id, flw_art_id, in_art_nr, art_id
, basismenge_einh_id, prodhier_id, artikelart_id, vol, vol_einh_id, nettogew, gew_einh_id, best_menge_einh_id,
best_basismenge_einh_id, bedarfsplan_id, produktgruppe_id, wg_art_fg, posten_id, loesch_id, gewart_id, muki_block_vk_id
, bio_fg, discount_id, mhd_zeitraum, fw_saison_id, fw_wk_system_id, fw_wk_discount_id, fw_wk_national_id,
fw_we_hammer_id, fw_we_artikel_id, fw_reserve_id, ind_fg, tierwohl_kz, loesch_id_ind, dat_von_loesch_id_ind) AS SELECT
 V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.flw_art_id,
 V01.flw_art_nr AS in_art_nr,
 V01.art_id,
 V01.basismenge_einh_id,
 1 AS prodhier_id,
 V01.artikelart_id,
 V01.vol,
 V01.vol_einh_id,
 V01.nettogew,
 V01.gew_einh_id,
 V01.best_menge_einh_id,
  CASE
  WHEN V01.best_menge_einh_id = ''
  THEN V01.basismenge_einh_id
  ELSE V01.best_menge_einh_id
  END AS best_basismenge_einh_id,
  CASE
  WHEN V01.bedarfsplan_id = ''
  THEN 'System generated'
  ELSE V01.bedarfsplan_id
  END AS bedarfsplan_id,
 V01.produktgruppe_id,
 COALESCE(V02.wg_art_fg, 0) AS wg_art_fg,
 COALESCE(CASE
   WHEN V02.mandant_id = 2 AND V02.posten_id = ''
   THEN '0'
   ELSE V02.posten_id
   END, CASE
   WHEN V02.mandant_id = 1
   THEN ''
   ELSE '0'
   END) AS posten_id,
 COALESCE(V02.loesch_id, '') AS loesch_id,
 COALESCE(V02.gewart_id, '') AS gewart_id,
 COALESCE(V02.mutter_vk_id, V02.art_id, - 1) AS muki_block_vk_id,
 COALESCE(V02.bio_fg, 0) AS bio_fg,
 COALESCE(V02.discount_id, 0) AS discount_id,
 COALESCE(V02.mhd_zeitraum, - 1) AS mhd_zeitraum,
 COALESCE(V02.fw_saison_id, '') AS fw_saison_id,
 COALESCE(V02.fw_wk_system_id, '') AS fw_wk_system_id,
 COALESCE(V02.fw_wk_discount_id, '') AS fw_wk_discount_id,
 COALESCE(V02.fw_wk_national_id, '') AS fw_wk_national_id,
 COALESCE(V02.fw_we_hammer_id, '') AS fw_we_hammer_id,
 COALESCE(V02.fw_we_artikel_id, '') AS fw_we_artikel_id,
 COALESCE(V02.fw_reserve_id, '') AS fw_reserve_id,
 1 AS ind_fg,
 V02.tierwohl_kz,
 COALESCE(V01.loesch_id, '') AS loesch_id_ind,
 V01.dat_von_loesch_id AS dat_von_loesch_id_ind
FROM kfl_production_dbp_view.v_flw_art_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 LEFT JOIN (SELECT mandant_id,
   flw_art_id,
   MAX(CASE
     WHEN flw_art_col_id = 2
     THEN art_col_auspr
     ELSE NULL
     END) AS prodh_lvl_2
  FROM kfl_production_dbp_view.v_flw_art_col_zu_1
  GROUP BY mandant_id,
   flw_art_id) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.flw_art_id = v03.flw_art_id
WHERE (V01.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
     'ZFLV') OR V01.flw_art_id = - 1)
 AND V01.mandant_id IN (1, 2)
UNION DISTINCT
SELECT V01.mandant_id,
  CASE
  WHEN V01.art_id < 0
  THEN V01.art_id * - 1 + 10000000
  ELSE V01.art_id * - 1
  END AS in_art_id,
  CASE
  WHEN V01.art_id < 0
  THEN V01.art_id * - 1 + 10000000
  ELSE V01.art_id * - 1
  END AS flw_art_id,
 CAST(V01.kl_art_id AS STRING) AS in_art_nr,
 V01.art_id,
 V01.basismenge_einh_id,
 1 AS prodhier_id,
 '' AS artikelart_id,
 0 AS vol,
 '' AS vol_einh_id,
 0 AS nettogew,
 '' AS gew_einh_id,
 '' AS best_menge_einh_id,
 '' AS best_basismenge_einh_id,
 '' AS bedarfsplan_id,
 '' AS produktgruppe_id,
 V01.wg_art_fg,
  CASE
  WHEN V01.mandant_id = 2 AND V01.posten_id = ''
  THEN '0'
  ELSE V01.posten_id
  END AS posten_id,
 V01.loesch_id,
 V01.gewart_id,
 COALESCE(V01.mutter_vk_id, V01.art_id) AS muki_block_vk_id,
 V01.bio_fg,
 V01.discount_id,
 V01.mhd_zeitraum,
 V01.fw_saison_id,
 V01.fw_wk_system_id,
 V01.fw_wk_discount_id,
 V01.fw_wk_national_id,
 V01.fw_we_hammer_id,
 V01.fw_we_artikel_id,
 V01.fw_reserve_id,
 0 AS ind_fg,
 V01.tierwohl_kz,
 '' AS loesch_id_ind,
 CAST(NULL AS DATE) AS dat_von_loesch_id_ind
FROM kfl_production_dbp_view.v_art_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
   
WHERE V01.mandant_id IN (1, 2)
 AND V03.dat_bis = DATE '9999-12-31'
 AND V03.arthiertyp_id = 2
 AND V03.wg_id IN (3, 122, 128, 134, 135, 136, 137, 138, 139, 141, 142, 144, 145, 146, 147, 158, 159, 184, 186, 232, 233
   , 234, 235, 236, 237, 238, 239, 331, 242, 243, 244, 245, 246)
 AND V01.dat_bis = DATE '9999-12-31'
 AND V02.flw_art_id IS NULL;