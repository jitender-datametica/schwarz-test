--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_best_vw_sum_artbew_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_best_vw_sum_artbew_tmpk2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_kmo_tmp2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_best_vw_sum_artbew_kmo_tmp  (
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  gp_id INTEGER,
  wrg_id CHAR(3),
  relevant_fg BYTEINT,
  bezugsweg_id BYTEINT,
  dat DATE,
  menge_abgang_bme DECIMAL(18,4),
  betrag_vk_netto_abgang DECIMAL(18,4),
  herkunft CHAR(10) COLLATE 'en-ci' NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_best_vw_sum_artbew_tmpk2  (
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  vw_id BYTEINT NOT NULL,
  relevant_fg BYTEINT NOT NULL,
  bezugsweg_id BYTEINT NOT NULL,
  dat DATE NOT NULL,
  menge_abgang_bme DECIMAL(18,4),
  betrag_vk_netto_abgang DECIMAL(18,4),
  herkunft CHAR(10) COLLATE 'en-ci' NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_kmo_tmp  (
  mandant_id BYTEINT NOT NULL,
  vw_id BYTEINT NOT NULL,
  bezugsweg_id BYTEINT NOT NULL,
  lagerbestand_fg BYTEINT NOT NULL,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  gp_id INTEGER NOT NULL,
  relevant_fg BYTEINT NOT NULL,
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL,
  betrag_vk_netto_frei_bme DECIMAL(18,4),
  betrag_vk_netto_gesamt_bme DECIMAL(18,4),
  betrag_vk_netto_qual_bme DECIMAL(18,4),
  menge_abgang_bme DECIMAL(18,3),
  betrag_vk_netto_abgang DECIMAL(18,4),
  herkunft CHAR(10) COLLATE 'en-ci' NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_kmo_tmp2  (
  mandant_id BYTEINT NOT NULL,
  vw_id BYTEINT NOT NULL,
  bezugsweg_id BYTEINT NOT NULL,
  lagerbestand_fg BYTEINT NOT NULL,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  gp_id INTEGER NOT NULL,
  relevant_fg BYTEINT NOT NULL,
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL,
  betrag_vk_netto_frei_bme DECIMAL(18,4),
  betrag_vk_netto_gesamt_bme DECIMAL(18,4),
  betrag_vk_netto_qual_bme DECIMAL(18,4),
  menge_abgang_bme DECIMAL(18,3),
  betrag_vk_netto_abgang DECIMAL(18,4)
)
;

