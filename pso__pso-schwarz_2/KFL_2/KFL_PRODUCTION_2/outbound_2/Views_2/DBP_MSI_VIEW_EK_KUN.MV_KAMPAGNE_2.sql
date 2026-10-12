CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne_2 (mandant_id, kampagne_id, kampagne_name,
dat_kampagne_von, dat_kampagne_bis, kampagne_rhythmus_typ_id, kampagne_version_nr, anzahl_loyalty_kunden) AS SELECT V01
 .mandant_id,
 V01.kampagne_id,
 V01.kampagne_name,
 V01.dat_kampagne_von,
 V01.dat_kampagne_bis,
 V01.kampagne_rhythmus_typ_id,
 V01.kampagne_version_nr,
 COUNT(DISTINCT V02.crm_kunde_id) AS anzahl_loyalty_kunden
FROM kfl_production_dbp_view.v_kampagne_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_crm_l_kunde_2 AS V02 ON V01.mandant_id = V02.kunde_mandant_id
WHERE DATE(V02.zeit_registrierung) <= V01.dat_kampagne_von
GROUP BY V01.mandant_id,
 V01.kampagne_id,
 V01.kampagne_name,
 V01.dat_kampagne_von,
 V01.dat_kampagne_bis,
 V01.kampagne_rhythmus_typ_id,
 V01.kampagne_version_nr;