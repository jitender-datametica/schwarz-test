--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Function calls 
--original statement
--CALL ${DWH_COMMON_DBX_PROCESS}.kmep_calc_rb_wo ('WW');
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'CALL'.
--CALL DBP_ETL_PROCES ^^^> S.kmep_calc_rb_wo ('WW');
--translated statement
CALL DBP_ETL_PROCESS.kmep_calc_rb_wo ('WW');

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Function calls 
--original statement
--CALL ${DWH_COMMON_DBX_PROCESS}.kmep_calc_rb_wo ('KW');
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'CALL'.
--CALL DBP_ETL_PROCES ^^^> S.kmep_calc_rb_wo ('KW');
--translated statement
CALL DBP_ETL_PROCESS.kmep_calc_rb_wo ('KW');

