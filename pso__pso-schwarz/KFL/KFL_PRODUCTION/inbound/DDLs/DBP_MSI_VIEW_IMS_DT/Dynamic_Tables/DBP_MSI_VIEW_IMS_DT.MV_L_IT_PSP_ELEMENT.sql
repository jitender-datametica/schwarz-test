CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IT_PSP_ELEMENT
(
	MANDANT_ID,
	IT_PSP_ID,
	IT_PSP_ID_CHAR,
	PSP_BEZ,
	IT_PROJEKT_ID,
	IT_PROJEKT_DEF
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.04.2013 AL neu erstellt
-- 13.07.2016 twie SPEC0012030 Filter auf ims_projekt_typ_id
-- 08.04.2024 twie SPEC0241850 it_projekt_id zukünftig aus PSP Element ermitteln

   SELECT
   v02.mandant_id,
   v02.psp_id  AS it_psp_id,
   v02.psp_id_char AS it_psp_id_char,
   v02.psp_bez,
   --Bei IT Projekten ist PSP und Projekt gleich benannt
   v02.psp_id_char AS it_projekt_id,
   v01.in_projekt_id_char AS it_projekt_def

  FROM dbp_view.v_in_projekt v01
   INNER JOIN dbp_view.v_in_psp_element v02
   ON v01.in_projekt_id = v02.in_projekt_id AND
   v01.mandant_id = v02.mandant_id

   WHERE
   -- IT Projekte
   v01.ims_projekt_typ_id = 'P'  AND

   --Neue Projekte nur statistisch
   v02.statistisch_fg  = 1
;
