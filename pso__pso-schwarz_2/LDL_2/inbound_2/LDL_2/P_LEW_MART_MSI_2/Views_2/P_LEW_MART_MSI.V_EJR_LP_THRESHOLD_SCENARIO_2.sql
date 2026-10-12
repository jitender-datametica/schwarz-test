CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_SCENARIO_2
/*	
#DescStart#	
#$Revision: 6244 $, $LastChangedBy: hwieber $	
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
#DescEnd#	
*/	
(	
client_id	
,threshold_group_id	
,threshold_group_desc	
,min_val_retail_ejr	
,max_val_retail_ejr	
)	
AS	
   SELECT	
   client_id,	
   threshold_group_id,	
   threshold_group_desc,	
   min_val_retail_ejr,	
   max_val_retail_ejr	
   FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_2	
	
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
   AND approval_fg = 1;