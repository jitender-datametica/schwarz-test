CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_ist_summenge_1 AS SELECT mandant_id,
 flw_werk_id,
 flw_arbeitsplatz_id,
 schicht_id,
 mes_prodmengetyp_id,
 dat_prod,
 ist_menge,
 ist_einh,
 datzeit_aenderung
FROM kfl_production_dbp_data.flw_mes_ist_summenge_1;