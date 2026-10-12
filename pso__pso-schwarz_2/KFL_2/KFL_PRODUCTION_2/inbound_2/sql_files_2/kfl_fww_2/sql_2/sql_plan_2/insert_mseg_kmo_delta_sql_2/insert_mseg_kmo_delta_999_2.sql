CREATE OR REPLACE TABLE DBP_ETL.kmo_mseg_delta_2  (
art_id INTEGER,
art_id_bf INTEGER NOT NULL,
art_id_empfaenger INTEGER NOT NULL,
auto_fg CHAR(1) COLLATE 'en-ci' NOT NULL,
beleg_user_name CHAR(20) COLLATE 'en-ci' NOT NULL,
belegart_id CHAR(2) COLLATE 'en-ci',
belegkopftext VARCHAR(30) COLLATE 'en-ci',
best_beleg_id DECIMAL(18,0),
best_beleg_pos_id INTEGER NOT NULL,
betrag_belegfluss_wg_art DECIMAL(18,2),
betrag_bnk DECIMAL(18,4) NOT NULL,
betrag_einstandspreis DECIMAL(18,4),
betrag_exbwr DECIMAL(18,4) NOT NULL,
betrag_lagerbew DECIMAL(18,4),   /*dies Feld wird verschlüsselt*/  
betrag_umbewertung DECIMAL(18,4) NOT NULL,
betrag_verkauf DECIMAL(18,2) NOT NULL,
betrag_verkauf_ist DECIMAL(18,2) NOT NULL, 
betrag_verkauf_ist_netto DECIMAL(18,4) ,
betrag_vk_netto DECIMAL(18,2) NOT NULL, 
betrag_vk_netto_vz DECIMAL(18,4) NOT NULL,
bq_findung_id BYTEINT NOT NULL,
buchungskreis_id SMALLINT NOT NULL,
bw_vorgang_id SMALLINT NOT NULL,
dat_beleg DATE NOT NULL,
dat_buch DATE NOT NULL,
dat_erfasst DATE,
einkaufsorganisation_id SMALLINT,
empfaenger VARCHAR(10) COLLATE 'en-cs',
empfaenger_id INTEGER,
endlief_fg BYTEINT NOT NULL,
erfsngs_menge_einh_id CHAR(3) COLLATE 'en-cs' NOT NULL,
gp_id INTEGER,
gp_id_zl INTEGER ,
grund_id CHAR(10) COLLATE 'en-ci' NOT NULL,
kj INTEGER NOT NULL, 
kostenstelle_id CHAR(10) COLLATE 'en-ci' NOT NULL,
kunnr VARCHAR(10) COLLATE 'en-ci',
lager_bewart_id CHAR(3) COLLATE 'en-ci' NOT NULL,
lagerbew_beleg_id DECIMAL(18,0) NOT NULL,
lagerbew_beleg_pos_id INTEGER NOT NULL,
lagerbew_beleg_pos_mutter_id INTEGER NOT NULL,
lagerbew_beleg_pos_storno_id INTEGER,
lagerbew_beleg_storno_id DECIMAL(18,0), 
lagerbew_beleg_storno_kj SMALLINT,
lagerort_id CHAR(4) COLLATE 'en-ci' NOT NULL,  
lagerort_id_empfaenger CHAR(4) COLLATE 'en-ci' NOT NULL,
lagerplatz_id CHAR(10) COLLATE 'en-ci',
lief_gp_id INTEGER NOT NULL,   
line_id INTEGER NOT NULL,
mandant_id BYTEINT NOT NULL,
mandant_id_empfaenger BYTEINT,
mandant_id_kunde BYTEINT,
menge_bestand_bme DECIMAL(18,3) NOT NULL, 
menge_erf DECIMAL(18,3) NOT NULL,
menge_lagerbew_bme DECIMAL(18,3) NOT NULL,
menge_lagerbew_kolli DECIMAL(18,3) NOT NULL,
menge_lagerbew_palette DECIMAL(18,3),
menge_lief DECIMAL(18,3) NOT NULL,
menge_lieferschein DECIMAL(18,3) NOT NULL,
mwst DECIMAL(12,2) NOT NULL,
mwst_id BYTEINT NOT NULL,
nb_id SMALLINT NOT NULL,
ref_lagerbew_beleg_id VARCHAR(20) COLLATE 'en-ci',
ref_lagerbew_beleg_id_num DECIMAL(18,0) NOT NULL,
sachkonto_id CHAR(10) COLLATE 'en-ci' NOT NULL,
shkum CHAR(1) COLLATE 'en-ci' NOT NULL,
soll_haben_kz CHAR(1) COLLATE 'en-ci' NOT NULL,
spr_id SMALLINT NOT NULL,
system_id INTEGER,
transaktion_code CHAR(10) COLLATE 'en-ci',
vorgangsart_id CHAR(2) COLLATE 'en-ci' NOT NULL,
waren_begl_schein_id CHAR(10) COLLATE 'en-ci',
wert_bestand DECIMAL(18,4) NOT NULL,
wg_art_fg BYTEINT NOT NULL,
wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL,
wup_id INTEGER,
xruem_fg BYTEINT NOT NULL,
zeit_erfasst INTEGER NOT NULL,
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9),
lagerbew_beleg_pos_sort_id NUMBER(38,0),
lagerbew_beleg_parent_pos_sort_id NUMBER(38,0),
display_art_id NUMBER(38,0)
);

CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_bg_2 LIKE DBP_ETL.kmo_mseg_delta_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_cz_2 LIKE DBP_ETL.kmo_mseg_delta_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_hr_2 LIKE DBP_ETL.kmo_mseg_delta_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_md_2 LIKE DBP_ETL.kmo_mseg_delta_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_pl_2 LIKE DBP_ETL.kmo_mseg_delta_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_ro_2 LIKE DBP_ETL.kmo_mseg_delta_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_delta_sk_2 LIKE DBP_ETL.kmo_mseg_delta_2;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_bg_2
;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_cz_2
;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_hr_2
;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_md_2
;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_pl_2
;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_ro_2
;

INSERT INTO DBP_ETL.kmo_mseg_delta_2
SELECT *
FROM DBP_ETL.kmo_mseg_delta_sk_2
;

create or replace volatile table _vkset_potentials_kopf as (
select mandant_id,
       lagerbew_beleg_id,
       dat_buch,
       lagerbew_beleg_parent_pos_sort_id
from dbp_etl.kmo_mseg_delta_2
where lagerbew_beleg_parent_pos_sort_id <> 0 and
      lager_bewart_id in ('317','319')
group by 1,2,3,4
);

create or replace volatile table _vkset_potentials as (
select mandant_id,
       lagerbew_beleg_id,
       dat_buch,
       lagerbew_beleg_pos_sort_id
from dbp_etl.kmo_mseg_delta_2
where (mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id) in (select mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_parent_pos_sort_id from _vkset_potentials_kopf)
group by 1,2,3,4
);

create or replace volatile table _vkset_updates as (
select mandant_id,
       lagerbew_beleg_id,
       dat_buch,
       lagerbew_beleg_pos_sort_id,
       art_id
from dbp_etl.kmo_mseg_delta_2
where (mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id) in (select mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id from _vkset_potentials)
group by 1,2,3,4,5
);

update dbp_etl.kmo_mseg_delta_2 set display_art_id = -1
;

update dbp_etl.kmo_mseg_delta_2 from (select *
                                      from _vkset_updates) b
                                     
set display_art_id = b.art_id

where dbp_etl.kmo_mseg_delta.mandant_id = b.mandant_id and
      dbp_etl.kmo_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id and
      dbp_etl.kmo_mseg_delta.dat_buch = b.dat_buch and
      dbp_etl.kmo_mseg_delta.lagerbew_beleg_parent_pos_sort_id = b.lagerbew_beleg_pos_sort_id
;

update dbp_etl.kmo_mseg_delta_2 from (select *
                                      from _vkset_updates) b
                                     
set display_art_id = b.art_id

where dbp_etl.kmo_mseg_delta.mandant_id = b.mandant_id and
      dbp_etl.kmo_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id and
      dbp_etl.kmo_mseg_delta.dat_buch = b.dat_buch and
      dbp_etl.kmo_mseg_delta.lagerbew_beleg_pos_sort_id = b.lagerbew_beleg_pos_sort_id
;
