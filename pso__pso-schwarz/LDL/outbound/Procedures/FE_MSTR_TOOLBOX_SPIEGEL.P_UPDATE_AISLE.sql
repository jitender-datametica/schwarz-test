/*
#----------------------------------------------------------------------------
# Description:
# This procedure provides updates new aisle to the store in the toolbox configuration.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/



CREATE OR REPLACE PROCEDURE fe_mstr_toolbox_spiegel.p_update_aisle(IN SPACEMAN_SECTION_SID INT64, IN CLIENT_ID INT64, IN MOVE_TO_STORE_ID INT64, IN AISLE STRING)
BEGIN
BEGIN TRANSACTION;
UPDATE fe_mstr_toolbox_spiegel.t_spaceman_section_store_aisle SET
    aisle = AISLE,
    dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE spaceman_section_sid = SPACEMAN_SECTION_SID AND client_id = CLIENT_ID AND move_to_store_id = MOVE_TO_STORE_ID;
COMMIT TRANSACTION;
END;