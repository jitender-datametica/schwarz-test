CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_marktabschriften_kmo_aktion_1 (wup_id, nb_id, aktion_id,
mandant_id, dat, art_id, menge_abschrift, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id, vk_aktion_netto,
vk_vor_aktion_netto) AS SELECT V01.wup_id,
 V01.nb_id,
 V01.aktion_id,
 V01.mandant_id,
 V01.dat,
 V01.art_id,
 V01.menge_abschrift,
 V01.abschriftbetrag_netto,
 V01.abschriftbetrag_brutto,
 V01.wrg_id,
 V01.vk_aktion_netto,
 V01.vk_vor_aktion_netto
FROM kfl_production_dbp_view.v_marktabschriften_kmo_aktion_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
          AND (V02.mandant_id NOT IN (1, 7) OR V02.mandant_id IN (1, 7) AND TRIM(CAST(V02.wg_id AS STRING FORMAT '000')
             ) || TRIM(CAST(V02.wug_id AS STRING FORMAT '000')) <> '969006') AND (V02.mandant_id <> 7 OR V02.mandant_id
          = 7 AND TRIM(CAST(V02.wg_id AS STRING FORMAT '000')) <> '980') AND V02.wg_id <> 961 AND (V02.mandant_id NOT IN
        (2, 3, 4, 5, 6, 7, 8) OR V02.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND TRIM(CAST(V02.wg_id AS STRING FORMAT '000')
          ) || TRIM(CAST(V02.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V02.arthiertyp_id
     = 2 AND V02.dat_bis = DATE '9999-12-31';