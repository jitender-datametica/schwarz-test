CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_wup AS SELECT wup_id,
 nb_id,
 mandant_id,
 dat_von,
 dat_bis,
 dat_eroeffnung,
 breitengrad,
 laengengrad
FROM kfl_production_dbp_view.v_wup AS V01;