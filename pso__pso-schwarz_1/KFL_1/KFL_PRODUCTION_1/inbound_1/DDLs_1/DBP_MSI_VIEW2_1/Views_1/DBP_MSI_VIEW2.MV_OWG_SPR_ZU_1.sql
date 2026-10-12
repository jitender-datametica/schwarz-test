CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_OWG_SPR_ZU_1
-- 15.04.2021 lsvi0303 NSR2095327 - removing owg_id 1011, 1012, 1014
(
owg_id
,spr_id
,arthiertyp_id
,mandant_id
, owg_bez
)
AS
   SELECT
   owg_id, spr_id, arthiertyp_id, mandant_id, owg_bez

   FROM dbp_view.v_owg_spr_zu_1
   WHERE spr_id=22
   AND owg_id NOT IN (1011, 1012, 1014)
   AND mandant_id=1;