CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_STORE_CONTACT as
        /*	
        #DescStart#	
        #$Revision: 7431 $, $LastChangedBy: smustafa $	
        #SubjectAreas#: Organisationsstruktur	
        #DescEnd#	
        */	
        SELECT	
         client_id,	
        store_id,	
        zipcode,	
        city,	
        street,	
        postbox,	
        phone,	
        fax,	
        zipcode_postbox,	
        modem	
        FROM p_lew_mart_msi.t_org_store_contact  lcnt;