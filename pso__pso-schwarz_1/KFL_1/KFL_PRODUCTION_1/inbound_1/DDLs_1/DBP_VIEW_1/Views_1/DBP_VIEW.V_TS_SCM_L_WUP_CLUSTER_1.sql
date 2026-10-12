CREATE OR REPLACE VIEW DBP_VIEW.V_ts_scm_l_wup_cluster_1 AS 
    SELECT 
        mandant_id,
        wup_cluster_id,
        wup_cluster_bez,
        wup_cluster_descr,
        wup_cluster_del_fg,
        update_timestamp,
        update_user
FROM DBP_DATA.ts_scm_l_wup_cluster_1 ;