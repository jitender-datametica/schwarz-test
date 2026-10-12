CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_DAY_REL_EXTRAPOL_1 as
       /*	
       #DescStart#	
       #$Revision: 7085 $, $LastChangedBy: pmittler $	
       #SubjectAreas#: Kalender	
       #DescEnd#	
       */	
      SELECT	
        a.cal_dt AS dat_calendar,	
      a.dat_calendar_extrapol	
      FROM p_lew_bil_ac.v_cal_day_rel_extrapol_1 AS a	
      -- Filter um Zukunftsjahre auf max 3 Jahre einzugrenzen	
      WHERE EXTRACT(year from cal_dt) < (SELECT MAX(EXTRACT(year from cal_dt))-6 FROM p_lew_bil_ac.v_cal_day_rel_extrapol_1 )	
;