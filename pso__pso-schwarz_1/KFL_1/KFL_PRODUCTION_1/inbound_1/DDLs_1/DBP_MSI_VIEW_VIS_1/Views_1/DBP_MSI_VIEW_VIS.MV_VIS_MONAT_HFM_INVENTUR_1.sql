create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	GJ,
	KJMO,
	OWG_ID,
	HWG_ID,
	ABT_ID,
	INVENTURART_INT_ID,
	ABT_INVART_ID,
	DAT_PLAN_ZAEHLUNG,
	DAT_VORLETZTE_ZAEHLUNG,
	ZEITRAUM,
	WRG_ID,
	INV_FG,
	INV_INV_FG,
	INVENTUR_WERT_NETTO,
	INVENTUR_UMS_NETTO,
	INVENTUR_DIEBSTAHL_ABSCHRIFT_NETTO,
	INVENTUR_PREIS_ABSCHRIFT_NETTO,
	INVENTUR_TOTAL_ABSCHRIFT_NETTO,
	INVENTUR_DIFF_KALK,
	INV_UMS_NETTO_OWG,
	INV_UMS_NETTO_HWG,
	INV_UMS_NETTO_ABT,
	INV_DIEBSTAHL_NETTO_OWG
) as 
 









 
SELECT
  hfm.mandant_id
, hfm.nb_id
, hfm.wup_id
, hfm.gj
, hfm.kjmo
, hfm.owg_id
, owg.hwg_id
, hwg.abt_id
, hfm.inventurart_int_id
, aia.abt_invart_id 
, hfm.dat_plan_zaehlung
, hfm.dat_vorletzte_zaehlung
, hfm.zeitraum
, hfm.wrg_id
, hfm.inv_fg
, hfm.inv_inv_fg
, hfm.inventur_wert_vk_netto AS inventur_wert_netto
, hfm.umsatz_vk_netto_sum    AS inventur_ums_netto
, hfm.betrag_netto_diebstahl_abschrift AS inventur_diebstahl_abschrift_netto
, hfm.betrag_netto_preis_abschrift     AS inventur_preis_abschrift_netto
, hfm.betrag_netto_total_abschrift     AS inventur_total_abschrift_netto
, hfm.betrag_kalk_inventur_diff        AS inventur_diff_kalk   
, hfm.ums_netto_owg AS inv_ums_netto_owg
, hfm.ums_netto_hwg AS inv_ums_netto_hwg
, hfm.ums_netto_abt AS inv_ums_netto_abt
, hfm.abs_netto_owg AS inv_diebstahl_netto_owg

FROM ( 
	SELECT
		inv.mandant_id
		, inv.nb_id
		, wup.aktuell_wup_id AS wup_id
		, inv.owg_id
		, inv.inventurart_int_id
		, inv.dat_plan_zaehlung
		, inv.dat_vorletzte_zaehlung
		, TO_NUMBER(inv.dat_plan_zaehlung - inv.dat_vorletzte_zaehlung,38,0) AS zeitraum
		, zeit.gj
		, zeit.kjmo
		, inv.wrg_id
		, inv.inv_inv_fg
		, 1::BYTEINT AS inv_fg
		, inv.inventur_wert_vk_netto
		, inv.umsatz_vk_netto_sum
		
		, inv.betrag_netto_diebstahl_abschrift
		, inv.betrag_netto_preis_abschrift
		, inv.betrag_netto_total_abschrift
		, inv.betrag_kalk_inventur_diff
		
		, SUM(vis_agg.ums_netto_owg) AS ums_netto_owg
		, SUM(vis_agg.ums_netto_hwg) AS ums_netto_hwg
		, SUM(vis_agg.ums_netto_abt) AS ums_netto_abt
		
		, SUM(vis_agg.abs_netto_owg) AS abs_netto_owg
	FROM ( 
		SELECT 
			inv0.mandant_id
			, inv0.nb_id
			, inv0.wup_id
			, inv0.owg_id
			, inv0.inventurart_int_id
			, inv0.dat_plan_zaehlung
			, inv0.dat_vorletzte_zaehlung
			, krs.nach_wrg_id AS wrg_id
			, inv0.inventur_wert_vk_netto * krs.umrechnungskurs AS inventur_wert_vk_netto
			, inv0.umsatz_vk_netto_sum    * krs.umrechnungskurs AS umsatz_vk_netto_sum
			, inv0.betrag_netto_diebstahl_abschrift * krs.umrechnungskurs AS betrag_netto_diebstahl_abschrift
			, inv0.betrag_netto_preis_abschrift     * krs.umrechnungskurs AS betrag_netto_preis_abschrift
			, inv0.betrag_netto_total_abschrift     * krs.umrechnungskurs AS betrag_netto_total_abschrift
			, inv0.betrag_kalk_inventur_diff        * krs.umrechnungskurs AS betrag_kalk_inventur_diff
			, MAX(CASE WHEN inv0.inventurart_int_id IN (4, 5) THEN dat_plan_zaehlung END)      OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.owg_id) AS dat_z_akt
			, MIN(CASE WHEN inv0.inventurart_int_id IN (4, 5) THEN dat_vorletzte_zaehlung END) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.owg_id) AS dat_z_vor
			, MAX(CASE WHEN inv0.inventurart_int_id IN (3)    THEN dat_plan_zaehlung END)      OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.owg_id) AS dat_wg_akt
			, MIN(CASE WHEN inv0.inventurart_int_id IN (3)    THEN dat_vorletzte_zaehlung END) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.owg_id) AS dat_wg_vor
			, CASE
				WHEN inventurart_int_id = 8 THEN -1                            
				WHEN dat_z_akt IS NULL AND dat_wg_akt IS NULL THEN 1           
				WHEN dat_plan_zaehlung = dat_z_akt THEN 1                      
				WHEN dat_plan_zaehlung BETWEEN dat_z_vor AND dat_z_akt THEN 0  
				WHEN inventurart_int_id = 3 THEN 1                             
				WHEN inventurart_int_id IN (1, 2) AND dat_plan_zaehlung BETWEEN dat_wg_vor AND dat_wg_akt THEN 0 
				ELSE 1  
			END::BYTEINT AS inv_inv_fg
		FROM dbp_view.v_hfm_inventur_termin_owg_wup_zu_1 inv0
 
		INNER JOIN ( 
			SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
			FROM dbp_data.kurs_1 krs1
			WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31'
			AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
			UNION ALL
			SELECT krs2.von_wrg_id, krs2.von_wrg_id AS nach_wrg_id, 1.00000 AS umrechnungskurs
			FROM dbp_data.kurs_1 krs2
			WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' 
			AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')
		) krs
		ON krs.von_wrg_id = inv0.wrg_id  
	) inv
 
	INNER JOIN dbp_view.v_tag_1 zeit_1
	ON zeit.dat = inv.dat_plan_zaehlung
 
	LEFT JOIN ( 
		SELECT
			vis00.mandant_id
			, vis00.nb_id
			, vis00.wup_id
			, vis00.wrg_id
			, vis00.dat
			, vis00.abt_id
			, vis00.hwg_id
			, vis00.owg_id
			, vis00.ums_netto  AS ums_netto_owg
			, vis00.abs_netto  AS abs_netto_owg
			, SUM(vis00.ums_netto) OVER (PARTITION BY vis00.mandant_id, vis00.wup_id, vis00.wrg_id, vis00.dat, vis00.hwg_id ORDER BY vis00.mandant_id, vis00.wup_id, vis00.wrg_id, vis00.dat, vis00.owg_id) AS ums_netto_hwg
			, SUM(vis00.ums_netto) OVER (PARTITION BY vis00.mandant_id, vis00.wup_id, vis00.wrg_id, vis00.dat, vis00.abt_id ORDER BY vis00.mandant_id, vis00.wup_id, vis00.wrg_id, vis00.dat, vis00.owg_id) AS ums_netto_abt
		FROM ( 
			SELECT
				vis_ums.mandant_id
				, vis_ums.nb_id
				, vis_ums.wup_id
				, vis_ums.wrg_id
				, vis_ums.dat
				, hwg.abt_id
				, owg.hwg_id
				, wg.owg_id
				, SUM(vis_ums.ums_netto)             AS ums_netto
				, SUM(vis_abs.abschrift_netto * -1)  AS abs_netto
			FROM dbp_msi_v_view.v_vis_tag_umsatz_wg_1  vis_ums 
			JOIN dbp_view.v_tag_1 zeit_1
			ON zeit.dat = vis_ums.dat AND zeit.akt_gj BETWEEN -2 AND 0
			INNER JOIN dbp_view.v_wg_per_1 wg
			ON wg.wg_id = vis_ums.wg_id AND wg.mandant_id = vis_ums.mandant_id
			AND wg.arthiertyp_id = 2 AND wg.dat_bis = '9999-12-31'
			INNER JOIN dbp_view.v_owg_per_1 owg
			ON owg.owg_id = wg.owg_id AND owg.mandant_id = wg.mandant_id
			AND owg.arthiertyp_id = 2 AND owg.dat_bis = '9999-12-31'
			INNER JOIN dbp_view.v_hwg_per_1 hwg
			ON hwg.hwg_id = owg.hwg_id AND hwg.mandant_id = owg.mandant_id
			AND hwg.arthiertyp_id = 2 AND hwg.dat_bis = '9999-12-31'
			LEFT JOIN dbp_msi_v_view.v_vis_tag_abschriften_wg_1 vis_abs 
			ON vis_abs.mandant_id = vis_ums.mandant_id AND vis_abs.wup_id = vis_ums.wup_id 
			AND vis_abs.wrg_id = vis_ums.wrg_id AND vis_abs.wg_id = vis_ums.wg_id
			AND vis_abs.dat = vis_ums.dat
			AND vis_abs.abschriftart_id IN (
				SELECT abschriftart_id FROM dbp_view.v_abschriftart_int_zu_1 WHERE abschriftart_int_id IN (190) 
			) 
			GROUP BY 
				vis_ums.mandant_id
				, vis_ums.nb_id
				, vis_ums.wup_id
				, vis_ums.wrg_id
				, vis_ums.dat
				, hwg.abt_id
				, owg.hwg_id
				, wg.owg_id
		) vis00
	) vis_agg
	ON vis_agg.mandant_id = inv.mandant_id AND vis_agg.wup_id = inv.wup_id AND vis_agg.wrg_id = inv.wrg_id
	AND vis_agg.owg_id = inv.owg_id AND vis_agg.dat BETWEEN inv.dat_vorletzte_zaehlung AND inv.dat_plan_zaehlung
	
	INNER JOIN dbp_view.v_wup_1 wup_1
   	ON inv.mandant_id = wup.mandant_id AND inv.wup_id = wup.wup_id

	GROUP BY 
		inv.mandant_id
		, inv.nb_id
		, wup.aktuell_wup_id
		, inv.owg_id
		, inv.inventurart_int_id
		, inv.dat_plan_zaehlung
		, inv.dat_vorletzte_zaehlung
		, zeitraum
		, zeit.gj
		, zeit.kjmo
		, inv.wrg_id
		, inv.inv_inv_fg
		, inv_fg
		, inv.inventur_wert_vk_netto
		, inv.umsatz_vk_netto_sum
		, inv.betrag_netto_diebstahl_abschrift
		, inv.betrag_netto_preis_abschrift
		, inv.betrag_netto_total_abschrift
		, inv.betrag_kalk_inventur_diff
) hfm
 
INNER JOIN dbp_view.v_owg_per_1 owg
ON owg.owg_id = hfm.owg_id AND owg.mandant_id = hfm.mandant_id
AND owg.arthiertyp_id = 2 AND owg.dat_bis = '9999-12-31'
 
INNER JOIN dbp_view.v_hwg_per_1 hwg
ON hwg.hwg_id = owg.hwg_id AND hwg.mandant_id = owg.mandant_id
AND hwg.arthiertyp_id = 2 AND hwg.dat_bis = '9999-12-31'
 
INNER JOIN dbp_msi_view_vis.mv_abt_inventurart_int_zu_1 aia
ON hwg.abt_id = aia.abt_id AND hfm.inventurart_int_id = aia.inventurart_int_id
;
