CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_FLAG_AKTIV_SPR_ZU

-- 2017-06-29 ttez1905; Lookup View für Flags;

(
flag_id
,flag_bez
)
AS

   SELECT
   flag as flag_id,
   flag_bez
   FROM dbp_view.v_flag_spr_zu
   WHERE
   flag_typ_id = 3 and spr_id = 22;