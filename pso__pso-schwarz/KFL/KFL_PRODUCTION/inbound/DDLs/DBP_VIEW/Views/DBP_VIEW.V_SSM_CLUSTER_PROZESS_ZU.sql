CREATE OR REPLACE VIEW DBP_VIEW.V_SSM_CLUSTER_PROZESS_ZU AS 
    SELECT 
        mandant_id
        ,ssm_cluster_id
        ,ssm_prozess_id
        ,dat_von
        ,etagen_anz
        ,wup_bereich_id
        ,wup_abt_id
        ,dat_bis
        ,fixwert_mo
        ,fixwert_di
        ,fixwert_mi
        ,fixwert_do
        ,fixwert_fr
        ,fixwert_sa
        ,fixwert_so
        ,zeit_benchmark
        ,prognose_multiplikator
        ,anpassung_nettoleistung_up_fg
        ,anpassung_nettoleistung_down_fg
        ,start_variabel_typ
        ,start_variabel_wert
        ,ende_variabel_typ
        ,ende_variabel_wert
FROM DBP_DATA.SSM_CLUSTER_PROZESS_ZU ;