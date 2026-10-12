CREATE OR REPLACE VIEW  DBP_MSI_VIEW_VIS.MV_VIS_MONAT_INVENTUR_ART_2(
  MANDANT_ID
 ,NB_ID
 ,WUP_ID
 ,GJ
 ,KJMO
 ,INVENTURART_INT_ID
 ,INVENTURART_VIS_ID
 ,ART_ID
 ,WG_ID
 ,OWG_ID
 ,HWG_ID
 ,ABT_ID
 ,DAT_PLAN_ZAEHLUNG
 ,DAT_VORLETZTE_ZAEHLUNG
 ,ZEITRAUM
 ,WRG_ID
 ,INV_WERT_NETTO
 ,INV_UMS_NETTO
 ,INV_JAHR_FG
 ,INV_ZWISCHEN_FG
) AS
 
 -- FAKT : Inventuren Filiale/Artikel_2 pro Monat_2
 -- Anreicherung Warenstruktur + Mapping auf Inventurart Reporting
 -- 2019.1118 ssch0611 : Initial (Inventuren pro Artikel_2) ohne Abschriften_2/Diebstahl
 -- 2019.1218 ssch0611 : Finetuning. Inventurart Reporting. Flags Jahres-/Zwischeninventur
 -- 2022-10-06 ssch0611 : Calculation EUR with new logic [P16167] 
 
SELECT
  sub01.mandant_id
, sub01.nb_id
, sub01.wup_id
, sub01.gj
, sub01.kjmo
, sub01.inventurart_int_id 
, iav.inventurart_vis_id   
, sub01.art_id
, wg.wg_id
, owg.owg_id
, hwg.hwg_id
, abt.abt_id
, sub01.dat_plan_zaehlung
, sub01.dat_vorletzte_zaehlung
, sub01.zeitraum
, sub01.wrg_id
, sub01.inv_wert_netto
, sub01.inv_ums_netto
, sub01.inv_jahr_fg
, sub01.inv_zwischen_fg
FROM ( 
	SELECT
	  inv.mandant_id
	, inv.nb_id
	, inv.wup_id
	, inv.art_id
	, inv.inventurart_int_id
	, inv.dat_plan_zaehlung
	, inv.dat_vorletzte_zaehlung
	, TO_NUMBER(inv.dat_plan_zaehlung - inv.dat_vorletzte_zaehlung,38,0) AS zeitraum
	, zeit.gj
	, zeit.kjmo
	, inv.wrg_id
	, inv.inv_jahr_fg
	, inv.inv_zwischen_fg
	, SUM(inv.inventur_wert_vk_netto) AS inv_wert_netto
	, SUM(inv.umsatz_vk_netto_sum)    AS inv_ums_netto
	FROM ( 
		SELECT 
		  inv0.mandant_id
		, inv0.nb_id
		, inv0.wup_id
		, inv0.art_id
		, inv0.inventurart_int_vorletzte_zaehlung AS inventurart_int_id
		, inv0.dat_plan_zaehlung
		, inv0.dat_vorletzte_zaehlung
		, krs.nach_wrg_id AS wrg_id
		, inv0.inventur_wert_vk_netto * krs.umrechnungskurs AS inventur_wert_vk_netto
		, inv0.umsatz_vk_netto_sum * krs.umrechnungskurs    AS umsatz_vk_netto_sum
		/* Jahres-Inventur_2 */ 
		, MAX(CASE WHEN inventurart_int_id IN (5) THEN dat_plan_zaehlung END) 
			OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.art_id) AS INV_J_AKT
		, MAX(CASE WHEN inventurart_int_id IN (5) THEN dat_vorletzte_zaehlung END) 
			OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.art_id) AS INV_J_VOR
		, CASE
			WHEN dat_plan_zaehlung < INV_J_VOR THEN -3 -- HISTORISCH 
			WHEN dat_plan_zaehlung = INV_J_VOR THEN -1 -- LETZTE 
			WHEN dat_plan_zaehlung < INV_J_AKT THEN -2 -- vorherige (sollte nicht vorkommen)  
			WHEN dat_plan_zaehlung = INV_J_AKT THEN  0 -- AKTUELLE Jahres-Inventur_2
			ELSE 1                                     -- NACH AKTUELLER 
		  END::BYTEINT AS inv_jahr_fg
		/* Zwischen-Inventur_2 */ 
		, MAX(CASE WHEN inventurart_int_id IN (4) THEN dat_plan_zaehlung END) 
			OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.art_id) AS INV_Z_AKT
		, MAX(CASE WHEN inventurart_int_id IN (4) THEN dat_vorletzte_zaehlung END) 
			OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.art_id) AS INV_Z_VOR
		, CASE
			WHEN dat_plan_zaehlung < INV_Z_VOR THEN -3 -- HISTORISCHE 
			WHEN dat_plan_zaehlung = INV_Z_VOR THEN -1 -- LETZTE 
			WHEN dat_plan_zaehlung < INV_Z_AKT THEN -2 -- vorherige (sollte nicht vorkommen)
			WHEN dat_plan_zaehlung = INV_Z_AKT THEN  0 -- AKTUELLE Zwischen-Inventur_2 
			ELSE 1                                     -- NACH AKTUELLER 
		  END::BYTEINT AS inv_zwischen_fg
		FROM dbp_view.v_inventur_termin_art_wup_zu_per_2 inv0
		
		INNER JOIN ( 
			SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
			FROM dbp_data.kurs_2 krs1 
			WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
			AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
			UNION ALL 
			SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
			FROM dbp_data.kurs_2 krs2 
			WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
			AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
		) krs
		ON krs.von_wrg_id = inv0.wrg_id
	) inv
	
	JOIN dbp_view.v_tag_2 zeit_2
	ON zeit.dat = inv.dat_plan_zaehlung
	
	GROUP BY 
	  inv.mandant_id
	, inv.nb_id
	, inv.wup_id
	, inv.art_id
	, inv.inventurart_int_id
	, inv.dat_plan_zaehlung
	, inv.dat_vorletzte_zaehlung
	, zeit.gj
	, zeit.kjmo
	, inv.wrg_id
	, inv.inv_jahr_fg
	, inv.inv_zwischen_fg
) sub01
 
JOIN dbp_view.v_art_wg_zu_per_2 art_2
ON art.art_id = sub01.art_id
AND art.mandant_id = sub01.mandant_id
AND art.arthiertyp_id = 2 AND art.dat_bis = '9999-12-31'
 
JOIN dbp_view.v_wg_per_2 wg
ON wg.wg_id = art.wg_id
AND wg.mandant_id = art.mandant_id
AND wg.arthiertyp_id = 2 AND wg.dat_bis = '9999-12-31'
 
JOIN dbp_view.v_owg_per_2 owg
ON owg.owg_id = wg.owg_id
AND owg.mandant_id = wg.mandant_id
AND owg.arthiertyp_id = 2 AND owg.dat_bis = '9999-12-31'
 
JOIN dbp_view.v_hwg_per_2 hwg
ON hwg.hwg_id = owg.hwg_id
AND hwg.mandant_id = owg.mandant_id
AND hwg.arthiertyp_id = 2 AND hwg.dat_bis = '9999-12-31'
 
JOIN dbp_view.v_abt_per_2 abt_2
ON abt.abt_id = hwg.abt_id
AND abt.mandant_id = hwg.mandant_id
AND abt.arthiertyp_id = 2 AND abt.dat_bis = '9999-12-31'
 
LEFT JOIN dbp_msi_view_vis.mv_inventurart_int_vis_zu_2 iav
ON abt.abt_id = iav.abt_id
AND sub01.inventurart_int_id = iav.inventurart_int_id;