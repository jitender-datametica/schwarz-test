CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_lin_datenfreigabe_2 (mandant_id, kjmo, vertrieb_fg, user_id,
zeitstempel, lin_freigabe_fg) AS SELECT mandant_id,
 kjmo,
 vertrieb_fg,
 user_id,
 zeitstempel,
 lin_freigabe_fg
FROM kfl_production_dbp_msi_data.lin_datenfreigabe_2;