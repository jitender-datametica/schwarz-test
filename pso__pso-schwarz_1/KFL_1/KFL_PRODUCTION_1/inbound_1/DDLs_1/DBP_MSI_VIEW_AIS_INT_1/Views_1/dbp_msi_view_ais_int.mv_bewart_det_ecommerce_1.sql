CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_bewart_det_ecommerce_1
AS
SELECT
kundenkarte_id,
mandant_id
FROM dbp_view.v_bewart_det_ecommerce_1;
