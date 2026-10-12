CREATE OR REPLACE VIEW P_LEW_TOOLS.V_MAT_SUPPLIER_CONEG_COUNTRY_HIST
AS
   select  client_id,
           sup_sid,
           country_sid_conegot_list,
           country_cd_conegot_list,
           country_sid_conegot_list_01,
           country_cd_conegot_list_01,
           country_sid_conegot_list_02,
           country_cd_conegot_list_02,
           country_sid_conegot_list_03,
           country_cd_conegot_list_03,
           country_sid_conegot_list_04,
           country_cd_conegot_list_04,
           country_sid_conegot_list_05,
           country_cd_conegot_list_05,
           country_sid_conegot_list_06,
           country_cd_conegot_list_06,
           country_sid_conegot_list_07,
           country_cd_conegot_list_07,
           country_sid_conegot_list_08,
           country_cd_conegot_list_08,
           country_sid_conegot_list_09,
           country_cd_conegot_list_09,
           country_sid_conegot_list_10,
           country_cd_conegot_list_10,
           deleted_fg,
           to_date(substr(peri, 1, 10),'YYYY-MM-DD') AS dwh_valid_from,
           to_date(substr(peri, 12, 10),'YYYY-MM-DD') AS dwh_valid_to,
           case  when current_date between dwh_valid_from and dwh_valid_to then 1 else 0 end dwh_actual_fg
  FROM (
       SELECT *
       FROM (
                SELECT   client_id,
                         sup_sid,
                         nullif(country_sid_conegot_list,'') country_sid_conegot_list,
                         nullif(country_cd_conegot_list,'') country_cd_conegot_list,
                         CASE WHEN CAST(STRTOK(','||country_sid_conegot_list,',',1) AS INTEGER) = 0 THEN null ELSE CAST(STRTOK(','||country_sid_conegot_list,',',1) AS INTEGER) END country_sid_conegot_list_01,
                         nullif(CAST(STRTOK(','||country_cd_conegot_list,',',1) AS VARCHAR(4)),'') country_cd_conegot_list_01,
                         CAST(STRTOK(','||country_sid_conegot_list,',',2) AS INTEGER) country_sid_conegot_list_02,
                         CAST(STRTOK(','||country_cd_conegot_list,',',2) AS VARCHAR(4)) country_cd_conegot_list_02,
                         CAST(STRTOK(','||country_sid_conegot_list,',',3) AS INTEGER) country_sid_conegot_list_03,
                         CAST(STRTOK(','||country_cd_conegot_list,',',3) AS VARCHAR(4)) country_cd_conegot_list_03,
                         CAST(STRTOK(','||country_sid_conegot_list,',',4) AS INTEGER) country_sid_conegot_list_04,
                         CAST(STRTOK(','||country_cd_conegot_list,',',4) AS VARCHAR(4)) country_cd_conegot_list_04,
                         CAST(STRTOK(','||country_sid_conegot_list,',',5) AS INTEGER) country_sid_conegot_list_05,
                         CAST(STRTOK(','||country_cd_conegot_list,',',5) AS VARCHAR(4)) country_cd_conegot_list_05,
                         CAST(STRTOK(','||country_sid_conegot_list,',',6) AS INTEGER) country_sid_conegot_list_06,
                         CAST(STRTOK(','||country_cd_conegot_list,',',6) AS VARCHAR(4)) country_cd_conegot_list_06,
                         CAST(STRTOK(','||country_sid_conegot_list,',',7) AS INTEGER) country_sid_conegot_list_07,
                         CAST(STRTOK(','||country_cd_conegot_list,',',7) AS VARCHAR(4)) country_cd_conegot_list_07,
                         CAST(STRTOK(','||country_sid_conegot_list,',',8) AS INTEGER) country_sid_conegot_list_08,
                         CAST(STRTOK(','||country_cd_conegot_list,',',8) AS VARCHAR(4)) country_cd_conegot_list_08,
                         CAST(STRTOK(','||country_sid_conegot_list,',',9) AS INTEGER) country_sid_conegot_list_09,
                         CAST(STRTOK(','||country_cd_conegot_list,',',9) AS VARCHAR(4)) country_cd_conegot_list_09,
                         CAST(STRTOK(','||country_sid_conegot_list,',',10) AS INTEGER) country_sid_conegot_list_10,
                         CAST(STRTOK(','||country_cd_conegot_list,',',10) AS VARCHAR(4)) country_cd_conegot_list_10,
                         deleted_fg,
                         peri
                FROM (
                        SELECT  client_id,
                                sup_sid,
                                replace(TRIM(LISTAGG(country_sid_conegot_vc|| ',') within group (order by order_crit)),' ','')  as country_sid_conegot_list,
                                replace(TRIM(LISTAGG(country_cd_conegot_vc || ',') within group (order by order_crit)),' ','') as country_cd_conegot_list,
                                case when nullif(country_sid_conegot_list,'') is null then 1 else MIN(deleted_fg) end deleted_fg,
                                peri
                        FROM p_lew_tools.v_mat0_supplier_coneg_country_hist
                        where map_type='MULTIPLE'
                        GROUP BY client_id,
                                sup_sid,
                                peri
                     ) multi_rows

            UNION ALL

            SELECT  client_id,
                    sup_sid,
                    nullif(country_sid_conegot_vc,'') country_sid_conegot_list,
                    nullif(country_cd_conegot_vc,'') country_cd_conegot_list,
                    CASE WHEN CAST(country_sid_conegot_vc as INTEGER) = 0 THEN null ELSE CAST(country_sid_conegot_vc as INTEGER) END country_sid_conegot_list_01,
                    nullif(CAST(country_cd_conegot_vc AS VARCHAR(4)),'') country_cd_conegot_list_01,
                    TO_NUMBER(NULL) country_sid_conegot_list_02,
                    NULL country_cd_conegot_list_02,
                    TO_NUMBER(NULL) country_sid_conegot_list_03,
                    NULL country_cd_conegot_list_03,
                    TO_NUMBER(NULL) country_sid_conegot_list_04,
                    NULL country_cd_conegot_list_04,
                    TO_NUMBER(NULL) country_sid_conegot_list_05,
                    NULL country_cd_conegot_list_05,
                    TO_NUMBER(NULL) country_sid_conegot_list_06,
                    NULL country_cd_conegot_list_06,
                    TO_NUMBER(NULL) country_sid_conegot_list_07,
                    NULL country_cd_conegot_list_07,
                    TO_NUMBER(NULL) country_sid_conegot_list_08,
                    NULL country_cd_conegot_list_08,
                    TO_NUMBER(NULL) country_sid_conegot_list_09,
                    NULL country_cd_conegot_list_09,
                    TO_NUMBER(NULL) country_sid_conegot_list_10,
                    NULL country_cd_conegot_list_10,
                    case when nullif(country_sid_conegot_vc,'') is null then 1 else deleted_fg end deleted_fg,
                    peri
            FROM p_lew_tools.v_mat0_supplier_coneg_country_hist unq_rows
            WHERE map_type='UNIQUE'
            ) all_rows
    ) tmprl_schrumpf
WHERE NOT(dwh_valid_to-dwh_valid_from=2958462 and deleted_fg=1);