-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_MANDANT source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_mandant AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sap_id,
 default_wrg,
 mandant_sort_id,
  CASE
  WHEN mandant_id = 1
  THEN 'DE'
  WHEN mandant_id = 2
  THEN 'CZ'
  WHEN mandant_id = 3
  THEN 'PL'
  WHEN mandant_id = 4
  THEN 'MD'
  WHEN mandant_id = 5
  THEN 'SK'
  WHEN mandant_id = 6
  THEN 'HR'
  WHEN mandant_id = 7
  THEN 'RO'
  WHEN mandant_id = 8
  THEN 'BG'
  ELSE NULL
  END AS iso_country_code,
  CASE
  WHEN mandant_id = 1
  THEN 'Germany'
  WHEN mandant_id = 2
  THEN 'Czech Republic'
  WHEN mandant_id = 3
  THEN 'Poland'
  WHEN mandant_id = 4
  THEN 'Moldova, Republic of'
  WHEN mandant_id = 5
  THEN 'Slovakia'
  WHEN mandant_id = 6
  THEN 'Croatia'
  WHEN mandant_id = 7
  THEN 'Romania'
  WHEN mandant_id = 8
  THEN 'Bulgaria'
  ELSE NULL
  END AS iso_country_name
FROM kfl_production_dbp_view.v_mandant;