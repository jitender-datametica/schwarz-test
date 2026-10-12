CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_PSP_ELEMENT_1
(
	MANDANT_ID,
	PSP_ID,
	PSP_ID_CHAR,
	PSP_BEZ,
	IN_PROJEKT_ID,
	IN_PROJEKT_ID_CHAR,
	PROJEKT_TYP_ID,
	IN_MASSNAHME_TYP_ID,
	BUCHUNGSKREIS_ID,
	DAT_ERFASST,
	PLAN_AKTIVIERUNGS_QUOTE,
	GEWERK_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 15.05.2013 AL neu erstellt
-- 31.05.2013 twie: Buchungskreis hinzugefügt
-- 14.06.2013 twie: dat_erfasst hinzugefügt
-- 19.07.2013 AL: Maßnahmentyp 17 Anschaffungen
-- 03.12.2014 twie: krk_id DE02 in DE ausschließen
-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt_1 aufgenommen und direkt referenziert + projekt_typ_bez entfernt
-- 08.04.2016 twie: AP0001938 Quote jetzt auf PSP Ebene, nicht mehr Projekt/Jahr, sowie neu Gewerk
-- 03.05.2016 twie: krk_id NULL zulassen wegen Dummy_1 PSPs

   SELECT
   v02.mandant_id,
   v02.psp_id,
   v02.psp_id_char,
   v02.psp_bez,
   v02.in_projekt_id,
   v01.in_projekt_id_char,
   v01.ims_projekt_typ_id AS projekt_typ_id,
   CASE
  -- Feste Maßnahmentyp für Anschaffungen
  WHEN v01.ims_projekt_typ_id = 'A' THEN '17'
  -- Reparaturen I-PSP
  WHEN  v01.ims_projekt_typ_id = 'I' AND psp_id > 0 THEN '16'
  WHEN  v01.ims_projekt_typ_id = 'I' AND psp_id < 0 THEN '15'
  ELSE COALESCE (in_massnahme_typ_id           , '-1')
  END AS in_massnahme_typ_id,
   COALESCE(v02.buchungskreis_id, -1) AS buchungskreis_id,
   COALESCE(v02.dat_erfasst, TO_DATE('1900-01-01','YYYY-MM_1-DD')) AS dat_erfasst,
   COALESCE(v02.plan_aktivierungs_quote,1) AS plan_aktivierungs_quote,
   COALESCE(v02.gewerk_id, -1) AS gewerk_id

   FROM  dbp_view.v_in_projekt_1 v01
   INNER JOIN  dbp_view.v_in_psp_element_1 v02
   ON v01.in_projekt_id = v02.in_projekt_id
   AND v01.mandant_id = v02.mandant_id

   WHERE
   --Neue Projekte nur statistisch
   --v02.statistisch_fg  = 1 AND  --entfernt wegen Dummy_1 PSP
   --KRK DE02 in DE ausschließen
   (v02.krk_id IS NULL OR v02.krk_id <> 'DE02' OR v02.mandant_id <> 1)
;