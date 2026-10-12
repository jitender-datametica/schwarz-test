CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_KW_DESC_1
/*	
#DescStart#	
#$Revision: 6244 $, $LastChangedBy: hwieber $	
#SubjectAreas#: Kalender 	
#DescEnd#	
*/	
(	
language_id	
, kw_name	
, kw_name_short	
)	
AS	
   SELECT	
   language_id,	
   kw_name,	
   kw_name_short	
  FROM p_lew_core_ac.v_wawi_cal_kw_desc_1;