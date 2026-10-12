CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTIKEL_VKPREIS_2
(
   ART_ID,
	MANDANT_ID,
	UMRECHNUNGSKURS,
	_VKPK1,
	_VKPK2,
	_VKPK3,
	_VKPK4,
	_VKPK5,
	_VKPK6,
	_VKPK7,
	_VKPK8,
	_VKPK9,
	_VKPK10,
	MWST
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
   AS 
    SELECT
   v01.art_id,
   v01.mandant_id,
   v300.umrechnungskurs, 
   _VKPK1,
   _VKPK2,
   _VKPK3,
   _VKPK4,
   _VKPK5,
   _VKPK6,
   _VKPK7,
   _VKPK8,
   _VKPK9,
   _VKPK10,
   mwst

   FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN
   (
   SELECT
   art_id,
   mandant_id,
   MAX(CASE  WHEN  pm_id = 1 THEN vk_brutto END)  AS _VKPK1,
   MAX(CASE  WHEN  pm_id = 2 THEN vk_brutto END)  AS _VKPK2,
   MAX(CASE  WHEN  pm_id = 3 THEN vk_brutto END)  AS _VKPK3,
   MAX(CASE  WHEN  pm_id = 4 THEN vk_brutto END)  AS _VKPK4,
   MAX(CASE  WHEN  pm_id = 5 THEN vk_brutto END)  AS _VKPK5,
   MAX(CASE  WHEN  pm_id = 6 THEN vk_brutto END)  AS _VKPK6,
   MAX(CASE  WHEN  pm_id = 7 THEN vk_brutto END)  AS _VKPK7,
   MAX(CASE  WHEN  pm_id = 8 THEN vk_brutto END)  AS _VKPK8,
   MAX(CASE  WHEN  pm_id = 9 THEN vk_brutto END)  AS _VKPK9,
   MAX(CASE  WHEN  pm_id =10 THEN vk_brutto END)  AS _VKPK10

   FROM dbp_view.v_art_pm_vw_zu_per_2
   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND mandant_id <> 1
   AND preistyp_id = 0
   GROUP BY art_id, mandant_id
   ) v02
   ON v01.mandant_id = v02.mandant_id AND
   v01.art_id = v02.art_id
   LEFT OUTER JOIN dbp_view.v_mwst_per_2 v03
   ON v03.dat_bis ='9999-12-31' AND
   v01.mwst_id=v03.mwst_id AND
   v01.mandant_id = v03.mandant_id

   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id

/*-- Umrechnung Aktuell Standardkurs, Tageskurs
   JOIN
   dbp_view.v_kurs_2 v300
   ON CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/
 
      -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'
   
   WHERE v01.mandant_id <> 1;