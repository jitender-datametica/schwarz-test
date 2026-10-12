CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_mes_soll_sumzeit_1 (mandant_id, werk_id,
flw_arbeitsplatz_id, schicht_id, mes_prodzeittyp_id, dat_soll_prod, planungs_dauer, planungs_einh) AS SELECT mandant_id
 ,
 flw_werk_id AS werk_id,
 flw_arbeitsplatz_id,
 schicht_id,
 mes_prodzeittyp_id,
 dat_soll_prod,
 planungs_dauer,
 planungs_einh
FROM kfl_production_dbp_view.v_flw_mes_soll_sumzeit_1;