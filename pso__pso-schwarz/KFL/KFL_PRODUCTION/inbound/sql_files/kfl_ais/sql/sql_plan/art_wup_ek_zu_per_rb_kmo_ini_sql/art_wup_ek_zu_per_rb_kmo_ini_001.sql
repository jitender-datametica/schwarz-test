--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_wup_ek_datum_relevant_kmo;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_wup_ek_datum_relevant_kmo  (
   dat_relevant DATE NOT NULL,
   dat_ausstieg DATE NOT NULL,
   rueckbewertung_fg BYTEINT NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_gp_nm_zu_per_rb_kmo;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.art_gp_nm_zu_per_rb_kmo LIKE DBP_DATA.art_gp_nm_zu_per;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_gp_wup_zu_per_rb_kmo;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_gp_wup_zu_per_rb_kmo  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE,
      ek_netto DECIMAL(18,4),
      ek_nettonetto DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      wrg_id CHAR(3) COLLATE 'en-ci' ,
      komponentenmenge DECIMAL(18,4) ,
      ek_netto_bnk DECIMAL(18,4)
) ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Table 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
INSERT INTO DBP_ETL.art_wup_ek_datum_relevant_kmo (dat_relevant,
                                                     dat_ausstieg,
                                                     rueckbewertung_fg)
SELECT CASE
         WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 1
         THEN CAST(EXTRACT(YEAR FROM CURRENT_DATE)-1||'-01-01' AS DATE)
         ELSE CAST(EXTRACT(YEAR FROM CURRENT_DATE)  ||'-01-01' AS DATE)
       END AS dat_relevant,
       CURRENT_DATE AS dat_ausstieg,
       1 AS rueckbewertung_fg;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
INSERT INTO DBP_ETL.art_gp_nm_zu_per_rb_kmo (mandant_id
                                              ,art_id
                                              ,wup_id
                                              ,nb_id
                                              ,dat_von
                                              ,gp_id
                                              ,einkaufsorganisation_id
                                              ,dat_bis
                                              ,vz_wup_id
                                              ,bq_findung_id
                                              ,bezugsweg_id)
SELECT mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,dat_von
      ,gp_id
      ,einkaufsorganisation_id
      ,dat_bis
      ,vz_wup_id
      ,bq_findung_id
      ,bezugsweg_id
FROM DBP_DATA.art_gp_nm_zu_per
WHERE dat_bis >= (SELECT dat_relevant
                  FROM DBP_ETL.art_wup_ek_datum_relevant_kmo) AND
      mandant_id > 1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
INSERT INTO DBP_ETL.art_gp_wup_zu_per_rb_kmo (mandant_id
                                               ,art_id
                                               ,gp_id
                                               ,wup_id
                                               ,dat_von
                                               ,dat_bis
                                               ,ek_netto
                                               ,ek_nettonetto
                                               ,ek_mep
                                               ,einstandspreis
                                               ,wrg_id
                                               ,komponentenmenge
                                               ,ek_netto_bnk)
SELECT mandant_id
      ,art_id
      ,gp_id
      ,wup_id
      ,dat_von
      ,dat_bis
      ,ek_netto
      ,ek_nettonetto
      ,ek_mep
      ,einstandspreis
      ,wrg_id
      ,komponentenmenge
      ,ek_netto_bnk
FROM DBP_DATA.art_gp_wup_zu_per
WHERE mandant_id > 1 AND
      dat_bis >= (SELECT dat_relevant
                  FROM DBP_ETL.art_wup_ek_datum_relevant_kmo) AND
      --CAST(PTY_FLOATDECEX(ek_netto , 'KLKPROD', 0, 1) AS DECIMAL(18,4)) > 0 AND
      ek_netto > 0 AND
      wup_id = -1
;

