create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_MES_SOLL_SUMZEIT_1(
	MANDANT_ID,
	WERK_ID,
	FLW_ARBEITSPLATZ_ID,
	SCHICHT_ID,
	MES_PRODZEITTYP_ID,
	DAT_SOLL_PROD,
	PLANUNGS_DAUER,
	PLANUNGS_EINH
) as

--20.07.2022 TWIE: SPEC0148992 neue Fakttabelle


SELECT

mandant_id
,flw_werk_id AS werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodzeittyp_id
,dat_soll_prod
,planungs_dauer
,planungs_einh

FROM dbp_view.v_flw_mes_soll_sumzeit_1;