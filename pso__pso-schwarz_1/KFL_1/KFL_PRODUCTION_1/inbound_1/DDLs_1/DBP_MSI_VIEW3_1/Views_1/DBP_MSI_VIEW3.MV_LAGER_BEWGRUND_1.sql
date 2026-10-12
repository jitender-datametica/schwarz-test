CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGER_BEWGRUND_1
(
grund_id
,lager_bewart_id
,mandant_id
)
AS
   SELECT
  grund_id, lager_bewart_id, mandant_id
   FROM dbp_view.v_l_lager_bewgrund_1;