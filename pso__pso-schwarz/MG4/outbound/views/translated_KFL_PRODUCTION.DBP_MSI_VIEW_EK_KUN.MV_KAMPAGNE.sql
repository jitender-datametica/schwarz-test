CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne (mandant_id, kampagne_id, kampagne_name,
dat_kampagne_von, dat_kampagne_bis, kampagne_rhythmus_typ_id, kampagne_version_nr, anzahl_loyalty_kunden) AS SELECT v01
 .mandant_id,
 v01.kampagne_id,
 v01.kampagne_name,
 v01.dat_kampagne_von,
 v01.dat_kampagne_bis,
 v01.kampagne_rhythmus_typ_id,
 v01.kampagne_version_nr,
 COUNT(DISTINCT v02.crm_kunde_id) AS anzahl_loyalty_kunden
FROM kfl_production_dbp_view.v_kampagne AS v01
 INNER JOIN kfl_production_dbp_view.v_crm_l_kunde AS v02 ON v01.mandant_id = v02.kunde_mandant_id
WHERE DATE(v02.zeit_registrierung) <= v01.dat_kampagne_von
GROUP BY v01.mandant_id,
 v01.kampagne_id,
 v01.kampagne_name,
 v01.dat_kampagne_von,
 v01.dat_kampagne_bis,
 v01.kampagne_rhythmus_typ_id,
 v01.kampagne_version_nr;