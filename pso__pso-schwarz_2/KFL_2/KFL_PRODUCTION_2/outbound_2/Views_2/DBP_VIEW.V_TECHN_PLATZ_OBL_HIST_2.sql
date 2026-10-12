CREATE OR REPLACE VIEW kfl_production_dbp_view.v_techn_platz_obl_hist_2 AS SELECT techn_platz_id,
 mandant_id,
 tech_platz_bez,
 tp_vl_name,
 tp_vkl_name,
 tp_ol_vermietung,
 tp_bl_kbl_name,
 tp_betreuer_kbl_name,
 tp_bl_projekt_name,
 tp_pl_kbl,
 dat_extrakt
FROM kfl_production_dbp_data.techn_platz_obl_hist_2;