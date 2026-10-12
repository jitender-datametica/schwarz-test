CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MIETAUFTRAG_SPR_ZU as
      -- 2008-12-15 NEU
      -- SPRACHZUORDNUNG Mietauftrag
      -- nur eine Sprache

      SELECT
      mandant_id,
      mietauftrag_id,
      mietauftrag_bez,
      spr_id

      FROM dbp_view.v_ivs_mietauftrag_spr_zu
      WHERE spr_id = 22;