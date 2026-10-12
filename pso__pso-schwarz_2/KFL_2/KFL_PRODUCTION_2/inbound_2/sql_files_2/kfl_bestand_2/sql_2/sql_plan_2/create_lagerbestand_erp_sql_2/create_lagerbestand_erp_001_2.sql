--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_2  (
wup_id                            INTEGER NOT NULL,
mandant_id                        BYTEINT NOT NULL,
nb_id                             SMALLINT NOT NULL,
lagerort_id                       CHAR(4) ,
art_id                            INTEGER NOT NULL,
menge_lgbest_erp_frei_bme         DECIMAL(18,3),
menge_lgbest_erp_umlag_bme        DECIMAL(18,3),
menge_lgbest_erp_qual_bme         DECIMAL(18,3),
menge_lgbest_erp_nf_charge_bme    DECIMAL(18,3),
menge_lgbest_erp_gesp_bme         DECIMAL(18,3),
menge_lgbest_erp_ret_gesp_bme     DECIMAL(18,3),
sperr_id                          CHAR(1) ,
gjmo_buch                         BYTEINT,
lagerort_loesch_fg                CHAR(1) ,
pflege_status                     CHAR(20) ,
dat_von                           DATE NOT NULL,
dat_bis                           DATE NOT NULL,
menge_lgbest_erp_kolli            DECIMAL(18,3),
menge_lgbest_erp_palette          DECIMAL(18,3),
betrag_lgbest_erp                 DECIMAL(18,4),
ek_netto_bnk                      DECIMAL(18,4),
komponentenmenge                  DECIMAL(18,4),
wrg_id                            CHAR(3),
vk_netto                          DECIMAL (9,3),
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_tmp2_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.lagerbestand_erp_tmp2_2  (
wup_id                            INTEGER NOT NULL,
mandant_id                        BYTEINT NOT NULL,
nb_id                             SMALLINT NOT NULL,
lagerort_id                       CHAR(4) ,
art_id                            INTEGER NOT NULL,
menge_lgbest_erp_frei_bme         DECIMAL(18,3),
menge_lgbest_erp_umlag_bme        DECIMAL(18,3),
menge_lgbest_erp_qual_bme         DECIMAL(18,3),
menge_lgbest_erp_nf_charge_bme    DECIMAL(18,3),
menge_lgbest_erp_gesp_bme         DECIMAL(18,3),
menge_lgbest_erp_ret_gesp_bme     DECIMAL(18,3),
sperr_id                          CHAR(1) ,
gjmo_buch                         BYTEINT,
lagerort_loesch_fg                CHAR(1) ,
pflege_status                     CHAR(20) ,
dat_von                           DATE NOT NULL,
dat_bis                           DATE NOT NULL,
menge_lgbest_erp_kolli            DECIMAL(18,3),
menge_lgbest_erp_palette          DECIMAL(18,3),
betrag_lgbest_erp                 DECIMAL(18,4),
ek_netto_bnk                      DECIMAL(18,4),
komponentenmenge                  DECIMAL(18,4),
wrg_id                            CHAR(3),
vk_netto_lgbest_erp               DECIMAL (18,4)
)
;

