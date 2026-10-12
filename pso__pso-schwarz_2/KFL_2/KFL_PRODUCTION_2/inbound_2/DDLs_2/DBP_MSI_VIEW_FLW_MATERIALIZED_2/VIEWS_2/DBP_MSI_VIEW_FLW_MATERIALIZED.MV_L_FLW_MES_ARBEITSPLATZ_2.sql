create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_MES_ARBEITSPLATZ_2(
	MANDANT_ID,
	FLW_ARBEITSPLATZ_ID,
	FLW_ARBEITSPLATZTYP_ID
) as

--14.06.2022 TWIE: SPEC0148992 neue Lookupview für Arbeitsplätze


SELECT

mandant_id
,flw_arbeitsplatz_id
,flw_arbeitsplatztyp_id

FROM dbp_view.v_flw_mes_arbeitsplatz_2;