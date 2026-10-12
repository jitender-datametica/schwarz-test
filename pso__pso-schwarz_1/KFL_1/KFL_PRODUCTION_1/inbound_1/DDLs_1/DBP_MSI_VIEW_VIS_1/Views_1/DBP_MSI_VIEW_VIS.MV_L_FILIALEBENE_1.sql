CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_FILIALEBENE_1 as

   SELECT DISTINCT 1 AS filialebene_id, 'Offensiv < -20.1%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 2 AS filialebene_id, 'Offensiv -20 bis -10.1%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 3 AS filialebene_id, 'Offensiv -10 bis -5.1%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 4 AS filialebene_id, 'Neutral -5 bis -2.6%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 5 AS filialebene_id, 'Neutral -2.5 bis -1.1%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 6 AS filialebene_id, 'Neutral -1 bis +1%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 7 AS filialebene_id, 'Neutral +1.1 bis +2.5%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 8 AS filialebene_id, 'Defensiv +2.6 bis +5%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 9 AS filialebene_id, 'Defensiv +5.1 bis +10%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 10 AS filialebene_id, 'Defensiv +10.1 bis +20%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT 11 AS filialebene_id, 'Defensiv > +20.1%'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1
   UNION ALL
   SELECT DISTINCT -1 AS filialebene_id,  'N/A'::VARCHAR(80) AS filialebene FROM dbp_view.v_mandant_1;