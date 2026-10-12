CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_wupcal_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 offen,
 offen_von,
 offen_bis,
 offen_theke_von,
 offen_theke_bis,
 ssm_umsatz_faktor
FROM kfl_production_dbp_view.v_wupcal_1 AS T1_1
WHERE nb_id = 0
UNION DISTINCT
SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 offen,
 offen_von,
 offen_bis,
 offen_theke_von,
 offen_theke_bis,
 ssm_umsatz_faktor
FROM kfl_production_dbp_view.v_wupcal_zukunft_1 AS T2
WHERE nb_id = 0;