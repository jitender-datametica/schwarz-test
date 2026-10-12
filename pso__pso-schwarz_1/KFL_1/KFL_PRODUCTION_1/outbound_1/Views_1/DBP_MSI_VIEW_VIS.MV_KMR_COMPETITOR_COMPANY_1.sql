CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_competitor_company_1 (mandant_id, competitor_fg, system_name
, competitor_company_id, competitor_company_code, competitor_company_name, competitor_sort_id) AS SELECT mandant_id,
 competitor_fg,
 ext_system_name AS system_name,
 ext_retail_company_id AS competitor_company_id,
 retail_company_code AS competitor_company_code,
 retail_company_name AS competitor_company_name,
  CASE
  WHEN mandant_id = 1
  THEN CASE
   WHEN ext_retail_company_id = 7
   THEN 10
   WHEN ext_retail_company_id IN (17, 232, 233, 237, 239, 240, 241, 315)
   THEN 20
   WHEN ext_retail_company_id = 229
   THEN 30
   WHEN ext_retail_company_id = 228
   THEN 40
   WHEN ext_retail_company_id = 16
   THEN 50
   WHEN ext_retail_company_id = 111
   THEN 60
   ELSE 999
   END
  WHEN mandant_id = 2
  THEN CASE
   WHEN ext_retail_company_id = 77
   THEN 10
   WHEN ext_retail_company_id = 222
   THEN 20
   WHEN ext_retail_company_id = 101
   THEN 30
   WHEN ext_retail_company_id = 102
   THEN 40
   WHEN ext_retail_company_id = 106
   THEN 50
   WHEN ext_retail_company_id = 110
   THEN 60
   WHEN ext_retail_company_id IN (98, 246)
   THEN 70
   ELSE 999
   END
  WHEN mandant_id = 3
  THEN CASE
   WHEN ext_retail_company_id = 51
   THEN 10
   WHEN ext_retail_company_id = 117
   THEN 20
   WHEN ext_retail_company_id = 96
   THEN 30
   WHEN ext_retail_company_id IN (94, 219, 442)
   THEN 40
   WHEN ext_retail_company_id = 100
   THEN 50
   WHEN ext_retail_company_id = 63
   THEN 60
   WHEN ext_retail_company_id = 190
   THEN 70
   WHEN ext_retail_company_id = 220
   THEN 80
   ELSE 999
   END
  WHEN mandant_id = 4
  THEN CASE
   WHEN ext_retail_company_id = 238
   THEN 10
   WHEN ext_retail_company_id = 242
   THEN 20
   WHEN ext_retail_company_id = 236
   THEN 30
   WHEN ext_retail_company_id = 243
   THEN 40
   WHEN ext_retail_company_id = 234
   THEN 50
   WHEN ext_retail_company_id = 235
   THEN 60
   WHEN ext_retail_company_id = 248
   THEN 70
   ELSE 999
   END
  WHEN mandant_id = 5
  THEN CASE
   WHEN ext_retail_company_id = 80
   THEN 10
   WHEN ext_retail_company_id IN (99, 443, 484)
   THEN 20
   WHEN ext_retail_company_id = 104
   THEN 30
   WHEN ext_retail_company_id = 107
   THEN 40
   WHEN ext_retail_company_id = 119
   THEN 50
   WHEN ext_retail_company_id = 247
   THEN 60
   ELSE 999
   END
  WHEN mandant_id = 6
  THEN CASE
   WHEN ext_retail_company_id = 76
   THEN 10
   WHEN ext_retail_company_id = 83
   THEN 20
   WHEN ext_retail_company_id = 115
   THEN 30
   WHEN ext_retail_company_id = 122
   THEN 40
   WHEN ext_retail_company_id = 112
   THEN 50
   WHEN ext_retail_company_id = 121
   THEN 60
   WHEN ext_retail_company_id = 194
   THEN 70
   ELSE 999
   END
  WHEN mandant_id = 7
  THEN CASE
   WHEN ext_retail_company_id = 79
   THEN 10
   WHEN ext_retail_company_id IN (95, 440, 441, 445)
   THEN 20
   WHEN ext_retail_company_id = 116
   THEN 30
   WHEN ext_retail_company_id = 86
   THEN 40
   WHEN ext_retail_company_id = 97
   THEN 50
   WHEN ext_retail_company_id = 114
   THEN 60
   ELSE 999
   END
  WHEN mandant_id = 8
  THEN CASE
   WHEN ext_retail_company_id = 75
   THEN 10
   WHEN ext_retail_company_id = 105
   THEN 20
   WHEN ext_retail_company_id = 118
   THEN 30
   WHEN ext_retail_company_id = 245
   THEN 40
   WHEN ext_retail_company_id = 108
   THEN 50
   WHEN ext_retail_company_id = 113
   THEN 60
   WHEN ext_retail_company_id = 244
   THEN 70
   ELSE 999
   END
  ELSE 0
  END AS competitor_sort_id
FROM kfl_production_dbp_view.v_retail_company_1 AS RCO
WHERE competitor_fg = 1;