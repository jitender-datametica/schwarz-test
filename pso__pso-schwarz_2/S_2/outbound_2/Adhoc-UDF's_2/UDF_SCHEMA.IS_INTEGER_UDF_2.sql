CREATE OR REPLACE FUNCTION UDF_SCHEMA.IS_INTEGER_UDF(value JSON) RETURNS BOOL LANGUAGE js AS R"""
if (value === null || value === undefined) return false;

  // If the value is a number, check if it's an integer
  if (typeof value === 'number') {
    return Number.isInteger(value);
  }

  // Reject strings or any non-number types
  return false;
""";
