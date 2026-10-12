CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.gjmo_spr_zu_bg_2 AS SELECT V01.gjmo,
   TRIM(V02.mo_bez) || ' GJ ' || SUBSTR(CAST(V01.gj AS STRING), 1, 4) AS gjmo_bez
FROM kfl_production_dbp_view.v_monat_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_2 AS V02 ON V01.mo_kj = V02.mo_id
WHERE V02.spr_id = 18;