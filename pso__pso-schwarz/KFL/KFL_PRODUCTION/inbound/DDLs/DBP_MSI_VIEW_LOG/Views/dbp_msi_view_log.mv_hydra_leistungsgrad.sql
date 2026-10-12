CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_HYDRA_LEISTUNGSGRAD(
	MANDANT_ID,
	PERS_TEILBEREICH_ID,
	DAT,
	LOHNART_ID,
	ZEITART_ID,
	PRAEMIENGRP_ID,
	TRANSPORT_GV_ID,
	LAGERNUMMER_ID,
	ARTIKELSORTIMENT_ID,
	EWM_FG,
	DAUER_IST,
	DAUER_SOLL,
	GRAD_LEISTUNG,
	MENGE,
	ABRECHNUNG_FG
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 
--2023-09-21, AP0145540,SPEC0182434, dknop, adding artikelsortiment
--2024-10-17, AP0210954_SPEC0239355, nwag, move TS to msi_data
SELECT 
 hl.mandant_id
,hl.pers_teilbereich_id
,hl.dat 
,hl.lohnart_id
,hl.zeitart_id
,COALESCE(CASE WHEN hl.praemiengrp_id='' THEN NULL ELSE hl.praemiengrp_id END,'-1') AS praemiengrp_id
,COALESCE(hl.transport_gv_id,'-1')
,COALESCE(hl.lagernummer_id,'-1')
,COALESCE(art_sort.ARTIKELSORTIMENT_ID, '-1')
,COALESCE(hl.ewm_fg,-1)
,hl.dauer_ist
,hl.dauer_soll
,hl.grad_leistung
,hl.menge
,hl.abrechnung_fg
FROM dbp_view.v_hydra_leistungsgrad hl
LEFT JOIN DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM art_sort
    ON  hl.lagernummer_id = art_sort.lagernummer_id 
    AND hl.mandant_id = art_sort.mandant_id
;