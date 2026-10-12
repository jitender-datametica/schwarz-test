CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_FLAECHEART_1 as
   SELECT
   flaecheart_id,
   flaecheart_bez,
   spr_id,
   mandant_id
   FROM dbp_view.v_ivs_l_flaecheart_1
   WHERE spr_id = 22;