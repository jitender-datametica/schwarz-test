CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ADV_INT_WEEK_REL as
      SELECT
          cy_week,
      cy,
      adv_week_int,
      adv_wt_nr_int
  FROM p_lew_mart_msi.t_adv_int_week_rel;