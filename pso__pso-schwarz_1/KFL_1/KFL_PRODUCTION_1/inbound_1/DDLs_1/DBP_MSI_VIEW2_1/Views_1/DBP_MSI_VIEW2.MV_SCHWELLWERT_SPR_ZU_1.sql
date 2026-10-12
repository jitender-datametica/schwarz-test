CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_SCHWELLWERT_SPR_ZU_1
(
mandant_id
,sw_id
,spr_id
,sw_bez

)
AS
   SELECT
   mandant_id, sw_id, spr_id, sw_bez

   FROM dbp_view.v_schwellwert_spr_zu_1
   WHERE spr_id = 22 AND mandant_id=1;