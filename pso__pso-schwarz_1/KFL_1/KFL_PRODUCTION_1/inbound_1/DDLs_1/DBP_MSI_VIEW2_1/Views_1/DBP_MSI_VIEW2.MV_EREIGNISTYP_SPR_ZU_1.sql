CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EREIGNISTYP_SPR_ZU_1
(
spr_id
,ereignistyp_id
,ereignistyp_bez
)
AS
   SELECT
  spr_id, ereignistyp_id, ereignistyp_bez

   FROM dbp_view.v_ereignistyp_spr_zu_1
   WHERE spr_id=22
   AND mandant_id = 1;