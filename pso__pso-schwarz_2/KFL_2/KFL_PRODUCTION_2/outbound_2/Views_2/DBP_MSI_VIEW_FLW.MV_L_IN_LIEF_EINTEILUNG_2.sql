CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lief_einteilung_2 (mandant_id, best_beleg_id,
best_beleg_pos_id, charge_id, einteil_id, dat_lief_wunsch, zeit_lief_wunsch, datzeit_lief_wunsch, datzeit_lief_wunsch_az
) AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 charge_id,
 einteil_id,
 dat_lief_wunsch,
 zeit_lief_wunsch,
 datzeit_lief_wunsch,
 datzeit_lief_wunsch_az
FROM kfl_production_dbp_view.v_flw_lief_einteilung_2 AS V01;