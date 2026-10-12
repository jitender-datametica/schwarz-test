CREATE OR REPLACE VIEW DBP_VIEW.V_ts_scm_wup_cluster_zu AS 
    SELECT 
        mandant_id,
        wup_id,
        wup_cluster_id,
        nb_id
FROM DBP_DATA.ts_scm_wup_cluster_zu ;