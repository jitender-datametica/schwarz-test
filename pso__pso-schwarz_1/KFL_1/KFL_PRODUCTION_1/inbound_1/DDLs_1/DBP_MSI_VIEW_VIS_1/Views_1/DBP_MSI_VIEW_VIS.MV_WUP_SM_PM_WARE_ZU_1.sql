CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_SM_PM_WARE_ZU_1 
AS

/*
	ZUORDNUNG - Sortimentstufe/Preiskategeorie je Filiale
	Werte pro WG, berechnete Durchschnitte pro OWG/HWG/ABT_1
	2020.03.23 ssch0611 : Initial (replaces Leit WG logic)
	2025-05-23 ssch0611 : Review (Referenz MV_VIS_MONAT_FAKT_WG_1) [AP0263159]
*/
SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, hwg.abt_id
	, AVG(CASE WHEN pm.pm_id > -1 THEN pm.pm_id END) OVER (PARTITION BY vis.mandant_id, vis.wup_id, hwg.abt_id) AS abt_pm_id
	, AVG(CASE WHEN sm.sm_id > -1 THEN sm.sm_id END) OVER (PARTITION BY vis.mandant_id, vis.wup_id, hwg.abt_id) AS abt_sm_id
	, owg.hwg_id
	, AVG(CASE WHEN pm.pm_id > -1 THEN pm.pm_id END) OVER (PARTITION BY vis.mandant_id, vis.wup_id, owg.hwg_id) AS hwg_pm_id
	, AVG(CASE WHEN sm.sm_id > -1 THEN sm.sm_id END) OVER (PARTITION BY vis.mandant_id, vis.wup_id, owg.hwg_id) AS hwg_sm_id
	, wg.owg_id
	, AVG(CASE WHEN pm.pm_id > -1 THEN pm.pm_id END) OVER (PARTITION BY vis.mandant_id, vis.wup_id, wg.owg_id)  AS owg_pm_id
	, AVG(CASE WHEN sm.sm_id > -1 THEN sm.sm_id END) OVER (PARTITION BY vis.mandant_id, vis.wup_id, wg.owg_id)  AS owg_sm_id
	, vis.wg_id
	, COALESCE(pm.pm_id, -1) AS wg_pm_id
	, COALESCE(sm.sm_id, -1) AS wg_sm_id


FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WG_1 vis

INNER JOIN dbp_data.tag_1 zeit_1
ON vis.kjmo = zeit.kjmo AND zeit.dat = CURRENT_DATE

INNER JOIN dbp_data.wg_per_1 wg
	ON vis.wg_id = wg.wg_id AND vis.mandant_id = wg.mandant_id AND wg.dat_bis='9999-12-31'

INNER JOIN dbp_data.owg_per_1 owg
	ON wg.owg_id = owg.owg_id AND wg.mandant_id = owg.mandant_id AND owg.dat_bis='9999-12-31'

INNER JOIN dbp_data.hwg_per_1 hwg
	ON owg.hwg_id = hwg.hwg_id AND owg.mandant_id = hwg.mandant_id AND hwg.dat_bis='9999-12-31'

LEFT JOIN dbp_data.sm_wup_wg_zu_per_1  sm_1
	ON vis.wup_id = sm.wup_id AND vis.wg_id = sm.wg_id AND vis.mandant_id = sm.mandant_id AND sm.dat_bis='9999-12-31'

LEFT JOIN dbp_data.pm_wup_wg_zu_per_1  pm_1
ON vis.wup_id = pm.wup_id AND vis.wg_id = pm.wg_id AND vis.mandant_id = pm.mandant_id AND pm.dat_bis='9999-12-31'

WHERE vis.wrg_id='EUR';