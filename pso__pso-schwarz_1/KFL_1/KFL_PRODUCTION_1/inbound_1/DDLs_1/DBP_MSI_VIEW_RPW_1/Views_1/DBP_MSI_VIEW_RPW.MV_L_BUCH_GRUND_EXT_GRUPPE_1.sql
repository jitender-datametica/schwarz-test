CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BUCH_GRUND_EXT_GRUPPE_1
          (
          system_id
          ,mandant_id
          ,buch_grund_ext_gruppe_id
          )
          AS
             SELECT
             7,
             mandant_id,
             buch_grund_ext_gruppe_id
             FROM dbp_view.v_l_buch_grund_ext_gruppe_1
             WHERE mandant_id = 1;