CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_VERPART_PL
(
mandant_id
,verpart_id
,spr_id
,verpart_bez
)
AS
   SELECT mandant_id, verpart_id, spr_id, verpart_bez
   FROM dbp_view.v_artkz_verpart
   WHERE spr_id = 90;