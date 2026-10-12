-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_MANDANT_1 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_MANDANT_1
AS
SELECT
mandant_id
,mandant_bez
,mandant_kbez
,mandant_sap_id
,default_wrg
,mandant_sort_id
,CASE WHEN mandant_id = 1 THEN 'DE' 
      WHEN mandant_id = 2 THEN 'CZ'
      WHEN mandant_id = 3 THEN 'PL'
      WHEN mandant_id = 4 THEN 'MD'
      WHEN mandant_id = 5 THEN 'SK'
      WHEN mandant_id = 6 THEN 'HR'
      WHEN mandant_id = 7 THEN 'RO'
      WHEN mandant_id = 8 THEN 'BG'
      END
 AS iso_country_code
,CASE WHEN mandant_id = 1 THEN CAST('Germany' AS VARCHAR(20))
      WHEN mandant_id = 2 THEN CAST('Czech Republic' AS VARCHAR(20))
      WHEN mandant_id = 3 THEN CAST('Poland' AS VARCHAR(20))
      WHEN mandant_id = 4 THEN CAST('Moldova, Republic of' AS VARCHAR(20))
      WHEN mandant_id = 5 THEN CAST('Slovakia' AS VARCHAR(20))
      WHEN mandant_id = 6 THEN CAST('Croatia' AS VARCHAR(20))
      WHEN mandant_id = 7 THEN CAST('Romania' AS VARCHAR(20))
      WHEN mandant_id = 8 THEN CAST('Bulgaria' AS VARCHAR(20))
      END
   AS iso_country_name
FROM dbp_view.v_mandant_1
;