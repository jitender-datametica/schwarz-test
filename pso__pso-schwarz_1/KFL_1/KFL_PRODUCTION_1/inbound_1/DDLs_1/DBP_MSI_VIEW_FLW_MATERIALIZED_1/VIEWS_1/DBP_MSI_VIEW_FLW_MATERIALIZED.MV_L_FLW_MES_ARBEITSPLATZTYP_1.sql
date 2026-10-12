create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_MES_ARBEITSPLATZTYP_1(
	MANDANT_ID,
	FLW_ARBEITSPLATZTYP_ID
) as

--19.07.2022 TWIE: SPEC0148992 neue Lookupview für Arbeitsplatztyp (Attributname Maschinentyp)
--es gibt keine eigene Lookuptabelle deshalb den Fremdschlüssel in Arbeitsplatztabelle unique ausgeben


SELECT

mandant_id
,flw_arbeitsplatztyp_id

FROM dbp_view.v_flw_mes_arbeitsplatz_1

GROUP BY
mandant_id
,flw_arbeitsplatztyp_id;