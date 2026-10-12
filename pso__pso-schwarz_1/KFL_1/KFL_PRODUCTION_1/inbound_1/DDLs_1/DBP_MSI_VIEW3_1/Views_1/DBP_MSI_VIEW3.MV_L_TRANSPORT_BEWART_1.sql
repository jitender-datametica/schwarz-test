CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_TRANSPORT_BEWART_1
(
mandant_id
, lvs_bewart_id
, lagernummer_id
, wup_id
, nb_id
)
AS
   SELECT
   v01.mandant_id, v01.lvs_bewart_id, v01.lagernummer_id, v01.wup_id, v01.nb_id

   FROM dbp_view.v_l_transport_bewart_1 v01;