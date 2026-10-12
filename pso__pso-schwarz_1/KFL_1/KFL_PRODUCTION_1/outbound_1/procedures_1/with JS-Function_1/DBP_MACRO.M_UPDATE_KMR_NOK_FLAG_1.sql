CREATE OR REPLACE PROCEDURE `dbp_macro.m_update_kmr_nok_flag`(
  mdl_frage_id FLOAT64,
  mdl_antwort_id FLOAT64,
  mdl_nok_fg FLOAT64
)
BEGIN
  -- Start a transaction to mirror the explicit COMMIT in the original script
  BEGIN TRANSACTION;

  UPDATE `dbp_data.mdl_frage_antwort_zu_1`
  SET 
    nok_fg = cast(mdl_nok_fg as int64)
  WHERE antwort_id = mdl_antwort_id
    AND frage_id = mdl_frage_id;

  COMMIT TRANSACTION;

  -- Optional: return a status_1 result
  SELECT 'Update successful' AS status_1;

EXCEPTION WHEN ERROR THEN
  -- Rollback in case of technical failure
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;