CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_INDICATOR_MONTH as
      /* 	
      #DescStart# 	
      #$Revision: 10788 $, $LastChangedBy: ekun $ 	
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
      month_id,	
      val_indicator,	
      dat_dayend,	
      load_id	
      FROM p_lew_bil_ac.v_kpi_month	
	
	
;