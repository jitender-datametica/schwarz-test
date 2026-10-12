CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_mes_ist_summenge_2 (mandant_id, werk_id,
flw_arbeitsplatz_id, schicht_id, mes_prodmengetyp_id, dat_prod, ist_menge, ist_einh) AS SELECT mandant_id,
 flw_werk_id AS werk_id,
 flw_arbeitsplatz_id,
 schicht_id,
 mes_prodmengetyp_id,
 dat_prod,
 ist_menge,
 ist_einh
FROM kfl_production_dbp_view.v_flw_mes_ist_summenge_2;