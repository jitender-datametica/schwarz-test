CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_WG_SPR_ZU_CZ as
   SELECT

   in_wg_id,
   in_wg_bez

   FROM dbp_view.v_in_wg_spr_zu
   WHERE mandant_id=2 AND spr_id=124
;