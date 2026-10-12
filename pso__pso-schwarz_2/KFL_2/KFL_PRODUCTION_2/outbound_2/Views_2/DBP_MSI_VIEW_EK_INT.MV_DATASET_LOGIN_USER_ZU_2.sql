CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_dataset_login_user_zu_2 (mandant_id, datasetuser_id,
loginuser_id) AS SELECT DISTINCT ART.mandant_id,
 ART.user_id AS datasetuser_id,
 US.user_id AS loginuser_id
FROM kfl_production_dbp_msi_view_ek_int.mv_art_user_zu_2 AS ART_2
 INNER JOIN kfl_production_dbp_msi_view_ek_int.mv_user_rolle_ek_int_zu_2 AS US ON ART.mandant_id = US.mandant_id AND ART.user_id
    = CASE
    WHEN US.rolle_id = 4
    THEN 'Superuser'
    ELSE CAST(US.user_id AS STRING)
    END;