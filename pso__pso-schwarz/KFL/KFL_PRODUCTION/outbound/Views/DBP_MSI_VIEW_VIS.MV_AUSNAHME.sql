CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ausnahme (mandant_id, nb_id, wup_id, dat_plan, art_id,
pruef_id, z_arbeitsgebiet_id, gp_id, ausnahme_mutter_id, ausnahme_menge_bme, ausnahme_menge_kolli) AS SELECT V01.mandant_id
 ,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.dat_plan,
 V01.art_id,
 V01.pruef_id,
 V01.z_arbeitsgebiet_id,
 V01.gp_id,
 V01.ausnahme_mutter_id,
 V01.ausnahme_menge_bme,
 V01.ausnahme_menge_kolli
FROM kfl_production_dbp_view.v_ausnahme AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
WHERE V01.mandant_id <> 1 AND V01.nb_id = 0 AND V01.z_arbeitsgebiet_id = 1 AND V01.pruef_id IN (202, 203, 205, 206, 207
    , 209, 210, 214, 216, 218, 223, 225, 231, 700)
 OR V01.mandant_id <> 1 AND V01.nb_id = 0 AND V01.z_arbeitsgebiet_id = 0 AND V01.pruef_id IN (1, 2, 5, 250, 252, 253)
 OR V01.mandant_id = 1 AND V01.nb_id = 0 AND V01.z_arbeitsgebiet_id = 0 AND V01.pruef_id IN (252);