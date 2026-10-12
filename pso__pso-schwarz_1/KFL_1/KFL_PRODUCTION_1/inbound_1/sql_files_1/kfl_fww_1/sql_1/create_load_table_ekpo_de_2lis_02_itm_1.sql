/*
###########################################################################
#  	In diesem Script wird ein DBX_LOAD Tabellen erstellt, 
#	die für die 2LIS_02_ITM notwendig ist und zwar:
#     - de_ekpo_1
###########################################################################
*/


CREATE OR REPLACE TABLE ${KFL_SNFLK_COMMON_DBP_LOAD}.de_ekpo_2lis_02_itm
     (
      mandant_id DECIMAL(38,0) NOT NULL,
      best_beleg_id DECIMAL(18,0) NOT NULL,
      best_beleg_pos_id DECIMAL(38,0) NOT NULL,
      art_id DECIMAL(38,0),
      wup_id DECIMAL(38,0),
      nb_id DECIMAL(38,0),
      lagerort_id VARCHAR(24),
      loesch_fg DECIMAL(38,0),
      menge_best_bme DECIMAL(18,3),
      selbstabhol_fg DECIMAL(38,0),
      best_preis_menge_einh_id VARCHAR(18),
      best_menge_einh_id VARCHAR(18),
      menge_best_kolli DECIMAL(18,3),
      menge_best_palette DECIMAL(18,3),
      endlief_fg DECIMAL(38,0),
      dat_aenderung DATE,
      kunde_id VARCHAR(60),
      dat_best_beleg DATE,
      wg_verkett_id DECIMAL(38,0),
      fremd_lagerort_id VARCHAR(24),
      ean_id DECIMAL(26,0),
      betrag_kond_zw_sum2 DECIMAL(18,4), /*Verschlüsselt*/
      pos_kostenlos_fg DECIMAL(38,0),
      betrag_pos_netto DECIMAL(18,4), /*Verschlüsselt*/
      betrag_pos_netto_best_wrg DECIMAL(18,4), /*Verschlüsselt*/
      wrg_id VARCHAR(18),
      betrag_best DECIMAL(18,4), /*Verschlüsselt*/
      werks_ber DECIMAL(38,0),
      nb_id_ber DECIMAL(38,0),
      kopf_wup_id DECIMAL(38,0),
      gp_teilsortiment_id VARCHAR(90),
      zentral_best_fg DECIMAL(38,0),
      dat_best_beleg_orig DATE,
      anforderer_name VARCHAR(20),
      bedarfsnummer VARCHAR(10),
      TD_UPDATE TIMESTAMP_LTZ(9),
      TD_INSERT TIMESTAMP_LTZ(9));
