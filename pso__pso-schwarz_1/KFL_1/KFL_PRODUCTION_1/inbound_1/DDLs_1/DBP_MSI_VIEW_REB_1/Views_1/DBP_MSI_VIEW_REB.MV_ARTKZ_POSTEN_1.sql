CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_POSTEN_1
(
posten_id
, posten_bez
, mandant_id
, spr_id
)
AS
   SELECT
   posten_id, posten_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_posten_1
   WHERE posten_id IN ('PN','')
   AND mandant_id = 1
   AND spr_id =22;