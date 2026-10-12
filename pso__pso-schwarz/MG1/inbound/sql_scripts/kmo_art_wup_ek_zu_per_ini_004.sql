
--translated statement
CREATE  TABLE DBP_ETL.kmo_art_wup_ek_datum_relevant  (
   dat_relevant DATE NOT NULL,
   dat_ausstieg DATE NOT NULL
)
;


INSERT INTO DBP_ETL.kmo_art_wup_ek_datum_relevant (dat_relevant,
                                                     dat_ausstieg) 
SELECT MIN(dat) AS dat_relevant,
       MAX(dat) AS dat_ausstieg
FROM DBP_DATA.tag
WHERE dat BETWEEN (SELECT MAX(snapshot_datum)+1
                   FROM DBP_ETL_PROCESS.metadata_kmo_art_wup_ek) AND CURRENT_DATE-1;

