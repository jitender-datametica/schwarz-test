CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_mkpf_neu_1 AS SELECT V01.mandant_id,
 TRIM(CAST(V01.lagerbew_beleg_id AS STRING FORMAT '0000000000')) AS mblnr,
 CAST(V01.lagerbew_beleg_id AS STRING) AS v01_lagerbew_beleg_id,
 V01.kj AS mjahr,
 V01.vorgangsart_id AS vgart,
 V01.dat_buch AS budat,
 V01.beleg_user_name AS usnam,
 V01.ref_lagerbew_beleg_id AS xblnr,
 V01.dat_beleg AS bldat,
 V01.dat_erfasst AS cpudt,
 CAST(REPLACE(FORMAT_DATE('%F', V01.dat_erfasst) || CASE
     WHEN V01.zeit_erfasst IS NULL
     THEN '00:00:00'
     ELSE FORMAT_TIME('00:00:00', V01.zeit_erfasst)
     END, ',', ':') AS DATETIME) AS cpudt_cputm,
 CAST(REPLACE(FORMAT_DATE('%F', V01.dat_erfasst) || CASE
     WHEN V01.zeit_erfasst IS NULL
     THEN '00:00:00'
     ELSE FORMAT_TIME('00:00:00', V01.zeit_erfasst)
     END, ',', ':') AS DATETIME) AS cpudt_cputm_str,
 V01.belegart_id AS blart,
 V01.belegkopftext AS bktxt,
 V01.waren_begl_schein_id AS xabln,
 V01.transaktion_code AS tcode2,
 0 AS akt_fg
FROM kfl_production_dbp_view.v_lagerbew_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_lagerbew_delta_1 AS B ON V01.mandant_id = B.mandant_id AND V01.lagerbew_beleg_id = B
     .lagerbew_beleg_id AND V01.kj = B.kj AND V01.dat_buch = B.dat_buch
WHERE B.mandant_id IS NULL
UNION ALL
SELECT mandant_id,
 TRIM(CAST(lagerbew_beleg_id AS STRING FORMAT '0000000000')) AS mblnr,
 CAST(lagerbew_beleg_id AS STRING) AS dm__operand2,
 kj AS mjahr,
 vorgangsart_id AS vgart,
 dat_buch AS budat,
 beleg_user_name AS usnam,
 ref_lagerbew_beleg_id AS xblnr,
 dat_beleg AS bldat,
 dat_erfasst AS cpudt,
 CAST(REPLACE(FORMAT_DATE('%F', dat_erfasst) || CASE
     WHEN zeit_erfasst IS NULL
     THEN '00:00:00'
     ELSE FORMAT_TIME('00:00:00', zeit_erfasst)
     END, ',', ':') AS DATETIME) AS cpudt_cputm,
 CAST(REPLACE(FORMAT_DATE('%F', dat_erfasst) || CASE
     WHEN zeit_erfasst IS NULL
     THEN '00:00:00'
     ELSE FORMAT_TIME('00:00:00', zeit_erfasst)
     END, ',', ':') AS DATETIME) AS cpudt_cputm_str,
 belegart_id AS blart,
 belegkopftext AS bktxt,
 waren_begl_schein_id AS xabln,
 transaktion_code AS tcode2,
 1 AS akt_fg
FROM kfl_production_dbp_view.v_lagerbew_delta_1;