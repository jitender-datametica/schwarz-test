CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TIME_MAIN AS 
SELECT a.*
FROM (
SELECT 
    CLIENT_ID
   ,LOC_SID_STORE
   ,DWH_CAL_DT
   ,WORK_TIME_GROSS_HR
   ,WORK_TIME_NET_HR
   ,BREAK_HR
   ,PERFORM_RELEV_ABSENCE_HR
FROM (
   SELECT   
			
   lvl0.client_id    
   ,lvl0.loc_sid                      AS loc_sid_store  
   ,lvl0.dwh_cal_dt                   AS dwh_cal_dt 
   ,SUM(lvl0.working_time_brutto_hrs) AS work_time_gross_hr 
   ,SUM(lvl0.working_time_netto_hrs ) AS work_time_net_hr   
   ,SUM(lvl0.break_hrs              ) AS break_hr   
   ,SUM(lvl0.perf_rel_absence_hrs   ) AS perform_relev_absence_hr   
   ,-1                                AS dwh_load_id    
   ,CURRENT_TIMESTAMP                 AS dwh_created    
   ,CURRENT_TIMESTAMP                 AS dwh_updated
  FROM (    
      /* UNION1: workingtimes in t_time_tracking_record table (GPS) */  
      SELECT
            client_id  
   ,loc_sid 
   ,dwh_cal_dt  
   ,CAST((/* P10 = Kommen, P20 = Gehen */   
   CASE WHEN event_type_cd = 'P20' THEN timestamp_secONds   
        WHEN event_type_cd = 'P10' THEN timestamp_secONds * (-1)    
        ELSE 0  
   END  
) / 3600.00000 AS DECIMAL(18,5))   AS working_time_brutto_hrs  
   ,CAST((/* P15 = Pause Start, P25 = Pause Ende */ 
   CASE WHEN event_type_cd = 'P25' THEN timestamp_secONds   
        WHEN event_type_cd = 'P15' THEN timestamp_secONds * (-1)    
        ELSE 0  
   END  
) / 3600.00000 AS DECIMAL(18,5))    AS break_hrs    
   ,working_time_brutto_hrs - break_hrs      AS working_time_netto_hrs  
   ,CAST(NULL AS DECIMAL(18, 5))             AS perf_rel_absence_hrs    
      FROM  
      ( 
          SELECT    
				 
				gwt.client_id   
   ,gwt.loc_sid
   ,gwt.employee_hASh   
   ,gwt.dwh_cal_dt  
   ,gwt.event_type_cd   
   ,(CAST(gwt.event_tmsp AS DATE) - MIN(CAST(gwt.event_tmsp AS DATE)) OVER (    
                                        PARTITION BY gwt.client_id, gwt.loc_sid, gwt.employee_hASh)) * 24 * 3600    
   + EXTRACT(HOUR FROM gwt.event_tmsp) * 3600   
   + EXTRACT(MINUTE FROM gwt.event_tmsp) * 60   
   + EXTRACT(SECOND FROM gwt.event_tmsp)   AS timestamp_secONds 
FROM (SELECT * FROM 
       (
    SELECT SUM(CASE WHEN cancel_fg=1 THEN 1 ELSE 0 END) OVER (PARTITION BY time_record_id) AS pdsnr_cancel_fg_sum,* FROM FE_MSTR_BCBI.t_time_tracking_record   /* Story 417399 added cancellatiON logic */
   WHERE dwh_cal_dt > ADD_MONTHS(CURRENT_DATE, -61) 
     AND event_type_cd NOT IN ('P01','P02')
 
         QUALIFY ROW_NUMBER() OVER (    
                   PARTITION BY client_id, loc_sid, time_record_id /* Reverted for Story 417399*/
       ORDER BY time_record_change_dt DESC NULLS LAST, dwh_load_id DESC) = 1 ) AS pdsnr_dedup
      WHERE pdsnr_cancel_fg_sum=0 
   QUALIFY ROW_NUMBER() OVER (  
                   PARTITION BY client_id, loc_sid, employee_hASh, event_tmsp, event_type_cd /* Change for ticket INC3331966*/
             ORDER BY time_record_change_dt DESC, cancel_fg) = 1 ) AS gwt   
   INNER JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST WHERE ACTIVE_TO_DT = '9999-12-30' )     AS typ   
   ON  gwt.client_id     = typ.client_id    
   AND gwt.time_type_sid = typ.time_type_sid    
   /*AND typ.presence_fg   = 1*/  /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */    
   AND typ.performance_relevant_fg = 1 /* leistungsrelevant */  
   WHERE gwt.cancel_fg = 0  /* Kein Storno */   
) AS t  
UNION ALL   
/* UNION2: workingtimes in t_time_tracking_period table (PTM) */    
 
    SELECT 	
     pwt.client_id 
   ,pwt.loc_sid 
   ,pwt.dwh_cal_dt
   ,CASE WHEN pwt.period_start_tmsp IS NULL OR pwt.period_end_tmsp IS NULL  
     THEN 0.00000   
     ELSE CAST( ( ( ( EXTRACT(HOUR FROM   pwt.period_end_tmsp) * 3600 + 
   EXTRACT(MINUTE FROM pwt.period_end_tmsp) * 60 +  
   EXTRACT(SECOND FROM pwt.period_end_tmsp) 
) -    
( EXTRACT(HOUR FROM   pwt.period_start_tmsp) * 3600 +  
   EXTRACT(MINUTE FROM pwt.period_start_tmsp) * 60 +    
   EXTRACT(SECOND FROM pwt.period_start_tmsp)   
) +    
  /* calculate date-difference in secONds */    
( CAST(pwt.period_end_tmsp AS DATE) - CAST(pwt.period_start_tmsp AS DATE) ) * 86400    
) / 3600.00000 
) AS DECIMAL(18,5) )    
END * pwt.performance_factor               AS working_time_brutto_hrs  /* Arbeitszeit in Stunden * Leistungsfaktor */   
   /* ,pwt.break_duratiON_minute  * 1.00000 / 60  AS break_hrs 
            /* performance_factor AS multiplier */
   ,CAST ((pwt.break_duratiON_minute  * 1.00000  / 60 )* pwt.performance_factor AS DECIMAL(18,6))  AS break_hrs /* Pausenzeit in Stunden */
   ,working_time_brutto_hrs - break_hrs        AS working_time_netto_hrs    
   ,CAST(NULL AS DECIMAL(18, 5))               AS perf_rel_absence_hrs  
      FROM (SELECT * FROM FE_MSTR_BCBI.t_time_tracking_period
             WHERE dwh_cal_dt > ADD_MONTHS(CURRENT_DATE, -61)  
               AND time_type_grp_cd = 'WT'  /* PTM workingtime */   
            /* 1 persON can several record per day, so either start_time, or record_id is needed in partitiON  */   
            /* Take the latest record for each time_record_id */    
            QUALIFY ROW_NUMBER() OVER(  
                  PARTITION BY client_id, loc_sid, time_record_id, employee_hASh, dwh_cal_dt    
                      ORDER BY time_record_change_tmsp DESC NULLS LAST) = 1 ) AS pwt    
   INNER JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST WHERE ACTIVE_TO_DT = '9999-12-30' )     AS typ   
   ON  pwt.client_id     = typ.client_id    
   AND pwt.time_type_sid = typ.time_type_sid    
   /*AND typ.presence_fg   = 1*/    /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */  
   AND typ.performance_relevant_fg = 1 /* leistungsrelevant */  
   WHERE pwt.cancel_fg = 0  /* Kein Storno */   
     AND pwt.deleted_fg = 0 /* Filter auf deleted_fg darf erst nach dem QUALIFY erfolgen */ 
   UNION ALL    
   /* UNION3: workingtimes in t_time_tracking_day table (GPS missing) */    
   /* External Hours can be the same employee_hASh, but different time_record_id */ 
   SELECT  
     
        gmt.client_id  
   ,gmt.loc_sid 
   ,gmt.dwh_cal_dt
   ,CAST(gmt.hours_cnt AS DECIMAL(18,4)) AS working_time_brutto_hrs 
   ,0                                    AS break_hrs   
   ,CAST(gmt.hours_cnt AS DECIMAL(18,4)) AS working_time_netto_hrs  
   ,CAST(NULL AS DECIMAL(18, 5))         AS perf_rel_absence_hrs    
      FROM (SELECT * FROM FE_MSTR_BCBI.T_TIME_TRACKING_DAY
            WHERE dwh_cal_dt > ADD_MONTHS(CURRENT_DATE, -61)    
            /*take the latest record for  */    
            QUALIFY ROW_NUMBER() OVER(  
               PARTITION BY client_id, loc_sid, time_record_id, /*employee_hASh,*/ time_type_sid, dwh_cal_dt    
                   ORDER BY time_record_change_dt DESC NULLS LAST, time_record_id DESC NULLS LAST) = 1 ) AS gmt   /* gps_missing */ 
   INNER JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST WHERE ACTIVE_TO_DT = '9999-12-30' )  AS typ  
   ON  gmt.client_id     = typ.client_id    
   AND gmt.time_type_sid = typ.time_type_sid    
   AND gmt.cancel_fg     = 0    
   AND typ.presence_fg   = 1    /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */  
   AND typ.performance_relevant_fg = 1 /* leistungsrelevant */  
   WHERE gmt.cancel_fg = 0 /* Kein Storno */    
   UNION ALL    
   /* UNION4: Performance_relevant_absence_hours GPS        */  
 
    SELECT 
	    
        td.client_id   
   ,td.loc_sid  
   ,td.dwh_cal_dt  
   ,CAST(NULL AS DECIMAL(18, 5))                   AS working_time_brutto_hrs   
   ,CAST(NULL AS DECIMAL(18, 5))                   AS break_hrs 
   ,CAST(NULL AS DECIMAL(18, 5))                   AS working_time_netto_hrs    
   ,CAST(td.hours_cnt AS DECIMAL(18,5))            AS absence_hours 
      FROM (SELECT * FROM FE_MSTR_BCBI.T_TIME_TRACKING_DAY
            WHERE dwh_cal_dt > ADD_MONTHS(CURRENT_DATE, -61)    
            QUALIFY ROW_NUMBER() OVER(  
                PARTITION BY client_id,loc_sid,dwh_cal_dt,time_record_id, /*employee_hASh,*/time_type_sid   
                    ORDER BY time_record_change_dt DESC NULLS LAST, time_record_id DESC NULLS LAST) = 1 ) AS td /* time_record_change_dt replaces former dwh_updated */ 
   INNER JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST WHERE ACTIVE_TO_DT = '9999-12-30' )  AS typ  
   ON  td.client_id     = typ.client_id 
   AND td.time_type_sid = typ.time_type_sid 
   AND typ.presence_fg  = 0 /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */  
   AND typ.performance_relevant_fg = 1  /* leistungsrelevant */ 
   WHERE td.cancel_fg = 0  /* Kein Storno */    
   UNION ALL    
   /* UNION5: Performance_relevant_absence_hours PTM           */   
   SELECT 
    
        tp.client_id   
   ,tp.loc_sid  
   ,tp.dwh_cal_dt
   ,CAST(NULL AS DECIMAL(18, 5))                   AS working_time_brutto_hrs   
   ,CAST(NULL AS DECIMAL(18, 5))                   AS break_hrs 
   ,CAST(NULL AS DECIMAL(18, 5))                   AS working_time_netto_hrs    
   ,CASE WHEN tp.period_start_tmsp IS NULL OR tp.period_end_tmsp IS NULL    
                THEN CAST(0.00000 AS DECIMAL(18,5)) 
                WHEN CAST(tp.period_start_tmsp AS TIME) = '00:00:00' OR CAST(tp.period_end_tmsp AS TIME) = '00:00:00'   
                THEN CAST(0.00000 AS DECIMAL(18,5)) 
           ELSE CAST( ( ( ( EXTRACT(HOUR FROM   tp.period_end_tmsp) * 3600 +    
   EXTRACT(MINUTE FROM tp.period_end_tmsp) * 60 +   
   EXTRACT(SECOND FROM tp.period_end_tmsp)  
) -    
( EXTRACT(HOUR FROM   tp.period_start_tmsp) * 3600 +   
   EXTRACT(MINUTE FROM tp.period_start_tmsp) * 60 + 
   EXTRACT(SECOND FROM tp.period_start_tmsp)    
) +    
   /* calculate date-difference in secONds */   
( CAST(tp.period_end_tmsp AS DATE) - CAST(tp.period_start_tmsp AS DATE) ) * 86400  
) / 3600.00000 
) AS DECIMAL(18,5) )    
END AS absence_hours    
FROM (SELECT * FROM FE_MSTR_BCBI.t_time_tracking_period
WHERE dwh_cal_dt > ADD_MONTHS(CURRENT_DATE, -61)    
AND time_type_grp_cd = 'MT'   /* PTM missing */ 
QUALIFY ROW_NUMBER() OVER(  
PARTITION BY client_id,loc_sid,dwh_cal_dt,employee_hASh,time_type_sid,period_start_tmsp 
ORDER BY time_record_change_tmsp DESC NULLS LAST,time_record_id DESC NULLS LAST) = 1 ) AS tp    
   INNER JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST WHERE ACTIVE_TO_DT = '9999-12-30' )  AS typ  
   ON  tp.client_id     = typ.client_id 
   AND tp.time_type_sid = typ.time_type_sid 
   /* AND typ.presence_fg  = 0 */  /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */   
   AND typ.performance_relevant_fg = 1 /* leistungsrelevant */  
   WHERE tp.cancel_fg = 0  /* Kein Storno */    
     AND tp.deleted_fg = 0 /* Filter auf deleted_fg darf erst nach dem QUALIFY erfolgen */  
) AS lvl0   
GROUP BY    
     lvl0.client_id 
   , lvl0.loc_sid   
   , lvl0.dwh_cal_dt
)) a;