CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_SCHWELLWERT_SPR_ZU
(
mandant_id
,sw_id
,spr_id
,sw_bez

)
AS
   SELECT
   mandant_id, sw_id, spr_id, sw_bez

   FROM dbp_view.v_schwellwert_spr_zu
   WHERE spr_id = 22 AND mandant_id=1;