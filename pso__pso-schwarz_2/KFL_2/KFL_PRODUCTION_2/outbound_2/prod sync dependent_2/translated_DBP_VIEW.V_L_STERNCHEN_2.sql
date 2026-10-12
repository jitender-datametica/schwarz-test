CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sternchen_2 (list_durchg_fg, bezugsweg1_fg, bezugsweg4_fg, kdis0_fg,
kdis1_fg, mandant_id, sternchen_id) AS SELECT list_durchg_fg,
 bezugsweg1_fg,
 bezugsweg4_fg,
 kdis0_fg,
 kdis1_fg,
 mandant_id,
 sternchen_id
FROM kfl_production_dbp_data.l_sternchen_2;