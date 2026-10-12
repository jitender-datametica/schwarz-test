CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_COUNTRY_DESC_BO_2 as
       /*	
       #DescStart#	
       #$Revision: 6244 $, $LastChangedBy: hwieber $	
       #SubjectAreas#: Organisationsstruktur	
       #DescEnd#	
       */	
       SELECT	
         a.country_id -- Buchungsnummer / Nummer des Landes	
       ,	
       a.language_id -- Nummer zur Referenzierung der Sprache	
       ,	
       a.country_desc -- Name des Landes in verschiedenen Sprachen	
   FROM p_lew_core_ac.v_wawi_ref_country_desc_2 a;