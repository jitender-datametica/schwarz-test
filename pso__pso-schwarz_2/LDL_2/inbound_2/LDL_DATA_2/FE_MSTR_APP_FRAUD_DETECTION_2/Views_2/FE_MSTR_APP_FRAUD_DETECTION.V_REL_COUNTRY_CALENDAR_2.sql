CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_REL_COUNTRY_CALENDAR_2(
cal_dt COMMENT 'A calendar_2 day ,'
,country_org_sid COMMENT 'Organizational Country_2 techinical Identifier'
,country_org_cd COMMENT 'Country_2 ISO identifier'
,holiday_name COMMENT 'Name of National Holiday'
,holiday_fg COMMENT 'Flag showing if on given day there is any National Holiday'
,holiday_dt COMMENT 'Holiday date only filled on holidays'
,cal_dt_offset COMMENT 'Offset of calendar_2 day'
) AS
WITH cnty_date_interval AS (
SELECT 
    org.country_org_sid AS country_org_sid,
    MAX(org.country_org_cd) AS country_org_cd,
    GREATEST(MIN(org.open_dt),'2013-01-01'::DATE) AS start_dt,
    ((YEAR(CURRENT_DATE()) + 2)::VARCHAR || '-03-01')::DATE  AS end_dt
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 org
GROUP BY org.country_org_sid
)  
SELECT
 cal.cal_dt AS cal_dt, 
 cnty_date_interval.country_org_sid AS country_org_sid,
 cnty_date_interval.country_org_cd AS country_org_cd, 
 hol.holiday_name AS holiday_name, 
 NVL2(hol.holiday_name,1,0)::NUMBER(38,0) AS holiday_fg,
 hol.cal_dt AS holiday_dt,
 cal.cal_dt_offset AS cal_dt_offset
FROM CORE_DIM.T_DIM_CALENDAR_DATE_2 cal
INNER JOIN cnty_date_interval
ON cal.cal_dt BETWEEN cnty_date_interval.start_dt AND cnty_date_interval.end_dt
LEFT JOIN CORE_DIM.T_FACT_NATIONAL_HOLIDAY_2 hol 
ON hol.cal_dt = cal.cal_dt
AND hol.iso_country_cd = cnty_date_interval.country_org_cd;