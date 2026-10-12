CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_ARTBEW_2
-- AP0030398, SPEC0039495 srom0404 04.07.2018 - Payback ins WWC
-- AP0032822, SPEC0041631 - 30.10.2108, mkub1811 Erweiterung um bezugsweg_id
(
WERKS
,mandant_id
,bewart_id
,nb_id
,dat
,art_id
,MENGE
,VK_netto
,umsatz_netto_sa
,vk_menge_sa
,pv_aktion_sa_loyalty
,pv_aktion_sa_loyalty_bby
,pv_aktion_sa_loyalty_kdn_bby
,pv_aktion_sa_loyalty_kdp_bby
,pv_aktion_sa_non_loyalty
,pv_aktion_sa_non_loyalty_bby
,pv_bby_loyalty
,pv_bby_non_loyalty
,pv_kdn_bby_loyalty
,pv_kdp_bby_loyalty
,pv_bonrabatt_bby_non_loyalty
,pv_bonrabatt_bby_loyalty
,pv_bonrabatt_bby
,wrg_id
,bezugsweg_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
  --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
  --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
  --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
  --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
  --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
  --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
  --20.03.2025, SPEC0301381, prescherad: Erweitrung um SA und PV
   SELECT v01.wup_id AS WERKS, 
   v01.mandant_id, 
   v01.bewart_id, v01.nb_id, 
   v01.dat, v01.art_id, 
   v01.menge AS MENGE,
   v01.umsatz_netto AS VK_netto,
   CASE   
	WHEN v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_sa,
   CASE
    WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa, 
   CASE
	WHEN v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion AS NUMBER(38,5)) END pv_aktion_sa_loyalty,
   CASE
	WHEN v01.bewart_det_id IN (100221, 100211)  THEN CAST(v01.pv_aktion_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_bby,
   CASE
	WHEN v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_kdn_bby,
   CASE
	WHEN v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_kdp_bby,
   CASE
	WHEN v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion AS NUMBER(38,5)) END pv_aktion_sa_non_loyalty,
   CASE
	WHEN v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby AS NUMBER(38,5)) END pv_aktion_sa_non_loyalty_bby,
   CASE
	WHEN v01.bewart_det_id IN (100221, 100231, 100241) THEN CAST(v01.pv_bby AS NUMBER(38,5)) END pv_bby_loyalty,
   CASE
	WHEN v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby AS NUMBER(38,5)) END pv_bby_non_loyalty,
   CASE
	WHEN v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby AS NUMBER(38,5)) END pv_kdn_bby_loyalty,
   CASE
	WHEN v01.bewart_det_id = 100241 THEN CAST(v01.pv_kdp_bby AS NUMBER(38,5)) END pv_kdp_bby_loyalty,
   CASE
	WHEN v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby AS NUMBER(38,5)) 
	ELSE CAST(0 AS NUMBER(38,5))  END pv_bonrabatt_bby_non_loyalty,
   CASE
	WHEN v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby AS NUMBER(38,5)) 
	ELSE CAST(0 AS NUMBER(38,5)) END pv_bonrabatt_bby_loyalty,		 
   pv_bonrabatt_bby_non_loyalty + pv_bonrabatt_bby_loyalty AS pv_bonrabatt_bby, 
   v02.default_wrg AS wrg_id, 
   v01.bezugsweg_id
   FROM dbp_view.v_artbew_2 v01
   JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id
    --Suhsi RO ausfiltern
   INNER JOIN DBP_VIEW.V_art_wg_zu_per_2 V03
   ON v01.Art_ID=v03.art_id
   AND v01.mandant_id = v03.mandant_id
   -- Wenn nicht Mandant_2 1,7 dann alles   
   AND (v03.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant_2 1,7 dann  kein Sushi/Shop in Shop 
      OR (V03.MANDANT_ID IN (1,7) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(V03.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_2 7 dann alles   
   AND (v03.MANDANT_ID != 7
   -- Wenn  Mandant_2 7 dann kein Pfand 
      OR v03.MANDANT_ID = 7 AND TO_VARCHAR(v03.wg_id,'FM000') !='980')
   --Ausfiltern Shop in Shop
   AND V03.wg_id!=961
     --Ausfiltern E-Loading alle Mandaten ungleich 1
   AND (v03.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     -- wenn  Mandant_2 ungleich 1 dann ohne E-loading 
      OR (v03.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
   )      
   AND V03.arthiertyp_id = 2
   AND V03.dat_bis = '9999-12-31';