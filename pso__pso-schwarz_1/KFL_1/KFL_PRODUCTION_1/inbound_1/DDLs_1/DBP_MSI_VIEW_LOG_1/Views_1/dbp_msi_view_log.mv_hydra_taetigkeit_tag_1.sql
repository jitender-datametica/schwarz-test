CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_HYDRA_TAETIGKEIT_TAG_1(
	MANDANT_ID,
	PERS_TEILBEREICH_ID,
	DAT,
	TAETIGKEIT_ID,
	KOSTENSTELLE_ID,
	DAUER,
	ABRECHNUNG_FG
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 

 SELECT 
 mandant_id
,pers_teilbereich_id
,dat  
,taetigkeit_id
,COALESCE(CASE WHEN kostenstelle_id='' THEN NULL ELSE kostenstelle_id END,'0') AS kostenstelle_id
,dauer
,abrechnung_fg
FROM dbp_view.v_hydra_taetigkeit_tag_1

;