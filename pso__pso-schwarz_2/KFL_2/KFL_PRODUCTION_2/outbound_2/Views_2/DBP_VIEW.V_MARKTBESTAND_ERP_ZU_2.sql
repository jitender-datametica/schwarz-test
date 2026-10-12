CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktbestand_erp_zu_2 AS SELECT mandant_id,
 bestand_id,
 ek_netto,
 ek_netto_bnk,
 vk_netto,
 wrg_id,
 ek_nettonetto,
 einstandspreis
FROM kfl_production_dbp_data.marktbestand_erp_zu_2;