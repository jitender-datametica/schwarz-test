CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_KONDITIONSART_1
(
system_id
,mandant_id
,KSCHL
)
AS
   SELECT
   system_id, mandant_id, konditionsart_id AS KSCHL
   FROM dbp_view.v_l_konditionsart_1
;