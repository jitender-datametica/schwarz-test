CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_EKORG_SPR_ZU_SK as
      SELECT
      einkaufsorganisation_id,
      mandant_id,
      einkaufsorganisation_bez
      FROM dbp_view.v_in_ekorg_spr_zu
      WHERE spr_id = 108;