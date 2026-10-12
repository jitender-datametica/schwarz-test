CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_HWG_PER_2
          (
          hwg_id
          ,arthiertyp_id
          ,mandant_id
          ,dat_von
          ,dat_bis
          ,abt_id
          ,system_id
          )
          AS
             SELECT
             hwg_id,
             arthiertyp_id,
             mandant_id,
             dat_von,
             dat_bis,
             abt_id,
             7
             FROM dbp_view.v_hwg_per_2
             WHERE mandant_id = 1
             AND arthiertyp_id = 2;