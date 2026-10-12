CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_monat_spr_zu_sk (mo_kj, mo_bez, kjmo, kj, mo_bez_lang) AS
SELECT V01.mo_id AS mo_kj,
 CAST(V01.mo_bez AS STRING) AS mo_bez,
 V02.kjmo,
 V02.kj,
   TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON V01.mo_id = V02.mo_kj
WHERE V02.kjmo >= 201001
 AND V01.spr_id = 108;