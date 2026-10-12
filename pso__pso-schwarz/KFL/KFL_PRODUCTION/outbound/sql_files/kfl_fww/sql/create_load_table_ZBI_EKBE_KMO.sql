/*
###########################################################################
#    Erstellen Hilfstabelle de_mseg 
###########################################################################
*/


CREATE OR REPLACE TABLE ${KFL_SNFLK_COMMON_DBP_LOAD}.kmo_ekbe (
mandant_id INTEGER NOT NULL,
best_beleg_pos_id INTEGER,
best_beleg_id INTEGER,
kontierung_pos_id INTEGER,
vorgart_best_entw_id STRING(1),
folge_beleg_id INTEGER,
folge_beleg_pos_id INTEGER,
kj INTEGER,
wup_id INTEGER,
nb_id INTEGER,
bestaetigung_lfd_nr INTEGER,
best_entw_typ_id STRING(1),
menge_anteil NUMERIC(29,3),
menge_best NUMERIC(29,3),
lager_bewart_id STRING(3),
dat_buch DATE,
menge_basis NUMERIC(29,3),
betrag NUMERIC(29,4),
wrg_id STRING(3),
soll_haben_kz STRING(1),
ref_beleg_id INTEGER,
ref_beleg_pos_id INTEGER,
ref_gj INTEGER,
system_id INTEGER,
betrag_wrbtr NUMERIC(29,4),
wrg_id_beleg STRING(3),
dat_buch_orig DATE,
cpudt STRING(16),
bldat STRING(16),
cputm STRING(30),
td_update TIMESTAMP,
td_insert TIMESTAMP
);