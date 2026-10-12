--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bestand_mardh_mard_tmp1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bestand_mardh_mard_tmp2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bestand_mardh_mard_tmp3;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.bestand_mardh_mard_tmp1  (
  art_id         INTEGER NOT NULL,
  mandant_id     BYTEINT NOT NULL ,
  wup_id         INTEGER NOT NULL ,
  nb_id          SMALLINT NOT NULL ,
  lagerort_id    CHAR(4) COLLATE 'en-ci' NOT NULL,
  dat            DATE NOT NULL,
  gjmo           INTEGER NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.bestand_mardh_mard_tmp2  (
  art_id                            INTEGER NOT NULL,
  mandant_id                        BYTEINT NOT NULL ,
  wup_id                            INTEGER NOT NULL ,
  nb_id                             SMALLINT NOT NULL ,
  gjmo                              INTEGER NOT NULL,
  lagerort_id                       CHAR(4) COLLATE 'en-ci' NOT NULL,
  menge_lgbest_erp_frei_bme         DECIMAL(18,3) ,
  menge_lgbest_erp_umlag_bme        DECIMAL(18,3) ,
  menge_lgbest_erp_qual_bme         DECIMAL(18,3) ,
  menge_lgbest_erp_nf_charge_bme    DECIMAL(18,3) ,
  menge_lgbest_erp_gesp_bme         DECIMAL(18,3) ,
  menge_lgbest_erp_ret_gesp_bme     DECIMAL(18,3) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.bestand_mardh_mard_tmp3  (
  art_id                            INTEGER NOT NULL,
  mandant_id                        BYTEINT NOT NULL ,
  wup_id                            INTEGER NOT NULL ,
  nb_id                             SMALLINT NOT NULL ,
  gjmo_ziel                         INTEGER NOT NULL,
  gjmo_load                         INTEGER NOT NULL,
  gjmo_bis_ziel                     INTEGER NOT NULL,
  gjmo_bis_ziel_neu                 INTEGER NOT NULL,
  gjmo_bis_neu                      INTEGER NOT NULL,
  lagerort_id                       CHAR(4) COLLATE 'en-ci' NOT NULL,
  mard_fg                           BYTEINT NOT NULL ,
  menge_lgbest_erp_frei_bme         DECIMAL(18,3) ,
  menge_lgbest_erp_umlag_bme        DECIMAL(18,3) ,
  menge_lgbest_erp_qual_bme         DECIMAL(18,3) ,
  menge_lgbest_erp_nf_charge_bme    DECIMAL(18,3) ,
  menge_lgbest_erp_gesp_bme         DECIMAL(18,3) ,
  menge_lgbest_erp_ret_gesp_bme     DECIMAL(18,3) )

 ;

