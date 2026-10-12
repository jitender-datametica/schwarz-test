CREATE OR REPLACE VIEW DBP_VIEW.V_ts_scm_l_art_cluster_2 AS 
    SELECT 
        mandant_id,
        art_cluster_id,
        art_cluster_bez,
        art_cluster_descr,
        art_cluster_del_fg,
        update_timestamp,
        update_user
FROM DBP_DATA.ts_scm_l_art_cluster_2 ;