--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_per_tag_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_per_tag_tmp_2  (
wup_id INTEGER NOT NULL ,
mandant_id BYTEINT NOT NULL ,
nb_id SMALLINT NOT NULL ,
art_id INTEGER NOT NULL,
menge_lgbest_erp_frei_bme DECIMAL(18,3),
menge_lgbest_erp_gesamt_bme DECIMAL(18,3),
menge_lgbest_erp_qual_bme DECIMAL(18,3),
wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
dat DATE NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_per_tag_tmp2_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_per_tag_tmp2_2  (
wup_id INTEGER NOT NULL ,
mandant_id BYTEINT NOT NULL ,
nb_id SMALLINT NOT NULL ,
art_id INTEGER NOT NULL,
menge_lgbest_erp_frei_bme DECIMAL(18,3),
menge_lgbest_erp_gesamt_bme DECIMAL(18,3),
menge_lgbest_erp_qual_bme DECIMAL(18,3),
wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
dat DATE NOT NULL,
wup_id_neu INTEGER,
nb_id_neu SMALLINT,
vw_id BYTEINT,
gp_id INTEGER,
vk_netto DECIMAL(18,4)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_tmp_2  (
mandant_id BYTEINT NOT NULL ,
vw_id BYTEINT NOT NULL ,
bezugsweg_id BYTEINT NOT NULL ,
lagerbestand_fg BYTEINT NOT NULL ,
nb_id SMALLINT NOT NULL ,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat DATE NOT NULL,
gp_id INTEGER NOT NULL,
relevant_fg BYTEINT NOT NULL ,
wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL,
menge_lgbest_erp_gesamt_bme DECIMAL(18,3) NOT NULL,
menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL,
betrag_vk_netto_frei_bme DECIMAL(18,4),
betrag_vk_netto_gesamt_bme DECIMAL(18,4),
betrag_vk_netto_qual_bme DECIMAL(18,4),
menge_abgang_bme DECIMAL(18,3) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lager_process_tag_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.lager_process_tag_2  (
dat DATE NOT NULL,
verarbeitet_fg BYTEINT
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_tmpk_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_tmpk_2  (
wup_id                         INTEGER NOT NULL,
mandant_id                     BYTEINT NOT NULL,
wrg_id                         CHAR(3) COLLATE 'en-ci' NOT NULL,
nb_id                          SMALLINT NOT NULL,
lagerort_id                    CHAR(4) ,
art_id                         INTEGER NOT NULL,
menge_lgbest_erp_frei_bme      DECIMAL(18,3),
menge_lgbest_erp_umlag_bme     DECIMAL(18,3),
menge_lgbest_erp_qual_bme      DECIMAL(18,3),
menge_lgbest_erp_nf_charge_bme DECIMAL(18,3),
menge_lgbest_erp_gesp_bme      DECIMAL(18,3),
menge_lgbest_erp_ret_gesp_bme  DECIMAL(18,3),
sperr_id                       CHAR(1) ,
gjmo_buch                      BYTEINT,
lagerort_loesch_fg             CHAR(1) ,
pflege_status                  CHAR(20) ,
dat_von                        DATE NOT NULL,
dat_bis                        DATE NOT NULL,
menge_lgbest_erp_kolli         DECIMAL(18,3),
menge_lgbest_erp_palette       DECIMAL(18,3),
betrag_lgbest_erp              DECIMAL(18,4),
ek_netto_bnk                   DECIMAL(18,4),
bewertungskreis_id             CHAR(4) COLLATE 'en-ci' ,
vk_netto                       DECIMAL(18,4),
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_mard_dat_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.kmo_mard_dat_2  (
mandant_id INTEGER
,dat_von    DATE
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_tmp3_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_tmp3_2  (
wup_id                         INTEGER NOT NULL ,
mandant_id                     BYTEINT NOT NULL ,
nb_id                          SMALLINT NOT NULL ,
lagerort_id                    CHAR(4) COLLATE 'en-ci' NOT NULL ,
art_id                         INTEGER NOT NULL,
menge_lgbest_erp_frei_bme      DECIMAL(18,3) ,
menge_lgbest_erp_umlag_bme     DECIMAL(18,3) ,
menge_lgbest_erp_qual_bme      DECIMAL(18,3) ,
menge_lgbest_erp_nf_charge_bme DECIMAL(18,3) ,
menge_lgbest_erp_gesp_bme      DECIMAL(18,3) ,
menge_lgbest_erp_ret_gesp_bme  DECIMAL(18,3) ,
sperr_id                       CHAR(1) COLLATE 'en-ci' ,
gjmo_buch                      BYTEINT,
lagerort_loesch_fg             CHAR(1) COLLATE 'en-ci' ,
pflege_status                  CHAR(20) COLLATE 'en-ci' ,
dat_von                        DATE NOT NULL,
menge_lgbest_erp_kolli         DECIMAL(18,3),
menge_lgbest_erp_palette       DECIMAL(18,3),
dat_bis                        DATE,
betrag_lgbest_erp              DECIMAL(18,4),
wrg_id                         CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
vk_netto_lgbest_erp            DECIMAL(18,4)
)
;

