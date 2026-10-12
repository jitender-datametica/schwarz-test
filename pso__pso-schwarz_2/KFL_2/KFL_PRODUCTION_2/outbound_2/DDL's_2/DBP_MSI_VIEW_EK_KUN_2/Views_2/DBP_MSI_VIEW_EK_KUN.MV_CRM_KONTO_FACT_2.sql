CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_konto_fact_2 (crm_konto_id, crm_kunde_id,
crm_konto_typ_id, crm_kundenprogramm_id, zeit_von, zeit_bis, dat_bis, geloescht_fg_konto, dat) AS SELECT V01.crm_konto_id
 ,
 V01.crm_kunde_id,
 V01.crm_konto_typ_id,
 V01.crm_kundenprogramm_id,
 V01.zeit_von,
 V01.zeit_bis,
 DATE(V01.zeit_bis) AS dat_bis,
 V01.geloescht_fg AS geloescht_fg_konto,
 V02.dat
FROM kfl_production_dbp_view.v_crm_l_konto_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON CAST(V02.dat AS DATETIME) BETWEEN V01.zeit_von AND V01.zeit_bis
WHERE V02.akt_tag <= 0;