CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_LAGERORT
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
          FROM dbp_view.v_l_lagerort
          WHERE mandant_id = 1;