/* #DescStart# 
   #$Revision: 10790 $, $LastChangedBy: ekun $ 
   #SubjectAreas#: KPGES Views 
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_indicator_day_1 AS SELECT client_id,
 org_type_id,
 org_unit_nr,
 indicator_id,
 indicator_type_id,
 cy,
 dat_formdate,
 val_indicator,
 dat_dayend,
 load_id
FROM ldl_p_lew_bil_ac.v_kpi_day_1;