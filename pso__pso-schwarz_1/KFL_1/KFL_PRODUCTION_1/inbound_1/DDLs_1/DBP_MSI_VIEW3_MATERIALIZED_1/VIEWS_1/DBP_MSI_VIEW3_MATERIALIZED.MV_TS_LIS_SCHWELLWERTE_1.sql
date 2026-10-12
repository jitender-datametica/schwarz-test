create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TS_LIS_SCHWELLWERTE_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	SCHWELLWERT_TYP_BEZ,
	SCHWELLWERT,
	MANDANT_KBEZ
) as
   SELECT v01.mandant_id, v01.wup_id, v01.nb_id, v01.schwellwert_typ_bez, v01.schwellwert, v02.mandant_kbez
   FROM DBP_MSI_VIEW3_MATERIALIZED.ts_lis_schwellwerte_1 v01
   INNER JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id;