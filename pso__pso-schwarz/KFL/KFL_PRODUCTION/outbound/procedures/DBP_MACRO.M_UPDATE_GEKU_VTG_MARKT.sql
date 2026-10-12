CREATE OR REPLACE PROCEDURE dbp_macro.m_update_geku_vtg_markt(IN VERTEILGEBIET_UID FLOAT64, IN WUP_ID FLOAT64, IN MANDANT_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
SET sql_stmt  =  -- using select
  'MERGE INTO dbp_data.geku_verteilgebiet AS TARGET USING (SELECT mandant_id,   nils_verteilgebiet_id  FROM dbp_data.vaus_wup  WHERE mandant_id = @MANDANT_ID  AND wup_id = @WUP_ID) AS using_select ON TARGET.verteilgebiet_uid = @VERTEILGEBIET_UID WHEN MATCHED THEN UPDATE SET  nils_verteilgebiet_id = using_select.nils_verteilgebiet_id,  mandant_id = using_select.mandant_id ';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  WUP_ID AS WUP_ID,  VERTEILGEBIET_UID AS VERTEILGEBIET_UID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
