CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_besch_rech_zekp
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DET.rech_beleg_id,
 DET.rech_beleg_pos_id,
 DET.gj,
 DET.kj,
 DET.art_id,
 7 AS system_id,
 ART_GP.gp_id,
 DET.mandant_id,
 DET.nb_id,
 DET.wup_id,
  CASE
  WHEN KOPF.rech_beleg_status_id = '5'
  THEN CAST(KOPF.dat_erfasst AS STRING)
  ELSE NULL
  END AS dat_buch,
 ROUND(CAST(TRUNC(CAST(DET.menge_rech / UMRECH.umrech_faktor AS BIGNUMERIC)) AS NUMERIC), 3) AS menge_rech,
 DET.betrag_beleg,
  DET.menge_rech * ART_GP_WUP.ek_brutto AS betrag_ek_brutto,
  DET.menge_rech * ART_GP_WUP.ek_netto AS betrag_ek_n,
  DET.menge_rech * ART_GP_WUP.ek_nettonetto AS betrag_ek_nn,
  DET.menge_rech * ART_GP_WUP.ek_mep AS betrag_ek_mep,
  DET.menge_rech * ART_GP_WUP.ek_netto_bnk AS betrag_ek_netto_bnk,
 DET.best_beleg_id,
 DET.best_beleg_pos_id,
 DET.lagerbew_beleg_id,
 DET.lagerbew_beleg_pos_id
FROM kfl_production_dbp_view.v_besch_rech_det AS DET
 INNER JOIN kfl_production_dbp_view.v_besch_rech AS KOPF ON DET.rech_beleg_id = KOPF.rech_beleg_id AND DET.mandant_id =
    KOPF.mandant_id AND DET.gj = KOPF.gj
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS ART_GP ON DET.art_id = ART_GP.art_id AND DET.mandant_id = ART_GP
    .mandant_id AND KOPF.dat_buch BETWEEN ART_GP.dat_von AND ART_GP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS ART_GP_WUP ON DET.art_id = ART_GP_WUP.art_id AND DET.mandant_id
       = ART_GP_WUP.mandant_id AND ART_GP.gp_id = ART_GP_WUP.gp_id AND DET.wup_id = ART_GP_WUP.wup_id AND KOPF.dat_buch
   BETWEEN ART_GP_WUP.dat_von AND ART_GP_WUP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS UMRECH ON DET.mandant_id = UMRECH.mandant_id AND DET
     .art_id = UMRECH.art_id AND DET.best_menge_einh_id = UMRECH.altnv_menge_einh_id AND KOPF.dat_buch BETWEEN UMRECH.dat_von
   AND UMRECH.dat_bis
WHERE DET.mandant_id = 1;