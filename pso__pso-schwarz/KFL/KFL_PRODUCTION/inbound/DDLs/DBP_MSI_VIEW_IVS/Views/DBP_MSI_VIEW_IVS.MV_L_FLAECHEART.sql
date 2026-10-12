CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_FLAECHEART as
   SELECT
   flaecheart_id,
   flaecheart_bez,
   spr_id,
   mandant_id
   FROM dbp_view.v_ivs_l_flaecheart
   WHERE spr_id = 22;