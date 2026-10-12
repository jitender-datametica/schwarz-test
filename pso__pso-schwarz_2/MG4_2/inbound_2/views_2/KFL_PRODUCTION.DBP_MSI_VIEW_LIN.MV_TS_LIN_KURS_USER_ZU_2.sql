create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_TS_LIN_KURS_USER_ZU_2(
	MANDANT_ID,
	LIN_KURS_ID,
	USER_ID,
	LOESCH_FG
) as
   SELECT
   mandant_id, lin_kurs_id, user_id, 0 AS loesch_fg
   FROM dbp_msi_view_lin.ts_lin_kurs_user_zu_2
;