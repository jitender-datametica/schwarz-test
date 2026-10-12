CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_CLIENT_SKEY_2	
     /*
     #DescStart#	
     #$Revision: 6244 $, $LastChangedBy: hwieber $	
     #SubjectAreas#: Organisationsstruktur	
     #DescEnd#	
     */	
     (	
       client_id   -- techn. Schlüssel zur Referenzierung des Landes. Jedes Land_2 hat genau eine_2 client_id.                                                                                                                        	
     , country_group_id    -- techn. DWH- SChlüssel zur Referenzierung der Vorstandsregion                                                                                                               	
     )	
     AS	
        SELECT	
          v.client_id,	
        v.country_group_id	
 FROM p_lew_core_ac.v_wawi_org_client_skey_2 AS v;