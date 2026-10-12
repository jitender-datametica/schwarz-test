CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_lagerauslastung_kpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_ctry
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), wh_id
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
OPTIONS(description='Flag if record is deleted')) AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_lagerauslastung_add_2;