CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_monat_spr_zu_1 AS SELECT V01.mo_id,
 CAST(V01.mo_bez AS STRING) AS mo_bez,
 V02.kjmo,
 V02.kj,
   TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39)) AS mo_bez_lang,
 V01.spr_id
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V02 ON V01.mo_id = V02.mo_kj;