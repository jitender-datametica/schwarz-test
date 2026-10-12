CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_FLAG_SPR_ZU_2

-- 2017-06-29 ttez1905; Lookup View für Flags;

(
flag
,flag_bez
)
AS

   SELECT
   flag as flag_id,
   flag_bez
   FROM dbp_view.v_flag_spr_zu_2
   WHERE
   flag_typ_id = 1 and spr_id = 22;