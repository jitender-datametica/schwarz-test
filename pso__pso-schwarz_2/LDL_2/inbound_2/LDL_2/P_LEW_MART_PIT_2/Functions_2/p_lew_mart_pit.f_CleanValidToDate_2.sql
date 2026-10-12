/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for SF Functions CleanValidFromDate PITonCloud
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Region_2 Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
Function	:	f_CleanValidToDate(valid_from_dt date)
Input		:	valid_from_dt date
                
Return		:   Date 
Convert		: 	None 
Description	:	Converts incorrect valid_from_dt 9999-12-30 to 9999-12-31 harmonizing the CDC for PIT 
				other dates are return as the are
TYPE		:	SQL-Function - single scalar				
Example		:	SELECT f_CleanValidToDate( '9999-12-30'::DATE ), f_CleanValidToDate( '2022-12-30'::DATE )
------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION p_lew_mart_pit.f_cleanvalidtodate(
  p_valid_from_dt DATE
)
RETURNS DATE
AS (
  CASE
    WHEN p_valid_from_dt IS NULL OR p_valid_from_dt = DATE '9999-12-30' THEN DATE '9999-12-31'
    ELSE p_valid_from_dt
  END
); -- End of f_CleanValidToDate
--SELECT f_CleanValidToDate( '9999-12-30'::DATE ), f_CleanValidToDate( '2022-12-30'::DATE ); 