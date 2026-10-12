CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_kundenbarometer_1 (geku_ticket_id_kundenbarometer, dat,
wup_id, nb_id, mandant_id) AS SELECT geku_ticket_id_kundenbarometer,
 dat,
 wup_id,
 nb_id,
 mandant_id_wup AS mandant_id
FROM kfl_production_dbp_view.v_geku_kundenbarometer_1;