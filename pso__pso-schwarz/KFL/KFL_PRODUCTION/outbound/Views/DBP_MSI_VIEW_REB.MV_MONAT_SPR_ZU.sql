CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_monat_spr_zu (mo_gj, mo_kj, spr_id, mo_bez, kjmo, kj, gj, gjmo
, mo_bez_lang) AS SELECT V02.mo_gj,
 V01.mo_id AS mo_kj,
 V01.spr_id,
 V01.mo_bez,
 V02.kjmo,
 V02.kj,
 V02.gj,
 V02.gjmo,
   TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON V01.mo_id = V02.mo_kj
WHERE V01.spr_id = 22;