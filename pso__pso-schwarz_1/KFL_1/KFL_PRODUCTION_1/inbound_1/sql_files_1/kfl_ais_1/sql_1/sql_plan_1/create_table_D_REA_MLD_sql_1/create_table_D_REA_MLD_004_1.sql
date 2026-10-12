--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.rea_inlist_1 ;
CREATE TABLE DBP_ETL.rea_inlist_1  (

         artikelnummer 	INTEGER NOT NULL
        ,td_insert TIMESTAMP_LTZ(9)
)
;

