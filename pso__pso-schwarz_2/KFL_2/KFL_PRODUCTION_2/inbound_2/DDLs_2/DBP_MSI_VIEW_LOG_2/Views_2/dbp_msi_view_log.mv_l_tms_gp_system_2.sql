CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_GP_SYSTEM_2(
	MANDANT_ID,
	TMS_GP_ID,
	NB_ID,
	EWM_FG,
	SYSTEM_BEZ,
	TMS_GP_ID_ANZEIGE,
	TMS_GP_NAME
) AS
--2024-11-07, dknop, initial
--2025-01-29, nwag, FLW
--VZ:
SELECT 
 tg.mandant_id
,tg.tms_gp_id
,ll.nb_id
,ll.ewm_fg
,CASE WHEN ll.ewm_fg = 1 THEN 'EWM' ELSE 'LES' END AS system_bez
,CASE WHEN ll.ewm_fg=1 THEN ll.lagernummer_id_ ELSE ll.wup_id::VARCHAR END  AS tms_gp_id_anzeige
,tg.tms_gp_name
FROM dbp_view.v_tms_gp_2 tg 
JOIN dbp_view.v_L_SYSTEM_2 sys 
ON sys.system_id=tg.system_id
JOIN (SELECT mandant_id, wup_id, ewm_fg, nb_id, MAX(lagernummer_id) AS lagernummer_id_ FROM dbp_data.l_lagernummer_2 ll 
GROUP BY 1,2,3,4) ll ON ll.wup_id = TRY_CAST(tg.tms_gp_id AS NUMBER) 
AND ll.mandant_id=tg.mandant_id
WHERE tg.tms_gp_typ_cd='L' AND tg.tms_gp_id NOT IN ('6921','6922') AND LEFT(sys.SYSTEM_BEZ,4) = 'KTMS' AND LEFT(sys.KL_SYSTEM_BEZ,3)  <> 'FLW' 
UNION --FLW:
SELECT 
 tg.mandant_id
,tg.tms_gp_id
,-111 AS nb_id
,2 AS ewm_fg
,'FLW' AS system_bez
,tg.tms_gp_id  AS tms_gp_id_anzeige
,tg.tms_gp_name
FROM dbp_view.v_tms_gp_2 tg 
JOIN dbp_view.v_L_SYSTEM_2 sys 
ON sys.system_id=tg.system_id
WHERE tg.tms_gp_id IN ('6921','6922') AND LEFT(sys.SYSTEM_BEZ,4) = 'KTMS' AND LEFT(sys.KL_SYSTEM_BEZ,3)  = 'FLW' 
;