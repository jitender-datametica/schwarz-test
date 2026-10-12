CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_expected_1 AS SELECT DATES.cal_dt AS day,
 DATES.month_of_year,
 DATES.month_of_year_name,
 DATES.cy_month,
 DATES.cy,
 DATES.bus_year,
 DATES.cy_week,
 EXP.zone,
 EXP.project_id,
 EXP.project_name,
 EXP.cube_id,
 EXP.cube_name,
 EXP.subcube_id,
 EXP.subcube_name,
 SOL.first_resp_solution_id AS first_solution_id,
 SOL.first_resp_solution_name AS first_solution_name,
 SOL.sec_resp_solution_id AS sec_solution_id,
 SOL.sec_resp_solution_name AS sec_solution_name,
 SERV.iserver_id,
 SERV.iserver_name,
 EXP.dat_rec_start,
 EXP.dat_rec_end,
 EXP.sla_vta,
 EXP.sla_vvta,
 EXP.sla_nvta,
 EXP.timestamp_load_bcbi
FROM ldl_bcbi_fe_mstr_bcbi.t_cubeavail_expected_list_1 AS EXP
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_cubeavail_solutions_1 AS SOL ON EXP.subcube_id = SOL.subcube_id
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_cubeavail_server_1 AS SERV ON EXP.zone = SERV.zone
 INNER JOIN (SELECT cal_dt,
   month_of_year,
   month_of_year_name,
   cy_month,
   cy,
   bus_year,
   cy_week
  FROM ldl_bcbi_fe_mstr_bcbi.t_dim_cal_day_1
  WHERE cal_dt BETWEEN DATE '2023-06-20' AND (CURRENT_DATE)) AS DATES ON DATES.cal_dt BETWEEN EXP.dat_rec_start AND EXP
  .dat_rec_end;