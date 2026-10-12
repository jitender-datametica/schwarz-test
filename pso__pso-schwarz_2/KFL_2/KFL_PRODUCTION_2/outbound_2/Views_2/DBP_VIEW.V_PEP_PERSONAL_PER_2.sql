CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_personal_per_2 AS SELECT idpersonal,
 dat_von,
 dat_bis,
 stunden_woche,
 stunden_monat,
 idmastatus,
 idcompany,
 idabteilungen,
 pep_ma_funktion_id
FROM kfl_production_dbp_data.pep_personal_per_2;