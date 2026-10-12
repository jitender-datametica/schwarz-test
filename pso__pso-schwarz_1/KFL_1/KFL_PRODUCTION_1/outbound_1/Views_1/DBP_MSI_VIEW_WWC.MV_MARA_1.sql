CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_mara_1 (art_id, mandant_id, mandant_kbez, matnr_sap, mwst_id,
land_id, region_id, kl_art_id, dat_von, dat_bis, loesch_id, bio_fg, wg_art_fg, lead_id, leist_id, discount_id,
verpart_id, esb_id, aldi_id, zek_id, gewart_id, eigenmarke_id, mutter_wb_id, pmata, display_id, bprme, loeschvorm_fg,
mhd_zeitraum, meins, mtart, faktor_nettoinhalt, lager_prozent, saiso, posten_id, attyp, bismt, verkauf_sperre_fg,
zzek_nsale, yellowprint_fg, tagesartikel_fg, verhandler_id, mutter_vk_id, muki_block_vk_id, muki_block_kz_vk_id,
muki_block_wb_id, muki_block_kz_wb_id, muki_kz_vk_id, muki_kz_wb_id, inhalt_menge, inhalt_menge_einh_id, ipn_id, gtin_id
, nettogew, ek_marken_id, int_art_id) AS SELECT V01.art_id,
 V01.mandant_id,
 V02.mandant_kbez,
  CASE
  WHEN V01.artikelart_id IN ('MWST', 'ZWER')
  THEN CONCAT('W', SUBSTR(SUBSTR(CAST(V01.kl_art_id AS STRING), 1, 10), 2, 4))
  ELSE CASE
   WHEN V01.mandant_id <> 1 OR V01.mandant_id = 1 AND V01.art_id > 0
   THEN TRIM(CAST(V01.kl_art_id AS STRING FORMAT '00000000'))
   WHEN V01.mandant_id = 1 AND V01.art_id < 0
   THEN '00' || CAST(TRUNC(CAST(V01.art_id / 100 AS BIGNUMERIC)) AS STRING)
   ELSE NULL
   END
  END AS matnr_sap,
 V01.mwst_id,
 V01.land_id,
 V01.region_id,
 V01.kl_art_id,
 V01.dat_von,
 V01.dat_bis,
 V01.loesch_id,
 V01.bio_fg,
 V01.wg_art_fg,
 V01.lead_id,
 V01.leist_id,
 V01.discount_id,
 V01.verpart_id,
 V01.esb_id,
 V01.aldi_id,
 V01.zek_id,
 V01.gewart_id,
 V01.eigenmarke_id,
 V01.mutter_wb_id,
 V01.mutter_vk_id AS pmata,
 V01.display_id,
 V01.best_menge_einh_id AS bprme,
 V01.loeschvorm_fg,
 V01.mhd_zeitraum,
 V01.basismenge_einh_id AS meins,
 V01.artikelart_id AS mtart,
 V01.faktor_nettoinhalt,
 V01.lager_prozent,
 V01.saison_id AS saiso,
  CASE
  WHEN V01.mandant_id = 1
  THEN V01.posten_id
  ELSE V01.posten_kz_sap
  END AS posten_id,
 V01.artikeltyp_id AS attyp,
  CASE
  WHEN V01.artikelart_id = 'MWST'
  THEN TRIM(CAST(V01.kl_art_id_alt AS STRING FORMAT '0000'))
  ELSE CASE
   WHEN V01.mandant_id <> 1 OR V01.mandant_id = 1 AND V01.kl_art_id_alt > 0
   THEN TRIM(CAST(V01.kl_art_id_alt AS STRING FORMAT '00000000'))
   WHEN V01.mandant_id = 1 AND V01.kl_art_id_alt < 0
   THEN '00' || CAST(V01.kl_art_id_alt AS STRING)
   ELSE NULL
   END
  END AS bismt,
 V01.verkauf_sperre_fg,
 V01.kein_abverkauf_fg AS zzek_nsale,
  CASE
  WHEN V01.yellowprint_fg = 1
  THEN 'X'
  ELSE ''
  END AS yellowprint_fg,
 V01.tagesartikel_fg,
 V01.verhandler_id,
 V01.mutter_vk_id,
 COALESCE(V01.mutter_vk_id, V01.art_id) AS muki_block_vk_id,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_vk_id,
 COALESCE(V01.mutter_wb_id, V01.art_id) AS muki_block_wb_id,
  CASE
  WHEN V01.mutter_wb_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_wb_id,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  WHEN V01.art_id = V01.mutter_vk_id
  THEN 'M'
  ELSE 'K'
  END AS muki_kz_vk_id,
  CASE
  WHEN V01.mutter_wb_id IS NULL
  THEN 'W'
  WHEN V01.art_id = V01.mutter_wb_id
  THEN 'M'
  ELSE 'K'
  END AS muki_kz_wb_id,
 V01.inhalt_menge,
 V01.inhalt_menge_einh_id,
 V01.ipn_id,
 V01.gtin_id,
 V01.nettogew,
 V01.ek_marken_id,
 V01.int_art_id
FROM kfl_production_dbp_view.v_art_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.dat_bis =
   DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
          AND (V03.mandant_id NOT IN (1, 7) OR V03.mandant_id IN (1, 7) AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')
             ) || TRIM(CAST(V03.wug_id AS STRING FORMAT '000')) <> '969006') AND (V03.mandant_id <> 7 OR V03.mandant_id
          = 7 AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')) <> '980') AND V03.wg_id <> 961 AND (V03.mandant_id NOT IN
        (2, 3, 4, 5, 6, 7, 8) OR V03.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')
          ) || TRIM(CAST(V03.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V03.arthiertyp_id
     = 2 AND V03.dat_bis = DATE '9999-12-31';