CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_soll_sumzeit_2 AS SELECT mandant_id,
 flw_werk_id,
 flw_arbeitsplatz_id,
 schicht_id,
 mes_prodzeittyp_id,
 dat_soll_prod,
 planungs_dauer,
 planungs_einh,
 datzeit_aenderung
FROM kfl_production_dbp_data.flw_mes_soll_sumzeit_2;