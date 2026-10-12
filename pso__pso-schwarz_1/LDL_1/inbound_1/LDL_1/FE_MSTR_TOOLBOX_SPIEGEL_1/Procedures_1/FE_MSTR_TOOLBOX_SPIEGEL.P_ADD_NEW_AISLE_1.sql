/*
#----------------------------------------------------------------------------
# Description:
# This procedure provides adds new aisle to the store in the toolbox configuration.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE FE_MSTR_TOOLBOX_SPIEGEL.P_ADD_NEW_AISLE (SPACEMAN_SECTION_SID NUMBER, CLIENT_ID NUMBER, MOVE_TO_STORE_ID NUMBER, AISLE VARCHAR(20))
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
BEGIN
  INSERT INTO FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_SECTION_STORE_AISLE_1 
  (spaceman_section_sid, client_id, move_to_store_id, aisle, dwh_created, dwh_updated)
  SELECT :SPACEMAN_SECTION_SID, :CLIENT_ID, :MOVE_TO_STORE_ID, :AISLE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
  WHERE :AISLE <> '-';
  Commit;
END;
$$
;
