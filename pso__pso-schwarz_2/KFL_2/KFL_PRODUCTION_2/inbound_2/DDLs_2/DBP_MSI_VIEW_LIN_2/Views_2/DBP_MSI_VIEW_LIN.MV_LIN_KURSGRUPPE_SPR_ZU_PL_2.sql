CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_LIN_KURSGRUPPE_SPR_ZU_PL_2
(
mandant_id
,lin_kursgruppe_id
,lin_kursgruppe_bez
)
AS
   SELECT v1.mandant_id, v1.lin_kursgruppe_id, v2.lin_kursgruppe_bez
   FROM dbp_view.v_l_lin_kursgruppe_2 v1
   INNER JOIN dbp_view.v_lin_kursgruppe_spr_zu_2 v2
   ON v1.lin_kursgruppe_id = v2.lin_kursgruppe_id
   WHERE v2.spr_id = 90
   GROUP BY 1,2,3
   ;