CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_AUFTRAG_2
(
	MANDANT_ID,
	AUFTRAG_ID,
	AUFTRAGSART_ID,
	TECHN_PLATZ_ID,
	CS_AUFTRAG_PRIO
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 10.06.2013 AL init
-- 17.05.2022 prescherad SPEC0150439 erweiterung um Auftragsprio aus View V_IN_INSTANDHALTUNG_OBJEKT_QUAL_2
    SELECT
   	auftr.mandant_id,
   	auftr.auftrag_id,
   	auftr.auftragsart_id,
   	COALESCE(auftr.techn_platz_id , '')   AS techn_platz_id,
    CASE
        WHEN AUFTRAGSART_ID ='4IHA' THEN obj.CS_AUFTRAG_PRIO
        ELSE NULL
    END AS CS_AUFTRAG_PRIO    
   FROM dbp_view.v_in_auftrag_2 auftr
   LEFT JOIN dbp_view.V_IN_INSTANDHALTUNG_OBJEKT_QUAL_2 Obj
   ON auftr.auftrag_id = obj.auftrag_id 
   AND auftr.mandant_id=obj.mandant_id
;