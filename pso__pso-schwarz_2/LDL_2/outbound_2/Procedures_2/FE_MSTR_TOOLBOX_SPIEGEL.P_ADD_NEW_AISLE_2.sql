/*
#----------------------------------------------------------------------------
# Description:
# This procedure provides adds new aisle to the store in the toolbox configuration.
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE fe_mstr_toolbox_spiegel.p_add_new_aisle(IN SPACEMAN_SECTION_SID INT64, IN CLIENT_ID INT64, IN MOVE_TO_STORE_ID INT64, IN AISLE STRING)
BEGIN
BEGIN TRANSACTION;
INSERT INTO fe_mstr_toolbox_spiegel.t_spaceman_section_store_aisle_2 (spaceman_section_sid, client_id, move_to_store_id, aisle, dwh_created, dwh_updated)
(SELECT SPACEMAN_SECTION_SID , CLIENT_ID , MOVE_TO_STORE_ID , AISLE, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM (SELECT 0 AS zero) AS t
    WHERE AISLE <> '-');
COMMIT TRANSACTION;
END;
