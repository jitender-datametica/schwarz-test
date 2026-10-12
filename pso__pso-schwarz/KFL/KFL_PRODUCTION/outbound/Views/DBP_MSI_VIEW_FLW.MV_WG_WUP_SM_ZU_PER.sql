CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_wg_wup_sm_zu_per (mandant_id, wup_id, nb_id, in_kunde_id,
wg_id, arthiertyp_id, sm_id, dat_von, dat_bis) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V02.flw_kunde_id AS in_kunde_id,
 V01.wg_id,
 V01.arthiertyp_id,
 V01.sm_id,
 V01.dat_von,
 V01.dat_bis
FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
WHERE V01.mandant_id IN (1, 2)
 AND V01.arthiertyp_id = 2
 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.nb_id <> 99;