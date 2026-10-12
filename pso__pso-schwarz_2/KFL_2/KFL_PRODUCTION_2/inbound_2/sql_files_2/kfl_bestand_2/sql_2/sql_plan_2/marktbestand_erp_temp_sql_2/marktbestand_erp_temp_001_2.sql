CREATE OR REPLACE TABLE DBP_ETL.marktbestand_erp_tmp_2 (
  mandant_id BYTEINT NOT NULL,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  vz_wup_id INTEGER DEFAULT -1,
  vw_id BYTEINT,
  gp_id INTEGER DEFAULT -1,
  bestand_id INTEGER ,
  bezugsweg_id BYTEINT DEFAULT 0 NOT NULL,
  listung_id BYTEINT ,
  kdis BYTEINT  DEFAULT 0 NOT NULL,
  relevant_fg BYTEINT NOT NULL DEFAULT 0  ,
  ek_netto DECIMAL(18,4) DEFAULT 0 NOT NULL,
  ek_netto_bnk DECIMAL(18,4) DEFAULT 0 NOT NULL,
  vk_netto DECIMAL(18,4) DEFAULT 0 ,
  wrg_id CHAR(3) COLLATE 'en-ci' DEFAULT 'EUR' NOT NULL,
  ek_nettonetto DECIMAL(18,4) DEFAULT 0 NOT NULL,
  einstandspreis DECIMAL(18,4) DEFAULT 0 NOT NULL,
  menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_gesp_bme DECIMAL(18,3) NOT NULL
);

INSERT INTO DBP_ETL.marktbestand_erp_tmp_2 (mandant_id,
                                          wup_id,
                                          art_id,
                                          menge_lgbest_erp_frei_bme,
                                          menge_lgbest_erp_qual_bme,
                                          menge_lgbest_erp_gesp_bme)
SELECT mandant_id,
       wup_id,
       art_id,
       menge_lgbest_erp_frei_bme,
       menge_lgbest_erp_qual_bme,
       menge_lgbest_erp_gesp_bme
FROM DBP_DATA.marktbestand_erp_2 
WHERE dat = CURRENT_DATE- ${LOOP_ID}
;
