CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_MIETART_2 as
   SELECT
   mietart_id,
   mandant_id,
   spr_id,
   mietart_bez
   FROM dbp_view.v_ivs_l_mietart_2
   WHERE spr_id = 22;