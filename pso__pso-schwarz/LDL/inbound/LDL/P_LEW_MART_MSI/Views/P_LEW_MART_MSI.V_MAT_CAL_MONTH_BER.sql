CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_MONTH_BER 	
(	
 dat_calendar_amd	
 , dat_calendar_pmd	
 , dat_calendar_pyd	
 , dat_calendar_pypm	
 , dat_calendar_ppy
 , dat_calendar_pppy 	
 , cy_month	
 , prev_month	
  )	
AS	
   SELECT	
   dd.dat_calendar dat_calendar_amd   --Aktueller Kalendertag 	
   ,pd.dat_calendar dat_calendar_pmd   --zugehörige Kalendertage des Vormonats 	
   ,CASE	
   WHEN (py.dat_calendar  IS NULL AND dat_calendar_pmd IS NULL )	
   THEN DATEADD(MONTH,-12,dd.dat_calendar)
   ELSE py.dat_calendar
   END	
   dat_calendar_pyd     --zugehörige Kalendertage des Monats im Vorjahr 	
   ,CASE	
   WHEN (pypm.dat_calendar IS NULL	
   AND EXTRACT(DAY FROM dat_calendar_pyd) = 29	
   AND EXTRACT(MONTH FROM dat_calendar_pyd) = 3	
   AND (MOD(EXTRACT(YEAR FROM dat_calendar_pyd), 4)) = 0  )	
   THEN DATEADD(MONTH,-1,dat_calendar_pyd)	
	
   WHEN (pypm.dat_calendar IS NULL	
   AND EXTRACT(DAY FROM dat_calendar_pmd) = 29	
   AND EXTRACT(MONTH FROM dat_calendar_pmd) = 2	
   AND (MOD(EXTRACT(YEAR FROM dat_calendar_pmd), 4)) = 0  )	
   THEN NULL	
	
   ELSE DATEADD(MONTH,-12,dat_calendar_pmd )	
   END	
   dat_calendar_pypm     --zugehörige Kalendertage des Vormonats im Vorjahr 	
   ,CASE	
    WHEN (ppy.dat_calendar  IS NULL AND dat_calendar_pmd IS NULL )	
    THEN DATEADD(MONTH,-24,dd.dat_calendar)	
    ELSE ppy.dat_calendar 
    END	
    dat_calendar_ppy     --zugehörige Kalendertage im Vorvorjahr 	
   ,CASE    
    WHEN (pppy.dat_calendar  IS NULL AND dat_calendar_pmd IS NULL )  
    THEN DATEADD(MONTH,-36,dd.dat_calendar) 
    ELSE pppy.dat_calendar   
    END 
    dat_calendar_pppy     --zugehörige Kalendertage im Vorvorvorjahr
   ,mm.cy_month      --aktueller Monat 	
   ,mm.prev_month      --Vormonat 	
	
   FROM p_lew_mart_msi.v_cal_month mm	
   INNER JOIN p_lew_mart_msi.v_cal_calendarday dd	
   ON mm.cy_month = dd.cy_month	
   LEFT OUTER JOIN p_lew_mart_msi.v_cal_calendarday pd	
   ON mm.prev_month = pd.cy_month	
   AND DATEADD(MONTH,1,pd.dat_calendar) = dd.dat_calendar	
   LEFT OUTER JOIN p_lew_mart_msi.v_cal_calendarday py	
   ON mm.cy_month = py.cy_month + 100	
   AND DATEADD(MONTH,12,py.dat_calendar) = dd.dat_calendar	
   AND DATEADD(MONTH,11,py.dat_calendar) = pd.dat_calendar	
   LEFT OUTER JOIN p_lew_mart_msi.v_cal_calendarday pypm	
   ON mm.prev_month = pypm.cy_month + 100	
   AND DATEADD(MONTH,1,pypm.dat_calendar) = py.dat_calendar	
   AND DATEADD(MONTH,12,pypm.dat_calendar) = pd.dat_calendar	
   LEFT OUTER JOIN p_lew_mart_msi.v_cal_calendarday ppy	
   ON mm.cy_month = ppy.cy_month + 200	
   AND DATEADD(MONTH,24,ppy.dat_calendar) = dd.dat_calendar	
   AND DATEADD(MONTH,23,ppy.dat_calendar) = pd.dat_calendar	
	LEFT OUTER JOIN p_lew_mart_msi.v_cal_calendarday pppy 
   ON mm.cy_month = pppy.cy_month + 300  
   AND DATEADD(MONTH,36,pppy.dat_calendar) = dd.dat_calendar     
   AND DATEADD(MONTH,35,pppy.dat_calendar) = pd.dat_calendar  

   WHERE dat_calendar_amd IS NOT NULL	
   AND dat_calendar_amd >= '2005-01-01'	
;