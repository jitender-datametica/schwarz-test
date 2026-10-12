CREATE OR REPLACE VIEW p_lew_bil.v_mat_supplier_coneg_country_hist
AS
/*****************************************************************************************
#DescStart#
* Jens Thole (c) 05.07.2018
* Erstellung der historisierten Zielstruktur, die nun nur noch Suppliergranular ist. Die vorher im Core vorhandenen Granularität (SUP, CONEG-COUNTRY)
* wird projiziert auf den Supplier, indem die in jedem Zeitintervall vorkommenden Kombinationen als Liste erstellt wird.
* Zudem, werden die ersten 10 EKS-Nummern in Feldern pivotiert.
*
* Es wird der in V_MAT0 gebildete Schalter MAP_TYPE (MULTIPLE|UNIQUE|NOT RELEVANT) benutzt 
,* um die Verarbeitung zu splitten und die aufwendige Listenbildung nur für die Zeilen durchzuführen, die dies auch benötigen.
* So kann der Prozeß viel leichtgewichtiger bzgl CPU-LAst aufgebaut werden.
*
* Yucel Cesmeli 19.09.2021
* Teradata Normalize function has been adapted to Snowflake by using Window functions.
#DescEnd#
*****************************************************************************************/
SELECT  client_id
        ,sup_sid
        ,country_sid_conegot_list
        ,country_cd_conegot_list
        ,country_sid_conegot_list_01
        ,country_cd_conegot_list_01
        ,country_sid_conegot_list_02
        ,country_cd_conegot_list_02
        ,country_sid_conegot_list_03
        ,country_cd_conegot_list_03
        ,country_sid_conegot_list_04
        ,country_cd_conegot_list_04
        ,country_sid_conegot_list_05
        ,country_cd_conegot_list_05
        ,country_sid_conegot_list_06
        ,country_cd_conegot_list_06
        ,country_sid_conegot_list_07
        ,country_cd_conegot_list_07
        ,country_sid_conegot_list_08
        ,country_cd_conegot_list_08
        ,country_sid_conegot_list_09
        ,country_cd_conegot_list_09
        ,country_sid_conegot_list_10
        ,country_cd_conegot_list_10
        ,deleted_fg
        ,(DATEADD('day',1,MIN(schnitt_peri_start))) AS dwh_valid_from
        ,MAX(schnitt_peri_end) AS dwh_valid_to    -- TODO: check if one day has to be substracted (PERIOD datatype makes last day exclusive)
        ,CASE  WHEN CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to THEN 1 ELSE 0 END dwh_actual_fg
    FROM (
    SELECT client_id
           ,sup_sid
           ,country_sid_conegot_list
           ,country_cd_conegot_list
           ,country_sid_conegot_list_01
           ,country_cd_conegot_list_01
           ,country_sid_conegot_list_02
           ,country_cd_conegot_list_02
           ,country_sid_conegot_list_03
           ,country_cd_conegot_list_03
           ,country_sid_conegot_list_04
           ,country_cd_conegot_list_04
           ,country_sid_conegot_list_05
           ,country_cd_conegot_list_05
           ,country_sid_conegot_list_06
           ,country_cd_conegot_list_06
           ,country_sid_conegot_list_07
           ,country_cd_conegot_list_07
           ,country_sid_conegot_list_08
           ,country_cd_conegot_list_08
           ,country_sid_conegot_list_09
           ,country_cd_conegot_list_09
           ,country_sid_conegot_list_10
           ,country_cd_conegot_list_10
           ,deleted_fg
           ,schnitt_peri_start
           ,schnitt_peri_end
           ,SUM(groupstartflag) OVER (PARTITION BY client_id,sup_sid,country_sid_conegot_list,country_cd_conegot_list
                                      ,country_sid_conegot_list_01,country_cd_conegot_list_01
                                      ,country_sid_conegot_list_02,country_cd_conegot_list_02
                                      ,country_sid_conegot_list_03,country_cd_conegot_list_03
                                      ,country_sid_conegot_list_04,country_cd_conegot_list_04
                                      ,country_sid_conegot_list_05,country_cd_conegot_list_05
                                      ,country_sid_conegot_list_06,country_cd_conegot_list_06
                                      ,country_sid_conegot_list_07,country_cd_conegot_list_07
                                      ,country_sid_conegot_list_08,country_cd_conegot_list_08
                                      ,country_sid_conegot_list_09,country_cd_conegot_list_09
                                      ,country_sid_conegot_list_10,country_cd_conegot_list_10,deleted_fg
									  ORDER BY schnitt_peri_start,schnitt_peri_end ROWS UNBOUNDED PRECEDING) AS groupid 		   
     FROM
        (  
    SELECT all_rows.*
	,CASE WHEN schnitt_peri_start <= NVL(LAG(schnitt_peri_end) OVER (PARTITION BY client_id,sup_sid,country_sid_conegot_list,country_cd_conegot_list
                                      ,country_sid_conegot_list_01,country_cd_conegot_list_01
                                      ,country_sid_conegot_list_02,country_cd_conegot_list_02
                                      ,country_sid_conegot_list_03,country_cd_conegot_list_03
                                      ,country_sid_conegot_list_04,country_cd_conegot_list_04
                                      ,country_sid_conegot_list_05,country_cd_conegot_list_05
                                      ,country_sid_conegot_list_06,country_cd_conegot_list_06
                                      ,country_sid_conegot_list_07,country_cd_conegot_list_07
                                      ,country_sid_conegot_list_08,country_cd_conegot_list_08
                                      ,country_sid_conegot_list_09,country_cd_conegot_list_09
                                      ,country_sid_conegot_list_10,country_cd_conegot_list_10,deleted_fg
									  ORDER BY schnitt_peri_start,schnitt_peri_end),schnitt_peri_end) THEN 0 ELSE 1 END AS groupstartflag
        FROM (
            SELECT  client_id
                    ,sup_sid
                    ,NULLIF(country_sid_conegot_list,'') country_sid_conegot_list
                    ,NULLIF(country_cd_conegot_list,'') country_cd_conegot_list
                    ,NULLIFZERO(TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',1))) country_sid_conegot_list_01
                    ,NULLIF(TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',1) :: VARCHAR(4)),'') country_cd_conegot_list_01
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',2)) country_sid_conegot_list_02
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',2) :: VARCHAR(4)) country_cd_conegot_list_02
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',3)) country_sid_conegot_list_03
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',3) :: VARCHAR(4)) country_cd_conegot_list_03
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',4)) country_sid_conegot_list_04
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',4) :: VARCHAR(4)) country_cd_conegot_list_04
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',5)) country_sid_conegot_list_05
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',5) :: VARCHAR(4)) country_cd_conegot_list_05
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',6)) country_sid_conegot_list_06
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',6) :: VARCHAR(4)) country_cd_conegot_list_06
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',7)) country_sid_conegot_list_07
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',7) :: VARCHAR(4)) country_cd_conegot_list_07
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',8)) country_sid_conegot_list_08
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',8) :: VARCHAR(4)) country_cd_conegot_list_08
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',9)) country_sid_conegot_list_09
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',9) :: VARCHAR(4)) country_cd_conegot_list_09
                    ,TO_NUMBER(STRTOK(','||country_sid_conegot_list,',',10)) country_sid_conegot_list_10
                    ,TO_VARCHAR(STRTOK(','||country_cd_conegot_list,',',10) :: VARCHAR(4)) country_cd_conegot_list_10
                    ,deleted_fg
                    ,schnitt_peri_start
                    ,schnitt_peri_end
            FROM (
                    SELECT  client_id
                            ,sup_sid
                            ,TO_VARCHAR(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(TO_VARCHAR(LISTAGG(TRIM(country_sid_conegot_vc)|| ',') WITHIN GROUP (ORDER BY order_crit) :: VARCHAR(200)),' ',''),',,',','),',,',','), ','), ',') :: VARCHAR(100)) country_sid_conegot_list
                            ,TO_VARCHAR(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(TO_VARCHAR(LISTAGG(TRIM(country_cd_conegot_vc)|| ',') WITHIN GROUP (ORDER BY order_crit) :: VARCHAR(200)),' ',''),',,',','),',,',','), ','), ',') :: VARCHAR(100)) country_cd_conegot_list
                            ,CASE WHEN NULLIF(country_sid_conegot_list,'') IS NULL THEN 1 ELSE MIN(deleted_fg) END deleted_fg
                            ,schnitt_peri_start
                            ,schnitt_peri_end
                    FROM p_lew_bil.v_mat0_supplier_coneg_country_hist
                    WHERE map_type='MULTIPLE'
                    GROUP BY client_id
                            ,sup_sid
                            ,schnitt_peri_start
                            ,schnitt_peri_end
                    ) multi_rows
            UNION ALL
            SELECT client_id
                ,sup_sid
                ,NULLIF(country_sid_conegot_vc,'') country_sid_conegot_list
                ,NULLIF(country_cd_conegot_vc,'') country_cd_conegot_list
                ,NULLIFZERO(TRY_TO_NUMBER(country_sid_conegot_vc)) country_sid_conegot_list_01
                ,NULLIF(TO_VARCHAR(country_cd_conegot_vc :: VARCHAR(4)),'') country_cd_conegot_list_01
                ,TO_NUMBER(NULL) country_sid_conegot_list_02
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_02
                ,TO_NUMBER(NULL) country_sid_conegot_list_03
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_03
                ,TO_NUMBER(NULL) country_sid_conegot_list_04
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_04
                ,TO_NUMBER(NULL) country_sid_conegot_list_05
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_05
                ,TO_NUMBER(NULL) country_sid_conegot_list_06
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_06
                ,TO_NUMBER(NULL) country_sid_conegot_list_07
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_07
                ,TO_NUMBER(NULL) country_sid_conegot_list_08
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_08
                ,TO_NUMBER(NULL) country_sid_conegot_list_09
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_09
                ,TO_NUMBER(NULL) country_sid_conegot_list_10
                ,TO_VARCHAR(NULL :: VARCHAR(4)) country_cd_conegot_list_10
                ,CASE WHEN NULLIF(country_sid_conegot_vc,'') IS NULL THEN 1 ELSE deleted_fg END deleted_fg
                ,schnitt_peri_start
                ,schnitt_peri_end
            FROM  p_lew_bil.v_mat0_supplier_coneg_country_hist unq_rows
            WHERE map_type='UNIQUE'
        ) all_rows
       ) all_rows_norm
    ) tmprl_schrumpf
      GROUP BY 
      client_id
      ,sup_sid
      ,country_sid_conegot_list
      ,country_cd_conegot_list
      ,country_sid_conegot_list_01
      ,country_cd_conegot_list_01
      ,country_sid_conegot_list_02
      ,country_cd_conegot_list_02
      ,country_sid_conegot_list_03
      ,country_cd_conegot_list_03
      ,country_sid_conegot_list_04
      ,country_cd_conegot_list_04
      ,country_sid_conegot_list_05
      ,country_cd_conegot_list_05
      ,country_sid_conegot_list_06
      ,country_cd_conegot_list_06
      ,country_sid_conegot_list_07
      ,country_cd_conegot_list_07
      ,country_sid_conegot_list_08
      ,country_cd_conegot_list_08
      ,country_sid_conegot_list_09
      ,country_cd_conegot_list_09
      ,country_sid_conegot_list_10
      ,country_cd_conegot_list_10
      ,deleted_fg
      ,groupid
      HAVING NOT(dwh_valid_to-dwh_valid_from=2958462 AND deleted_fg=1);