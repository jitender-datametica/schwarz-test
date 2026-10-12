CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_umsatz_kmep_zu_per_kw (mandant_id, nb_id, art_id,
zeitraum_kz, dat_von, dat_bis, betrag_kmep, betrag_kmep_einh, betrag_kmep_einh_o_fwu, kjwo) AS SELECT V01.mandant_id,
 0 AS nb_id,
 V01.art_id,
 V01.zeitraum_kz,
 V01.dat_von,
 V01.dat_bis,
 V01.betrag_kmep,
 V01.betrag_kmep_einh,
 V01.betrag_kmep_einh_o_fwu,
 V02.kjwo
FROM kfl_production_dbp_view.v_art_umsatz_kmep_zu_per AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat_von = V02.dat
WHERE V01.zeitraum_kz = 'KW';