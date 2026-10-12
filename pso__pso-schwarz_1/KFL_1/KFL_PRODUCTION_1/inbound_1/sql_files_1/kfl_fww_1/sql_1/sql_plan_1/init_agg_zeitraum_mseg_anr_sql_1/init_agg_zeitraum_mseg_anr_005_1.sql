--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.kmo_mseg_dat_1
(     
     dat_buch
    ,mandant_id
)
SELECT
 t2.dat
,t1.mandant_id
FROM DBP_ETL.zeitraum_mseg_anr_1 t1_1
INNER JOIN DBP_DATA.tag_1 t2
ON t2.dat BETWEEN t1.min_dat AND t1.max_dat

;

