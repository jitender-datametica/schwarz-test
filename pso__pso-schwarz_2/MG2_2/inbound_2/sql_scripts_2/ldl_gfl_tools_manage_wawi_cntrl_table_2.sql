select * from etl.wawi_control_table_2 where SOURCE_TABLE_NAME = '$SRC_NAME'

/*
MERGE INTO etl.wawi_control_table_2 AS TGT
USING (SELECT $SRC_NAME AS SOURCE_TABLE_NAME
     , '1900-01-01 00:00:00.000000' AS BEGIN_TMSP
     , '1900-01-01 00:00:00.000000' AS END_TMSP
     , 0 AS REC_COUNT
     , 'A' AS SOURCE_STATUS
     , current_timestamp() AS UPDATED_TMSP) AS SRC 
   ON SRC.SOURCE_TABLE_NAME = TGT.SOURCE_TABLE_NAME
 WHEN NOT MATCHED THEN 
      INSERT (SOURCE_TABLE_NAME
           , BEGIN_TMSP
           , END_TMSP
           , REC_COUNT
           , SOURCE_STATUS
           , UPDATED_TMSP)
      VALUES (SRC.SOURCE_TABLE_NAME
           , SRC.BEGIN_TMSP
           , SRC.END_TMSP
           , SRC.REC_COUNT
           , SRC.SOURCE_STATUS
           , SRC.UPDATED_TMSP)    
;
*/
