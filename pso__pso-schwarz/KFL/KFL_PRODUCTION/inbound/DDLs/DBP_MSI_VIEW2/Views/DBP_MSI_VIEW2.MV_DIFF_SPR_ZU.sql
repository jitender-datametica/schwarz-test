CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_DIFF_SPR_ZU
(
mandant_id
, diff_id
, spr_id
, diff_bez
)
AS
   SELECT
   v01.mandant_id, v01.diff_id, v01.spr_id, v01.diff_bez

   FROM dbp_view.v_diff_spr_zu v01
   WHERE v01.mandant_id =1;