/* The dwh_valid_fg on t_plan_by_month_1 must be set after the data has been loaded

"TRUE if this record has the greatest dwh_valid_from_tmsp among records with matching {int_org_sid,int_org_type_cd,real_estate_sid,cal_month,planned_val_type_sid,plan_pos_nr}.
FALSE otherwise.

When there is a new current (with highest dwh_valid_from_tmsp) record for keys
{iint_org_sid,int_org_type_cd,real_estate_sid,cal_month,planned_val_type_sid,plan_pos_nr},
in previously current row for the key this column has to be set from TRUE to FALSE."

*/

-- Sort within groups, most recent dwh_valid_from_tmsp determined as the "current record"
BEGIN TRANSACTION;

CREATE OR REPLACE TEMPORARY TABLE ETL.VT_PLAN_BY_MONTH
AS (select int_org_sid,int_org_type_cd,real_estate_sid,cal_month,planned_val_type_sid,plan_pos_nr, dwh_valid_from_tmsp,
	   row_number() over (partition by int_org_sid,int_org_type_cd,real_estate_sid,cal_month,planned_val_type_sid,plan_pos_nr ORDER BY dwh_valid_from_tmsp DESC) as rn,
        CASE WHEN rn = 1 THEN 'TRUE'
        ELSE 'FALSE' END AS dwh_valid_fg
 from core_rel.t_plan_by_month_1);

 MERGE INTO core_rel.t_plan_by_month_1 src
 USING ETL.VT_PLAN_BY_MONTH lkp
 ON src.int_org_sid = lkp.int_org_sid AND
    src.real_estate_sid = lkp.real_estate_sid AND
    src.cal_month = lkp.cal_month AND
    src.planned_val_type_sid = lkp.planned_val_type_sid AND
    src.plan_pos_nr = lkp.plan_pos_nr AND
    src.planned_val_type_sid = lkp.planned_val_type_sid AND
    src.dwh_valid_from_tmsp = lkp.dwh_valid_from_tmsp 
 WHEN MATCHED THEN UPDATE SET src.dwh_valid_fg = lkp.dwh_valid_fg;

COMMIT;
