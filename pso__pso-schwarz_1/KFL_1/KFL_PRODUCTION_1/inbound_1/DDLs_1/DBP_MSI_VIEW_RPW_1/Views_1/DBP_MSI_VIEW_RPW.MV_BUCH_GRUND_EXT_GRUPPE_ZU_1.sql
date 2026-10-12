CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCH_GRUND_EXT_GRUPPE_ZU_1
          (
          system_id
          ,mandant_id
          ,buch_grund_ext_id
          ,buch_grund_ext_gruppe_id
          )
          AS
             SELECT
             7,
             mandant_id,
             buch_grund_ext_id,
             buch_grund_ext_gruppe_id
             FROM dbp_view.v_buch_grund_ext_gruppe_zu_1
             WHERE mandant_id = 1;