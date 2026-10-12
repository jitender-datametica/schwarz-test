CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_POSTEN_SPR_ZU
(
posten_id_orig
, mandant_id
, spr_id
, posten_bez
)
AS
   SELECT
   posten_id, mandant_id, spr_id, CASE WHEN posten_id = '' THEN 'nicht gepflegt' ELSE posten_bez END posten_bez
   FROM dbp_view.v_artkz_posten
   WHERE mandant_id = 1
   AND spr_id = 22;