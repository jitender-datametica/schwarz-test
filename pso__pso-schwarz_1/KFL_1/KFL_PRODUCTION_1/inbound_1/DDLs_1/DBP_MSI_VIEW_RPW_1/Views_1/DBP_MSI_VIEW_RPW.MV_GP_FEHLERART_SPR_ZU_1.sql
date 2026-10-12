CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GP_FEHLERART_SPR_ZU_1
       (
       system_id
       ,mandant_id
       ,gp_fehlerart_id
       ,spr_id
       ,gp_fehlerart_bez
       )
       AS
          SELECT
          7,
          mandant_id,
          CASE WHEN gp_fehlerart_id= '' THEN  '0' ELSE gp_fehlerart_id END gp_fehlerart_id,
          spr_id,
          gp_fehlerart_bez
          FROM dbp_view.v_gp_fehlerart_spr_zu_1
          WHERE mandant_id = 1
          AND  spr_id = 22;