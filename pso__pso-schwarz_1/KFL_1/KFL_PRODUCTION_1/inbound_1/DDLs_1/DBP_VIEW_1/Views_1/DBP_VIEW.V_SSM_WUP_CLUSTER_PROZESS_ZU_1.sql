CREATE OR REPLACE VIEW DBP_VIEW.V_SSM_WUP_CLUSTER_PROZESS_ZU_1 AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,ssm_cluster_id
        ,ssm_prozess_id
        ,dat_von
        ,dat_bis
        ,wup_bereich_id
        ,wup_abt_id
FROM DBP_DATA.SSM_WUP_CLUSTER_PROZESS_ZU_1 ;