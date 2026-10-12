CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_zeitfenster_2 AS SELECT mandant_id,
 zeitfenster_id,
 zeit_von,
 zeit_bis,
 report_zeit_von,
 report_zeit_bis
FROM kfl_production_dbp_view.v_l_zeitfenster_2;