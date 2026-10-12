
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


CREATE OR REPLACE PROCEDURE FE_MSTR_TOOLBOX_SPIEGEL.P_UPDATE_AISLE (SPACEMAN_SECTION_SID NUMBER, CLIENT_ID NUMBER, MOVE_TO_STORE_ID NUMBER, AISLE VARCHAR(20))
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
BEGIN
  UPDATE FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_SECTION_STORE_AISLE_1 
  SET 
    AISLE = :AISLE,
    DWH_UPDATED = CURRENT_TIMESTAMP
  WHERE 
    SPACEMAN_SECTION_SID = :SPACEMAN_SECTION_SID AND
    CLIENT_ID = :CLIENT_ID AND
    MOVE_TO_STORE_ID = :MOVE_TO_STORE_ID;
  COMMIT;
END;
$$
;