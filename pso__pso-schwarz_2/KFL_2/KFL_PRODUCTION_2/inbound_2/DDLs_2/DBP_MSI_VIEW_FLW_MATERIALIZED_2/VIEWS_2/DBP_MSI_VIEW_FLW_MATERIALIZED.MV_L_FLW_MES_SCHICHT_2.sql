create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_MES_SCHICHT_2(
	MANDANT_ID,
	SCHICHT_ID,
	SCHICHTTYP_ID,
	DAT_SCHICHT,
	FLW_ARBEITSPLATZ_ID
) as

--19.07.2022 TWIE: SPEC0148992 neue Lookupview für Schicht


SELECT

mandant_id
,schicht_id
,schichttyp_id
,dat_schicht
,flw_arbeitsplatz_id

FROM dbp_view.v_flw_mes_schicht_2;