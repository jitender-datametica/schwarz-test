CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_VERPART
(
verpart_id
,verpart_bez
,mandant_id
,spr_id
)
AS
   SELECT
   verpart_id, verpart_bez, mandant_id, spr_id

   FROM dbp_view.v_artkz_verpart
   WHERE mandant_id = 1;