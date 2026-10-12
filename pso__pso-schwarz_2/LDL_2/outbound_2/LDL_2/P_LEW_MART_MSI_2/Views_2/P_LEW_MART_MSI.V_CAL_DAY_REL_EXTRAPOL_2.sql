/* #DescStart#	
       #$Revision: 7085 $, $LastChangedBy: pmittler $	
       #SubjectAreas#: Kalender	
       #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_day_rel_extrapol_2 AS
-- Filter um Zukunftsjahre auf max 3 Jahre einzugrenzen
 SELECT cal_dt AS dat_calendar,
 dat_calendar_extrapol
FROM ldl_p_lew_bil_ac.v_cal_day_rel_extrapol_2 AS A
WHERE EXTRACT(YEAR FROM cal_dt) < (SELECT MAX(EXTRACT(YEAR FROM cal_dt)) - 6
   FROM ldl_p_lew_bil_ac.v_cal_day_rel_extrapol_2);