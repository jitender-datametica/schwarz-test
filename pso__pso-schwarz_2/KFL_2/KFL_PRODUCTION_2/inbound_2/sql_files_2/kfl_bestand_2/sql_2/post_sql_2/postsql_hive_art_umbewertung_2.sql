INSERT INTO DBP_ETL_PROCESS.hive_art_umbewertung_2
SELECT
        B.mandant_id, 
        B.dat_umbew,
        'ZUSEG', 
        current_date,
        current_date,
        current_date 
FROM            DBP_ETL.kmo_idb_zmuseg_2 A
INNER JOIN      DBP_DATA.art_umbewertung_2 B
on  A.mandant_id        = B.mandant_id
AND A.umbew_beleg_id    = B.umbew_beleg_id
AND A.umbew_beleg_pos_id= B.umbew_beleg_pos_id
AND A.kj                = B.kj
GROUP BY B.mandant_id, B.dat_umbew;

