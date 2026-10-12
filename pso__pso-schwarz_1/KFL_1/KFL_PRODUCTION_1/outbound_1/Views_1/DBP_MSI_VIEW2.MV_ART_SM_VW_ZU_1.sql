CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_sm_vw_zu_1 (art_id, vw_id, sm_id, mandant_id) AS SELECT V01.art_id
 ,
 V01.vw_id,
 CAST(TRIM(V02.sap_sm_id) AS STRING) AS sm_id,
 V01.mandant_id
FROM kfl_production_dbp_view.v_art_sm_vw_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_sm_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.sm_id = V02.sm_id
 INNER JOIN (SELECT art_id,
   vw_id,
   mandant_id,
   MAX(dat_von) AS dat_von
  FROM kfl_production_dbp_view.v_art_sm_vw_zu_per_1 AS V03
  WHERE mandant_id = 1
  GROUP BY art_id,
   vw_id,
   mandant_id) AS t1_1 ON V01.art_id = t1.art_id AND V01.vw_id = t1.vw_id AND V01.mandant_id = t1.mandant_id AND V01.dat_von
    = t1.dat_von;