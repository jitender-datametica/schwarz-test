CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_COUNTRY_GROUP_1 as
      /*	
      #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Organisationsstruktur	
      #DescEnd#	
      */	
      SELECT	
        country_group_id -- techn. DWH - Schlüssel für die Nummer der Vorstandsregion	
      ,	
      country_group_desc -- Name und Bezeichnung der Vorstandsregion	
      ,	
      1 AS int_id	
     FROM p_lew_core_ac.v_wawi_ref_country_group_1;