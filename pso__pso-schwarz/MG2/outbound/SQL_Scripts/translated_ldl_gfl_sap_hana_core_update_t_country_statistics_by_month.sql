/* The curr_stat_fg on t_company_statistics_by_month must be set after the data has been loaded

"TRUE if this record has the greatest stat_dt among records with matching {int_company_sid, stat_type_cd, cal_month}.
FALSE otherwise.

When there is a new current (with highest stat_dt) record for keys
{int_company_sid, stat_type_cd, cal_month},
in previously current row for the key this column has to be set from TRUE to FALSE."

*/

-- Sort within groups, most recent stat_dt determined as the "current record"

 


CREATE OR REPLACE TEMPORARY TABLE vt_country_statistics_by_month AS
SELECT reporting_country_sid,
 stat_type_cd,
 stat_dt,
 cal_month,
 ROW_NUMBER() OVER (PARTITION BY CAST(reporting_country_sid AS STRING), stat_type_cd, CAST(cal_month AS STRING) ORDER BY
    stat_dt IS NULL DESC, stat_dt DESC) AS rn,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(reporting_country_sid AS STRING), stat_type_cd, CAST(cal_month AS STRING)
     ORDER BY stat_dt IS NULL DESC, stat_dt DESC)) = 1
  THEN 'TRUE'
  ELSE 'FALSE'
  END AS curr_stat_fg
FROM ldl_data_production_core_rel.t_country_statistics_by_month;


MERGE INTO ldl_data_production_core_rel.t_country_statistics_by_month AS src
USING vt_country_statistics_by_month AS lkp
ON src.reporting_country_sid = lkp.reporting_country_sid AND src.stat_type_cd = lkp.stat_type_cd AND src.stat_dt = lkp.stat_dt
    AND src.cal_month = lkp.cal_month
WHEN MATCHED THEN UPDATE SET
 curr_stat_fg = CAST(lkp.curr_stat_fg AS BOOL);