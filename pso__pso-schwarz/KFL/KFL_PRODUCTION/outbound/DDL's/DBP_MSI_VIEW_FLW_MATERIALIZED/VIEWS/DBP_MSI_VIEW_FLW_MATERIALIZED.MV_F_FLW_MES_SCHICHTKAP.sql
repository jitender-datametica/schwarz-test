CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_mes_schichtkap (mandant_id, schicht_id,
dat_schicht, werk_id, kapa_dauer, kapa_einh) AS SELECT V01.mandant_id,
 V01.schicht_id,
 V01.dat_schicht,
 V02.flw_werk_id AS werk_id,
 V01.kapa_dauer,
 V01.kapa_einh
FROM kfl_production_dbp_view.v_flw_mes_schichtkap AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_mes_schicht AS V02 ON V01.mandant_id = V02.mandant_id AND V01.schicht_id = V02
   .schicht_id;