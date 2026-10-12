CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_MES_PRODFEHLER_CODEGRUPPE_1(
	MANDANT_ID,
	FEHLER_CODE_GRUPPE_ID
) AS

--28.07.2022 TWIE: SPEC0148993 neue Lookupview für Prodfehler Codegruppe
--fehler_katalog_id nicht relevant, auch wenn in Tabelle laut SAP im PK
--19.12.2022 twie: SPEC0148993 Bez in spr_zu View ausgelagert für Mehrsprachigkeit

SELECT

mandant_id
,fehler_code_gruppe_id

FROM dbp_view.v_flw_mes_prodfehler_codegruppe_1;