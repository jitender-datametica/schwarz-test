CREATE OR REPLACE PROCEDURE KFL_PRODUCTION_DBP_MACRO.M_UPS_USER_ROLLE_EK_INT_ZU(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN ROLLE_ID FLOAT64, IN ZEK_ID STRING, IN WBL_ID FLOAT64, IN GF_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;

SET sql_stmt = '''MERGE INTO KFL_PRODUCTION_DBP_SECURITY.user_rolle_ek_int_zu_2 AS target
USING (
  SELECT
    ? AS mandant_id,
    CASE 
      WHEN ? = "adminkis" THEN ?
      ELSE CONCAT(UPPER(SUBSTR(?, 1, 2)), LOWER(SUBSTR(?, 3 ,length(?) - 2)))
    END AS user_id,
    ? AS rolle_id,
    ? AS zek_id,
    ? AS wbl_id,
    ? AS gf_id
) AS source
ON target.mandant_id = source.mandant_id
   AND target.user_id = source.user_id
   AND target.rolle_id = source.rolle_id
   AND (target.zek_id = source.zek_id OR source.zek_id IS NULL)
   AND (target.wbl_id = source.wbl_id OR source.wbl_id IS NULL)
   AND (target.gf_id = source.gf_id OR source.gf_id IS NULL)

WHEN MATCHED THEN
  UPDATE SET target.rolle_bez = NULL

WHEN NOT MATCHED THEN
  INSERT (mandant_id, user_id, rolle_id, rolle_bez, zek_id, wbl_id, gf_id)
  VALUES (
    source.mandant_id,
    source.user_id,
    source.rolle_id,
    NULL,
    CASE WHEN source.rolle_id = 1 THEN source.zek_id ELSE NULL END,
    CASE WHEN source.rolle_id = 2 THEN source.wbl_id ELSE NULL END,
    CASE WHEN source.rolle_id = 3 THEN source.gf_id ELSE NULL END
  );
''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID,USER_ID,USER_ID,USER_ID,USER_ID,USER_ID,ROLLE_ID,ZEK_ID,WBL_ID,GF_ID;
SET sql_commit  =  'COMMIT TRANSACTION'
;

EXECUTE IMMEDIATE (sql_commit);
END;
