CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_MIETAUFTRAG as
      -- 2008-12-15 NEU
      -- LOOKUP mietauftrag

      SELECT
      mandant_id,
      mietauftrag_id
      FROM dbp_view.v_ivs_l_mietauftrag;