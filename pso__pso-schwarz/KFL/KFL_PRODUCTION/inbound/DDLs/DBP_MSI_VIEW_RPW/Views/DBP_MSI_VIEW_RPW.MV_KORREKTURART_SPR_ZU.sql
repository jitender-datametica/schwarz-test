CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_KORREKTURART_SPR_ZU
       (
       system_id
       ,mandant_id
       ,korrekturart_id
       ,spr_id
       ,korrekturart_bez
       )
       AS
          SELECT
          7,
          mandant_id,
          CASE WHEN korrekturart_id = ''
          THEN '0'
          ELSE korrekturart_id
          END  korrekturart_id,
          spr_id,
          korrekturart_bez
          FROM dbp_view.v_korrekturart_spr_zu
          WHERE mandant_id = 1
          AND  spr_id = 22;