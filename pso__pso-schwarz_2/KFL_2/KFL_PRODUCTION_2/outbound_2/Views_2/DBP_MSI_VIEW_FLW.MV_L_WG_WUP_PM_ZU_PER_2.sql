CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_wg_wup_pm_zu_per_2 (in_kunde_id, nb_id, arthiertyp_id, wg_id,
pm_id, dat_von, dat_bis, mandant_id) AS SELECT V02.flw_kunde_id AS in_kunde_id,
 V01.nb_id,
 V01.arthiertyp_id,
 V01.wg_id,
 V01.pm_id,
 V01.dat_von,
 V01.dat_bis,
 V01.mandant_id
FROM kfl_production_dbp_view.v_pm_wup_wg_zu_per_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id = 1
 AND V01.arthiertyp_id = 2
 AND V01.dat_bis > CURRENT_DATE
 AND V01.nb_id = 0;