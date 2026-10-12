CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_verteilung_laender_2 AS SELECT it_plan_ebene_id,
 it_projekt_id,
 berichts_position_it_id,
 gj,
 verteilung_betrag,
 verteilung_quote
FROM kfl_production_dbp_data.it_projekt_verteilung_laender_2;