create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_MES_IST_SUMMENGE(
	MANDANT_ID,
	WERK_ID,
	FLW_ARBEITSPLATZ_ID,
	SCHICHT_ID,
	MES_PRODMENGETYP_ID,
	DAT_PROD,
	IST_MENGE,
	IST_EINH
) as

--19.07.2022 TWIE: SPEC0148992 neue Fakttabelle


SELECT

mandant_id
,flw_werk_id AS werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodmengetyp_id
,dat_prod
,ist_menge
,ist_einh


FROM dbp_view.v_flw_mes_ist_summenge;