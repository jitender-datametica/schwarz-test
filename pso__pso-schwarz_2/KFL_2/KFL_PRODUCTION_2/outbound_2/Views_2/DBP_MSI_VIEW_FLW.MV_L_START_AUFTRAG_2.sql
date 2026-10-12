CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_start_auftrag_2 (mandant_id, auftrag_id, auftragsart_id,
dat_start) AS SELECT V01.mandant_id,
 V01.auftrag_id,
 V01.auftragsart_id,
 V02.dat_start
FROM kfl_production_dbp_view.v_flw_auftrag_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_auftrag_pps_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.auftrag_id = V02
   .auftrag_id;