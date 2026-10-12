CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BUCH_GRUND_INT_1
          (
          buch_grund_int_id
          ,mandant_id
          ,system_id
          )
          AS
             SELECT
             buch_grund_int_id,
             mandant_id,
             7
             FROM dbp_view.v_l_buch_grund_int_1
             WHERE mandant_id = 1;