create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_MES_PRODFEHLER_2(
	MANDANT_ID,
	MES_PRODZEITTYP_ID
) as

--28.07.2022 TWIE: SPEC0148993 neue Lookupview für Prodfehler (Zeit_2-Art_2)
--da es keine Lookuptabelle gibt, die Sprachtabelle auf den PK groupieren

SELECT

mandant_id
,mes_prodzeittyp_id

FROM dbp_view.v_flw_mes_prodfehler_spr_zu_2

GROUP BY
mandant_id
,mes_prodzeittyp_id;