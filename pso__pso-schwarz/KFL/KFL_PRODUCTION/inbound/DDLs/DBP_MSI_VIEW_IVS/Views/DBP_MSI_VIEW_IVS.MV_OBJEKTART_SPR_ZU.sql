CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_OBJEKTART_SPR_ZU as
      -- 2008-12-15 NEU
      -- SPRACHZUORDNUNG Objektart
      -- nur eine Sprache

      SELECT
      mandant_id,
      objektart_id,
      objektart_bez,
      spr_id

      FROM dbp_view.v_ivs_objektart_spr_zu
      WHERE spr_id = 22;