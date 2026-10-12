create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_LIN_KURSGRUPPE_SPR_ZU_PL(
	MANDANT_ID,
	LIN_KURSGRUPPE_ID,
	LIN_KURSGRUPPE_BEZ
) as
   SELECT v1.mandant_id, v1.lin_kursgruppe_id, v2.lin_kursgruppe_bez
   FROM dbp_view.v_l_lin_kursgruppe v1
   INNER JOIN dbp_view.v_lin_kursgruppe_spr_zu v2
   ON v1.lin_kursgruppe_id = v2.lin_kursgruppe_id
   WHERE v2.spr_id = 90
   GROUP BY 1,2,3
   ;