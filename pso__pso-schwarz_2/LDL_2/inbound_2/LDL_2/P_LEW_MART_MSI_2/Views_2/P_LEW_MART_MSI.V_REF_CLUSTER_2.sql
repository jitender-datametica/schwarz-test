CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CLUSTER_2	
/*
#Subject Areas:# Cluster	
#DescEnd# */	
(	
    cluster_id       -- Cluster Nummer                                                                                                                   	
    , cluster_desc       -- Cluster Beschreibung                                                                                                               	
    , sorting_order           -- Sortierungsreihenfolge                                                                                                          	
)	
AS	
   SELECT	
       v.cluster_id,	
   v.cluster_desc,	
   v.sorting_order	
   FROM p_lew_core_ac.v_wawi_ref_cluster_2 AS v;