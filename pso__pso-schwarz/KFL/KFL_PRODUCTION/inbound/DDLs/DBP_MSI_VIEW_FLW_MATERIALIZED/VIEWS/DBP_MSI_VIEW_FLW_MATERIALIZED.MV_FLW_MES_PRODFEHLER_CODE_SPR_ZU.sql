create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLW_MES_PRODFEHLER_CODE_SPR_ZU(
	MANDANT_ID,
	FEHLER_CODE_ID,
	FEHLER_CODE_GRUPPE_ID,
	FEHLER_CODE_BEZ
) as

--19.12.2022 twie: SPEC0148993 neue spr_zu View für Mehrsprachigkeit

SELECT

v01.mandant_id
,v01.fehler_code_id
,v01.fehler_code_gruppe_id
,v01.fehler_code_bez

FROM dbp_view.v_flw_mes_prodfehler_code_spr_zu v01

JOIN dbp_msi.akt_msi_user_spr_zu v02
ON v01.spr_id = v02.spr_id;