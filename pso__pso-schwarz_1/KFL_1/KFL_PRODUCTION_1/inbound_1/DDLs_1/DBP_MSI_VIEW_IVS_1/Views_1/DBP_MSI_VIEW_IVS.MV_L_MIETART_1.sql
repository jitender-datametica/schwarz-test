CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_MIETART_1 as
   SELECT
   mietart_id,
   mandant_id,
   spr_id,
   mietart_bez
   FROM dbp_view.v_ivs_l_mietart_1
   WHERE spr_id = 22;