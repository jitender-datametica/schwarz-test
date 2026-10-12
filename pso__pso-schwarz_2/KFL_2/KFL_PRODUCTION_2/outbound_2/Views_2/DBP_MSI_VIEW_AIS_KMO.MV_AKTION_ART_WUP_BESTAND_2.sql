CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_aktion_art_wup_bestand_2 (aktion_id, mandant_id,
geplante_aktion_id, art_id, wup_id, nb_id, geplante_sap_aktion_id, in_aktion_fg, wrg_id, menge_aktion_bestand_bme,
menge_aktion_bestand_bme_frei) AS SELECT V01.aktion_id,
 V01.mandant_id,
 V04.plan_aktion_id AS geplante_aktion_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V04.plan_aktion_id AS geplante_sap_aktion_id,
  CASE
  WHEN V01.grund_sperrung IS NULL
  THEN 1
  ELSE 0
  END AS in_aktion_fg,
 V01.wrg_id,
 CAST(V03.menge_lgbest_erp_frei_bme + V03.menge_lgbest_erp_qual_bme AS BIGNUMERIC) AS menge_aktion_bestand_bme,
 CAST(V03.menge_lgbest_erp_frei_bme AS BIGNUMERIC) AS menge_aktion_bestand_bme_frei
FROM kfl_production_dbp_view.v_aktion_art_wup_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_aktion_2 AS V02 ON V01.aktion_id = V02.aktion_id AND V01.mandant_id = V02.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_marktbestand_erp_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V02.dat_bis = V03.dat
       AND V01.art_id = V03.art_id AND V01.wup_id = V03.wup_id AND V01.nb_id = V03.nb_id
 INNER JOIN kfl_production_dbp_view.v_aktion_art_aktion_zu_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V02.aktion_id =
   V04.aktion_id
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id = V05.art_id AND V04
   .kl_art_id = V05.kl_art_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V06 ON TRUE
WHERE V01.mandant_id <> 1;