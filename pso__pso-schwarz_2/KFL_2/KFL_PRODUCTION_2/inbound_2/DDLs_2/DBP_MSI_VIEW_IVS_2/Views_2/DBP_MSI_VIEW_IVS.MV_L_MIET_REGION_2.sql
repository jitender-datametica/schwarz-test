CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_MIET_REGION_2 as
      SELECT
      mandant_id,
      miet_region_id,
      miet_region_bez,
      bl_id,
      bl_bez,
      spr_id
      FROM dbp_view.v_ivs_l_miet_region_2
      WHERE spr_id = 22;