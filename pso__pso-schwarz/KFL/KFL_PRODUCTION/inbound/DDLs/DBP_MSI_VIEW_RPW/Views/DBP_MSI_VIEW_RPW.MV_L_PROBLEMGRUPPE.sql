CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_PROBLEMGRUPPE
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
             FROM dbp_view.v_l_problemgruppe
             WHERE mandant_id = 1;