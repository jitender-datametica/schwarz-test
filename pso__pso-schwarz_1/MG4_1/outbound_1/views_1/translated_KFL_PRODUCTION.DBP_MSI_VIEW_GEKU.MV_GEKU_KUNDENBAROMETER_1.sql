-- 31.08.2017 twie: SPEC0025359 mandant_id_wup als mandant_id, es gibt nur noch ein Landattr. in KMR

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_kundenbarometer_1 (geku_ticket_id_kundenbarometer, dat, wup_id, nb_id,
mandant_id) AS SELECT geku_ticket_id_kundenbarometer,
 dat,
 wup_id,
 nb_id,
 mandant_id_wup AS mandant_id
FROM kfl_production_dbp_view.v_geku_kundenbarometer_1;