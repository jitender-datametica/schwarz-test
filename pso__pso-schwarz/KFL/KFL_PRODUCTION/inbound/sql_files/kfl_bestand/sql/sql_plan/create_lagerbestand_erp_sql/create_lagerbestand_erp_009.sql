--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbest_erp_per_tag_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbest_erp_per_tag_kmo_tmp  (
wup_id INTEGER NOT NULL,
mandant_id BYTEINT NOT NULL,
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
DROP TABLE IF EXISTS DBP_ETL.lagerbest_erp_per_tag_kmo_tmp2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbest_erp_per_tag_kmo_tmp2  (
wup_id          INTEGER NOT NULL,
mandant_id      BYTEINT NOT NULL,
nb_id           SMALLINT NOT NULL ,
art_id          INTEGER NOT NULL,
menge_lgbest_erp_frei_bme       DECIMAL(18,3),
menge_lgbest_erp_gesamt_bme     DECIMAL(18,3),
menge_lgbest_erp_qual_bme       DECIMAL(18,3),
wrg_id          CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
dat             DATE NOT NULL,
vw_id           BYTEINT,
gp_id           INTEGER,
vk_netto        DECIMAL(18,4)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_kmo_tmp  (
mandant_id BYTEINT NOT NULL,
vw_id BYTEINT NOT NULL,
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
menge_abgang_bme DECIMAL(18,3) ,
betrag_vk_netto_abgang DECIMAL(18,4)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lager_process_tag_kmo;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lager_process_tag_kmo  (
mandant_id BYTEINT NOT NULL,
dat DATE NOT NULL,
verarbeitet_fg BYTEINT
)
;

