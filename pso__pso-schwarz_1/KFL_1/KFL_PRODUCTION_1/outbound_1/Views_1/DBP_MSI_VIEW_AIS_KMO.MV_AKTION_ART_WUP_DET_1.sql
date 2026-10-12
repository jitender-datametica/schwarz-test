CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_aktion_art_wup_det_1 (aktion_id, mandant_id,
geplante_aktion_id, art_id, wup_id, nb_id, dat, geplante_sap_aktion_id, in_aktion_fg, wrg_id, vk_menge_aktion, vk_dat)
AS SELECT V01.aktion_id,
 V01.mandant_id,
 V05.plan_aktion_id AS geplante_aktion_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V04.dat,
 V05.plan_aktion_id AS geplante_sap_aktion_id,
  CASE
  WHEN V01.grund_sperrung IS NULL
  THEN 1
  ELSE 0
  END AS in_aktion_fg,
 V04.wrg_1 AS wrg_id,
 CAST(V04.menge AS BIGNUMERIC) AS vk_menge_aktion,
 V04.dat AS vk_dat
FROM kfl_production_dbp_data.aktion_art_wup_zu_1 AS V01
 INNER JOIN kfl_production_dbp_data.aktion_1 AS V02 ON V01.aktion_id = V02.aktion_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_data.tag_1 AS V03 ON V03.dat BETWEEN V02.dat_von AND V02.dat_bis
 INNER JOIN kfl_production_dbp_data.artbew_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V03.dat = V04.dat AND V01.art_id
            = V04.art_id AND V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND (V04.mandant_id <> 5 OR V04.art_id <>
          206731500) AND (V04.mandant_id <> 2 OR V04.art_id <> 208124500) AND (V04.mandant_id <> 3 OR V04.art_id <>
        208113690) AND (V04.mandant_id <> 6 OR V04.art_id <> 208131570) AND (V04.mandant_id NOT IN (4, 7) OR V04.art_id
      <> 208114740) AND (V04.mandant_id <> 8 OR V04.art_id <> 208131640)
 INNER JOIN kfl_production_dbp_data.aktion_art_aktion_zu_1 AS V05 ON V02.mandant_id = V05.mandant_id AND V02.aktion_id =
   V05.aktion_id
 INNER JOIN kfl_production_dbp_data.art_1 AS V07 ON V01.mandant_id = V07.mandant_id AND V01.art_id = V07.art_id AND V05.kl_art_id
    = V07.kl_art_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V08 ON TRUE
WHERE V03.dat >= DATE '2010-01-01'
 AND V01.mandant_id <> 1;