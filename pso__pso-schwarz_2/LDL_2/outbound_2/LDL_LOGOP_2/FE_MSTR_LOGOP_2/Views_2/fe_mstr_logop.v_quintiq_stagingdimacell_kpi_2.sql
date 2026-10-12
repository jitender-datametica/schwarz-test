/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_stagingdimacell_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_stagingdimacell_kpi_2 (client_id
OPTIONS(description='CLIENT ID - CALCULATED BASED ON THE COUNTRY_2 CODE'), lidl_country
OPTIONS(description='COUNTRY_2 CODE. ORIGINAL FIELD NAME BIC_ZMLILA'), source_system OPTIONS(description='SOURCE SYSTEM'),
wh_id OPTIONS(description='WAREHOUSE ID'), src_tgt_dist
OPTIONS(description='DISTANCE FROM ORIGIN TO DESTINATION ADDRESS_2 (DISREGARD UOM)'), src_tgt_dur
OPTIONS(description='DURATION FROM ORIGIN TO DESTIONATION ADDRESS_2 (IN MINUTES) - IMPORTED'), src_address_id
OPTIONS(description='IDENTIFIER OF THE ORIGIN ADDRESS_2'), resource_type_id
OPTIONS(description='THE IDENTIFIER FOR RESOURCE TYPE'), time_profile_id
OPTIONS(description='IDENTIFIER OF TIME PROFILE'), tgt_address_id
OPTIONS(description='IDENTIFIER OF THE DESTINATION ADDRESS_2'), toll_dist2
OPTIONS(description='DISTANCE FOR WHICH THE SECOND TYPE OF TOLL IS CONSIDERED'), toll_dist
OPTIONS(description='DISTANCE FOR WHICH FIRST TYPE OF TOLL IS CONSIDERED'), tolldistance3
OPTIONS(description='DISTANCE FOR WHICH THE THIRD TYPE OF TOLL IS CONSIDERED IN KILOMETERS'), dwh_load_id
OPTIONS(description='LOAD ID'), dwh_created OPTIONS(description='RECORD CREATED AT'), dwh_updated
OPTIONS(description='RECORD UPDATED AT'), dwh_valid_from OPTIONS(description='VALID FROM DATE'), dwh_valid_to
OPTIONS(description='VALID TO DATE'), deleted_fg OPTIONS(description='FLAG IF RECORD IS DELETED'), active_fg
OPTIONS(description='FLAG IF RECORD IS ACTIVE')) OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS
SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 src_tgt_dist,
 src_tgt_dur,
 src_address_id,
 resource_type_id,
 time_profile_id,
 tgt_address_id,
 toll_dist2,
 toll_dist,
 tolldistance3,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_stagingdimacell_2;