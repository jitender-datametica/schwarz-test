/* The curr_accrual_fg on t_revenue_accrual must be set after the data has been loaded

"TRUE if this record has the greatest accrual_dt among records with matching {int_org_sid, bus_dt}.
FALSE otherwise.

When there is a new current (with highest accrual_dt) record for keys
{int_org_sid, bus_dt},
in previously current row for the key this column has to be set from TRUE to FALSE."

*/

-- Sort within groups, most recent accrual date determined as the "current accrual"



BEGIN TRANSACTION;


CREATE OR REPLACE TEMPORARY TABLE vt_revenue_accrual AS
SELECT int_org_sid,
 real_estate_sid,
 bus_dt,
 accrual_dt,
 ROW_NUMBER() OVER (PARTITION BY CAST(int_org_sid AS STRING), CAST(real_estate_sid AS STRING), bus_dt ORDER BY
    accrual_dt IS NULL DESC, accrual_dt DESC) AS rn,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(int_org_sid AS STRING), CAST(real_estate_sid AS STRING), bus_dt ORDER BY
       accrual_dt IS NULL DESC, accrual_dt DESC)) = 1
  THEN 'TRUE'
  ELSE 'FALSE'
  END AS curr_accrual_fg
FROM ldl_data_production_core_rel.t_revenue_accrual;


MERGE INTO ldl_data_production_core_rel.t_revenue_accrual AS src
USING vt_revenue_accrual AS lkp
ON src.int_org_sid = lkp.int_org_sid AND src.real_estate_sid = lkp.real_estate_sid AND src.bus_dt = lkp.bus_dt AND src.accrual_dt
   = lkp.accrual_dt
WHEN MATCHED THEN UPDATE SET
 curr_accrual_fg = CAST(lkp.curr_accrual_fg AS BOOL);


COMMIT;