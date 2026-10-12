CREATE OR REPLACE FUNCTION `ldl_dig_production_etl.json_merge`(o1 JSON, o2 JSON)
RETURNS JSON
LANGUAGE js AS r"""
  if (o1 === null || o1 === undefined) {
    return o2;
  }
  return Object.assign({}, o1, o2);
""";
