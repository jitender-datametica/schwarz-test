CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_KORREKTURART_1
       (
       system_id
       ,mandant_id
       ,korrekturart_id
       )
       AS
          SELECT
          7,
          mandant_id,
          CASE WHEN korrekturart_id = ''
          THEN '0'
          ELSE korrekturart_id
          END  korrekturart_id
          FROM dbp_view.v_l_korrekturart_1
          WHERE mandant_id = 1;