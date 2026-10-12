CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_zone_detail_1(
	day
	,week
	,week_name
	,week_id
	,month
	,month_name
	,month_id
	,year
	,bus_year
	,zone
	,expected_cube
	,amount_cube_vta
	,amount_cube_vvta
	,amount_cube_nvta
	,endtime_last_cube
	,zone_status
	,cube_restarted
	,technische_verarbeitung
	,t_vta
	,info
) AS WITH ZONE_AVAIL AS (SELECT t4.day0 AS day,
   t4.week,
   t4.week_name,
   t4.week_id,
   t4.month,
   t4.month_name,
   t4.month_id,
   t4.year,
   t4.bus_year,
   t4.zone,
   t4.expected_cube,
   t4.amount_cube_vta,
   t4.amount_cube_vvta,
   t4.amount_cube_nvta,
   t4.endtime_last_cube,
   t4.zone_status,
   t4.technische_verarbeitung,
   t4.t_vta,
   t4.info
  FROM (SELECT EXPT.day AS day0,
     DET.week,
     DET.week_name,
     DET.week_id,
     DET.month,
     DET.month_name,
     DET.month_id,
     DET.year,
     DET.bus_year,
     EXPT.zone,
     EXPT.amount_expected_cubes AS expected_cube,
     COUNT(CASE
       WHEN DET.cube_status = 'VTA'
       THEN 1
       ELSE NULL
       END) AS amount_cube_vta,
     COUNT(CASE
       WHEN DET.cube_status = 'VVTA'
       THEN 1
       ELSE NULL
       END) AS amount_cube_vvta,
     COUNT(CASE
       WHEN DET.cube_status = 'NVTA'
       THEN 1
       ELSE NULL
       END) AS amount_cube_nvta,
     MAX(DET.endtime_last_cube) AS endtime_last_cube,
      CASE
      WHEN COUNT(CASE
         WHEN DET.cube_status = 'NVTA'
         THEN 1
         ELSE NULL
         END) > 0
      THEN 'NVTA'
      WHEN COUNT(CASE
         WHEN DET.cube_status = 'VVTA'
         THEN 1
         ELSE NULL
         END) > 0
      THEN 'VVTA'
      WHEN COUNT(CASE
         WHEN DET.cube_status = 'VTA'
         THEN 1
         ELSE NULL
         END) = EXPT.amount_expected_cubes
      THEN 'VTA'
      ELSE NULL
      END AS zone_status,
      CASE
      WHEN EXPT.zone = 'EU' AND inc.t_vta IS NULL AND CURRENT_TIME > '10:00:00' OR EXPT.zone = 'US' AND inc.t_vta
         IS NULL AND CURRENT_TIME > '13:00:00'
      THEN 'JA'
      WHEN inc.t_vta = 'nein'
      THEN 'NEIN'
      ELSE ''
      END AS technische_verarbeitung,
     inc.t_vta,
     inc.link_html AS info,
     EXPT.day
    FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_cube_detail_1 AS DET
     LEFT JOIN (SELECT day,
       zone,
       COUNT(DISTINCT cube_id) AS amount_expected_cubes
      FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_expected_1
      GROUP BY day,
       zone) AS EXPT ON DET.zone = EXPT.zone AND DET.day = EXPT.day
     LEFT JOIN (SELECT id,
       subject,
       current_status,
       DATE(affected_day) AS affected_day,
        CASE
        WHEN STRPOS(affected_countries, 'EU') <> 0
        THEN 'EU'
        WHEN STRPOS(affected_countries, 'US') <> 0
        THEN 'US'
        ELSE NULL
        END AS affected_zone,
       t_vta,
       CONCAT('https://schwarzit.sharepoint.com/teams/Spielwiese/Lists/Strungs%20und%20Wartungsinformationen/DispForm.aspx?ID='
        , id) AS url,
       CONCAT('<a href="', CONCAT('https://schwarzit.sharepoint.com/teams/Spielwiese/Lists/Strungs%20und%20Wartungsinformationen/DispForm.aspx?ID='
         , id), '" target="_blank" >', 'Cosmic Link', '</a>') AS link_html
      FROM ldl_bcbi_fe_mstr_bcbi.t_maintenance_incidents_1) AS inc ON DATE_SUB(EXPT.day, INTERVAL 1 DAY) = inc.affected_day
        AND EXPT.zone = inc.affected_zone
    GROUP BY EXPT.day,
     DET.week,
     DET.week_name,
     DET.week_id,
     DET.month,
     DET.month_name,
     DET.month_id,
     DET.year,
     DET.bus_year,
     EXPT.zone,
     expected_cube,
     technische_verarbeitung,
     inc.t_vta,
     info
    ORDER BY EXPT.day NULLS LAST,
     DET.week NULLS LAST) AS t4) (SELECT ZONE0.day,
   ZONE0.week,
   ZONE0.week_name,
   ZONE0.week_name AS week_name0,
   ZONE0.month,
   ZONE0.month_name,
   ZONE0.month_id,
   ZONE0.year,
   ZONE0.bus_year,
   ZONE0.zone,
   ZONE0.expected_cube,
    CASE
    WHEN UPD.amount_cube_vta IS NULL
    THEN CAST(ZONE0.amount_cube_vta AS INTEGER)
    ELSE UPD.amount_cube_vta
    END AS amount_cube_vta,
    CASE
    WHEN UPD.amount_cube_vvta IS NULL
    THEN CAST(ZONE0.amount_cube_vvta AS INTEGER)
    ELSE UPD.amount_cube_vvta
    END AS amount_cube_vvta,
    CASE
    WHEN UPD.amount_cube_nvta IS NULL
    THEN CAST(ZONE0.amount_cube_nvta AS INTEGER)
    ELSE UPD.amount_cube_nvta
    END AS amount_cube_nvta,
    CASE
    WHEN UPD.endtime IS NULL
    THEN SUBSTR(CAST(ZONE0.endtime_last_cube AS STRING), 1, 255)
    ELSE UPD.endtime
    END AS endtime_last_cube,
    CASE
    WHEN UPD.cubing_status IS NULL
    THEN ZONE0.zone_status
    ELSE UPD.cubing_status
    END AS zone_status,
    CASE
    WHEN UPD.cube_restarted = 'Ja'
    THEN 'Ja'
    ELSE 'Nein'
    END AS cube_restarted,
   ZONE0.technische_verarbeitung,
   ZONE0.t_vta,
   ZONE0.info
  FROM ZONE_AVAIL AS ZONE0
   LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_cubeavail_update_1 AS UPD ON ZONE0.day = UPD.day AND ZONE0.zone = UPD.zone);