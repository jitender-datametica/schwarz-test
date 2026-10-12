CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BELEGART_1
       (
       mandant_id
       ,belegart_id
       ,system_id
       )
       AS
          SELECT
          mandant_id,
          belegart_id,
          7
          FROM dbp_view.v_l_belegart_1
          WHERE mandant_id = 1;