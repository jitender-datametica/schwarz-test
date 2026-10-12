CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ek_sort_sortiment_mat_zeitraum_2 AS SELECT kjmo_sort,
 kjwo_von,
 kjwo_bis,
 dat_von,
 dat_bis,
 monate_anz
FROM kfl_production_dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2;