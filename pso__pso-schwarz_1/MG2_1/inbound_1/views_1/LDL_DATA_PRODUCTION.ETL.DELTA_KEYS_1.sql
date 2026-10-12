create or replace view LDL_DATA_PRODUCTION.ETL.DELTA_KEYS_1(
	BUS_DT,
	INT_ORG_SID
) as (
    SELECT DISTINCT  
           src.dwh_cal_dt AS bus_dt
         , src.loc_sid AS int_org_sid
      FROM ETL.VT1 AS src
);