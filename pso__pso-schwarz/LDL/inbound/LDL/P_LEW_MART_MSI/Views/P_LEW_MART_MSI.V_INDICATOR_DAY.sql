CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_INDICATOR_DAY
AS
   /* 
   #DescStart# 
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 
   #SubjectAreas#: KPGES Views 
   #DescEnd# 
   */
   SELECT
     client_id,
   org_type_id,
   org_unit_nr,
   indicator_id,
   indicator_type_id,
   cy,
   dat_formdate,
   val_indicator,
   dat_dayend,
   load_id
   FROM p_lew_bil_ac.v_indicator_day;