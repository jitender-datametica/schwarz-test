CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_VERPART_2
(
mandant_id
,verpart_id
,spr_id
,verpart_bez
)
AS
   SELECT mandant_id, verpart_id, spr_id, verpart_bez
   FROM dbp_view.v_artkz_verpart_2
   WHERE spr_id = 22;