CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_lagerauslastung_add (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_ctry
OPTIONS(description='Country code. Original field name bic_zmlila'), wh_id
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
strg_bin OPTIONS(description='Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'), strg_type
OPTIONS(description='Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'), strg_type_desc, area, areaid
, strg_sec OPTIONS(description='Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'), bin_cnt,
strg_bin_type OPTIONS(description='Storage bin type'), bin_acs_type OPTIONS(description='Bin access type'),
is_strg_bin_empty_flg
OPTIONS(description='Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER'),
is_strg_bin_full_flg OPTIONS(description='Full Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER'),
strg_bin_aisle OPTIONS(description='Storage bin aisle'), strg_bin_stack OPTIONS(description='Storage bin stack'),
strg_bin_level OPTIONS(description='Storage bin level'), is_strg_bin_fixed_flg
OPTIONS(description='Fixed Storage Bin Type'), tot_capa
OPTIONS(description='Total Capacity Key Figure - Technical name: G_CAPA - Component Type: /SCWM/DE_GCAPA'), rem_capa
OPTIONS(description='Net Capacity Key Figure'), epe_capa
OPTIONS(description='Total Capacity in EuroPallet Equivalent, rounded down'), avl_capa
OPTIONS(description='Net Capacity in EuroPallet Equivalent, rounded down'), used_capa
OPTIONS(description='Total-Net Capacity in EuroPallet Equivalent, rounded down'), empty_bin
OPTIONS(description='Empty bins'), total_bin OPTIONS(description='Total bins'), occupied_bin
OPTIONS(description='Occupied bins'), bin_rem OPTIONS(description='Remaining bins - calculations adjusted for AHR'),
bin_ges OPTIONS(description='Total bins - calculations adjusted for AHR'), bin_used
OPTIONS(description='Occupied bins - calculations adjusted for AHR'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted')) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 wh_id,
 lgpla AS strg_bin,
 lgtyp AS strg_type,
  CASE
  WHEN lgtyp = '0101'
  THEN 'HR Ambient Reserve'
  WHEN lgtyp = '0111'
  THEN 'HR Hazardous Ambient Reserve'
  WHEN lgtyp = '0121'
  THEN 'HR Chilled Ambient Reserve'
  WHEN lgtyp = '0131'
  THEN 'HR Ambient Reserve'
  WHEN lgtyp = '0143'
  THEN 'Buffer for Reorg Tunnel'
  WHEN lgtyp = '0205'
  THEN 'Ambient Roll Rack Reserve'
  WHEN lgtyp = '0251'
  THEN 'Bulk Reserve'
  WHEN lgtyp = '0301'
  THEN 'HR NF/Food Promo Reserve'
  WHEN lgtyp = '0307'
  THEN 'NF Pushback Reserve'
  WHEN lgtyp = '0501'
  THEN 'HR Chiller Reserve'
  WHEN lgtyp = '0601'
  THEN 'MPF Catch Weight Reserve'
  WHEN lgtyp = '0602'
  THEN 'MPF Non CW Reserve'
  WHEN lgtyp = '0701'
  THEN 'HR Freezer Reserve'
  WHEN lgtyp = '0707'
  THEN 'HR Freezer Pushback Reserve'
  WHEN lgtyp = '0711'
  THEN 'HR Bake Off Reserve'
  WHEN lgtyp = '0715'
  THEN 'HR Bake Off Roll Rack Reserve'
  WHEN lgtyp = '7000'
  THEN 'HR Returned Products'
  WHEN lgtyp = '8141'
  THEN 'AHR Ambient Reserve'
  WHEN lgtyp = '8143'
  THEN 'AHR Ambient Emergency Exit -Loops Defect'
  WHEN lgtyp = '8180'
  THEN 'AHR Ambient Conveyor System'
  WHEN lgtyp = 'EX01'
  THEN 'Ext. WH 1'
  WHEN lgtyp = 'EX02'
  THEN 'Ext. WH 2'
  WHEN lgtyp = 'EX03'
  THEN 'Ext. WH 3'
  ELSE 'Unassigned'
  END AS strg_type_desc,
  CASE
  WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
  THEN 'Ambient'
  WHEN lgtyp = '0205' OR lgtyp = '0251'
  THEN 'Bulk'
  WHEN lgtyp = '0301' OR lgtyp = '0307'
  THEN 'NF'
  WHEN lgtyp = '0501'
  THEN 'Chiller'
  WHEN lgtyp = '0601' OR lgtyp = '0602'
  THEN 'MPF'
  WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
  THEN 'Freezer'
  WHEN lgtyp = '7000'
  THEN 'NF-Return'
  WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
  THEN 'AHR'
  WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
  THEN 'ExWH'
  ELSE 'Unassigned'
  END AS area,
  CASE
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'AHR'
  THEN '8'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Ambient'
  THEN '1'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'NF'
  THEN '3'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Returns'
  THEN '9'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Bulk'
  THEN '2'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'F&V'
  THEN '4'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Chiller'
  THEN '5'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'MPF'
  THEN '6'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Freezer'
  THEN '7'
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143'
    THEN 'Ambient'
    WHEN lgtyp = '0205' OR lgtyp = '0251'
    THEN 'Bulk'
    WHEN lgtyp = '0301' OR lgtyp = '0307'
    THEN 'NF'
    WHEN lgtyp = '0501'
    THEN 'Chiller'
    WHEN lgtyp = '0601' OR lgtyp = '0602'
    THEN 'MPF'
    WHEN lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715'
    THEN 'Freezer'
    WHEN lgtyp = '7000'
    THEN 'NF-Return'
    WHEN lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'ExWH'
  THEN '10'
  ELSE '-999'
  END AS areaid,
 lgber AS strg_sec,
 COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS bin_cnt,
 lptyp AS strg_bin_type,
 bin_at AS bin_acs_type,
 kzler AS is_strg_bin_empty_flg,
 kzvol AS is_strg_bin_full_flg,
 aisle AS strg_bin_aisle,
 stack AS strg_bin_stack,
 lvl_v AS strg_bin_level,
 fixbintyp AS is_strg_bin_fixed_flg,
 max_capa AS tot_capa,
 fcapa AS rem_capa,
 CAST(FLOOR(max_capa / 10000000) AS INTEGER) AS epe_capa,
 CAST(FLOOR(fcapa / 10000000) AS INTEGER) AS avl_capa,
  CAST(FLOOR(max_capa / 10000000) AS INTEGER) - CAST(FLOOR(fcapa / 10000000) AS INTEGER) AS used_capa,
 rem_bin_depth AS empty_bin,
 max_bin_depth AS total_bin,
  max_bin_depth - rem_bin_depth AS occupied_bin,
  CASE
  WHEN lgtyp IN ('8141', '8143', '8180')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   rem_bin_depth
  ELSE CAST((COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * IF(kzler, 1, 0) AS BIGNUMERIC)
  END AS bin_rem,
  CASE
  WHEN lgtyp IN ('8141', '8143', '8180')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   max_bin_depth
  ELSE CAST(COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS BIGNUMERIC)
  END AS bin_ges,
  CASE
  WHEN lgtyp IN ('8141', '8143', '8180')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * (max_bin_depth
      - rem_bin_depth)
  ELSE (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - CASE
    WHEN lgtyp IN ('8141', '8143', '8180')
    THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
     rem_bin_depth
    ELSE CAST((COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * IF(kzler, 1, 0) AS BIGNUMERIC)
    END
  END AS bin_used,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_sapewm_storagebin
WHERE lgtyp IN ('0101', '0111', '0121', '0131', '0143', '0205', '0251', '0301', '0307', '0501', '0601', '0602', '0701',
   '0707', '0711', '0715', '7000', '8141', '8143', '8180', 'EX01', 'EX02', 'EX03')
 AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND lgpla NOT LIKE '%DUMMY%'
 AND NOT deleted_fg
UNION DISTINCT
SELECT client_id,
 lidl_country AS lidl_ctry,
 wh_id,
 lgpla AS strg_bin,
 lgtyp AS strg_type,
  CASE
  WHEN lgtyp = '0101'
  THEN 'HR Ambient Reserve'
  WHEN lgtyp = '0111'
  THEN 'HR Hazardous Ambient Reserve'
  WHEN lgtyp = '0121'
  THEN 'HR Chilled Ambient Reserve'
  WHEN lgtyp = '0131'
  THEN 'HR Ambient Reserve'
  WHEN lgtyp = '0143'
  THEN 'Buffer for Reorg Tunnel'
  WHEN lgtyp = '0205'
  THEN 'Ambient Roll Rack Reserve'
  WHEN lgtyp = '0251'
  THEN 'Bulk Reserve'
  WHEN lgtyp = '0301'
  THEN 'HR NF/Food Promo Reserve'
  WHEN lgtyp = '0307'
  THEN 'NF Pushback Reserve'
  WHEN lgtyp = '0501'
  THEN 'HR Chiller Reserve'
  WHEN lgtyp = '0601'
  THEN 'MPF Catch Weight Reserve'
  WHEN lgtyp = '0602'
  THEN 'MPF Non CW Reserve'
  WHEN lgtyp = '0701'
  THEN 'HR Freezer Reserve'
  WHEN lgtyp = '0707'
  THEN 'HR Freezer Pushback Reserve'
  WHEN lgtyp = '0711'
  THEN 'HR Bake Off Reserve'
  WHEN lgtyp = '0715'
  THEN 'HR Bake Off Roll Rack Reserve'
  WHEN lgtyp = '7000'
  THEN 'HR Returned Products'
  WHEN lgtyp = '8141'
  THEN 'AHR Ambient Reserve'
  WHEN lgtyp = '8143'
  THEN 'AHR Ambient Emergency Exit -Loops Defect'
  WHEN lgtyp = '8180'
  THEN 'AHR Ambient Conveyor System'
  WHEN lgtyp = 'EX01'
  THEN 'Ext. WH 1'
  WHEN lgtyp = 'EX02'
  THEN 'Ext. WH 2'
  WHEN lgtyp = 'EX03'
  THEN 'Ext. WH 3'
  ELSE 'Unassigned'
  END AS strg_type_desc,
  CASE
  WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143' OR lgtyp = '0205' OR lgtyp
                     = '0251' OR lgtyp = '0301' OR lgtyp = '0307' OR lgtyp = '0501' OR lgtyp = '0601' OR lgtyp = '0602'
             OR lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715' OR lgtyp = '7000' OR lgtyp = '8141'
          OR lgtyp = '8143' OR lgtyp = '8180' OR lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
  THEN 'Total'
  ELSE 'Unassigned'
  END AS area,
  CASE
  WHEN CASE
    WHEN lgtyp = '0101' OR lgtyp = '0111' OR lgtyp = '0121' OR lgtyp = '0131' OR lgtyp = '0143' OR lgtyp = '0205' OR
                      lgtyp = '0251' OR lgtyp = '0301' OR lgtyp = '0307' OR lgtyp = '0501' OR lgtyp = '0601' OR lgtyp =
                 '0602' OR lgtyp = '0701' OR lgtyp = '0707' OR lgtyp = '0711' OR lgtyp = '0715' OR lgtyp = '7000' OR
           lgtyp = '8141' OR lgtyp = '8143' OR lgtyp = '8180' OR lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'Total'
    ELSE 'Unassigned'
    END = 'Total'
  THEN '999'
  ELSE '-999'
  END AS areaid,
 lgber AS strg_sec,
 COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS bin_cnt,
 lptyp AS strg_bin_type,
 bin_at AS bin_acs_type,
 kzler AS is_strg_bin_empty_flg,
 kzvol AS is_strg_bin_full_flg,
 aisle AS strg_bin_aisle,
 stack AS strg_bin_stack,
 lvl_v AS strg_bin_level,
 fixbintyp AS is_strg_bin_fixed_flg,
 max_capa AS tot_capa,
 fcapa AS rem_capa,
 CAST(FLOOR(max_capa / 10000000) AS INTEGER) AS epe_capa,
 CAST(FLOOR(fcapa / 10000000) AS INTEGER) AS avl_capa,
  CAST(FLOOR(max_capa / 10000000) AS INTEGER) - CAST(FLOOR(fcapa / 10000000) AS INTEGER) AS used_capa,
 rem_bin_depth AS empty_bin,
 max_bin_depth AS total_bin,
  max_bin_depth - rem_bin_depth AS occupied_bin,
  CASE
  WHEN lgtyp IN ('8141', '8143', '8180')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   rem_bin_depth
  ELSE CAST((COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * IF(kzler, 1, 0) AS BIGNUMERIC)
  END AS bin_rem,
  CASE
  WHEN lgtyp IN ('8141', '8143', '8180')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   max_bin_depth
  ELSE CAST(COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS BIGNUMERIC)
  END AS bin_ges,
  CASE
  WHEN lgtyp IN ('8141', '8143', '8180')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * (max_bin_depth
      - rem_bin_depth)
  ELSE (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - CASE
    WHEN lgtyp IN ('8141', '8143', '8180')
    THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
     rem_bin_depth
    ELSE CAST((COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * IF(kzler, 1, 0) AS BIGNUMERIC)
    END
  END AS bin_used,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_sapewm_storagebin
WHERE lgtyp IN ('0101', '0111', '0121', '0131', '0143', '0205', '0251', '0301', '0307', '0501', '0601', '0602', '0701',
   '0707', '0711', '0715', '7000', '8141', '8143', '8180')
 AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND lgpla NOT LIKE '%DUMMY%'
 AND NOT deleted_fg;