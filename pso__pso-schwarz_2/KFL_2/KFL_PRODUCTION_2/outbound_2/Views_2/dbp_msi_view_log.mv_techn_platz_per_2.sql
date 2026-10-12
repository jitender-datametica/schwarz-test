CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_techn_platz_per_2 (techn_platz_id, mandant_id,
werk_instandhaltung_plan, werk_id) AS SELECT V01.techn_platz_id,
 V01.mandant_id,
 V01.werk_instandhaltung_plan,
 V02.werk_id
FROM kfl_production_dbp_view.v_techn_platz_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_werk_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.werk_instandhaltung_plan
    = V02.werk_nr
WHERE V01.dat_bis = DATE '9999-12-31';