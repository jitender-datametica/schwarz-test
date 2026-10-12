CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_INDICATOR as
                    /* 	
                    #DescStart# 	
                    #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
                    #SubjectAreas#: KPGES Views 	
                    #DescEnd# 	
                    */	
                    SELECT	
                    indicator_id,	
                    indicator_desc,	
                    indicator_valuetype,	
                    dat_dayend,	
                    load_id	
                    FROM p_lew_core_ac.v_wawi_ref_indicator;