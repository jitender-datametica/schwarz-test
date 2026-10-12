CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ECOM_RES_2
(
art_id
, mandant_id
, wup_id
, nb_id
, dat_von
, dat_bis
, aktion_id
, bewart_id
, reservierbar_fg
)
AS
   SELECT
   art_id, mandant_id, wup_id, nb_id, dat_von, dat_bis, aktion_id, bewart_id, 1 AS reservierbar_fg

   FROM dbp_view.v_ecom_res_2
   WHERE mandant_id = 1;