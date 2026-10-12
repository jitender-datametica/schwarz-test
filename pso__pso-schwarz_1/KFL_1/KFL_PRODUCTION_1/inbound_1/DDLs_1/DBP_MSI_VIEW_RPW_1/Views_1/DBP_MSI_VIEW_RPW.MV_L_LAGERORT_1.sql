CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_LAGERORT_1
       (
       mandant_id
       ,lagerort_id
       ,wup_id
       ,nb_id
       ,system_id
       )
       AS
          SELECT
          mandant_id,
          lagerort_id,
          wup_id,
          nb_id,
          7
          FROM dbp_view.v_l_lagerort_1
          WHERE mandant_id = 1;