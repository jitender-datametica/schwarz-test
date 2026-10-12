/*
###########################################################################
#  	In diesem Script wird ein DBX_LOAD Tabellen erstellt, 
#	die für die 2LIS_02_ITM notwendig ist und zwar:
#     - kmo_ekpo_2
###########################################################################
*/


CREATE OR REPLACE TABLE ${KFL_SNFLK_COMMON_DBP_LOAD}.kmo_ekpo_2lis_02_itm
     (
      mandant_id BYTEINT NOT NULL,
      best_beleg_id DECIMAL(18,0) NOT NULL,
      best_beleg_pos_id INTEGER NOT NULL,
      art_id INTEGER,
      wup_id INTEGER ,
      nb_id SMALLINT , 
      lagerort_id CHAR(4) ,
      loesch_fg BYTEINT ,
      menge_best_bme DECIMAL(18,3) ,
      selbstabhol_fg BYTEINT ,
      best_preis_menge_einh_id CHAR(3)  ,
      best_basismenge_einh_id CHAR(3)  ,
      menge_best_kolli DECIMAL(18,3),
      menge_best_palette DECIMAL(18,3),
      endlief_fg BYTEINT,
      dat_aenderung DATE ,
      kunde_id VARCHAR(10) ,
      dat_best_beleg DATE ,
      wg_verkett_id INTEGER,
      fremd_lagerort_id VARCHAR(24) ,
      ean_id DECIMAL(26,0),
      betrag_kond_zw_sum2 DECIMAL(18,4),
      pos_kostenlos_fg BYTEINT,
      betrag_pos_netto DECIMAL(18,4),
      betrag_pos_netto_best_wrg DECIMAL(18,4),
      wrg_id  CHAR(3) ,
      betrag_best DECIMAL(18,4),
      gp_id INTEGER,
      kopf_wup_id INTEGER,
      gp_teilsortiment_id VARCHAR(90) ,
      bestellart_id CHAR(4) ,
      menge_block_bestand DECIMAL(18,3),
      zentral_best_fg BYTEINT,
      dat_best_beleg_orig DATE ,
      ek_netto DECIMAL(18,4),
      anforderer_name VARCHAR(20) ,
      bedarfsnummer VARCHAR(10),
      TD_UPDATE TIMESTAMP_LTZ(9),
      TD_INSERT TIMESTAMP_LTZ(9));
