--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.bestand_mardh_tmp_1  (
art_id                            INTEGER NOT NULL,
mandant_id                        BYTEINT NOT NULL ,
wup_id                            INTEGER NOT NULL ,
nb_id                             SMALLINT NOT NULL ,
gjmo                              INTEGER NOT NULL,
gjmo_bis                          INTEGER NOT NULL,
lagerort_id                       CHAR(4) COLLATE 'en-ci' NOT NULL,
mard_fg                           BYTEINT NOT NULL ,
menge_lgbest_erp_frei_bme         DECIMAL(18,3) ,
menge_lgbest_erp_umlag_bme        DECIMAL(18,3) ,
menge_lgbest_erp_qual_bme         DECIMAL(18,3) ,
menge_lgbest_erp_nf_charge_bme    DECIMAL(18,3) ,
menge_lgbest_erp_gesp_bme         DECIMAL(18,3) ,
menge_lgbest_erp_ret_gesp_bme     DECIMAL(18,3) ,
-- Lade-Kennzeichen (0= neue Daten, 1= alte Daten (aus Zieltabelle, s. Step 4)
lade_kz  BYTEINT NOT NULL ,
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9)
)

;

