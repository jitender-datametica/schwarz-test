CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_SCENARIO as
        /* 	
        #DescStart# 	
        #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
        #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 	
        #DescEnd# 	
        */	
        SELECT scenario_id	
        FROM p_lew_mart_msi.t_msi_ejr_lp_rel_scenario_to_group	
        GROUP BY scenario_id;