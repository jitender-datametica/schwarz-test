CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_verrechfall_kostenart_1 (mandant_id, verrechfall_kostenart_id,
verrechnungsart_id) AS ((((SELECT mandant_id,
     verrechfall_kostenart_id,
     verrechnungsart_id
    FROM kfl_production_dbp_view.v_l_verrechfall_kostenart_1
    UNION DISTINCT
    SELECT mandant_id,
     'MDIES',
     'M'
    FROM kfl_production_dbp_view.v_mandant_1)
   UNION DISTINCT
   SELECT mandant_id,
    'MSTRO',
    'M'
   FROM kfl_production_dbp_view.v_mandant_1)
  UNION DISTINCT
  SELECT mandant_id,
   'MGAS',
   'M'
  FROM kfl_production_dbp_view.v_mandant_1)
 UNION DISTINCT
 SELECT mandant_id,
  'MMAUT',
  'M'
 FROM kfl_production_dbp_view.v_mandant_1)
UNION DISTINCT
SELECT mandant_id,
 'MKUEH',
 'M'
FROM kfl_production_dbp_view.v_mandant_1;