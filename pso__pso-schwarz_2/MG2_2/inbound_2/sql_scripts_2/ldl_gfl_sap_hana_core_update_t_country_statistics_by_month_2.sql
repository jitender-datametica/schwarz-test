/* The curr_stat_fg on t_company_statistics_by_month_2 must be set after the data has been loaded

"TRUE if this record has the greatest stat_dt among records with matching {int_company_sid, stat_type_cd, cal_month}.
FALSE otherwise.

When there is a new current (with highest stat_dt) record for keys
{int_company_sid, stat_type_cd, cal_month},
in previously current row for the key this column has to be set from TRUE to FALSE."

*/

-- Sort within groups, most recent stat_dt determined as the "current record"

 CREATE OR REPLACE TEMPORARY TABLE ETL.VT_COUNTRY_STATISTICS_BY_MONTH
 AS (SELECT reporting_country_sid, stat_type_cd, stat_dt, cal_month,
	   row_number() over (partition by reporting_country_sid, stat_type_cd,cal_month ORDER BY stat_dt DESC) as rn,
        CASE WHEN rn = 1 THEN 'TRUE'
        ELSE 'FALSE' END AS curr_stat_fg
 FROM core_rel.t_country_statistics_by_month_2);

 MERGE INTO core_rel.t_country_statistics_by_month_2 src
 USING ETL.VT_COUNTRY_STATISTICS_BY_MONTH lkp
 ON src.reporting_country_sid = lkp.reporting_country_sid AND
    src.stat_type_cd = lkp.stat_type_cd AND
    src.stat_dt=lkp.stat_dt AND
    src.cal_month = lkp.cal_month 
 WHEN MATCHED THEN UPDATE SET src.curr_stat_fg = lkp.curr_stat_fg;
