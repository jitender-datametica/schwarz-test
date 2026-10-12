CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_HYDRA_ZEITERFASSUNG_2(
	MANDANT_ID,
	PERS_TEILBEREICH_ID,
	DAT,
	DAUER,
	ABRECHNUNG_FG
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 

SELECT 
 mandant_id
,pers_teilbereich_id
,dat
,dauer
,abrechnung_fg
FROM dbp_view.v_hydra_zeiterfassung_2
;