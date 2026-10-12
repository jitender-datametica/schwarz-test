CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_lagerauslastung_gz_add (client_id
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
  WHEN lgtyp = '0100'
  THEN 'HR Ambient Case Pick'
  WHEN lgtyp = '0106'
  THEN 'HR Ambient Flow Rack Case Pick'
  WHEN lgtyp = '0110'
  THEN 'HR Hazardous Ambient Case Pick'
  WHEN lgtyp = '0120'
  THEN 'HR Chilled Ambient Case Pick'
  WHEN lgtyp = '0126'
  THEN 'HR Chilled Ambient Flow Rack Case Pick'
  WHEN lgtyp = '0130'
  THEN 'HR High Value Ambient Case Pick'
  WHEN lgtyp = '0200'
  THEN 'Lane Bulk Case Pick (Top Up)'
  WHEN lgtyp = '0201'
  THEN 'Lane Bulk Pallet Pick'
  WHEN lgtyp = '0240'
  THEN 'Empties Block Virtual Lanes'
  WHEN lgtyp = '0280'
  THEN 'Bread'
  WHEN lgtyp = '0300'
  THEN 'HR NF/Food Promo Case Pick'
  WHEN lgtyp = '0304'
  THEN 'NF Pushback Pick'
  WHEN lgtyp = '0306'
  THEN 'NF Flow Rack Case Pick'
  WHEN lgtyp = '0310'
  THEN 'Lane NF/Food Promo Case Pick'
  WHEN lgtyp = '0311'
  THEN 'Lane NF/Food Promo Pallet Pick'
  WHEN lgtyp = '0400'
  THEN 'Lane 14\u00b0C F&V Case Pick'
  WHEN lgtyp = '0410'
  THEN 'Lane 04\u00b0C F&V Case Pick'
  WHEN lgtyp = '0500'
  THEN 'HR Chiller Case Pick'
  WHEN lgtyp = '0506'
  THEN 'Flow Rack Chiller Cases'
  WHEN lgtyp = '0510'
  THEN 'Lane Chiller Case Pick'
  WHEN lgtyp = '0511'
  THEN 'Lane Chiller Pallet Pick'
  WHEN lgtyp = '0600'
  THEN 'Lane Meat, Poultry, & Fish Case Pick CW'
  WHEN lgtyp = '0610'
  THEN 'Lane MPF Pick - Non CW'
  WHEN lgtyp = '0700'
  THEN 'HR Freezer Case Pick'
  WHEN lgtyp = '0704'
  THEN 'Freezer Pushback Pick '
  WHEN lgtyp = '0710'
  THEN 'HR Bake Off Case Pick'
  WHEN lgtyp = '0714'
  THEN 'HR Bake Off Tunnel Case Pick'
  WHEN lgtyp = '0720'
  THEN 'Lane Freezer Case Pick'
  WHEN lgtyp = '0721'
  THEN 'Lane Freezer Pallet Pick'
  WHEN lgtyp = '0910'
  THEN 'Shadow Ambient + Bulk Case Pick'
  WHEN lgtyp = '0911'
  THEN 'Shadow Ambient + Bulk Pallet Pick'
  WHEN lgtyp = '0930'
  THEN 'Shadow NF/Food Promo Case Pick'
  WHEN lgtyp = '0931'
  THEN 'Shadow NF/Food Promo Pallet Pick'
  WHEN lgtyp = '0940'
  THEN 'Shadow F&V HU Case Pick'
  WHEN lgtyp = '0941'
  THEN 'Shadow F&V Pallet Pick'
  WHEN lgtyp = '0942'
  THEN 'Shadow F&V Case Pick'
  WHEN lgtyp = '0950'
  THEN 'Shadow Meat, Poultry & Fish Case Pick'
  WHEN lgtyp = '0951'
  THEN 'Shadow Meat, Poultry & Fish Pallet Pick'
  WHEN lgtyp = '0952'
  THEN 'GR/GI Milk Trolley'
  WHEN lgtyp = '0953'
  THEN 'GR/GI Milk Trolley Case Pick'
  WHEN lgtyp = '0970'
  THEN 'Shadow Freezer Case Pick'
  WHEN lgtyp = '0971'
  THEN 'Shadow Freezer Pallet Pick'
  WHEN lgtyp = '8100'
  THEN 'AHR Ambient Tunnel Case Pick'
  WHEN lgtyp = '8110'
  THEN 'AHR Hazardous Ambient Tunnel Case Pick'
  WHEN lgtyp = '8120'
  THEN 'AHR Chilled Ambient Tunnel Case Pick'
  WHEN lgtyp = '8142'
  THEN 'AHR Ambient Replenishment for Tunnel'
  WHEN lgtyp = '8300'
  THEN 'AHR NF Tunnel Case Pick'
  WHEN lgtyp = 'EX01'
  THEN 'Ext. WH 1'
  WHEN lgtyp = 'EX02'
  THEN 'Ext. WH 2'
  WHEN lgtyp = 'EX03'
  THEN 'Ext. WH 3'
  ELSE 'Unassigned'
  END AS strg_type_desc,
  CASE
  WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
  THEN 'Ambient'
  WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
  THEN 'Bulk'
  WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
  THEN 'NF'
  WHEN lgtyp = '0400' OR lgtyp = '0410'
  THEN 'F&V'
  WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
  THEN 'Chiller'
  WHEN lgtyp = '0600' OR lgtyp = '0610'
  THEN 'MPF'
  WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
  THEN 'Freezer'
  WHEN lgtyp = '0910' OR lgtyp = '0911'
  THEN 'Ambient'
  WHEN lgtyp = '0930' OR lgtyp = '0931'
  THEN 'NF'
  WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
  THEN 'F&V'
  WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
  THEN 'MPF'
  WHEN lgtyp = '0970' OR lgtyp = '0971'
  THEN 'Freezer'
  WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
  THEN 'AHR'
  WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
  THEN 'ExWH'
  ELSE 'Unassigned'
  END AS area,
  CASE
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'AHR'
  THEN '8'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Ambient'
  THEN '1'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'NF'
  THEN '3'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Returns'
  THEN '9'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Bulk'
  THEN '2'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'F&V'
  THEN '4'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Chiller'
  THEN '5'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'MPF'
  THEN '6'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
    THEN 'AHR'
    WHEN lgtyp = 'EX01' OR lgtyp = 'EX02' OR lgtyp = 'EX03'
    THEN 'ExWH'
    ELSE 'Unassigned'
    END = 'Freezer'
  THEN '7'
  WHEN CASE
    WHEN lgtyp = '0100' OR lgtyp = '0106' OR lgtyp = '0110' OR lgtyp = '0120' OR lgtyp = '0126' OR lgtyp = '0130'
    THEN 'Ambient'
    WHEN lgtyp = '0200' OR lgtyp = '0201' OR lgtyp = '0240' OR lgtyp = '0280'
    THEN 'Bulk'
    WHEN lgtyp = '0300' OR lgtyp = '0304' OR lgtyp = '0306' OR lgtyp = '0310' OR lgtyp = '0311'
    THEN 'NF'
    WHEN lgtyp = '0400' OR lgtyp = '0410'
    THEN 'F&V'
    WHEN lgtyp = '0500' OR lgtyp = '0506' OR lgtyp = '0510' OR lgtyp = '0511'
    THEN 'Chiller'
    WHEN lgtyp = '0600' OR lgtyp = '0610'
    THEN 'MPF'
    WHEN lgtyp = '0700' OR lgtyp = '0704' OR lgtyp = '0710' OR lgtyp = '0714' OR lgtyp = '0720' OR lgtyp = '0721'
    THEN 'Freezer'
    WHEN lgtyp = '0910' OR lgtyp = '0911'
    THEN 'Ambient'
    WHEN lgtyp = '0930' OR lgtyp = '0931'
    THEN 'NF'
    WHEN lgtyp = '0940' OR lgtyp = '0941' OR lgtyp = '0942'
    THEN 'F&V'
    WHEN lgtyp = '0950' OR lgtyp = '0951' OR lgtyp = '0952' OR lgtyp = '0953'
    THEN 'MPF'
    WHEN lgtyp = '0970' OR lgtyp = '0971'
    THEN 'Freezer'
    WHEN lgtyp = '8100' OR lgtyp = '8110' OR lgtyp = '8120' OR lgtyp = '8142' OR lgtyp = '8300'
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
  WHEN lgtyp IN ('8100', '8110', '8120', '8142')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   rem_bin_depth
  ELSE CAST((COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * IF(kzler, 1, 0) AS BIGNUMERIC)
  END AS bin_rem,
  CASE
  WHEN lgtyp IN ('8100', '8110', '8120', '8142')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   max_bin_depth
  ELSE CAST(COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS BIGNUMERIC)
  END AS bin_ges,
  CASE
  WHEN lgtyp IN ('8100', '8110', '8120', '8142')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * (max_bin_depth
      - rem_bin_depth)
  ELSE (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - CASE
    WHEN lgtyp IN ('8100', '8110', '8120', '8142')
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
WHERE lgtyp IN ('0100', '0106', '0110', '0120', '0126', '0130', '0200', '0201', '0240', '0280', '0300', '0304', '0306',
   '0310', '0311', '0400', '0410', '0500', '0506', '0510', '0511', '0600', '0610', '0700', '0704', '0710', '0714',
   '0720', '0721', '0910', '0911', '0930', '0931', '0940', '0941', '0942', '0950', '0951', '0952', '0953', '0970',
   '0971', '8100', '8110', '8120', '8142', '8300', 'EX01', 'EX02', 'EX03')
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
  WHEN lgtyp = '0100'
  THEN 'HR Ambient Case Pick'
  WHEN lgtyp = '0106'
  THEN 'HR Ambient Flow Rack Case Pick'
  WHEN lgtyp = '0110'
  THEN 'HR Hazardous Ambient Case Pick'
  WHEN lgtyp = '0120'
  THEN 'HR Chilled Ambient Case Pick'
  WHEN lgtyp = '0126'
  THEN 'HR Chilled Ambient Flow Rack Case Pick'
  WHEN lgtyp = '0130'
  THEN 'HR High Value Ambient Case Pick'
  WHEN lgtyp = '0200'
  THEN 'Lane Bulk Case Pick (Top Up)'
  WHEN lgtyp = '0201'
  THEN 'Lane Bulk Pallet Pick'
  WHEN lgtyp = '0240'
  THEN 'Empties Block Virtual Lanes'
  WHEN lgtyp = '0280'
  THEN 'Bread'
  WHEN lgtyp = '0300'
  THEN 'HR NF/Food Promo Case Pick'
  WHEN lgtyp = '0304'
  THEN 'NF Pushback Pick'
  WHEN lgtyp = '0306'
  THEN 'NF Flow Rack Case Pick'
  WHEN lgtyp = '0310'
  THEN 'Lane NF/Food Promo Case Pick'
  WHEN lgtyp = '0311'
  THEN 'Lane NF/Food Promo Pallet Pick'
  WHEN lgtyp = '0400'
  THEN 'Lane 14\u00b0C F&V Case Pick'
  WHEN lgtyp = '0410'
  THEN 'Lane 04\u00b0C F&V Case Pick'
  WHEN lgtyp = '0500'
  THEN 'HR Chiller Case Pick'
  WHEN lgtyp = '0506'
  THEN 'Flow Rack Chiller Cases'
  WHEN lgtyp = '0510'
  THEN 'Lane Chiller Case Pick'
  WHEN lgtyp = '0511'
  THEN 'Lane Chiller Pallet Pick'
  WHEN lgtyp = '0600'
  THEN 'Lane Meat, Poultry, & Fish Case Pick CW'
  WHEN lgtyp = '0610'
  THEN 'Lane MPF Pick - Non CW'
  WHEN lgtyp = '0700'
  THEN 'HR Freezer Case Pick'
  WHEN lgtyp = '0704'
  THEN 'Freezer Pushback Pick '
  WHEN lgtyp = '0710'
  THEN 'HR Bake Off Case Pick'
  WHEN lgtyp = '0714'
  THEN 'HR Bake Off Tunnel Case Pick'
  WHEN lgtyp = '0720'
  THEN 'Lane Freezer Case Pick'
  WHEN lgtyp = '0721'
  THEN 'Lane Freezer Pallet Pick'
  WHEN lgtyp = '0910'
  THEN 'Shadow Ambient + Bulk Case Pick'
  WHEN lgtyp = '0911'
  THEN 'Shadow Ambient + Bulk Pallet Pick'
  WHEN lgtyp = '0930'
  THEN 'Shadow NF/Food Promo Case Pick'
  WHEN lgtyp = '0931'
  THEN 'Shadow NF/Food Promo Pallet Pick'
  WHEN lgtyp = '0940'
  THEN 'Shadow F&V HU Case Pick'
  WHEN lgtyp = '0941'
  THEN 'Shadow F&V Pallet Pick'
  WHEN lgtyp = '0942'
  THEN 'Shadow F&V Case Pick'
  WHEN lgtyp = '0950'
  THEN 'Shadow Meat, Poultry & Fish Case Pick'
  WHEN lgtyp = '0951'
  THEN 'Shadow Meat, Poultry & Fish Pallet Pick'
  WHEN lgtyp = '0952'
  THEN 'GR/GI Milk Trolley'
  WHEN lgtyp = '0953'
  THEN 'GR/GI Milk Trolley Case Pick'
  WHEN lgtyp = '0970'
  THEN 'Shadow Freezer Case Pick'
  WHEN lgtyp = '0971'
  THEN 'Shadow Freezer Pallet Pick'
  WHEN lgtyp = '8100'
  THEN 'AHR Ambient Tunnel Case Pick'
  WHEN lgtyp = '8110'
  THEN 'AHR Hazardous Ambient Tunnel Case Pick'
  WHEN lgtyp = '8120'
  THEN 'AHR Chilled Ambient Tunnel Case Pick'
  WHEN lgtyp = '8142'
  THEN 'AHR Ambient Replenishment for Tunnel'
  WHEN lgtyp = '8300'
  THEN 'AHR NF Tunnel Case Pick'
  WHEN lgtyp = 'EX01'
  THEN 'Ext. WH 1'
  WHEN lgtyp = 'EX02'
  THEN 'Ext. WH 2'
  WHEN lgtyp = 'EX03'
  THEN 'Ext. WH 3'
  ELSE 'Unassigned'
  END AS strg_type_desc,
  CASE
  WHEN lgtyp = '0100' OR (lgtyp = '0106' OR lgtyp = '0110') OR (lgtyp = '0120' OR (lgtyp = '0126' OR lgtyp = '0130')) OR
      (lgtyp = '0200' OR (lgtyp = '0201' OR lgtyp = '0240') OR (lgtyp = '0280' OR (lgtyp = '0300' OR lgtyp = '0304')))
    OR (lgtyp = '0306' OR (lgtyp = '0310' OR lgtyp = '0311') OR (lgtyp = '0400' OR (lgtyp = '0410' OR lgtyp = '0500'))
      OR (lgtyp = '0506' OR (lgtyp = '0510' OR lgtyp = '0511') OR (lgtyp = '0600' OR lgtyp = '0610' OR (lgtyp = '0700'
            OR lgtyp = '0704')))) OR (lgtyp = '0710' OR (lgtyp = '0714' OR lgtyp = '0720') OR (lgtyp = '0721' OR (lgtyp
            = '0910' OR lgtyp = '0911')) OR (lgtyp = '0930' OR (lgtyp = '0931' OR lgtyp = '0940') OR (lgtyp = '0941' OR
           (lgtyp = '0942' OR lgtyp = '0950'))) OR (lgtyp = '0951' OR (lgtyp = '0952' OR lgtyp = '0953') OR (lgtyp =
           '0970' OR (lgtyp = '0971' OR lgtyp = '8100')) OR (lgtyp = '8110' OR (lgtyp = '8120' OR lgtyp = '8142') OR (lgtyp
              = '8300' OR lgtyp = 'EX01' OR (lgtyp = 'EX02' OR lgtyp = 'EX03')))))
  THEN 'Total'
  ELSE 'Unassigned'
  END AS area,
  CASE
  WHEN CASE
    WHEN lgtyp = '0100' OR (lgtyp = '0106' OR lgtyp = '0110') OR (lgtyp = '0120' OR (lgtyp = '0126' OR lgtyp = '0130'))
       OR (lgtyp = '0200' OR (lgtyp = '0201' OR lgtyp = '0240') OR (lgtyp = '0280' OR (lgtyp = '0300' OR lgtyp = '0304'
            ))) OR (lgtyp = '0306' OR (lgtyp = '0310' OR lgtyp = '0311') OR (lgtyp = '0400' OR (lgtyp = '0410' OR lgtyp
              = '0500')) OR (lgtyp = '0506' OR (lgtyp = '0510' OR lgtyp = '0511') OR (lgtyp = '0600' OR lgtyp = '0610'
            OR (lgtyp = '0700' OR lgtyp = '0704')))) OR (lgtyp = '0710' OR (lgtyp = '0714' OR lgtyp = '0720') OR (lgtyp
            = '0721' OR (lgtyp = '0910' OR lgtyp = '0911')) OR (lgtyp = '0930' OR (lgtyp = '0931' OR lgtyp = '0940') OR
           (lgtyp = '0941' OR (lgtyp = '0942' OR lgtyp = '0950'))) OR (lgtyp = '0951' OR (lgtyp = '0952' OR lgtyp =
              '0953') OR (lgtyp = '0970' OR (lgtyp = '0971' OR lgtyp = '8100')) OR (lgtyp = '8110' OR (lgtyp = '8120' OR
               lgtyp = '8142') OR (lgtyp = '8300' OR lgtyp = 'EX01' OR (lgtyp = 'EX02' OR lgtyp = 'EX03')))))
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
  WHEN lgtyp IN ('8100', '8110', '8120', '8142')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   rem_bin_depth
  ELSE CAST((COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * IF(kzler, 1, 0) AS BIGNUMERIC)
  END AS bin_rem,
  CASE
  WHEN lgtyp IN ('8100', '8110', '8120', '8142')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) *
   max_bin_depth
  ELSE CAST(COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS BIGNUMERIC)
  END AS bin_ges,
  CASE
  WHEN lgtyp IN ('8100', '8110', '8120', '8142')
  THEN (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * (max_bin_depth
      - rem_bin_depth)
  ELSE (COUNT(lgpla) OVER (PARTITION BY lgpla RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - CASE
    WHEN lgtyp IN ('8100', '8110', '8120', '8142')
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
WHERE lgtyp IN ('0100', '0106', '0110', '0120', '0126', '0130', '0200', '0201', '0240', '0280', '0300', '0304', '0306',
   '0310', '0311', '0400', '0410', '0500', '0506', '0510', '0511', '0600', '0610', '0700', '0704', '0710', '0714',
   '0720', '0721', '0910', '0911', '0930', '0931', '0940', '0941', '0942', '0950', '0951', '0952', '0953', '0970',
   '0971', '8100', '8110', '8120', '8142', '8300')
 AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND lgpla NOT LIKE '%DUMMY%'
 AND NOT deleted_fg;