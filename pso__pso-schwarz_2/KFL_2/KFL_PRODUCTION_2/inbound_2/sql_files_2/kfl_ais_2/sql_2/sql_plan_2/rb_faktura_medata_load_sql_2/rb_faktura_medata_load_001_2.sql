--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_MEDATA_DATE_2' does not exist or not authorized.
CREATE TABLE DBP_ETL.rb_faktura_date_metadata_min_2 as
(
SELECT CAST(MIN(dat_von) AS INTEGER) as dat_von
FROM DBP_ETL.rb_faktura_medata_date_2
WHERE
kjmo IN
(
SELECT
MIN(kjmo)
FROM
DBP_ETL.rb_faktura_medata_date_2
WHERE
rb_status=0
)
AND
rb_status=0
) 
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_MEDATA_DATE_2' does not exist or not authorized.
CREATE TABLE DBP_ETL.rb_faktura_date_metadata_max_2 as
(
SELECT CAST(MAX(dat_bis) AS INTEGER) as dat_bis
FROM DBP_ETL.rb_faktura_medata_date_2
WHERE
kjmo IN
(
SELECT
MIN(kjmo)
FROM
DBP_ETL.rb_faktura_medata_date_2
WHERE
rb_status=0
)
AND
rb_status=0
) 
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.faktura_medata_rb_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.faktura_medata_rb_2 LIKE DBP_DATA.besch_faktura_medata_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--ALTER TABLE DBX_LOAD.faktura_medata_rb_2
-- ADD wup_id INTEGER NOT NULL
--,ADD nb_id SMALLINT NOT NULL
--,ADD gp_id INTEGER NOT NULL
--,ADD ek_netto_bnk_neu  DECIMAL(18,4) 
--,ADD ek_mep_neu DECIMAL(18,4) 
--,ADD logistikkostenzuschlag_neu DECIMAL(18,4)
--
--;
--
--Comment from validation checker
--error line 3 at position 11 unexpected 'SMALLINT'.
--,ADD nb_id  ^^^> SMALLINT NOT NULL
--translated statement
ALTER TABLE DBP_ETL.faktura_medata_rb_2
 ADD wup_id INTEGER NOT NULL
,ADD nb_id SMALLINT NOT NULL
,ADD gp_id INTEGER NOT NULL
,ADD ek_netto_bnk_neu  DECIMAL(18,4) 
,ADD ek_mep_neu DECIMAL(18,4) 
,ADD logistikkostenzuschlag_neu DECIMAL(18,4)

;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_DATE_METADATA_MIN_2' does not exist or not authorized.
INSERT INTO DBP_ETL.faktura_medata_rb_2

(
 art_id
,mandant_id
,faktura_markt
,dat_faktura
,wup_id
,nb_id
,gp_id
,zwsum_3_betrag
,menge_fakturiert
,ek_netto_bnk
,ek_mep
,logistikkostenzuschlag
,ek_netto_bnk_neu
,ek_mep_neu
,logistikkostenzuschlag_neu
)
SELECT 
 t0.art_id
,t0.mandant_id
,t0.faktura_markt
,t0.dat_faktura
,t0.wup_id
,t0.nb_id
,t1.gp_id
,t0.zwsum_3_betrag
,t0.menge_fakturiert
,t0.ek_netto_bnk
,t0.ek_mep
,t0.logistikkostenzuschlag
,(CAST(CAST((t2.ek_netto_bnk ) AS DECIMAL(18,4)) * t0.menge_fakturiert * t2.komponentenmenge AS DECIMAL(18,4)) ) AS ek_netto_bnk_neu 
,(CAST(CAST((t2.ek_mep ) AS DECIMAL(18,4)) * t0.menge_fakturiert * t2.komponentenmenge AS DECIMAL(18,4)) ) AS ek_mep_neu 
,CAST(t2.logistikkostenzuschlag * t0.menge_fakturiert * t2.komponentenmenge AS DECIMAL(18,4)) AS logistikkostenzuschlag_neu

FROM
	DBP_DATA.besch_faktura_medata_2 t0

INNER JOIN
	DBP_DATA.art_gp_zu_per_2 t1_2
ON
	t0.mandant_id=t1.mandant_id
AND
	t0.art_id=t1.art_id
AND
	t0.dat_faktura BETWEEN t1.dat_von AND t1.dat_bis


INNER JOIN
	DBP_DATA.art_gp_wup_zu_per_2 t2

ON
	t0.art_id=t2.art_id
AND
	t1.gp_id=t2.gp_id
AND
	t0.dat_faktura BETWEEN t2.dat_von AND t2.dat_bis


WHERE
  t1.einkaufsorganisation_id = 1000
AND
  t2.einkaufsorganisation_id=1000
AND
  t2.wup_id = 6906        /* Fuer VK_2-Anreicherung Fleicschwerk werden generell nur die VK_2'S aus VZ 6906 heran gezogen */
AND
  t2.nb_id IN (99,-111)   /* Lager */
AND
  t2.bezugsweg_id = 4     /* zentral */
AND
  CAST((t2.ek_kal_basis ) AS DECIMAL(18,4)) > 0  /* der ek_kal_basis muss positiv sein */
AND
  t0.mandant_id = t2.mandant_id
AND
  t0.dat_faktura BETWEEN CAST((SELECT dat_von FROM DBP_ETL.rb_faktura_date_metadata_min_2 ) AS DATE) 
AND CAST((SELECT dat_bis FROM DBP_ETL.rb_faktura_date_metadata_max_2 ) AS DATE)
AND 
  t0.mandant_id = 1
;

