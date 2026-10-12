CREATE OR REPLACE VIEW  FE_MSTR_AUTODISPO.V_DIM_SOURCE(
	SOURCE_FLAG
  , DESC
) AS
    /* Version: 1.0
	** Author:	Dominik Pfarr
	** Date:    2023-03-22
	** Change:  initial version
	*/
SELECT
 0 AS source_flag
, '3Soft' AS DESC
FROM DUAL
UNION 
SELECT 
1 AS source_flag
, 'Internal' AS DESC
FROM DUAL;