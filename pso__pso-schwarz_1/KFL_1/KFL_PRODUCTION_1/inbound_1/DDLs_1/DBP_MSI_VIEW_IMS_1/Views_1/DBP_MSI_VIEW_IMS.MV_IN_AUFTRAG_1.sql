 CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_AUFTRAG_1 AS
-- 10.06.2013 AL init
-- 17.05.2022 prescherad SPEC0150439 erweiterung um Auftragsprio aus View V_IN_INSTANDHALTUNG_OBJEKT_QUAL_1
   
   SELECT
   auftr.mandant_id,
   auftr.auftrag_id,
   auftr.auftragsart_id,
   COALESCE(auftr.techn_platz_id , '')   AS techn_platz_id,
   CASE
        WHEN AUFTRAGSART_ID ='4IHA' THEN obj.CS_AUFTRAG_PRIO
        ELSE NULL
   END AS CS_AUFTRAG_PRIO    
   FROM dbp_view.v_in_auftrag_1 auftr
   LEFT JOIN dbp_view.V_IN_INSTANDHALTUNG_OBJEKT_QUAL_1 Obj
   ON auftr.auftrag_id = obj.auftrag_id 
   AND auftr.mandant_id=obj.mandant_id;