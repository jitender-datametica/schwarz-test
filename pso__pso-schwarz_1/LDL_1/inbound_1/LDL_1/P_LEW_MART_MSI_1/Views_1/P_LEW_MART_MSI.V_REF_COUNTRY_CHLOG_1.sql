CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_COUNTRY_CHLOG_1 as
        /*	
        #DescStart#	
        #$Revision: 6244 $, $LastChangedBy: hwieber $	
        #SubjectAreas#: Organisationsstruktur	
        #DescEnd#	
        */	
        SELECT	
          country_id,	
        dashboard_relevant_fg,	
        requesting_user,	
        timestamp_request,	
        approval_fg,	
        approval_user,	
        timestamp_approval	
    FROM p_lew_core_ac.v_wawi_ref_country_chlog_1;