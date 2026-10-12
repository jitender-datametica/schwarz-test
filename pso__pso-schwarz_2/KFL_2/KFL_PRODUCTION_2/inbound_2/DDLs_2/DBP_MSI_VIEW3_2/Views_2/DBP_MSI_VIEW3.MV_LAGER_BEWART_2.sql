CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGER_BEWART_2
(
lager_bewart_id
, mandant_id
,system_id
)
AS
   SELECT
  lager_bewart_id, mandant_id, system_id
   FROM dbp_view.v_l_lager_bewart_2;