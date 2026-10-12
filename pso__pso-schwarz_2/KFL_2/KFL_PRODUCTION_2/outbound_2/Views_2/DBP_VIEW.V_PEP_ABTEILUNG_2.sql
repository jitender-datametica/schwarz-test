CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_abteilung_2 AS SELECT idabteilungen,
 pep_abt_id,
 dat_von,
 dat_bis,
 abt_bez
FROM kfl_production_dbp_data.pep_abteilung_2;