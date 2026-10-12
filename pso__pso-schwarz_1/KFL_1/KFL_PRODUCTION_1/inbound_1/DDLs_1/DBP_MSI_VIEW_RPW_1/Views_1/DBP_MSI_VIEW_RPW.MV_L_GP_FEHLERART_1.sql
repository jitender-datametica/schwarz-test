CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_GP_FEHLERART_1
          (
          system_id
          ,mandant_id
          ,gp_fehlerart_id
          )
          AS
             SELECT
             7,
             mandant_id,
             CASE WHEN gp_fehlerart_id= ''
             THEN  '0'
             ELSE gp_fehlerart_id
             END gp_fehlerart_id
             FROM dbp_view.v_l_gp_fehlerart_1
             WHERE mandant_id = 1;