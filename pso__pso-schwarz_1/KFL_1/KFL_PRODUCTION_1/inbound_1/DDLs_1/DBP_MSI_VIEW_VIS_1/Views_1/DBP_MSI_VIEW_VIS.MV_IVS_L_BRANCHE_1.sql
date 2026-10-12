CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_L_BRANCHE_1 as
   SELECT
   mandant_id, branche_id, branche_bez, spr_id
   FROM dbp_view.v_ivs_l_branche_1
   WHERE spr_id = 22;