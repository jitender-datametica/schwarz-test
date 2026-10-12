CREATE OR REPLACE VIEW kfl_production_dbp_view.v_eps_druck_statistik_per_1 AS SELECT mandant_id,
 eps_druck_statistik_id,
 wup_id,
 nb_id,
 kl_art_id,
 druck_anlass_id,
 datzeit_anforderung,
 datzeit_druck,
 containertyp_id,
 layout_groesse_id,
 papierart_id
FROM kfl_production_dbp_data.eps_druck_statistik_per_1;