CREATE OR REPLACE FUNCTION UDF_SCHEMA.flatten(input JSON, path STRING, outer_ BOOL, recursive_ BOOL, mode STRING) RETURNS ARRAY<STRUCT<SEQ INT64, KEY STRING, PATH STRING, INDEX INT64, VALUE JSON, THIS JSON>> LANGUAGE js
OPTIONS (description="Emulates the 'flatten' function present in Snowflake.") AS R"""
mode = mode.toLowerCase();
  if (mode === "array" && !Array.isArray(input)) {
        if (outer_) {
    return [{
      SEQ: 1,
      KEY: null,
      PATH: null,
      INDEX: null,
      VALUE: null,
      THIS: input
    }];
  }
    return [];
  }
    if (mode === "object" && Array.isArray(input)) {
        if (outer_) {
    return [{
      SEQ: 1,
      KEY: null,
      PATH: null,
      INDEX: null,
      VALUE: null,
      THIS: input
    }];
  }
    return [];
  }
  
  
  if (path.length > 0) {
    for (part of path.matchAll(/(\.?\w+)|(\[\d+\])/g)) {
      input = input[part[0].replace(/[\[\].]/g, '')];
    }
  }
  let f = function(i, p) {
    let result = [];
    let index = 0;
    let arr = Array.isArray(i);
    for (const [key, value] of Object.entries(i)) {
      index++;
      let path = p;
      if (p.length > 0 && !arr) {
        path = path + '.';
      }
      path = path + (arr ? '[' + key + ']' : key);
      result.push({
        SEQ: index,
        KEY: arr ? null : key,
        PATH: path,
        INDEX: arr ? key : null,
        VALUE: value,
        THIS: i
      });

      const isArray = Array.isArray(value);
      const arrayRecurse = (mode === 'array' || mode === 'both') && isArray;
      const objectRecurse = (mode === 'object' || mode === 'both') &&
          !isArray && Object.isExtensible(value);
      if (recursive_ && (arrayRecurse || objectRecurse)) {
        result = result.concat(f(value, path));
      }
    }
    return result;
  };
  let result = f(input, path);
  if (outer_ && result.length === 0) {
    return [{
      SEQ: 1,
      KEY: null,
      PATH: null,
      INDEX: null,
      VALUE: null,
      THIS: input
    }];
  }
  return result;
""";
