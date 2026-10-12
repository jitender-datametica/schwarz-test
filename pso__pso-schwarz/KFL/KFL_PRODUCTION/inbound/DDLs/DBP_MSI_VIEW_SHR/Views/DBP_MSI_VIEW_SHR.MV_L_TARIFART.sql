CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_TARIFART
(
mandant_id
,tarifart_id
)
AS
   SELECT
   v01.mandant_id, v01.tarifart_id

   FROM dbp_view.v_l_tarifart v01;