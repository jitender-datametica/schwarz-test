CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_POSTEN_2
( posten_id
, posten_bez
, mandant_id
, spr_id
)
AS
   SELECT
  posten_id, posten_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_posten_2
   WHERE posten_id IN ('PN','')
   AND mandant_id = 1;