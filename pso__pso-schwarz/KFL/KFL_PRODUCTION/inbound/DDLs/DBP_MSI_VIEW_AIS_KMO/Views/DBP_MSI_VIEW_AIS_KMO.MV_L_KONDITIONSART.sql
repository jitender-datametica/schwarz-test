CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_KONDITIONSART
(
mandant_id
,konditionsart_id
)
AS

   SELECT
   v01.mandant_id,
   v01.konditionsart_id

   FROM dbp_view.v_l_konditionsart v01

   WHERE v01.mandant_id <> 1;