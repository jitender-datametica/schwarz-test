CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_COUNTRY_ACT_BO as
      /*	
      #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Organisationsstruktur	
      #DescEnd#	
      */	
      SELECT	
        int_id,	
      country_id -- Buchungskreis / Nummer des Landes	
      ,	
      country_iso_cd -- Landeskürzel	
      ,	
      cluster_id -- SAP - Cluster Nummer	
      ,	
      sorting_order  -- Sortierungsreihenfolge	
      ,	
      country_desc -- Landesname 	
      ,	
      language_id  -- Nummer zur Referenzierung de Sprache	
      ,	
      dashboard_relevant_fg -- Relevant für das Lead - Dashboard	
     FROM p_lew_core_ac.v_wawi_ref_country_act;