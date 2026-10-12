CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_LAGERORT_2 as
   SELECT
  lagerort_id, mandant_id, nb_id, wup_id, COALESCE(lagernummer_id,'-99') AS lagernummer_id
   FROM dbp_view.v_l_lagerort_2
   WHERE lagerort_id NOT IN ('-1', '-2', '-3');