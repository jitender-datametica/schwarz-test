create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_INC_PRB_MATCHING__1WEEK_GB_1(
	NUMBER,
	PROBLEM_NUMBER
) as
select number, problem_number from data.v_cel_incident_1Week_GB_1 where problem_number is not null;