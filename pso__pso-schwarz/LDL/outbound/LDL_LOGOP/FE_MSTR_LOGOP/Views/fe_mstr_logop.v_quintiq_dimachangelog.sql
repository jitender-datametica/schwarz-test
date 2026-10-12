/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_dimachangelog
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_dimachangelog (client_id
OPTIONS(description='CLIENT ID - CALCULATED BASED ON THE COUNTRY CODE'), lidl_country
OPTIONS(description='COUNTRY CODE. ORIGINAL FIELD NAME BIC_ZMLILA'), source_system OPTIONS(description='SOURCE SYSTEM'),
wh_id OPTIONS(description='WAREHOUSE ID'), changed_attr OPTIONS(description='THE ATTRIBUTE THAT WAS CHANGED'),
change_tmsp OPTIONS(description='TIME WHEN THE OK BUTTON WAS PRESSED TO TRIGGER THE CHANGE'), change_id
OPTIONS(description='COMBINATION OF ADDRESSFROM  TO  RESOURCETYPE AND TIMEPROFILE'), new_val
OPTIONS(description='THE NEW VALUE OF THE ATTRIBUTE'), old_val OPTIONS(description='THE OLD VALUE OF THE ATTRIBUTE'),
user_nr OPTIONS(description='EMPLOYEE NUMBER OF THE USER THAT MADE THE CHANGE'), changedobject
OPTIONS(description='THE NAME OF THE OBJECT THAT WAS CHANGED (STAGINGDIMACELL OR STAGINGTOLLCELL)'), datasetname
OPTIONS(description='THE NAME OF THE DATASET WHERE THIS CHANGE OCCURED'), reason
OPTIONS(description='The given reason for this DiMa change'), dwh_load_id OPTIONS(description='LOAD ID'), dwh_created
OPTIONS(description='RECORD CREATED AT'), dwh_updated OPTIONS(description='RECORD UPDATED AT'), dwh_valid_from
OPTIONS(description='VALID FROM DATE'), dwh_valid_to OPTIONS(description='VALID TO DATE'), deleted_fg
OPTIONS(description='FLAG IF RECORD IS DELETED')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 *
FROM ldl_logop_data.t_quintiq_dimachangelog;