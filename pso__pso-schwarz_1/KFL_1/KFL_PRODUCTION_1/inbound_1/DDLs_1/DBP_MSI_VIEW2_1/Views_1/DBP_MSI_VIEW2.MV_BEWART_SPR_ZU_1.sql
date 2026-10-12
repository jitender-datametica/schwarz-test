CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BEWART_SPR_ZU_1
(
spr_id
,bewart_id
,bewart_bez
,mandant_id
)
AS
   SELECT
  spr_id, bewart_id, bewart_bez, mandant_id

   FROM dbp_view.v_bewart_spr_zu_1
   WHERE spr_id=22
   AND mandant_id = 1;