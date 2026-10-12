CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_BUYING_REGION_1	
  /*
  #DescStart#	
  #$Revision: 6244 $, $LastChangedBy: hwieber $	
  #SubjectAreas#: Organisationsstruktur	
  #DescEnd#	
  */	
  /* 	
  Diese Tabelle zeigt, welche Länder zu welchem Vorstand zugeordnet sind. 	
  */	
	
  (	
   client_id  -- techn. Schlüssel zur Referenz des Landes	
  ,buying_region  -- Einkaufsregion	
  ,region_sequence -- Jeder Einkaufsregion ist ein Schlüssel zugewiesen	
  )	
  AS	
     SELECT	
      client_id,	
     buying_region,	
     MIN(region_sequence) AS region_sequence	
     FROM p_lew_core_ac.v_wawi_org_wh_buying_region_1	
     GROUP BY	
      client_id	
     ,buying_region;