CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_PROBLEMGRUPPE_1
          (
          system_id
          ,mandant_id
          ,problemgruppe_id
          )
          AS
             SELECT
             7,
             mandant_id,
             problemgruppe_id
             FROM dbp_view.v_l_problemgruppe_1
             WHERE mandant_id = 1;