/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : DDL for F_CHANGE_KPI_SQL
#-------------------------------------------------------------------------------
# Describtion: Create DDL for F_CHANGE_KPI_EXP
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-08-04 Nikolai Toknov    Initial version
#-------------------------------------------------------------------------------
# 
# The function is required to generate a workable SQL expression 
# by analyzing the SQL expression KPI_SQL to find columns from the parameter COLUMN_LIST and adding the symbol '_' before the column name. 
# 
# The function is used when generating an SQL expression for calculating secondary KPIs in the procedure sp_agg_merge.
# 
# Parameters: 
# KPI_SQL - initial SQL-expression for calculation
# COLUMN_LIST - list of columns, to the name of which it is necessary to add the _ symbol in the SQL-expression. 
#
# Function result: 
# - corrected SQL-expression. 
# 
# 
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_change_kpi_exp(
  kpi_sql STRING,
  column_list STRING
)
RETURNS STRING
LANGUAGE js AS r"""

var v_kpi_sql = kpi_sql;
var v_column_list = column_list;

if (v_column_list !== null && v_column_list.length > 0) {
    v_kpi_sql = v_kpi_sql.replaceAll(v_column_list, '_' + v_column_list);
}

return v_kpi_sql;

""";