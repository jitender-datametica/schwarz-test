CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.MONTH_NAME_LONG("VAL2" TIMESTAMP_NTZ(9))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
    decode(monthname(val2)
         , ''Jan'' ,''January''
         , ''Feb'' ,''February''
         , ''Mar'' ,''March''
         , ''Apr'' ,''April''
         , ''May'' ,''May''
         , ''Jun'' ,''June''
         , ''Jul'' ,''July''
         , ''Aug'' ,''August''
         , ''Sep'' ,''September''
         , ''Oct'' ,''October''
         , ''Nov'' ,''November''
         , ''Dec'' ,''December''
         ,''None'')
';