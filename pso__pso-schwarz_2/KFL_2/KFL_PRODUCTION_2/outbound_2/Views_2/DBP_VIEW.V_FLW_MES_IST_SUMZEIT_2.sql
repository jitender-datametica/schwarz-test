CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_ist_sumzeit_2 AS SELECT mandant_id,
 flw_werk_id,
 flw_arbeitsplatz_id,
 schicht_id,
 mes_prodmengetyp_gruppe,
 mes_prodzeittyp_id,
 dat_ist_prod,
 ist_prod_dauer,
 ist_prod_einh,
 datzeit_aenderung
FROM kfl_production_dbp_data.flw_mes_ist_sumzeit_2;