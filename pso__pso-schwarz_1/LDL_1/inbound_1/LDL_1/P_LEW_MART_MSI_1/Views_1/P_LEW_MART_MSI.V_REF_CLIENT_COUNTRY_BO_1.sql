CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CLIENT_COUNTRY_BO_1	
     /*
     #DescStart#	
     #$Revision: 6244 $, $LastChangedBy: hwieber $	
     #SubjectAreas#: Organisationsstruktur	
     #DescEnd#	
     */	
     (	
        client_id	
      , country_id	
      )	
     AS	
        SELECT	
         v.client_id,	
        v.country_id	
        FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS v;