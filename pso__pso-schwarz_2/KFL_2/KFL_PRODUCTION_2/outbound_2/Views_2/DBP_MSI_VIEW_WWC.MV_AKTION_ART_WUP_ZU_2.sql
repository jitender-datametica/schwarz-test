CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_aktion_art_wup_zu_2 (aktion_id, art_id, wup_id, nb_id,
mandant_id, vk_aktion_brutto, vk_vor_aktion_brutto, vk_aktion_netto, vk_vor_aktion_netto) AS SELECT V01.aktion_id,
 V01.art_id,
 V01.wup_id,
 0 AS nb_id,
 V01.mandant_id,
 V01.vk_aktion_brutto,
 V01.vk_vor_aktion_brutto,
 TRUNC(CAST(V01.vk_aktion_brutto / (1.00 + TRUNC(CAST(V03.mwst / 100.00 AS BIGNUMERIC))) AS BIGNUMERIC)) AS
 vk_aktion_netto,
 TRUNC(CAST(V01.vk_vor_aktion_brutto / (1.00 + TRUNC(CAST(V03.mwst / 100.00 AS BIGNUMERIC))) AS BIGNUMERIC)) AS
 vk_vor_aktion_netto
FROM kfl_production_dbp_view.v_aktion_art_wup_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V03 ON V02.mwst_id = V03.mwst_id AND V02.mandant_id = V03.mandant_id
  AND V03.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
          AND (V04.mandant_id NOT IN (1, 7) OR V04.mandant_id IN (1, 7) AND TRIM(CAST(V04.wg_id AS STRING FORMAT '000')
             ) || TRIM(CAST(V04.wug_id AS STRING FORMAT '000')) <> '969006') AND (V04.mandant_id <> 7 OR V04.mandant_id
          = 7 AND TRIM(CAST(V04.wg_id AS STRING FORMAT '000')) <> '980') AND V04.wg_id <> 961 AND (V04.mandant_id NOT IN
        (2, 3, 4, 5, 6, 7, 8) OR V04.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND TRIM(CAST(V04.wg_id AS STRING FORMAT '000')
          ) || TRIM(CAST(V04.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V04.arthiertyp_id
     = 2 AND V04.dat_bis = DATE '9999-12-31'
WHERE V01.mandant_id <> 1
 AND V01.grund_sperrung IS NULL;