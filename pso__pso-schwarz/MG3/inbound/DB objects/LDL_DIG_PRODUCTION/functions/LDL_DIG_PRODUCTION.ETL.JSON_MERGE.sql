CREATE OR REPLACE FUNCTION LDL_DIG_PRODUCTION.ETL.JSON_MERGE(""O1"" OBJECT, ""O2"" OBJECT)
RETURNS OBJECT
LANGUAGE JAVASCRIPT
AS '
  if (O1 === null || typeof O1 === ''undefined'') {
    return O2;
  } else {
    return Object.assign({}, O1, O2);
  }
';