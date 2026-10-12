
DROP TABLE IF EXISTS DBP_ETL.art_gp_nm_zu_per_dat_relevant;

CREATE  TABLE DBP_ETL.art_gp_nm_zu_per_dat_relevant  (
   dat_relevant DATE NOT NULL,
   dat_ausstieg DATE NOT NULL
)
;

DELETE FROM DBP_ETL_PROCESS.metadata_kmo_bq_findung
WHERE ende IS NULL;


INSERT INTO DBP_ETL.art_gp_nm_zu_per_dat_relevant (dat_relevant,
                                                     dat_ausstieg)
SELECT MIN(dat) AS dat_relevant,
       MAX(dat) AS dat_ausstieg
FROM DBP_DATA.tag
WHERE dat BETWEEN (SELECT MAX(snapshot_datum)+1
                   FROM DBP_ETL_PROCESS.metadata_kmo_bq_findung) AND CURRENT_DATE-1
;

