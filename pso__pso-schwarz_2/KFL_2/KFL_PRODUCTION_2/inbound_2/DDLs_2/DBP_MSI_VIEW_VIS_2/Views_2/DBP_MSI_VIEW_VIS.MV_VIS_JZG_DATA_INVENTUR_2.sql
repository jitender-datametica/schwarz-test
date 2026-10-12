CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_DATA_INVENTUR_2 (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	GJ,
	WRG_ID,
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	METRIK_VGJ1,
	METRIK_VGJ2,
	METRIK_VGJ,
	METRIK_PLAN_VGJ1,
	METRIK_PLAN_VGJ2,
	METRIK_PLAN_VGJ,
	METRIK_DELTA,
	METRIK_ABW,
	METRIK_PLAN_GJ1,
	METRIK_PLAN_GJ2,
	METRIK_PLAN_GJ,
	METRIK_EINGABE,
	METRIK_ANTEIL,
	METRIK_ZIEL1,
	METRIK_ZIEL2,
	METRIK_ZIEL3,
	METRIK_ZIEL
) AS 
 
/* FAKT DENORM - Jahreszielgespräch 
   JZG DATA INVENTUR_2: Inventur_2 Historie inkl. Eingabe
   2023-02-01 ssch0611 : Initial. AP0144461
*/
 
/* JZG 500 - Inventur_2 FILIALE */
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.gj, vis.wrg_id
, 50::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.inv_wert AS METRIK_VGJ1 
, vis.inv_ums  AS METRIK_VGJ2 
, METRIK_VGJ1 / NULLIFZERO(METRIK_VGJ2) AS METRIK_VGJ 
, NULL AS METRIK_PLAN_VGJ1 /* KEIN PLAN */
, NULL AS METRIK_PLAN_VGJ2
, NULL AS METRIK_PLAN_VGJ
, NULL AS METRIK_DELTA
, NULL AS METRIK_ABW
, NULL AS METRIK_PLAN_GJ1
, NULL AS METRIK_PLAN_GJ2
, NULL AS METRIK_PLAN_GJ
, jzg50.wert_eingabe AS METRIK_EINGABE /* Eingabe Inventur_2 Proz */
, NULL AS METRIK_ANTEIL
, METRIK_EINGABE AS METRIK_ZIEL1 /* ZIEL = Eingabe */
, 1.00 AS METRIK_ZIEL2 
, METRIK_ZIEL1 / NULLIFZERO(METRIK_ZIEL2) AS METRIK_ZIEL3 
, COALESCE(METRIK_ZIEL3, 0) AS METRIK_ZIEL    
FROM ( /* JZG Inventur_2 - Filiale */
    SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, (vis_inv.gj+1) AS gj, vis_inv.wrg_id
    , SUM(vis_inv.inventur_wert_netto) AS inv_wert
    , SUM(vis_inv.inventur_ums_netto)  AS inv_ums
    , inv_wert / NULLIFZERO(inv_ums)   AS inv_quote
    FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_2 vis_inv
    JOIN DBP_DATA.TAG_2 zeit_2
    ON zeit.dat = vis_inv.dat_plan_zaehlung 
    WHERE zeit.akt_gj = -1 AND vis_inv.nb_id = 0 AND vis_inv.inventurart_int_id IN (8)
    GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.gj, vis_inv.wrg_id
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 50 Inventur_2 */
ON jzg50.mandant_id = vis.mandant_id AND jzg50.wup_id = vis.wup_id
AND jzg50.wrg_id = vis.wrg_id AND jzg50.gj = vis.gj
AND jzg50.metrik_id = 50 AND jzg50.typ_id = 0 AND jzg50.level_id = 0 
 
UNION ALL 
/* JZG510 - Inventur_2 ABTEILUNG */
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.gj, vis.wrg_id
, 50::INTEGER AS METRIK_ID
, 1::INTEGER  AS TYP_ID
, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, vis.inv_wert AS METRIK_VGJ1 
, vis.inv_ums  AS METRIK_VGJ2 
, METRIK_VGJ1 / NULLIFZERO(METRIK_VGJ2) AS METRIK_VGJ 
, NULL AS METRIK_PLAN_VGJ1 /* KEIN PLAN */
, NULL AS METRIK_PLAN_VGJ2
, NULL AS METRIK_PLAN_VGJ
, NULL AS METRIK_DELTA
, NULL AS METRIK_ABW
, NULL AS METRIK_PLAN_GJ1
, NULL AS METRIK_PLAN_GJ2
, NULL AS METRIK_PLAN_GJ
, jzg50.wert_eingabe AS METRIK_EINGABE /* Eingabe Inventur_2 Proz */
, NULL AS METRIK_ANTEIL
, METRIK_EINGABE AS METRIK_ZIEL1 /* ZIEL = Eingabe */
, 1.00 AS METRIK_ZIEL2 
, METRIK_ZIEL1 / NULLIFZERO(METRIK_ZIEL2) AS METRIK_ZIEL3 
, COALESCE(METRIK_ZIEL3, 0) AS METRIK_ZIEL    
FROM ( /* JZG Inventur_2 - ABTEILUNG */
    SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, (vis_inv.gj+1) AS gj, vis_inv.wrg_id, abt.abt_id
    , (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
    , SUM(vis_inv.inventur_wert_netto) AS inv_wert
    , SUM(vis_inv.inventur_ums_netto)  AS inv_ums
    , inv_wert / NULLIFZERO(inv_ums)   AS inv_quote
    FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_2 vis_inv
    JOIN DBP_DATA.TAG_2 zeit_2
    ON zeit.dat = vis_inv.dat_plan_zaehlung 
    JOIN dbp_msi_view_vis.mv_owg_int_2 owg
    ON owg.owg_id = vis_inv.owg_id
    JOIN dbp_msi_view_vis.mv_hwg_int_2 hwg
    ON hwg.hwg_id = owg.hwg_id
    JOIN dbp_msi_view_vis.mv_abt_int_2 abt_2
    ON abt.abt_id = hwg.abt_id
    WHERE zeit.akt_gj = -1 AND vis_inv.nb_id = 0 AND vis_inv.inventurart_int_id IN (8) 
    AND abt.abt_id IN(5,6) /* Ultra-Frische + Food Frische */
    GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.gj, vis_inv.wrg_id, abt.abt_id, LEVEL_ID
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 50 Inventur_2 */
ON jzg50.mandant_id = vis.mandant_id AND jzg50.wup_id = vis.wup_id
AND jzg50.wrg_id = vis.wrg_id AND jzg50.gj = vis.gj
AND jzg50.metrik_id = 50 AND jzg50.typ_id = 1 AND jzg50.level_id = vis.LEVEL_ID 
 
UNION ALL 
/* JZG520 - Inventur_2 HWG */
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.gj, vis.wrg_id
, 50::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, vis.inv_wert AS METRIK_VGJ1 
, vis.inv_ums  AS METRIK_VGJ2 
, METRIK_VGJ1 / NULLIFZERO(METRIK_VGJ2) AS METRIK_VGJ 
, NULL AS METRIK_PLAN_VGJ1 /* KEIN PLAN */
, NULL AS METRIK_PLAN_VGJ2
, NULL AS METRIK_PLAN_VGJ
, NULL AS METRIK_DELTA
, NULL AS METRIK_ABW
, NULL AS METRIK_PLAN_GJ1
, NULL AS METRIK_PLAN_GJ2
, NULL AS METRIK_PLAN_GJ
, jzg50.wert_eingabe AS METRIK_EINGABE /* Eingabe Inventur_2 Proz */
, NULL AS METRIK_ANTEIL
, METRIK_EINGABE AS METRIK_ZIEL1 /* ZIEL = Eingabe */
, 1.00 AS METRIK_ZIEL2 
, METRIK_ZIEL1 / NULLIFZERO(METRIK_ZIEL2) AS METRIK_ZIEL3 
, COALESCE(METRIK_ZIEL3, 0) AS METRIK_ZIEL    
FROM ( /* JZG Inventur_2 - HWG */
    SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, (vis_inv.gj+1) AS gj, vis_inv.wrg_id, abt.abt_id, hwg.hwg_id
    , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000)::INTEGER AS LEVEL_ID
    , SUM(vis_inv.inventur_wert_netto) AS inv_wert
    , SUM(vis_inv.inventur_ums_netto)  AS inv_ums
    , inv_wert / NULLIFZERO(inv_ums)   AS inv_quote
    FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_2 vis_inv
    JOIN DBP_DATA.TAG_2 zeit_2
    ON zeit.dat = vis_inv.dat_plan_zaehlung 
    JOIN dbp_msi_view_vis.mv_owg_int_2 owg
    ON owg.owg_id = vis_inv.owg_id
    JOIN dbp_msi_view_vis.mv_hwg_int_2 hwg
    ON hwg.hwg_id = owg.hwg_id
    JOIN dbp_msi_view_vis.mv_abt_int_2 abt_2
    ON abt.abt_id = hwg.abt_id
    WHERE zeit.akt_gj = -1 AND vis_inv.nb_id = 0 AND vis_inv.inventurart_int_id IN (8) 
    AND (abt.abt_id IN (5) OR hwg.hwg_id IN (65,81)) /* Ultra-Frische + Wurst SB alt/neu */
    GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.gj, vis_inv.wrg_id, abt.abt_id, hwg.hwg_id, LEVEL_ID
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 50 Inventur_2 */
ON jzg50.mandant_id = vis.mandant_id AND jzg50.wup_id = vis.wup_id
AND jzg50.wrg_id = vis.wrg_id AND jzg50.gj = vis.gj
AND jzg50.metrik_id = 50 AND jzg50.typ_id = 2 AND jzg50.level_id = vis.LEVEL_ID 
 
UNION ALL 
/* JZG520 - Inventur_2 OWG */
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.gj, vis.wrg_id
, 50::INTEGER AS METRIK_ID
, 03::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, vis.inv_wert AS METRIK_VGJ1 
, vis.inv_ums  AS METRIK_VGJ2 
, METRIK_VGJ1 / NULLIFZERO(METRIK_VGJ2) AS METRIK_VGJ 
, NULL AS METRIK_PLAN_VGJ1 /* KEIN PLAN */
, NULL AS METRIK_PLAN_VGJ2
, NULL AS METRIK_PLAN_VGJ
, NULL AS METRIK_DELTA
, NULL AS METRIK_ABW
, NULL AS METRIK_PLAN_GJ1
, NULL AS METRIK_PLAN_GJ2
, NULL AS METRIK_PLAN_GJ
, jzg50.wert_eingabe AS METRIK_EINGABE /* Eingabe Inventur_2 Proz */
, NULL AS METRIK_ANTEIL
, METRIK_EINGABE AS METRIK_ZIEL1 /* ZIEL = Eingabe */
, 1.00 AS METRIK_ZIEL2 
, METRIK_ZIEL1 / NULLIFZERO(METRIK_ZIEL2) AS METRIK_ZIEL3 
, COALESCE(METRIK_ZIEL3, 0) AS METRIK_ZIEL    
FROM ( /* JZG Inventur_2 - HWG */
    SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.gj+1 AS gj, vis_inv.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
    , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
    , SUM(vis_inv.inventur_wert_netto) AS inv_wert
    , SUM(vis_inv.inventur_ums_netto)  AS inv_ums
    , inv_wert / NULLIFZERO(inv_ums)   AS inv_quote
    FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_2 vis_inv
    JOIN DBP_DATA.TAG_2 zeit_2
    ON zeit.dat = vis_inv.dat_plan_zaehlung 
    JOIN dbp_msi_view_vis.mv_owg_int_2 owg
    ON owg.owg_id = vis_inv.owg_id
    JOIN dbp_msi_view_vis.mv_hwg_int_2 hwg
    ON hwg.hwg_id = owg.hwg_id
    JOIN dbp_msi_view_vis.mv_abt_int_2 abt_2
    ON abt.abt_id = hwg.abt_id
    WHERE zeit.akt_gj = -1 AND vis_inv.nb_id = 0 AND vis_inv.inventurart_int_id IN (8) 
    AND abt.abt_id IN (5) /* Ultra-Frische */
    GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.gj, vis_inv.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id, LEVEL_ID
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 50 Inventur_2 */
ON jzg50.mandant_id = vis.mandant_id AND jzg50.wup_id = vis.wup_id
AND jzg50.wrg_id = vis.wrg_id AND jzg50.gj = vis.gj
AND jzg50.metrik_id = 50 AND jzg50.typ_id = 3 AND jzg50.level_id = vis.LEVEL_ID 
;
