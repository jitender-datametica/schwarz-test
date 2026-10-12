CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_PLAN_PLANHEADER_2 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Planungswerte 	
   #DescEnd# 	
   */	
	
   SELECT	
   pp.client_id,	
   pp.plan_id,	
   pp.plan_nr,	
   pp.dat_plan,	
   pp.dat_busyear_from,	
   pp.dat_busyear_until,	
   pp.plantype_id,	
   pp.plan_version,	
   pp.plan_titel,	
   pp.plan_desc,	
   pp.dat_dayend	
    FROM p_lew_core_ac.v_wawi_plan_planheader_2 pp;