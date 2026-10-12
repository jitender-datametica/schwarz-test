/* #DescStart# 	
      #$Revision: 10788 $, $LastChangedBy: ekun $ 	
      #SubjectAreas#: KPGES Views 	
      #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_indicator_month_2 AS SELECT client_id,
 org_type_id,
 org_unit_nr,
 indicator_id,
 indicator_type_id,
 cy,
 month_id,
 val_indicator,
 dat_dayend,
 load_id
FROM ldl_p_lew_bil_ac.v_kpi_month_2;