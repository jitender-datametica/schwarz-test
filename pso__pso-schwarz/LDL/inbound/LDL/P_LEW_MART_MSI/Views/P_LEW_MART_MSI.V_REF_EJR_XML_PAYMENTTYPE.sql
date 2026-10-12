CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_EJR_XML_PAYMENTTYPE as
         /* 	
         #DescStart# 	
         #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
         #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 	
         #DescEnd# 	
         */	
         SELECT	
         paymenttype_id,	
         comment_string	
         FROM p_lew_core_ac.v_wawi_ref_ejr_xml_paymenttypes	
;