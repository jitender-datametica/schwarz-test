CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_TEMPERATUR_SPR_ZU_1
(
mandant_id
, spr_id
, temperatur_id
, temperatur_bez
)
AS
   SELECT
   mandant_id, spr_id, temperatur_id, temperatur_bez

   FROM dbp_view.v_temperatur_spr_zu_1
   WHERE mandant_id = 1
   AND spr_id = 22
;