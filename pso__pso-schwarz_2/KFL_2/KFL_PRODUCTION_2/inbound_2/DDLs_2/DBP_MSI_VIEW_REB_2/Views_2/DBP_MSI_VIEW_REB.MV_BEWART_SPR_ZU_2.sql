CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_BEWART_SPR_ZU_2
(
spr_id
, bewart_id
, bewart_bez
, mandant_id
)
AS
   SELECT
   spr_id, bewart_id, bewart_bez, mandant_id

   FROM dbp_view.v_bewart_spr_zu_2
   WHERE spr_id = 22
   AND mandant_id = 1
;