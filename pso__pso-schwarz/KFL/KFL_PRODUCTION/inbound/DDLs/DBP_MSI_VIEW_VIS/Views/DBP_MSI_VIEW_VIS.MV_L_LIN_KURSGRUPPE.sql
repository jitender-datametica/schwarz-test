CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LIN_KURSGRUPPE
(
mandant_id
,lin_kursgruppe_id
)
AS
   SELECT mandant_id, lin_kursgruppe_id
   FROM dbp_view.v_l_lin_kursgruppe
;