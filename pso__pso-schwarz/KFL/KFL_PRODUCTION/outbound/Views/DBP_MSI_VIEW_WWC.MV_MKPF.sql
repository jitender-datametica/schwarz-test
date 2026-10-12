CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_mkpf (mandant_id, mblnr, mblnr_num, mjahr, vgart, budat, usnam
, xblnr, bldat, cpudt, cpudt_cputm, cpudt_cputm_str, blart, bktxt, xabln, tcode2) AS SELECT mandant_id,
 TRIM(CAST(lagerbew_beleg_id AS STRING FORMAT '0000000000')) AS mblnr,
 lagerbew_beleg_id AS mblnr_num,
 kj AS mjahr,
 vorgangsart_id AS vgart,
 dat_buch AS budat,
 beleg_user_name AS usnam,
 ref_lagerbew_beleg_id AS xblnr,
 dat_beleg AS bldat,
 dat_erfasst AS cpudt,
 DATETIME(dat_erfasst, zeit_erfasst) AS cpudt_cputm,
   SUBSTR(CAST(dat_erfasst AS STRING), 1, 11) || ' ' || SUBSTR(CAST(zeit_erfasst AS STRING), 1, 8) AS cpudt_cputm_str,
 belegart_id AS blart,
 belegkopftext AS bktxt,
 waren_begl_schein_id AS xabln,
 transaktion_code AS tcode2
FROM kfl_production_dbp_view.v_lagerbew AS V01;