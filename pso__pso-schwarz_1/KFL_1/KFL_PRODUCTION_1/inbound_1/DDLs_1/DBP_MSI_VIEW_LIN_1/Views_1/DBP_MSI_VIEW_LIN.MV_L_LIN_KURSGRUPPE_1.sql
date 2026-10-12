CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_L_LIN_KURSGRUPPE_1
(
mandant_id
,lin_kursgruppe_id
)
AS
   SELECT mandant_id, lin_kursgruppe_id
   FROM dbp_view.v_l_lin_kursgruppe_1;