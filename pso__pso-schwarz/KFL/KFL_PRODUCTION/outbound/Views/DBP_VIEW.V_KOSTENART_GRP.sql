CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kostenart_grp AS SELECT kostenart_grp_id,
 system_id,
 kostenart_grp_mutter_id,
 kostenart_grp_id_kons,
 kl_kostenart_grp_id,
 ebene_id,
 ebene_pos_id
FROM kfl_production_dbp_data.kostenart_grp;