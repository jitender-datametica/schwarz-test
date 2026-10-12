CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_INDICATOR_TYPE_1 as
                       /* 	
                       #DescStart# 	
                       #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
                       #SubjectAreas#: KPGES Views 	
                       #DescEnd# 	
                       */	
                       SELECT	
                       indicator_type_id,	
                       indicator_type_desc,	
                       dat_dayend,	
                       load_id	
                       FROM p_lew_core_ac.v_wawi_ref_indicator_type_1;