CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_daily_vat_statististics_current_stat_dt_2 (store_sid, country_org_sid
, country_org_cd, real_estate_sid, stat_dt, bus_dt, curr_stat_fg, geo_area_sid, tax_class_cd, vat_stat_calc_method_cd,
turnover_gross_val, vat_val, curr_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, rank,
failed_latest_stat_dt_not_current, failed_previous_stat_dt_but_current, total)
OPTIONS(DESCRIPTION = `ONLY ONE CURRENT RECORD  WITH CURR_STAT_FG = TRUE (FOR MAX (STAT_DT)) FOR THE COMBINAISON OF THE FOLLWOING KEYS:\\NSTORE_SID,REAL_ESTATE_SID,BUS_DT,GEO_AREA_SID,\\NTAX_CLASS_CD, VAT_STAT_CALC_METHOD_CD`)
AS SELECT store_sid,
 country_org_sid,
 country_org_cd,
 real_estate_sid,
 stat_dt,
 bus_dt,
 curr_stat_fg,
 geo_area_sid,
 tax_class_cd,
 vat_stat_calc_method_cd,
 turnover_gross_val,
 vat_val,
 curr_cd,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd,
 RANK() OVER (PARTITION BY CAST(store_sid AS STRING), CAST(real_estate_sid AS STRING), bus_dt, CAST(geo_area_sid AS STRING)
    , tax_class_cd, vat_stat_calc_method_cd ORDER BY stat_dt IS NULL DESC, stat_dt DESC, curr_stat_fg IS NULL DESC,
    curr_stat_fg DESC) AS rank,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(store_sid AS STRING), CAST(real_estate_sid AS STRING), bus_dt, CAST(geo_area_sid AS STRING)
        , tax_class_cd, vat_stat_calc_method_cd ORDER BY stat_dt IS NULL DESC, stat_dt DESC, curr_stat_fg IS NULL DESC,
        curr_stat_fg DESC)) = 1 AND NOT curr_stat_fg
  THEN 1
  ELSE 0
  END AS failed_latest_stat_dt_not_current,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(store_sid AS STRING), CAST(real_estate_sid AS STRING), bus_dt, CAST(geo_area_sid AS STRING)
        , tax_class_cd, vat_stat_calc_method_cd ORDER BY stat_dt IS NULL DESC, stat_dt DESC, curr_stat_fg IS NULL DESC,
        curr_stat_fg DESC)) > 1 AND curr_stat_fg
  THEN 1
  ELSE 0
  END AS failed_previous_stat_dt_but_current,
 1 AS total
FROM ldl_data_production_core_rel.t_daily_vat_statistics_2;