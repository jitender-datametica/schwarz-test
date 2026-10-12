/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lpv_area
Description		|	LPV - prepared view on source table
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_AREA(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	LIDL_CTRY COMMENT 'Country code. Original field name bic_zmlila',
	SRC_SYS COMMENT 'source_system: LPV',
	WH_ID COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	AREA_NR COMMENT 'area_number (datastore_data:area_number',
	AREA_DESC COMMENT 'area_description (datastore_data:area_description)',
	RESERVE_AREA_NR COMMENT 'Location ID of the reserve area. FK: References LPV.BEREICH.NR. Original name - RESBEREICH',
	DWH_LOAD_ID COMMENT 'Load id',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DELETED_FG COMMENT 'Flag if record is deleted'
) COMMENT='LPV - prepared view on base table'
AS
SELECT
	 CLIENT_ID
	,LIDL_COUNTRY AS LIDL_CTRY
	,SOURCE_SYSTEM AS SRC_SYS
	,WH_ID
	,AREA_NR
	,CASE 
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26') AND AREA_NR = '700' THEN 'Reserve DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','8') AND AREA_NR = '702' THEN 'Reserve DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','4','6','7','11','16','18','20','24','26') AND AREA_NR = '703' THEN 'Reserve DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('3','9','10','12','13','14','17','19','21','22','23','25','27') AND AREA_NR = '704' THEN 'Reserve DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID = '15' AND AREA_NR = '709' THEN 'Reserve DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27') AND AREA_NR = '701' THEN 'Reserve FRAIS'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','4','6','7','9','10','11','12','13','14','15','18','19','20','21','22','23','24','25','26','27') AND AREA_NR = '702' THEN 'Reserve SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID = '2' AND AREA_NR = '704' THEN 'Reserve SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID = '5' AND AREA_NR = '707' THEN 'Reserve SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID = '17' AND AREA_NR = '709' THEN 'Reserve SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID IN ('8','16') AND AREA_NR = '706' THEN 'Reserve SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID IN ('3','9','10','12','14','17','19','21','23','25','27') AND AREA_NR = '703' THEN 'Reserve CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID = '4' AND AREA_NR = '707' THEN 'Reserve CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID = '24' AND AREA_NR = '704' THEN 'Reserve CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID IN ('8','16') AND AREA_NR = '705' THEN 'Reserve CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID = '11' AND AREA_NR = '706' THEN 'Reserve CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','6','7','8','10','13','19','24','25','27') AND AREA_NR = '708' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID = '17' AND AREA_NR = '702' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID = '22' AND AREA_NR = '703' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('15','18') AND AREA_NR = '704' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','26') AND AREA_NR = '705' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('4','6','9','20') AND AREA_NR = '706' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('11','12','14','22') AND AREA_NR = '707' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('21','23','24') AND AREA_NR = '709' THEN 'Reserve NF'
		WHEN CLIENT_ID=12 AND WH_ID = '13' AND AREA_NR = '703' THEN 'Reserve BLOCK'
		WHEN CLIENT_ID=12 AND WH_ID = '15' AND AREA_NR = '706' THEN 'Reserve BLOCK'
		WHEN CLIENT_ID=12 AND WH_ID = '23' AND AREA_NR = '708' THEN 'Reserve BLOCK'
		WHEN CLIENT_ID=12 AND WH_ID IN ('3','6','10','13','19','25','27') AND AREA_NR = '709' THEN 'Reserve ACTION'
		WHEN CLIENT_ID=12 AND WH_ID = '24' AND AREA_NR = '710' THEN 'Reserve ACTION'
		WHEN CLIENT_ID=12 AND WH_ID IN ('4','9','11','12','14','15','21') AND AREA_NR = '708' THEN 'Reserve ACTION'
		WHEN CLIENT_ID=12 AND WH_ID IN ('17','20') AND AREA_NR = '707' THEN 'Reserve ACTION'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','18','22','23','26') AND AREA_NR = '706' THEN 'Reserve ACTION'
		WHEN CLIENT_ID=12 AND WH_ID = '7' AND AREA_NR = '704' THEN 'Reserve ACTION'
		WHEN CLIENT_ID=12 AND WH_ID = '19' AND AREA_NR = '710' THEN 'Reserve ACTION FREEZER'
		WHEN CLIENT_ID=12 AND WH_ID = '13' AND AREA_NR = '706' THEN 'Reserve ACTION AMBIENT'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27') AND AREA_NR = '1' THEN 'Picking DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','8','16') AND AREA_NR = '3' THEN 'Picking DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','4','6','7','11','18','20','24','26') AND AREA_NR = '4' THEN 'Picking DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('3','9','10','12','13','14','17','19','21','22','23','25','27') AND AREA_NR = '5' THEN 'Picking DETAIL'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27') AND AREA_NR = '2' THEN 'Picking FRAIS'
		WHEN CLIENT_ID=12 AND WH_ID = '15' AND AREA_NR = '4' THEN 'Picking FRAIS'
		WHEN CLIENT_ID=12 AND WH_ID IN ('19','24') AND AREA_NR = '7' THEN 'Picking FRAIS'
		WHEN CLIENT_ID=12 AND WH_ID = '2' AND AREA_NR = '5' THEN 'Picking SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','17') AND AREA_NR = '9' THEN 'Picking SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID IN ('8','16') AND AREA_NR = '6' THEN 'Picking SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID = '2' AND AREA_NR = '5' THEN 'Picking SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','4','6','7','9','10','11','12','13','14','15','18','19','20','21','22','23','24','25','26','27') AND AREA_NR = '3' THEN 'Picking SURGELE'
		WHEN CLIENT_ID=12 AND WH_ID = '4' AND AREA_NR = '9' THEN 'Picking CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID IN ('8','11','16','24') AND AREA_NR = '5' THEN 'Picking CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID IN ('3','9','10','12','14','17','19','21','23','25','27') AND AREA_NR = '4' THEN 'Picking CHOCO'
		WHEN CLIENT_ID=12 AND WH_ID IN ('12','21','23','24') AND AREA_NR = '9' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('2','3','6','7','8','9','10','13','14','19','24','25','27') AND AREA_NR = '8' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID = '12' AND AREA_NR = '7' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('4','11','20','26') AND AREA_NR = '6' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','15','18') AND AREA_NR = '5' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID = '22' AND AREA_NR = '4' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID = '17' AND AREA_NR = '3' THEN 'Picking NF'
		WHEN CLIENT_ID=12 AND WH_ID = '23' AND AREA_NR = '8' THEN 'Picking BLOCK'
		WHEN CLIENT_ID=12 AND WH_ID = '24' AND AREA_NR = '10' THEN 'Picking ACTION'
		WHEN CLIENT_ID=12 AND WH_ID IN ('3','6','8','9','10','13','14','19','25','27') AND AREA_NR = '9' THEN 'Picking ACTION'
		WHEN CLIENT_ID=12 AND WH_ID IN ('4','11','12','15','17','18','20','21','22','26') AND AREA_NR = '8' THEN 'Picking ACTION'
		WHEN CLIENT_ID=12 AND WH_ID IN ('5','23') AND AREA_NR = '6' THEN 'Picking ACTION'
		WHEN CLIENT_ID=12 AND WH_ID = '7' AND AREA_NR = '5' THEN 'Picking ACTION'
		WHEN CLIENT_ID=12 AND WH_ID = '19' AND AREA_NR = '10' THEN 'Picking ACTION FREEZER'
		WHEN AREA_NR = 0 AND AREA_DESCR IS NULL THEN 'Nachschub GZ'
		ELSE AREA_DESCR
	END AS AREA_DESC
	,RESERVE_AREA_NR
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
	,DWH_VALID_FROM
	,DWH_VALID_TO
	,DELETED_FG
FROM DATA.T_LPV_AREA
WHERE CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
AND DELETED_FG = 0;