CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_f_gutschein_2 (crm_gutschein_id, crm_vorgang_id,
crm_gutschein_grund_id, gutschein_nummer, kostenstelle_id, mandant_id, gutschein_wert, dat_start, dat_ende,
dat_start_processing, dat_end_processing, sec_kz) AS SELECT V01.crm_gutschein_id,
 V01.crm_vorgang_id,
 V01.crm_gutschein_grund_id,
 V01.gutschein_nummer,
 V01.kostenstelle_id,
 V01.mandant_id,
 V01.gutschein_wert,
 DATE(V02.dat_start) AS dat_start,
 DATE(V02.dat_ende) AS dat_ende,
 DATE(V02.dat_start_processing) AS dat_start_processing,
 DATE(V02.dat_end_processing) AS dat_end_processing,
 3 AS sec_kz
FROM kfl_production_dbp_view.v_crm_gutschein_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_crm_vorgang_2 AS V02 ON V01.crm_vorgang_id = V02.crm_vorgang_id
WHERE CAST(V01.gutschein_nummer AS FLOAT64) <> - 1;