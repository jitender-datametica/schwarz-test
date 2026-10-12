create or replace view LDL_DATA_PRODUCTION.META.V_SCHEDULING_FREQUENCY_2(
	SCHEDULING_FREQ_CD COMMENT 'A code defining, how often a scheduling unit_2 or a test_2 is executed. E.g daily, weekly, ...',
	SCHEDULING_FREQ_DESCR COMMENT 'A textual description for the scheduling frequency.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity describes, how often a scheduling unit_2 or a test_2 is executed. E.g. daily, weekly, ...'
 as
SELECT
   scheduling_freq_cd
  ,scheduling_freq_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_SCHEDULING_FREQUENCY_2
UNION
SELECT '@', 'Unknown scheduling frequency', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;