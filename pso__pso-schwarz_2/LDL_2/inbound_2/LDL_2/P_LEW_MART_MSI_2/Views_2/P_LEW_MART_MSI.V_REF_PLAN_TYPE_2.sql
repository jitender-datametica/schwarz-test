CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_PLAN_TYPE_2 as
          /* 	
          #DescStart# 	
          #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
          #SubjectAreas#: Planungswerte 	
          #DescEnd# 	
          */	
	
          SELECT	
          rpt.plantype_id,	
          rpt.plantype_desc,	
          rpt.dat_dayend	
           FROM p_lew_core_ac.v_wawi_ref_plan_type_2 rpt;