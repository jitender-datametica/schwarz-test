CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_HYDRA_RUESTZEIT(
	MANDANT_ID,
	PERS_TEILBEREICH_ID,
	DAT,
	PRAEMIENGRP_ID,
	TRANSPORT_GV_ID,
	LAGERNUMMER_ID,
	ARTIKELSORTIMENT_ID,
	EWM_FG,
	DAUER_IST,
	DAUER_RUEST,
	DAUER_WECHSEL,
	DAUER_SONSTIGES,
	ABRECHNUNG_FG
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 
--2023-09-21, , AP0145540,SPEC0182434, dknop, adding artikelsortiment
--2024-10-17, AP0210954_SPEC0239355, nwag, move TS to msi_data
SELECT 
 hr.mandant_id
,hr.pers_teilbereich_id
,hr.dat  
,COALESCE(CASE WHEN hr.praemiengrp_id='' THEN NULL ELSE hr.praemiengrp_id END,'-1') AS praemiengrp_id
,COALESCE(hr.transport_gv_id,'-1')
,COALESCE(hr.lagernummer_id,'-1')
,COALESCE(art_sort.ARTIKELSORTIMENT_ID, '-1')
,COALESCE(hr.ewm_fg,-1)
,hr.dauer_ist
,hr.dauer_ruest
,hr.dauer_wechsel
,hr.dauer_sonstiges
,hr.abrechnung_fg
FROM dbp_view.v_hydra_ruestzeit hr
LEFT JOIN DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM art_sort
    ON  hr.lagernummer_id = art_sort.lagernummer_id 
    AND hr.mandant_id = art_sort.mandant_id
;