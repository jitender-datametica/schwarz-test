CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_store_open_by_date_and_status_consistency
OPTIONS(DESCRIPTION = `CONSISTENCY BETWEEN OPENING/CLOSING DATES AND THE REAL ESTATE STATUS\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_CALENDAR_PARTIAL_WEEK\\NCORE_DIM.T_DIM_REAL_ESTATE\\NCORE_DIM.T_FACT_REAL_ESTATE_LIFECYCLE`)
AS WITH wk AS (SELECT part_week,
   part_week_begin_dt,
   part_week_end_dt
  FROM ldl_data_production_core_dim.t_dim_calendar_partial_week
  WHERE part_week_offset = - 1) (SELECT t1.part_week,
   t1.part_week_begin_dt,
   t1.part_week_end_dt,
   re_by_dates.real_estate_sid AS re_by_dates_real_estate_sid,
   re_by_dates.real_estate_nr AS re_by_dates_real_estate_nr,
   re_by_dates.real_estate_status_cd AS re_by_dates_real_estate_status_cd,
   re_by_dates.real_estate_status_descr AS re_by_dates_real_estate_status_descr,
   re_by_dates.precontract_dt AS re_by_dates_precontract_dt,
   re_by_dates.contract_dt AS re_by_dates_contract_dt,
   re_by_dates.open_dt AS re_by_dates_open_dt,
   re_by_dates.close_dt AS re_by_dates_close_dt,
   re_by_dates.dwh_valid_from_tmsp AS re_by_dates_dwh_valid_from_tmsp,
   re_by_dates.dwh_valid_to_tmsp AS re_by_dates_dwh_valid_to_tmsp,
   re_by_status.real_estate_sid AS re_by_status_real_estate_sid,
   re_by_status.real_estate_nr AS re_by_status_real_estate_nr,
   re_by_status.real_estate_status_cd AS re_by_status_real_estate_status_cd,
   re_by_status.real_estate_status_descr AS re_by_status_real_estate_status_descr,
   re_by_status.precontract_dt AS re_by_status_precontract_dt,
   re_by_status.contract_dt AS re_by_status_contract_dt,
   re_by_status.open_dt AS re_by_status_open_dt,
   re_by_status.close_dt AS re_by_status_close_dt,
   re_by_status.dwh_valid_from_tmsp AS re_by_status_dwh_valid_from_tmsp,
   re_by_status.dwh_valid_to_tmsp AS re_by_status_dwh_valid_to_tmsp,
    CASE
    WHEN re_by_dates.real_estate_sid IS NULL OR re_by_status.real_estate_sid IS NULL
    THEN 1
    ELSE 0
    END AS failed,
   1 AS total
  FROM wk AS t1
   INNER JOIN (SELECT re.real_estate_sid,
     re.real_estate_nr,
     re.real_estate_status_cd,
     re.real_estate_status_descr,
     rel.precontract_dt,
     rel.contract_dt,
     rel.open_dt,
     rel.close_dt,
     re.dwh_valid_from_tmsp,
     re.dwh_valid_to_tmsp
    FROM ldl_data_production_core_dim.t_dim_real_estate AS re
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle AS rel ON re.real_estate_sid = rel.real_estate_sid
      
     INNER JOIN wk AS t4 ON t4.part_week_end_dt BETWEEN CAST(re.dwh_valid_from_tmsp AS DATE) AND (CAST(re.dwh_valid_to_tmsp AS DATE)
         ) AND rel.open_dt <= t4.part_week_end_dt AND (rel.close_dt > t4.part_week_end_dt OR rel.close_dt =
         DATE '0001-01-01')
    WHERE re.real_estate_type_cd IN ('STORE', 'SPEC')
     AND rel.open_dt <> DATE '0001-01-01') AS re_by_dates ON TRUE
   FULL JOIN (SELECT re0.real_estate_sid,
     re0.real_estate_nr,
     re0.real_estate_status_cd,
     re0.real_estate_status_descr,
     rel0.precontract_dt,
     rel0.contract_dt,
     rel0.open_dt,
     rel0.close_dt,
     re0.dwh_valid_from_tmsp,
     re0.dwh_valid_to_tmsp
    FROM ldl_data_production_core_dim.t_dim_real_estate AS re0
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle AS rel0 ON re0.real_estate_sid = rel0.real_estate_sid
      
     INNER JOIN wk AS t9 ON t9.part_week_end_dt BETWEEN CAST(re0.dwh_valid_from_tmsp AS DATE) AND (CAST(re0.dwh_valid_to_tmsp AS DATE)
       )
    WHERE re0.real_estate_type_cd IN ('STORE', 'SPEC')
     AND re0.real_estate_status_cd IN ('OP', 'TC')) AS re_by_status ON re_by_dates.real_estate_sid = re_by_status.real_estate_sid
    );