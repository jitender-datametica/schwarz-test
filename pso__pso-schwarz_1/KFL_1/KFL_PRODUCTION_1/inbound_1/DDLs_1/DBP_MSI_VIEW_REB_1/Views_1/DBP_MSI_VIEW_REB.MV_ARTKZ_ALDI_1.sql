CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_ALDI_1
(
aldi_bez
, aldi_id
, mandant_id
, spr_id
)
AS
   SELECT
   CASE WHEN aldi_bez = 'system generated' THEN 'kein Aldiartikel' ELSE aldi_bez END AS aldi_bez, aldi_id, mandant_id, spr_id

   FROM dbp_view.v_artkz_aldi_1
   WHERE mandant_id = 1
   AND spr_id = 22;