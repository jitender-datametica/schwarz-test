/*
###########################################################################
#  update archiv records
###########################################################################
*/
UPDATE ${KFL_SNFLK_COMMON_DBP_DATA}.ma_hierarchie_zu_per_2
FROM 
(
        SELECT 
                ma_id_,
                ma_mutter_id_,
                dat_bis_
        FROM (  SELECT  p.ma_id         AS ma_id_
                      , p.ma_mutter_id  AS ma_mutter_id_
                      , MAX(l.dat_bis)  AS dat_bis_
                FROM   ${KFL_SNFLK_COMMON_DBP_DATA}.ma_hierarchie_zu_per_2 p
                INNER JOIN ${KFL_SNFLK_COMMON_DBP_DATA}.l_ma_2 l
                         ON p.ma_id = l.ma_id
                WHERE p.dat_bis = '9999-12-31'
                  AND p.ma_id in ( SELECT ma_id 
	                           FROM(
                                        SELECT ma_id, MAX(dat_bis)as max_dat_bis 
                                        FROM ${KFL_SNFLK_COMMON_DBP_DATA}.l_ma_2 
                                        GROUP BY 1
                                        ) q
                                   WHERE max_dat_bis <> '9999-12-31' 
                                 )	                    
                GROUP BY 1,2	  
                ) q

        GROUP BY 1,2,3
 ) t2

  SET    dat_bis   = t2.dat_bis_
        ,td_update = CURRENT_TIMESTAMP
WHERE    ma_id             = t2.ma_id_
  AND    ma_mutter_id      = t2.ma_mutter_id_
  AND    dat_bis           = '9999-12-31';

/*
###########################################################################
#  update archiv records
###########################################################################
*/

UPDATE ${KFL_SNFLK_COMMON_DBP_DATA}.ma_hierarchie_zu_per_2
SET dat_bis = CURRENT_DATE
   ,td_update = CURRENT_TIMESTAMP
WHERE (ma_id,ma_mutter_id)   not in
(SELECT ma_id,ma_mutter_id FROM ${KFL_SNFLK_COMMON_DBP_LOAD}.ma_hierarchie_zu_per_temp_2)
AND dat_bis = '9999-12-31'
;
