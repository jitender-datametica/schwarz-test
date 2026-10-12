CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_PRICEGRP_2 as
              /* 	
              #DescStart# 	
              #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
              #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 	
              #DescEnd# 	
              */	
              SELECT	
              t1.client_id,	
              t1.position_article_sales_rep,	
              t1.pricegroup_id,	
              t1.pricegroup_desc,	
              t1.article_sales_rep_desc,	
              t1.dat_valid_from,	
              t1.dat_valid_until,	
              t1.load_id	
	
              FROM p_lew_core_ac.v_wawi_ref_pricegrp_2 AS t1_2	
	
              WHERE CURRENT_DATE BETWEEN dat_valid_from AND dat_valid_until	
;