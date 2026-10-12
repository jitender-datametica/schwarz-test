/*
#----------------------------------------------------------------------------
# Description:
# This view provides the agreggated KPIs on section and item_2 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          PAS_TYPE
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW fe_mstr_toolbox_spiegel.v_agg_spaceman_section_item_pas_fts_2 (
	 INT_ORG_SID COMMENT 'Internal Organisation ID'
	,SPACEMAN_SECTION_SID COMMENT 'Section ID'
	,SPACEMAN_ITEM_SID COMMENT 'Spaceman item_2 ID'
	,CASES COMMENT 'Number of cases with condition for reusing in different columns esp. Potential 1 calculation - KOLLI'
	,MULT_POS_CASES COMMENT 'Number of cases (Mehrfachstellungen) - KOLLI'
	,MULT_POS_EINZEL COMMENT 'Number of cases (Mehrfachstellungen) - EINZEL'
	,CASES_EINZEL COMMENT 'Number of individual items for reusing in different columns - EINZEL'
	,PLACING COMMENT 'Placing of item_2 (EP DD Regal ...)'
	,ITEM_MERCHANDISING_TYPE_CD COMMENT 'Item_2 merchandising type code Hand or Case'
	,CNT_ITEM_2 COMMENT 'Number of item_2'
	,CNT_CASES COMMENT 'Number of cases KOLLI (Mehrfachstellungen)'
	,CNT_CASES_EINZEL COMMENT 'Number of cases EINZEL (Mehrfachstellungen)'
	,AVG_KOLLI COMMENT 'Average kolli width'
	,AVG_EINZEL COMMENT 'Average einzel width'
	,AVG_CONTACT_DISTANCE_PER_ITEM COMMENT 'Average contact_2 distance (width of the position) per item_2'
	,AVG_FACINGS_PER_ITEM COMMENT 'Average facings per item_2'
	,POTENTIAL_1 COMMENT 'Potential 1 (old calculation)'
	,POTENTIAL_1_IN_CM COMMENT 'Potential 1 in cm KOLLI'
	,POTENTIAL_1_IN_CM_EINZEL COMMENT 'Potential 1 in cm EINZEL'
	,CNT_FACINGS COMMENT 'Number of facings'
	,CNT_FACINGS_REDUCED COMMENT 'Number of reduced facings KOLLI'
	,CNT_FACINGS_REDUCED_EINZEL COMMENT 'Number of reduced facings EINZEL'
	,CAPACITY COMMENT 'Capacity of item_2'
	,SECTION_SELECTION_ID COMMENT 'Technical column for export functionality in dashboard -> every section has one row for Yes and No'
	,METRIC_SYSTEM_ID COMMENT 'Technical column for selection the measurement unit_2 for KPIs: cm or inches'
    ,PAS_TYPE COMMENT 'PAS TYPE - Packaged food or Refrigerated'
	,HIGHER_MEAS COMMENT 'Factor to calculate higher meas of measurement value e.g. cm to m -> divide by 100'
	,SHELF_METER COMMENT 'Shelf meter'
	) AS
SELECT 
      INT_ORG_SID
	, SPACEMAN_SECTION_SID
	, SPACEMAN_ITEM_SID
	, CASES
	, MULT_POS_CASES
	, MULT_POS_EINZEL
	, CASES_EINZEL
	, PLACING
	, ITEM_MERCHANDISING_TYPE_CD
	, CNT_ITEM_2
	, CNT_CASES
	, CNT_CASES_EINZEL
	, AVG_KOLLI
	, AVG_EINZEL
	, AVG_CONTACT_DISTANCE_PER_ITEM
	, AVG_FACINGS_PER_ITEM
	, POTENTIAL_1
	, POTENTIAL_1_IN_CM
	, POTENTIAL_1_IN_CM_EINZEL
	, CNT_FACINGS
	, CNT_FACINGS_REDUCED
	, CNT_FACINGS_REDUCED_EINZEL
	, CAPACITY
	, SECTION_SELECTION_ID
	, METRIC_SYSTEM_ID
	, PAS_TYPE
	, HIGHER_MEAS
	, SHELF_METER
FROM FE_MSTR_TOOLBOX_SPIEGEL.T_AGG_SPACEMAN_SECTION_ITEM_PAS_FTS_2
;