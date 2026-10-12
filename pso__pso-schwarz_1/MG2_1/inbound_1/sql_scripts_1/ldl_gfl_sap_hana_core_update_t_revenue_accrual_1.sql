/* The curr_accrual_fg on t_revenue_accrual_1 must be set after the data has been loaded

"TRUE if this record has the greatest accrual_dt among records with matching {int_org_sid, bus_dt}.
FALSE otherwise.

When there is a new current (with highest accrual_dt) record for keys
{int_org_sid, bus_dt},
in previously current row for the key this column has to be set from TRUE to FALSE."

*/

-- Sort within groups, most recent accrual date determined as the "current accrual"
BEGIN TRANSACTION;

CREATE OR REPLACE TEMPORARY TABLE ETL.VT_REVENUE_ACCRUAL
AS (select INT_ORG_SID, REAL_ESTATE_SID, BUS_DT, ACCRUAL_DT,
	   row_number() over (partition by INT_ORG_SID, REAL_ESTATE_SID, BUS_DT ORDER BY ACCRUAL_DT DESC) as rn,
        CASE WHEN rn = 1 THEN 'TRUE'
        ELSE 'FALSE' END AS CURR_ACCRUAL_FG
 from core_rel.t_revenue_accrual_1);

 MERGE INTO core_rel.t_revenue_accrual_1 src
 USING ETL.VT_REVENUE_ACCRUAL lkp
 ON src.INT_ORG_SID = lkp.INT_ORG_SID AND
    src.REAL_ESTATE_SID = lkp.REAL_ESTATE_SID AND
    src.BUS_DT = lkp.BUS_DT AND
    src.ACCRUAL_DT = lkp.ACCRUAL_DT
 WHEN MATCHED THEN UPDATE SET src.CURR_ACCRUAL_FG = lkp.CURR_ACCRUAL_FG;

COMMIT;
