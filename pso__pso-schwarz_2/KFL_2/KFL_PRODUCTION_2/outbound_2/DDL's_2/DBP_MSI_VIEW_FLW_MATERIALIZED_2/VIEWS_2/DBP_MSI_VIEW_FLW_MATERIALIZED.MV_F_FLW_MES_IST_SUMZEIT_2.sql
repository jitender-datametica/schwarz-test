CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_mes_ist_sumzeit_2 (mandant_id, werk_id,
flw_arbeitsplatz_id, schicht_id, mes_prodzeittyp_id, dat_ist_prod, ist_prod_dauer) AS SELECT mandant_id,
 flw_werk_id AS werk_id,
 flw_arbeitsplatz_id,
 schicht_id,
 mes_prodzeittyp_id,
 dat_ist_prod,
 ist_prod_dauer
FROM kfl_production_dbp_view.v_flw_mes_ist_sumzeit_2;