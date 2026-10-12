CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_werbekat_spr_zu (werbe_kat_id, mandant_id, sap_werbe_kat_id,
spr_id, werbe_kat_bez, sap_werbe_kat_bez) AS SELECT V01.werbe_kat_id,
 V01.mandant_id,
 V01.sap_werbe_kat_id,
 V02.spr_id,
 V02.werbe_kat_bez,
   CAST(V01.sap_werbe_kat_id AS STRING) || '   ' || V02.werbe_kat_bez AS sap_werbe_kat_bez
FROM kfl_production_dbp_view.v_l_werbekat AS V01
 INNER JOIN kfl_production_dbp_view.v_werbekat_spr_zu AS V02 ON V01.werbe_kat_id = V02.werbe_kat_id AND V01.mandant_id =
   V02.mandant_id
WHERE V01.mandant_id = 1
 AND V02.spr_id = 22;