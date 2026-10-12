CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ASPECT_1 as
   /*	
   #DescStart#	
   #$Revision: 6244 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd#	
   */	
   SELECT	
     aspect_id,	
   aspect_desc	
  FROM p_lew_core_ac.v_wawi_ref_aspect_1;