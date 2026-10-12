CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_EKORG_SPR_ZU_2 as
      SELECT
      v01.einkaufsorganisation_id,
      v01.mandant_id,
      v01.einkaufsorganisation_bez
      FROM dbp_view.v_in_ekorg_spr_zu_2 v01
      INNER JOIN dbp_view.v_in_l_ekorg_2  v02
      ON v01.mandant_id = v02.mandant_id AND
      v01.einkaufsorganisation_id = v02.einkaufsorganisation_id AND
      v02.sako_fg=1

      WHERE spr_id =22;