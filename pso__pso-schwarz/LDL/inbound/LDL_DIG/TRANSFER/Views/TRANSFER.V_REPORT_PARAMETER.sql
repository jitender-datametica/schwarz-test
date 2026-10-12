CREATE OR REPLACE VIEW transfer.v_report_parameter
(
	report
	, entry_no
	, parameter_type
	, parameter_name
	, parameter_value_char
	, parameter_value_numeric
	, tmsp_insert
	, tmsp_update
) 
AS 
SELECT
	report
	, entry_no
	, parameter_type
	, parameter_name
	, parameter_value_char
	, parameter_value_numeric
	, tmsp_insert
	, tmsp_update
FROM 
	meta.t_report_parameter
;