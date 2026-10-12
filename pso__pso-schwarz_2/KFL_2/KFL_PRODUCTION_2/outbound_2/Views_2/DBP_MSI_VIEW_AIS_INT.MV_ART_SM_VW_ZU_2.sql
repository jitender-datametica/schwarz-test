CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_art_sm_vw_zu_2 (art_id, vw_id, sm_id, ksm_id, mandant_id) AS
SELECT V01.art_id,
 V01.vw_id,
 CAST(TRIM(V02.sap_sm_id) AS STRING) AS sm_id,
 CAST(TRIM(CASE
    WHEN V01.mandant_id = 1
    THEN V02.sap_sm_id
    ELSE CAST(V01.ksm_id AS STRING)
    END) AS STRING) AS k_sm_id,
 V01.mandant_id
FROM kfl_production_dbp_view.v_art_sm_vw_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_sm_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.sm_id = V02.sm_id
 INNER JOIN (SELECT art_id,
   vw_id,
   mandant_id,
   MAX(dat_von) AS dat_von
  FROM kfl_production_dbp_view.v_art_sm_vw_zu_per_2 AS V03
  GROUP BY art_id,
   vw_id,
   mandant_id) AS t1_2 ON V01.art_id = t1.art_id AND V01.vw_id = t1.vw_id AND V01.mandant_id = t1.mandant_id AND V01.dat_von
    = t1.dat_von
WHERE V02.spr_id = 22;