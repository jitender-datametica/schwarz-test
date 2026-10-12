CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_SCM_CLUSTER_2 AS 
    SELECT 
        cluster_id
        ,cluster_bez   
		,cluster_typ_id
		,cluster_typ_bez
        ,cluster_element_id
        ,cluster_element_bez
        ,zeit_von
        ,zeit_bis
        ,wert_von
        ,wert_bis


FROM DBP_MSI_DATA.TS_SCM_CLUSTER_2 ;