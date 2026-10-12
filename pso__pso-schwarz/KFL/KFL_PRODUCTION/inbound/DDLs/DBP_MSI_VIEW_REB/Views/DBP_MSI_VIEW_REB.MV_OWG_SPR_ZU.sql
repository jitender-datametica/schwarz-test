CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_OWG_SPR_ZU
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

   FROM dbp_view.v_owg_spr_zu
   WHERE spr_id=22
   AND mandant_id=1;