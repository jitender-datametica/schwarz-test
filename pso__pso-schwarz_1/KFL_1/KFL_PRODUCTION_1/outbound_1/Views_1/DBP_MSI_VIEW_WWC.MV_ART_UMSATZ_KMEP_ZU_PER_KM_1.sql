CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_umsatz_kmep_zu_per_km_1 (mandant_id, nb_id, art_id,
zeitraum_kz, dat_von, dat_bis, betrag_kmep, betrag_kmep_einh, betrag_kmep_einh_o_fwu, betrag_kmep_einh_abschrift, kjmo)
AS SELECT V01.mandant_id,
 0 AS nb_id,
 V01.art_id,
 V01.zeitraum_kz,
 V01.dat_von,
 V01.dat_bis,
 V01.betrag_kmep,
 V01.betrag_kmep_einh,
 V01.betrag_kmep_einh_o_fwu,
 V01.betrag_kmep_einh_abschrift,
 V02.kjmo
FROM kfl_production_dbp_view.v_art_umsatz_kmep_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat_von = V02.dat
WHERE V01.zeitraum_kz = 'KM';