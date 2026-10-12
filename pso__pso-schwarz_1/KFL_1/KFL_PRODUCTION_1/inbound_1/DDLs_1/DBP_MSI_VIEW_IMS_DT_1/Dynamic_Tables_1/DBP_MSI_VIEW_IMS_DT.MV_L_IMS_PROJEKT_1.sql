CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IMS_PROJEKT_1
(
	MANDANT_ID,
	IN_PROJEKT_ID,
	IN_PROJEKT_ID_CHAR,
	PROJEKT_EXT_ID,
	IN_PROJEKT_BEZ,
	PROJEKT_TYP_ID,
	STANDORT_ID,
	IN_BUDGET_TYP_ID,
	DAT_MASSNAHME_ENDE
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 15.05.2013 AL Init
-- 28.05.2013 AL standort_id auf 4 Stellen angepasst
-- 20.06.2013 AL JOIN mit PSP Element anstatt subselect aufgrund Probleme bei Standort Ermittlung aufgrund Reihenfolge von
-- Tabellenjoins
-- 01.07.2013 twie: neues Feld dat_massnahme_ende
-- 03.07.2013 AL modifiziert und Dummy_1 Projekte aufgenommen
-- 31.07.2013 AL Dummy_1 Projekte in_projekt_id < 0 unabhängig von statistish_fg in in_psp_element_1 anzeigen
-- 08.07.2014 twie: Dummy_1 -1 bei budget_typ mitgeben
-- 03.12.2014 twie: krk_id DE02 in DE ausschließen
-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt_1 aufgenommen und direkt referenziert + projekt_typ_bez entfernt
-- 13.04.2016 twie: Filter statistisch_fg entfernt wegen Dummy_1 PSP
-- 08.05.2024 twie: SPEC0241850 bei IT Projekten die Bezeichung aus der PSP Tabelle holen

   SELECT
   v01. mandant_id,
   v01.in_projekt_id,
   CASE --bei IT Projekten die Bez. aus dem PSP Element holen
   WHEN (v01.ims_projekt_typ_id = 'P' AND v02.statistisch_fg = 1)
   THEN v02.psp_id_char
   ELSE v01.in_projekt_id_char
   END AS in_projekt_id_char,
   v01.projekt_ext_id, -- Verbindung zu RPM
   v01.in_projekt_bez,
   v01.ims_projekt_typ_id AS projekt_typ_id,
   v01.standort_id,
   COALESCE(v01.in_budget_typ_id, '-1') AS in_budget_typ_id,
   COALESCE(v01.dat_massnahme_ende, '2010') AS dat_massnahme_ende

  FROM dbp_view.v_in_projekt_1 v01
  
  LEFT JOIN
  (SELECT 
    in_projekt_id,
    mandant_id,
    MAX(statistisch_fg) AS statistisch_fg,
    MAX(psp_id_char) AS psp_id_char
    FROM dbp_view.v_in_psp_element_1
    GROUP BY
    in_projekt_id,
    mandant_id
   ) v02
   ON v01.in_projekt_id = v02.in_projekt_id AND 
   v01.mandant_id = v02.mandant_id 
   
   WHERE
   --KRK DE02 in DE ausschließen
   (v01.krk_id  IS NULL OR v01.krk_id <> 'DE02' OR v01.mandant_id <> 1)
;