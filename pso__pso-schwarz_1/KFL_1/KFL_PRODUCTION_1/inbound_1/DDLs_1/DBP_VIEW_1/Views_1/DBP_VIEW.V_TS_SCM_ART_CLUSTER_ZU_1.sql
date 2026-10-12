CREATE OR REPLACE VIEW DBP_VIEW.V_ts_scm_art_cluster_zu_1 AS 
    SELECT 
        mandant_id,
        art_cluster_id,
        art_id
FROM DBP_DATA.ts_scm_art_cluster_zu_1 ;