create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_MES_IST_SUMZEIT(
	MANDANT_ID,
	WERK_ID,
	FLW_ARBEITSPLATZ_ID,
	SCHICHT_ID,
	MES_PRODZEITTYP_ID,
	DAT_IST_PROD,
	IST_PROD_DAUER
) as

--20.07.2022 TWIE: SPEC0148992 neue Fakttabelle
--mes_prodmengetyp_gruppe zwar im Tabellenschlüssel weil so von SAP, wird aber nicht verwendet, Datensatz ist auch ohne eindeutig

SELECT

mandant_id
,flw_werk_id AS werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodzeittyp_id
,dat_ist_prod
,ist_prod_dauer

FROM dbp_view.v_flw_mes_ist_sumzeit;