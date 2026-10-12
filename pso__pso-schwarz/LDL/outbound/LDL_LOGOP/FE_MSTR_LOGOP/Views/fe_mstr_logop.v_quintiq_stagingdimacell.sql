/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_stagingdimacell
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_stagingdimacell (client_id
OPTIONS(description='CLIENT ID - CALCULATED BASED ON THE COUNTRY CODE'), lidl_country
OPTIONS(description='COUNTRY CODE. ORIGINAL FIELD NAME BIC_ZMLILA'), source_system OPTIONS(description='SOURCE SYSTEM'),
wh_id OPTIONS(description='WAREHOUSE ID'), src_tgt_dist
OPTIONS(description='DISTANCE FROM ORIGIN TO DESTINATION ADDRESS (DISREGARD UOM)'), src_tgt_dur
OPTIONS(description='DURATION FROM ORIGIN TO DESTIONATION ADDRESS (IN MINUTES) - IMPORTED'), src_address_id
OPTIONS(description='IDENTIFIER OF THE ORIGIN ADDRESS'), resource_type_id
OPTIONS(description='THE IDENTIFIER FOR RESOURCE TYPE'), time_profile_id
OPTIONS(description='IDENTIFIER OF TIME PROFILE'), tgt_address_id
OPTIONS(description='IDENTIFIER OF THE DESTINATION ADDRESS'), toll_dist2
OPTIONS(description='DISTANCE FOR WHICH THE SECOND TYPE OF TOLL IS CONSIDERED'), toll_dist
OPTIONS(description='DISTANCE FOR WHICH FIRST TYPE OF TOLL IS CONSIDERED'), tolldistance3
OPTIONS(description='DISTANCE FOR WHICH THE THIRD TYPE OF TOLL IS CONSIDERED IN KILOMETERS'), dwh_load_id
OPTIONS(description='LOAD ID'), dwh_created OPTIONS(description='RECORD CREATED AT'), dwh_updated
OPTIONS(description='RECORD UPDATED AT'), dwh_valid_from OPTIONS(description='VALID FROM DATE'), dwh_valid_to
OPTIONS(description='VALID TO DATE'), deleted_fg OPTIONS(description='FLAG IF RECORD IS DELETED'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT *
FROM ldl_logop_data.t_quintiq_stagingdimacell;