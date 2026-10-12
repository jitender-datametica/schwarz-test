/*
#----------------------------------------------------------------------------
# COUNTRY TRANSLATION LIST
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2022-03-03 Rafal Rudnik          SD-2524 Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_COUNTRY_TRANS_LIST
COMMENT = 'List of languages avaiable for Translation'
(
 client_id       COMMENT 'Client_ID'
,iso_code     COMMENT 'ISO Language Code'
,lang_postfix          COMMENT 'column postfix for translation'            
)
AS
SELECT
client_id AS client_id
,country_cd AS iso_code
,CONCAT('_', LOWER(COUNTRY_CD)) AS lang_postfix
FROM P_LEW_PROCESS.T_LIDLPLUS_CONFIG_CLIENT;