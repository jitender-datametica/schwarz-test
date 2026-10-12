/*
###########################################################################
#  	In diesem Script wird ein DBX_LOAD Tabellen erstellt, 
#	die für die 2LIS_02_ITM notwendig ist und zwar:
#     - kmo_ekpo_1
###########################################################################
*/


CREATE OR REPLACE TABLE ${KFL_SNFLK_COMMON_DBP_LOAD}.kmo_ekpo_2lis_02_itm (
mandant_id INTEGER NOT NULL,
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id INTEGER NOT NULL,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
lagerort_id STRING(4),
loesch_fg INTEGER,
menge_best_bme NUMERIC(29,3),
selbstabhol_fg INTEGER,
best_preis_menge_einh_id STRING(3),
best_basismenge_einh_id STRING(3),
menge_best_kolli NUMERIC(29,3),
menge_best_palette NUMERIC(29,3),
endlief_fg INTEGER,
dat_aenderung DATE,
kunde_id STRING(10),
dat_best_beleg DATE,
wg_verkett_id INTEGER,
fremd_lagerort_id STRING(24),
ean_id INTEGER,
betrag_kond_zw_sum2 NUMERIC(29,4),
pos_kostenlos_fg INTEGER,
betrag_pos_netto NUMERIC(29,4),
betrag_pos_netto_best_wrg NUMERIC(29,4),
wrg_id STRING(3),
betrag_best NUMERIC(29,4),
gp_id INTEGER,
kopf_wup_id INTEGER,
gp_teilsortiment_id STRING(90),
bestellart_id STRING(4),
menge_block_bestand NUMERIC(29,3),
zentral_best_fg INTEGER,
dat_best_beleg_orig DATE,
ek_netto NUMERIC(29,4),
anforderer_name STRING(20),
bedarfsnummer STRING(10),
td_update TIMESTAMP,
td_insert TIMESTAMP
);