CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_SAAF
(
bewart_id
,bewart_bez
,mandant_id
,spr_id
)
AS
   SELECT
  bewart_id, bewart_bez, mandant_id, spr_id

   FROM dbp_view.v_bewart_spr_zu
   WHERE
   bewart_id IN (1001,1002)
   AND spr_id = 22
   AND mandant_id = 1;