--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.l_ma_1

SET     dat_bis = t2.dat_bis_
FROM
(SELECT     ma_id       as ma_id_
         , dat_bis      as dat_bis_
 FROM ${TEMP_TABLE} /*DBP_ETL.l_ma_temp */
 WHERE dat_bis <> to_date('99991231','YYYYMMDD') /*80991231*/
   AND (ma_id, dat_von) in 
   (SELECT ma_id,max(dat_von) as dat_von FROM ${TEMP_TABLE} /*DBP_ETL.l_ma_temp*/ GROUP BY 1)
) t2
 WHERE   ma_id   = t2.ma_id_;

