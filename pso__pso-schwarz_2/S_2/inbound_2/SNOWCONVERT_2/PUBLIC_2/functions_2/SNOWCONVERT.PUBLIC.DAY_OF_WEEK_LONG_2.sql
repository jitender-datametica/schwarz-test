CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.DAY_OF_WEEK_LONG("VAL2" TIMESTAMP_NTZ(9))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
    decode(dayname(val2), ''Sun'' , ''Sunday''
         , ''Mon'' ,''Monday''
         , ''Tue'' ,''Tuesday''
         , ''Wed'' ,''Wednesday''
         , ''Thu'' ,''Thursday''
         , ''Fri'',''Friday''
         , ''Sat'' ,''Saturday''
         ,''None'')
';