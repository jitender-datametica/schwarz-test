CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_BUSYEAR as
   /*	
   #DescStart#	
   #$Revision: 7108 $, $LastChangedBy: pmittler $	
   #SubjectAreas#: Kalender	
   #DescEnd#	
   */	
	
   SELECT	
   busyear AS byr,	
   cy_by_seq as cy_by_sequence	
   FROM p_lew_core_ac.v_cal_busyear	
;