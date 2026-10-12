CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_kjmo_spr_zu_2 (kjmo, mo_bez_lang) AS SELECT V01.kjmo,
   TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_2 AS V02 ON V01.mo_kj = V02.mo_id AND V02.spr_id = 22;