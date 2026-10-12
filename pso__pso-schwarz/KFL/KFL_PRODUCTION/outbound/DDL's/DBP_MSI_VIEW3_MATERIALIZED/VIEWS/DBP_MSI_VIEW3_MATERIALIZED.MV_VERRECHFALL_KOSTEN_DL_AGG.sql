-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_verrechfall_kosten_dl_agg (USERID STRING) AS SELECT V01.mandant_id
 ,
 V01.wrg_id,
 V01.wrg_typ_id,
 V01.verrechfall_id,
 V01.verrechfall_kostenart_id,
 MAX(V01.betrag_kosten_erster) AS betrag_kosten_erster,
 MAX(V01.betrag_kosten_letzter) AS betrag_kosten_letzter
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_verrechfall_kosten_dl_agg AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS V05 ON V01.wrg_typ_id = V05.wrg_typ_id
  
GROUP BY V01.mandant_id,
 V01.wrg_id,
 V01.wrg_typ_id,
 V01.verrechfall_id,
 V01.verrechfall_kostenart_id;
