CREATE OR REPLACE TABLE dbp_etl.ek01_1 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek02_1 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek03_1 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek04_1 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek05_1 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek06_1 (
      art_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek07_1 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek08_1 (
      art_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek09_1 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek10_1 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek11_1 (
      art_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek12_1 (
      art_id INTEGER NOT NULL,
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      komponentenmenge DECIMAL(18,4)
);

INSERT INTO dbp_etl.ek01_1 (art_id
,wup_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,gp_id
,komponentenmenge)
SELECT art_id
,wup_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,gp_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis  > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000
;

INSERT INTO dbp_etl.ek02_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,gp_id
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,gp_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111 )
AND bezugsweg_id = 4 
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, dat_von, gp_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek03_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,gp_id
,wup_id
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,gp_id
,wup_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, gp_id, wup_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek04_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,gp_id
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,gp_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, gp_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek05_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,wup_id
,komponentenmenge)
SELECT agw5_1.art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,CASE WHEN (agw5_1.dat_von > agw5_2.dat_von) THEN agw5_1.dat_von ELSE agw5_2.dat_von END AS dat_von
,CASE WHEN (agw5_1.dat_bis < agw5_2.dat_bis) THEN agw5_1.dat_bis ELSE agw5_2.dat_bis END AS dat_bis
,agw5_1.wup_id
,agw5_1.komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1 agw5_1

JOIN dbp_data.art_gp_zu_per_1 agw5_2
ON agw5_1.art_id=agw5_2.art_id
AND agw5_1.gp_id=agw5_2.gp_id
AND ((agw5_1.dat_von BETWEEN agw5_2.dat_von AND agw5_2.dat_bis) OR (agw5_2.dat_von BETWEEN agw5_1.dat_von AND agw5_1.dat_bis))
AND agw5_1.mandant_id=agw5_2.mandant_id
AND agw5_1.einkaufsorganisation_id=agw5_2.einkaufsorganisation_id

WHERE agw5_1.nb_id IN (99, -111)
AND agw5_1.bezugsweg_id = 4
AND agw5_1.ek_kal_basis > 0
AND agw5_1.mandant_id = 1
AND agw5_1.einkaufsorganisation_id = 1000
;

INSERT INTO dbp_etl.ek06_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,komponentenmenge)
SELECT agw6_1.art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,CASE WHEN (agw6_1.dat_von > agw6_2.dat_von) THEN agw6_1.dat_von ELSE agw6_2.dat_von END AS dat_von
,CASE WHEN (agw6_1.dat_bis < agw6_2.dat_bis) THEN agw6_1.dat_bis ELSE agw6_2.dat_bis END AS dat_bis
,agw6_1.komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1 agw6_1

JOIN dbp_data.art_gp_zu_per_1 agw6_2
ON agw6_1.art_id=agw6_2.art_id
AND agw6_1.gp_id = agw6_2.gp_id
AND ((agw6_1.dat_von BETWEEN agw6_2.dat_von AND agw6_2.dat_bis) OR (agw6_2.dat_von BETWEEN agw6_1.dat_von AND agw6_1.dat_bis))
AND agw6_1.mandant_id=agw6_2.mandant_id
AND agw6_1.einkaufsorganisation_id=agw6_2.einkaufsorganisation_id

WHERE agw6_1.nb_id IN (99, -111)
AND agw6_1.bezugsweg_id = 4
AND agw6_1.ek_kal_basis > 0
AND agw6_1.mandant_id = 1
AND agw6_1.einkaufsorganisation_id = 1000
;

INSERT INTO dbp_etl.ek07_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,wup_id
,komponentenmenge)

SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,wup_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE nb_id IN(99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, wup_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek08_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek09_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,komponentenmenge
,gp_id)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,komponentenmenge
,gp_id
FROM dbp_data.art_gp_wup_zu_per_1
WHERE (nb_id NOT IN (99,-111) OR nb_id IS NULL)
AND bezugsweg_id = 1
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000
;

INSERT INTO dbp_etl.ek10_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,komponentenmenge
,gp_id)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,komponentenmenge
,gp_id
FROM dbp_data.art_gp_wup_zu_per_1
WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)
AND bezugsweg_id = 1
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id,gp_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek11_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,dat_von
,dat_bis
,komponentenmenge)
SELECT agw11_1.art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,CASE WHEN (agw11_1.dat_von > agw11_2.dat_von) THEN agw11_1.dat_von ELSE agw11_2.dat_von END AS dat_von
,CASE WHEN (agw11_1.dat_bis < agw11_2.dat_bis) THEN agw11_1.dat_bis ELSE agw11_2.dat_bis END AS dat_bis
,agw11_1.komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1 agw11_1

JOIN dbp_data.art_gp_zu_per_1 agw11_2
ON agw11_1.art_id=agw11_2.art_id
AND agw11_1.gp_id=agw11_2.gp_id
AND ((agw11_1.dat_von BETWEEN agw11_2.dat_von AND agw11_2.dat_bis) OR (agw11_2.dat_von BETWEEN agw11_1.dat_von AND agw11_1.dat_bis))
AND agw11_1.mandant_id=agw11_2.mandant_id
AND agw11_1.einkaufsorganisation_id=agw11_2.einkaufsorganisation_id

WHERE (agw11_1.nb_id NOT IN ( 99, -111 ) OR agw11_1.nb_id IS NULL )
AND agw11_1.bezugsweg_id = 1
AND agw11_1.ek_kal_basis > 0
AND agw11_1.mandant_id = 1
AND agw11_1.einkaufsorganisation_id = 1000
;

INSERT INTO dbp_etl.ek12_1 (art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,ek_mep
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1

WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)
AND bezugsweg_id = 1
AND ek_kal_basis > 0
AND mandant_id = 1
AND einkaufsorganisation_id = 1000

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

update DBP_ETL.de_mseg_delta_1 set umwrk = NULL
where trim(umwrk) = ''
;

update DBP_ETL.de_mseg_delta_1 set wempf = NULL
where trim(wempf) = ''
;

-- DE --

create or replace volatile table _vkset_potentials_kopf as (
select mandant_id,
       lagerbew_beleg_id,
       dat_buch,
       lagerbew_beleg_parent_pos_sort_id
from dbp_etl.de_mseg_delta_1
where lagerbew_beleg_parent_pos_sort_id <> 0 and
      lager_bewart_id in ('317','319')
group by 1,2,3,4
);

create or replace volatile table _vkset_potentials as (
select mandant_id,
       lagerbew_beleg_id,
       dat_buch,
       lagerbew_beleg_pos_sort_id
from dbp_etl.de_mseg_delta_1
where (mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id) in (select mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_parent_pos_sort_id from _vkset_potentials_kopf)
group by 1,2,3,4
);

create or replace volatile table _vkset_updates as (
select mandant_id,
       lagerbew_beleg_id,
       dat_buch,
       lagerbew_beleg_pos_sort_id,
       art_id
from dbp_etl.de_mseg_delta_1
where (mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id) in (select mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id from _vkset_potentials)
group by 1,2,3,4,5
);

update dbp_etl.de_mseg_delta_1 set display_art_id = -1;

update dbp_etl.de_mseg_delta_1 from (select *
                                      from _vkset_updates) b
                                     
set display_art_id = b.art_id

where dbp_etl.de_mseg_delta.mandant_id = b.mandant_id and
      dbp_etl.de_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id and
      dbp_etl.de_mseg_delta.dat_buch = b.dat_buch and
      dbp_etl.de_mseg_delta.lagerbew_beleg_parent_pos_sort_id = b.lagerbew_beleg_pos_sort_id
;

update dbp_etl.de_mseg_delta_1 from (select *
                                      from _vkset_updates) b
                                     
set display_art_id = b.art_id

where dbp_etl.de_mseg_delta.mandant_id = b.mandant_id and
      dbp_etl.de_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id and
      dbp_etl.de_mseg_delta.dat_buch = b.dat_buch and
      dbp_etl.de_mseg_delta.lagerbew_beleg_pos_sort_id = b.lagerbew_beleg_pos_sort_id
;

DROP TABLE IF EXISTS DBP_ETL.de_mseg_work_1;

CREATE TABLE DBP_ETL.de_mseg_work_1  (
      art_id 			INTEGER,
      art_id_bf 		INTEGER ,
      art_id_empfaenger 	INTEGER ,
      auto_fg 			CHAR(1) COLLATE 'en-ci',
      beleg_user_name 		CHAR(20) COLLATE 'en-ci' ,
      belegart_id 		CHAR(2) COLLATE 'en-ci',
      belegkopftext 		VARCHAR(30) COLLATE 'en-ci',
      best_beleg_id 		DECIMAL(18,0),
      best_beleg_pos_id 	INTEGER  ,
      --betrag_belegfluss_wg_art 	DECIMAL(18,2),
      betrag_bnk 		DECIMAL(18,4)  ,
      betrag_exbwr 		DECIMAL(18,4)  ,
      betrag_lagerbew 		DECIMAL(18,4),
      betrag_umbewertung 	DECIMAL(18,4),
      betrag_verkauf 		DECIMAL(18,2) ,
      betrag_verkauf_ist 	DECIMAL(18,2) ,
      betrag_verkauf_ist_netto 	DECIMAL(18,4),
      betrag_vk_netto 		DECIMAL(18,2) ,
      betrag_vk_netto_vz 	DECIMAL(18,4) ,
      buchungskreis_id 		SMALLINT ,
      bw_vorgang_id 		SMALLINT,
      dat_beleg 		DATE ,
      dat_buch 			DATE ,
      dat_erfasst 		DATE,
      einkaufsorganisation_id 	SMALLINT,
      ek_netto_bnk              DECIMAL(18,4), /*Before PTY - DECIMAL(18,4)*/
      empfaenger_id 		INTEGER,
      endlief_fg 		BYTEINT NOT NULL,
      erfsngs_menge_einh_id 	CHAR(3) COLLATE 'en-cs'  ,
      gp_id 			INTEGER,
      grund_id 			CHAR(10) COLLATE 'en-ci'  ,
      kj 			INTEGER NOT NULL,
      komponentenmenge          DECIMAL(18,4),
      kostenstelle_id 		CHAR(10) COLLATE 'en-ci'  ,
      kunde_id 			VARCHAR(10) COLLATE 'en-ci', 
      lager_bewart_id 		CHAR(3) COLLATE 'en-ci'  ,
      lagerbew_beleg_id 	DECIMAL(18,0)  ,
      lagerbew_beleg_pos_id 	INTEGER  ,
      lagerbew_beleg_pos_mutter_id INTEGER  ,
      lagerbew_beleg_pos_storno_id INTEGER,
      lagerbew_beleg_storno_id 	DECIMAL(18,0),
      lagerbew_beleg_storno_kj 	SMALLINT,
      lagerort_id 		CHAR(4) COLLATE 'en-ci'  ,
      lagerort_id_empfaenger 	CHAR(4) COLLATE 'en-ci'  ,
      lagerplatz_id 		CHAR(10) COLLATE 'en-ci',
      lief_gp_id 		INTEGER  ,
      line_id 			INTEGER  ,
      los_charge                VARCHAR(10) COLLATE 'en-ci',
      mandant_id 		BYTEINT NOT NULL,
      mandant_id_empfaenger 	BYTEINT,
      mandant_id_kunde 		BYTEINT,
      menge_bestand_bme 	DECIMAL(18,3)  ,
      menge_erf 		DECIMAL(18,3)  ,
      menge_lagerbew_bme 	DECIMAL(18,3)  ,
      menge_lagerbew_kolli 	DECIMAL(18,3)  ,
      menge_lagerbew_palette 	DECIMAL(18,3),
      menge_lief 		DECIMAL(18,3)  ,
      menge_lieferschein 	DECIMAL(18,3)  ,
      nb_id 			SMALLINT  ,
      ref_lagerbew_beleg_id 	VARCHAR(20) COLLATE 'en-ci',
      ref_lagerbew_beleg_id_num DECIMAL(18,0)  ,
      sachkonto_id 		CHAR(10) COLLATE 'en-ci'  ,
      shkum 			CHAR(1) COLLATE 'en-ci'  ,
      soll_haben_kz 		CHAR(1) COLLATE 'en-ci'  ,
      system_id 		INTEGER,
      transaktion_code 		CHAR(10) COLLATE 'en-ci',
      vorgangsart_id 		CHAR(2) COLLATE 'en-ci'  ,
      waren_begl_schein_id 	CHAR(10) COLLATE 'en-ci',
      wert_bestand 		DECIMAL(18,4)  ,
      wg_art_fg                 BYTEINT  ,
      wrg_id 			CHAR(3) COLLATE 'en-ci'  ,
      wup_id 			INTEGER,
      xruem_fg 			BYTEINT  ,
      zeit_erfasst 		INTEGER  ,
      lagerbew_beleg_pos_sort_id NUMBER(38,0),
      lagerbew_beleg_parent_pos_sort_id NUMBER(38,0),
      display_art_id NUMBER(38,0)
)
;

INSERT INTO DBP_ETL.de_mseg_work_1
(  
      art_id,
      art_id_bf ,
      art_id_empfaenger ,
      auto_fg ,
      beleg_user_name ,
      belegart_id ,
      belegkopftext ,
      best_beleg_id ,
      best_beleg_pos_id ,
      --betrag_belegfluss_wg_art ,
      betrag_bnk ,
      betrag_exbwr ,
      betrag_lagerbew ,
      betrag_umbewertung ,
      betrag_verkauf ,
      betrag_verkauf_ist ,
      betrag_verkauf_ist_netto ,
      betrag_vk_netto ,
      betrag_vk_netto_vz ,
      buchungskreis_id ,
      bw_vorgang_id ,
      dat_beleg ,
      dat_buch ,
      dat_erfasst ,
      einkaufsorganisation_id ,
      ek_netto_bnk,
      empfaenger_id ,
      endlief_fg ,
      erfsngs_menge_einh_id ,
      gp_id ,
      grund_id ,
      kj ,
      komponentenmenge,
      kostenstelle_id ,
      kunde_id ,
      lager_bewart_id ,
      lagerbew_beleg_id ,
      lagerbew_beleg_pos_id ,
      lagerbew_beleg_pos_mutter_id ,
      lagerbew_beleg_pos_storno_id ,
      lagerbew_beleg_storno_id ,
      lagerbew_beleg_storno_kj ,
      lagerort_id ,
      lagerort_id_empfaenger ,
      lagerplatz_id ,
      lief_gp_id ,
      line_id ,
      los_charge ,
      mandant_id ,
      mandant_id_empfaenger ,
      mandant_id_kunde ,
      menge_bestand_bme ,
      menge_erf ,
      menge_lagerbew_bme ,
      menge_lagerbew_kolli ,
      menge_lagerbew_palette ,
      menge_lief ,
      menge_lieferschein ,
      nb_id ,
      ref_lagerbew_beleg_id ,
      ref_lagerbew_beleg_id_num,
      sachkonto_id ,
      shkum ,
      soll_haben_kz ,
      system_id ,
      transaktion_code ,
      vorgangsart_id ,
      waren_begl_schein_id ,
      wert_bestand ,
      wg_art_fg,
      wrg_id ,
      wup_id ,
      xruem_fg ,
      zeit_erfasst ,
      lagerbew_beleg_pos_sort_id,
      lagerbew_beleg_parent_pos_sort_id,
      display_art_id
)
SELECT
                mm.art_id,
                mm.art_id_bf,
                mm.art_id_empfaenger,
                mm.auto_fg,
                mm.beleg_user_name,
                mm.belegart_id,
                mm.belegkopftext,
                mm.best_beleg_id,
                mm.best_beleg_pos_id,
                mm.betrag_bnk,
                mm.betrag_exbwr,
		mm.betrag_lagerbew,		
                mm.betrag_umbewertung,
                mm.betrag_verkauf,
                mm.betrag_verkauf_ist,
                COALESCE((CAST(mm.betrag_verkauf_ist AS FLOAT) / (mm.mwst+100) * 100),0) AS betrag_verkauf_ist_netto,
                mm.betrag_vk_netto,
                mm.betrag_vk_netto_vz,
                mm.buchungskreis_id,
                mm.bw_vorgang_id,
                mm.dat_beleg,
                mm.dat_buch,
                mm.dat_erfasst,
                mm.einkaufsorganisation_id,
		(CASE 	WHEN (mm.nb_id IN (99,-111))
			THEN /* zentral */
				(COALESCE(	agw.ek_netto_bnk,
						agw2.ek_netto_bnk,
						agw3.ek_netto_bnk,
						agw4.ek_netto_bnk,
						agw5.ek_netto_bnk,
						agw6.ek_netto_bnk,
						agw7.ek_netto_bnk,
						agw8.ek_netto_bnk,
						agw9.ek_netto_bnk,
						agw10.ek_netto_bnk,
						agw11.ek_netto_bnk,
						agw12.ek_netto_bnk,
						(0 )
					)
				)
			ELSE /* dezentral (Lager kann nicht richtig sein) */
				(COALESCE(	agw9.ek_netto_bnk,
						agw10.ek_netto_bnk,
						agw11.ek_netto_bnk,
						agw12.ek_netto_bnk,
						agw2.ek_netto_bnk,
						agw4.ek_netto_bnk,
						agw6.ek_netto_bnk,
						agw8.ek_netto_bnk,
						(0 )
					)
				)
		END) AS ek_netto_bnk_,

	        COALESCE(mm.umwrk,CASE
                                WHEN mm.wempf LIKE '94000%' and 
                                     TRY_CAST(COALESCE(TRIM(bb.kunde_id),TRIM(mm.kunde_id)) AS INTEGER) is not NULL
                                THEN CAST(COALESCE(TRIM(bb.kunde_id),TRIM(mm.kunde_id)) AS INTEGER)
                                ELSE 
                                  CASE 
                                    WHEN mm.wempf IS NOT NULL and 
                                         TRY_CAST(TRIM(mm.wempf) AS INTEGER) is not NULL 
                                    THEN CAST(TRIM(mm.wempf) AS INTEGER) 
                                    ELSE NULL 
                                  END
                              END) AS empfaenger_id,
                mm.endlief_fg,
                mm.erfsngs_menge_einh_id,
                mm.gp_id,
                mm.grund_id,
                mm.kj, 
		(CASE 	WHEN (mm.nb_id IN (99,-111))
			THEN /* zentral */
				(COALESCE(	agw.komponentenmenge,
						agw2.komponentenmenge,
						agw3.komponentenmenge,
						agw4.komponentenmenge,
						agw5.komponentenmenge,
						agw6.komponentenmenge,
						agw7.komponentenmenge,
						agw8.komponentenmenge,
						agw9.komponentenmenge,
						agw10.komponentenmenge,
						agw11.komponentenmenge,
						agw12.komponentenmenge,
						1
					)
				)
			ELSE /* dezentral (Lager kann nicht richtig sein) */
				(COALESCE(	agw9.komponentenmenge,
						agw10.komponentenmenge,
						agw11.komponentenmenge,
						agw12.komponentenmenge,
						agw2.komponentenmenge,
						agw4.komponentenmenge,
						agw6.komponentenmenge,
						agw8.komponentenmenge,
						1
					)
				)
		END) AS komponentenmenge_,
                mm.kostenstelle_id,
                COALESCE(TRIM(bb.kunde_id) , TRIM(mm.kunde_id)) AS kunde_id,
                mm.lager_bewart_id,
                mm.lagerbew_beleg_id,
                mm.lagerbew_beleg_pos_id,
                mm.lagerbew_beleg_pos_mutter_id,
                mm.lagerbew_beleg_pos_storno_id,
                mm.lagerbew_beleg_storno_id, 
                mm.lagerbew_beleg_storno_kj,
                mm.lagerort_id ,  
                mm.lagerort_id_empfaenger ,
                mm.lagerplatz_id ,
                mm.lief_gp_id,   
                mm.line_id,
                mm.los_charge,
                mm.mandant_id,
                mm.mandant_id_empfaenger,
                mm.mandant_id_kunde,
                mm.menge_bestand_bme, 
                mm.menge_erf,
                mm.menge_lagerbew_bme,
		mm.menge_lagerbew_kolli,
           	mm.menge_lagerbew_palette,
		mm.menge_lief,
                mm.menge_lieferschein,
                mm.nb_id,
                mm.ref_lagerbew_beleg_id,
                mm.ref_lagerbew_beleg_id_num,
                mm.sachkonto_id,
                mm.shkum,
                mm.soll_haben_kz,
	        mm.system_id,
                mm.transaktion_code,
                mm.vorgangsart_id,
                mm.waren_begl_schein_id,
                mm.wert_bestand,
		mm.wg_art_fg,
                mm.wrg_id,
                mm.wup_id,
                mm.xruem_fg,
                CAST(TO_CHAR(mm.zeit_erfasst, '000000') AS INT) ,
                mm.lagerbew_beleg_pos_sort_id,
                mm.lagerbew_beleg_parent_pos_sort_id,
                mm.display_art_id
FROM DBP_ETL.de_mseg_delta_1 mm_1

LEFT OUTER JOIN 
        (SELECT *
         FROM DBP_DATA.besch_best_det_1
         WHERE (mandant_id,dat_best_beleg)  
		IN (	SELECT  a.mandant_id, a.dat_best_beleg
			FROM  	DBP_DATA.besch_best_1 a
			JOIN    DBP_ETL.de_mseg_delta_1 b
			ON      a.mandant_id 	= b.mandant_id 
			AND     a.best_beleg_id = b.best_beleg_id
			GROUP BY 1,2
		   )
        ) bb
	ON   	bb.mandant_id        	= mm.mandant_id
	AND 	bb.best_beleg_id 	= mm.best_beleg_id
	AND 	bb.best_beleg_pos_id 	= mm.best_beleg_pos_id
	AND 	bb.mandant_id           = 1

LEFT OUTER JOIN DBP_DATA.art_gp_zu_per_1 ap
	ON 	ap.art_id = mm.art_id 
	AND 	ap.mandant_id = mm.mandant_id
	AND 	mm.dat_buch BETWEEN ap.dat_von AND ap.dat_bis

/*
zentral
lager       richtig
datum       richtig
lieferant   richtig
*/
LEFT OUTER JOIN DBP_ETL.ek01_1 agw
	ON 	mm.art_id = agw.art_id
	AND 	mm.dat_buch BETWEEN agw.dat_von AND agw.dat_bis  /* richtiges Datum */
	AND 	mm.wup_id = agw.wup_id                           /* richtiges Lager */
	AND 	mm.gp_id_ber = agw.gp_id                         /* richtiger Lieferant */

/*
zentral
lager       falsch
datum       richtig
lieferant   richtig
*/
LEFT OUTER JOIN DBP_ETL.ek02_1 agw2
	ON 	mm.art_id = agw2.art_id
	AND 	mm.dat_buch BETWEEN agw2.dat_von AND agw2.dat_bis  /* richtiges Datum */
	AND 	mm.gp_id_ber = agw2.gp_id

/*
zentral
lager       richtig
datum       falsch
lieferant   richtig
*/
LEFT OUTER JOIN DBP_ETL.ek03_1 agw3
	ON 	mm.art_id = agw3.art_id
	AND 	mm.wup_id = agw3.wup_id           /* richtiges Lager */
	AND 	mm.gp_id_ber = agw3.gp_id         /* richtiger Lieferant */

/*
zentral
lager       falsch
datum       falsch
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek04_1 agw4
	ON 	mm.art_id = agw4.art_id
	AND 	mm.gp_id_ber = agw4.gp_id        /* richtiger Lieferant */

/*
zentral
lager       richtig
datum       richtig
lieferant   falsch
*/
LEFT OUTER JOIN DBP_ETL.ek05_1 agw5
	ON 	mm.art_id = agw5.art_id
	AND 	mm.dat_buch BETWEEN agw5.dat_von AND agw5.dat_bis  /* richtiges Datum */
	AND 	mm.wup_id = agw5.wup_id                            /* richtiges Lager */

/*
zentral
lager       falsch
datum       richtig
lieferant   falsch
*/
LEFT OUTER JOIN DBP_ETL.ek06_1 agw6
	ON 	mm.art_id = agw6.art_id
	AND 	mm.dat_buch BETWEEN agw6.dat_von AND agw6.dat_bis   /* richtiges Datum */

/*
zentral
lager       richtig
datum       falsch
lieferant   falsch
*/
LEFT OUTER JOIN DBP_ETL.ek07_1 agw7
	ON 	mm.art_id = agw7.art_id
	AND 	mm.wup_id = agw7.wup_id        /* richtiges Lager */

/*
zentral
lager       falsch
datum       falsch
lieferant   falsch
*/
LEFT OUTER JOIN DBP_ETL.ek08_1 agw8
	ON 	mm.art_id = agw8.art_id

/*
dezentral
lager       -1
datum       richtig
lieferant   richtig
*/
LEFT OUTER JOIN DBP_ETL.ek09_1 agw9
	ON 	mm.art_id = agw9.art_id
	AND 	mm.gp_id_ber = agw9.gp_id                          /* richtiger Lieferant */
	AND 	mm.dat_buch BETWEEN agw9.dat_von AND agw9.dat_bis  /* richtiges Datum */

/*
dezentral
lager       -1
datum       falsch
lieferant   richtig
*/
LEFT OUTER JOIN DBP_ETL.ek10_1 agw10
	ON 	mm.art_id = agw10.art_id
	AND 	mm.gp_id_ber = agw10.gp_id    /* richtiger Lieferant */

/*
dezentral
lager       -1
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek11_1 agw11
	ON 	mm.art_id = agw11.art_id
	AND 	mm.dat_buch BETWEEN agw11.dat_von AND agw11.dat_bis /* richtiges Datum */

/*
dezentral
lager       -1
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek12_1 agw12
	ON 	mm.art_id = agw12.art_id

QUALIFY ROW_NUMBER() OVER (PARTITION BY mm.mandant_id, mm.lagerbew_beleg_id , mm.lagerbew_beleg_pos_id, mm.kj ORDER BY CAST((ek_netto_bnk_ ) AS DECIMAL(18,4)) DESC, komponentenmenge_ DESC) = 1
;

DROP TABLE IF EXISTS DBP_ETL.de_mseg_menge_1;

CREATE TABLE DBP_ETL.de_mseg_menge_1  (
      art_id 			INTEGER,
      art_id_bf 		INTEGER ,
      art_id_empfaenger 	INTEGER ,
      auto_fg 			CHAR(1) COLLATE 'en-ci' NOT NULL,
      beleg_user_name 		CHAR(20) COLLATE 'en-ci' ,
      belegart_id 		CHAR(2) COLLATE 'en-ci',
      belegkopftext 		VARCHAR(30) COLLATE 'en-ci',
      best_beleg_id 		DECIMAL(18,0),
      best_beleg_pos_id 	INTEGER  NOT NULL,
      betrag_belegfluss_wg_art 	DECIMAL(18,2),
      betrag_bnk 		DECIMAL(18,4)  ,
      betrag_exbwr 		DECIMAL(18,4)  ,
      betrag_lagerbew 		DECIMAL(18,4)NOT NULL,
      betrag_umbewertung 	DECIMAL(18,4),
      betrag_verkauf 		DECIMAL(18,2) ,
      betrag_verkauf_ist 	DECIMAL(18,2) ,
      betrag_verkauf_ist_netto 	DECIMAL(18,4),
      betrag_vk_netto 		DECIMAL(18,2) ,
      betrag_vk_netto_vz 	DECIMAL(18,4) ,
      buchungskreis_id 		SMALLINT ,
      bw_vorgang_id 		SMALLINT,
      dat_beleg 		DATE ,
      dat_buch 			DATE ,
      dat_erfasst 		DATE,
      einkaufsorganisation_id 	SMALLINT,
      --ek_netto_bnk              DECIMAL(18,4), /*Before PTY - DECIMAL(18,4)*/
      empfaenger_id 		INTEGER,
      endlief_fg 		BYTEINT ,
      erfsngs_menge_einh_id 	CHAR(3) COLLATE 'en-cs'  ,
      gp_id 			INTEGER,
      grund_id 			CHAR(10) COLLATE 'en-ci'  ,
      kj 			INTEGER NOT NULL,
     -- komponentenmenge          DECIMAL(18,4),
      kostenstelle_id 		CHAR(10) COLLATE 'en-ci'  ,
      kunde_id 			VARCHAR(10) COLLATE 'en-ci', 
      lager_bewart_id 		CHAR(3) COLLATE 'en-ci'  ,
      lagerbew_beleg_id 	DECIMAL(18,0)  ,
      lagerbew_beleg_pos_id 	INTEGER  ,
      lagerbew_beleg_pos_mutter_id INTEGER  ,
      lagerbew_beleg_pos_storno_id INTEGER,
      lagerbew_beleg_storno_id 	DECIMAL(18,0),
      lagerbew_beleg_storno_kj 	SMALLINT,
      lagerort_id 		CHAR(4) COLLATE 'en-ci'  ,
      lagerort_id_empfaenger 	CHAR(4) COLLATE 'en-ci'  ,
      lagerplatz_id 		CHAR(10) COLLATE 'en-ci',
      lief_gp_id 		INTEGER  ,
      line_id 			INTEGER  ,
      los_charge                VARCHAR(10) COLLATE 'en-ci',
      mandant_id 		BYTEINT NOT NULL,
      mandant_id_empfaenger 	BYTEINT,
      mandant_id_kunde 		BYTEINT,
      menge_bestand_bme 	DECIMAL(18,3)  ,
      menge_erf 		DECIMAL(18,3)  ,
      menge_lagerbew_bme 	DECIMAL(18,3)  ,
      menge_lagerbew_kolli 	DECIMAL(18,3)  ,
      menge_lagerbew_palette 	DECIMAL(18,3),
      menge_lief 		DECIMAL(18,3)  ,
      menge_lieferschein 	DECIMAL(18,3)  ,
      nb_id 			SMALLINT  ,
      ref_lagerbew_beleg_id 	VARCHAR(20) COLLATE 'en-ci',
      ref_lagerbew_beleg_id_num DECIMAL(18,0)  ,
      sachkonto_id 		CHAR(10) COLLATE 'en-ci'  ,
      shkum 			CHAR(1) COLLATE 'en-ci'  ,
      soll_haben_kz 		CHAR(1) COLLATE 'en-ci'  ,
      system_id 		INTEGER,
      transaktion_code 		CHAR(10) COLLATE 'en-ci',
      vorgangsart_id 		CHAR(2) COLLATE 'en-ci'  ,
      waren_begl_schein_id 	CHAR(10) COLLATE 'en-ci',
      wert_bestand 		DECIMAL(18,4)  ,
     -- wg_art_fg                 BYTEINT  ,
      wrg_id 			CHAR(3) COLLATE 'en-ci'  ,
      wup_id 			INTEGER,
      xruem_fg 			BYTEINT  ,
      zeit_erfasst 		INTEGER  ,
      lagerbew_beleg_pos_sort_id NUMBER(38,0),
      lagerbew_beleg_parent_pos_sort_id NUMBER(38,0),
      display_art_id NUMBER(38,0)
)
;

INSERT INTO DBP_ETL.de_mseg_menge_1
(
  art_id
, art_id_bf
, art_id_empfaenger
, auto_fg
, beleg_user_name
, belegart_id
, belegkopftext
, best_beleg_id
, best_beleg_pos_id
, betrag_belegfluss_wg_art
, betrag_bnk
, betrag_exbwr
, betrag_lagerbew
, betrag_umbewertung
, betrag_verkauf
, betrag_verkauf_ist
, betrag_vk_netto
, betrag_vk_netto_vz
, buchungskreis_id
, bw_vorgang_id
, dat_beleg
, dat_buch
, dat_erfasst
, einkaufsorganisation_id
, empfaenger_id
, endlief_fg
, erfsngs_menge_einh_id
, gp_id
, grund_id
, kj
, kostenstelle_id
, kunde_id
, lager_bewart_id
, lagerbew_beleg_id
, lagerbew_beleg_pos_id
, lagerbew_beleg_pos_mutter_id
, lagerbew_beleg_pos_storno_id
, lagerbew_beleg_storno_id
, lagerbew_beleg_storno_kj
, lagerort_id
, lagerort_id_empfaenger
, lagerplatz_id
, lief_gp_id
, line_id
, los_charge
, mandant_id
, mandant_id_empfaenger
, mandant_id_kunde
, menge_bestand_bme
, menge_erf
, menge_lagerbew_bme
, menge_lagerbew_kolli
, menge_lagerbew_palette
, menge_lief
, menge_lieferschein
, nb_id
, ref_lagerbew_beleg_id
, ref_lagerbew_beleg_id_num
, sachkonto_id
, shkum
, soll_haben_kz
, system_id
, transaktion_code
, vorgangsart_id
, waren_begl_schein_id
, wert_bestand
, wrg_id
, wup_id
, xruem_fg
, zeit_erfasst
, lagerbew_beleg_pos_sort_id
, lagerbew_beleg_parent_pos_sort_id
, display_art_id
)
SELECT
	w.art_id
	,w.art_id_bf
	,w.art_id_empfaenger
	,COALESCE (w.auto_fg,'')
	,w.beleg_user_name
	,w.belegart_id
	,w.belegkopftext
	,w.best_beleg_id
	,w.best_beleg_pos_id
	,COALESCE(CAST((bbf.betrag_ek_netto ) AS DECIMAL (18,2)), 0) AS betrag_belegfluss_wg_art
	,w.betrag_bnk
	,w.betrag_exbwr
	,CASE	WHEN	wgfz.wg_id IS NOT NULL	THEN	betrag_lagerbew
		ELSE	(CAST(CAST(menge_lagerbew_bme AS FLOAT ) * CAST(CAST((w.ek_netto_bnk  ) AS DECIMAL(18,4)) * w.komponentenmenge  AS FLOAT ) AS DECIMAL(18,2)) )
		END  AS betrag_lagerbew
	,w.betrag_umbewertung
	,w.betrag_verkauf
	,w.betrag_verkauf_ist
	,w.betrag_vk_netto
	,w.betrag_vk_netto_vz
	,w.buchungskreis_id
	,w.bw_vorgang_id
	,w.dat_beleg
	,w.dat_buch
	,w.dat_erfasst
	,w.einkaufsorganisation_id
	,w.empfaenger_id
	,w.endlief_fg
	,w.erfsngs_menge_einh_id
	,w.gp_id
	,w.grund_id
	,w.kj
	,w.kostenstelle_id
	,w.kunde_id
	,w.lager_bewart_id
	,w.lagerbew_beleg_id
	,w.lagerbew_beleg_pos_id
	,w.lagerbew_beleg_pos_mutter_id
	,w.lagerbew_beleg_pos_storno_id
	,w.lagerbew_beleg_storno_id
	,w.lagerbew_beleg_storno_kj
	,w.lagerort_id
	,w.lagerort_id_empfaenger
	,w.lagerplatz_id
	,w.lief_gp_id
	,w.line_id
	,w.los_charge
	,w.mandant_id
	,w.mandant_id_empfaenger
	,w.mandant_id_kunde
	,w.menge_bestand_bme
	,w.menge_erf
	,w.menge_lagerbew_bme
	,CAST(( w.menge_lagerbew_bme * ( CASE 	
                                         WHEN ekko.bestellart_id = 'ZLLF' AND av.ausg_menge_einh_id <> ekpo.best_menge_einh_id THEN COALESCE(bstme_kolli.umrech_faktor,bstme_kolli_fallback.umrech_faktor) --SPEC0257065
                                         WHEN aukolli_alternativ.umrech_faktor IS NULL THEN 1 ELSE aukolli_alternativ.umrech_faktor END) ) AS DECIMAL(18,3) ) AS menge_lagerbew_kolli	
        ,CAST( CASE WHEN aupalette.umrech_faktor IS NULL THEN NULL ELSE (w.menge_lagerbew_bme * aupalette.umrech_faktor )END AS DECIMAL(18,3) ) AS menge_lagerbew_palette
	,w.menge_lief
	,w.menge_lieferschein
	,w.nb_id
	,w.ref_lagerbew_beleg_id
	,w.ref_lagerbew_beleg_id_num
	,w.sachkonto_id
	,w.shkum
	,w.soll_haben_kz
	,w.system_id
	,w.transaktion_code
	,w.vorgangsart_id
	,w.waren_begl_schein_id
	,w.wert_bestand
	,w.wrg_id
	,w.wup_id
	,w.xruem_fg
	,w.zeit_erfasst
        ,w.lagerbew_beleg_pos_sort_id
        ,w.lagerbew_beleg_parent_pos_sort_id
        ,w.display_art_id

FROM DBP_ETL.de_mseg_work_1 w

-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN
	(	SELECT 	art_id,
			paletten_faktor_einh_id,
			ausg_menge_einh_id,
			dat_von,
			dat_bis,
			mandant_id
		FROM DBP_DATA.art_vorschlagswert_per_1
	) av
	ON 	w.art_id 	 = av.art_id 
	AND	av.dat_von 	<= w.dat_buch 
	AND	av.dat_bis 	>= w.dat_buch 
	AND 	av.mandant_id 	= w.mandant_id

-- Umrechnungsfaktor für Palettenfaktor holen
LEFT OUTER JOIN
	(	SELECT	art_id,
			umrech_faktor,
			altnv_menge_einh_id,
			dat_von,
			dat_bis,
			mandant_id
		FROM DBP_DATA.art_umrechnung_faktor_per_1
	) aupalette
	ON 	w.art_id 			= aupalette.art_id 
	AND	av.paletten_faktor_einh_id 	= aupalette.altnv_menge_einh_id 
	AND	aupalette.dat_von 		<= w.dat_buch 
	AND	aupalette.dat_bis 		>= w.dat_buch 
	AND	aupalette.mandant_id 		= w.mandant_id

-- Umrechnungsfaktor für Default Mengeneinheit holen
LEFT OUTER JOIN
	(	SELECT 	art_id,
			altnv_menge_einh_id ,
			dat_von,
			dat_bis,
			umrech_faktor,
			mandant_id
		FROM DBP_DATA.art_umrechnung_faktor_per_1
	) aukolli_alternativ
	ON	w.art_id             		= aukolli_alternativ.art_id              
	AND	av.ausg_menge_einh_id       	= aukolli_alternativ.altnv_menge_einh_id 
	AND	aukolli_alternativ.dat_von 	<= w.dat_buch                            
	AND	aukolli_alternativ.dat_bis 	>= w.dat_buch                            
	AND	aukolli_alternativ.mandant_id 	= w.mandant_id

LEFT OUTER JOIN
	( 	SELECT	mandant_id,
			art_id,
			arthiertyp_id,
			wg_id,
			dat_von,
			dat_bis
		FROM DBP_DATA.art_wg_zu_per_1
	) awzp
	ON 	w.art_id = awzp.art_id 
	AND 	awzp.arthiertyp_id = 2 
	AND	w.mandant_id = awzp.mandant_id
	AND 	awzp.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')

LEFT OUTER JOIN DBP_DATA.wg_filter_zu_1 wgfz
	ON 	awzp.wg_id = wgfz.wg_id
	AND 	awzp.mandant_id = wgfz.mandant_id
	AND 	wgfz.wg_filter_id = 6
	AND 	wgfz.arthiertyp_id = 2

LEFT OUTER JOIN DBP_DATA.best_belegfluss_1 bbf 
     ON w.lagerbew_beleg_id     =  bbf.folge_beleg_id 
	AND	w.mandant_id            =  bbf.mandant_id 
	AND	w.lagerbew_beleg_pos_id =  bbf.folge_beleg_pos_id 
	AND	w.kj             	=  bbf.kj  
	AND	bbf.best_entw_typ_id    = 'E'
	AND	bbf.mandant_id          = 1 
	AND	w.dat_buch              =  bbf.dat_buch 
	AND 	bbf.best_beleg_id       =  w.best_beleg_id 
	AND	bbf.best_beleg_pos_id   =  w.best_beleg_pos_id
    AND w.wg_art_fg             =  1 

--SPEC0257065
LEFT JOIN dbp_data.besch_best_det_1 ekpo_1
  ON w.mandant_id = ekpo.mandant_id
  AND w.best_beleg_id = ekpo.best_beleg_id
  AND w.best_beleg_pos_id = ekpo.best_beleg_pos_id

LEFT JOIN dbp_data.besch_best_1 ekko_1
  ON ekpo.mandant_id = ekko.mandant_id
  AND ekpo.best_beleg_id = ekko.best_beleg_id
  AND ekpo.dat_best_beleg = ekko.dat_best_beleg

LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 bstme_kolli
  ON ekpo.mandant_id = bstme_kolli.mandant_id
  AND ekpo.art_id = bstme_kolli.art_id
  AND ekpo.best_menge_einh_id= bstme_kolli.altnv_menge_einh_id
  AND ekpo.dat_best_beleg BETWEEN bstme_kolli.dat_von AND bstme_kolli.dat_bis

LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 bstme_kolli_fallback
  ON ekpo.mandant_id = bstme_kolli_fallback.mandant_id
  AND ekpo.art_id = bstme_kolli_fallback.art_id
  AND ekpo.best_menge_einh_id = bstme_kolli_fallback.altnv_menge_einh_id
  AND bstme_kolli_fallback.dat_bis = '9999-12-31'
;

DROP TABLE IF EXISTS DBP_ETL.de_lagerbew_det_vk_anr_1;

CREATE TABLE DBP_ETL.de_lagerbew_det_vk_anr_1  (
mandant_id             BYTEINT,
lagerbew_beleg_id      DECIMAL(18,0),
lagerbew_beleg_pos_id  INTEGER,
dat_buch               DATE NOT NULL,
kj                     SMALLINT,
art_id                 INTEGER,
wup_id                 INTEGER,
nb_id                  SMALLINT,
menge_lagerbew_bme     DECIMAL(18,3),
vk_netto               DECIMAL(18,4)
)
;

INSERT INTO DBP_ETL.de_lagerbew_det_vk_anr_1                                
(
	 mandant_id
	,lagerbew_beleg_id
	,lagerbew_beleg_pos_id
	,dat_buch
	,kj
	,art_id
	,wup_id
	,nb_id
	,menge_lagerbew_bme
	,vk_netto
)
SELECT
	 dmm.mandant_id
	,dmm.lagerbew_beleg_id
	,dmm.lagerbew_beleg_pos_id
	,dmm.dat_buch
	,dmm.kj
	,dmm.art_id
	,dmm.wup_id
	,dmm.nb_id
	,dmm.menge_lagerbew_bme
	,CAST(ap.vk_brutto /(CASE       WHEN mwst.mwst_id IS NULL THEN 1
					ELSE 1+(mwst.mwst/100) END ) AS DECIMAL(10,4)
	     ) AS vk_netto
FROM  DBP_ETL.de_mseg_menge_1  dmm

INNER JOIN 	DBP_DATA.art_1 art_1
	ON  	dmm.mandant_id 	= art.mandant_id
	AND 	dmm.art_id    	= art.art_id

INNER JOIN 	DBP_DATA.mwst_per_1 mwst
	ON 	mwst.mandant_id 	= art.mandant_id
	AND 	art.mwst_id = mwst.mwst_id
	AND 	dmm.dat_buch BETWEEN mwst.dat_von AND mwst.dat_bis

LEFT OUTER JOIN DBP_DATA.art_pm_vw_zu_per_1 ap
         ON 	dmm.mandant_id 	= ap.mandant_id
        AND 	dmm.art_id  	= ap.art_id
        AND 	dmm.dat_buch BETWEEN ap.dat_von AND ap.dat_bis
        AND 	ap.preistyp_id 	= 0
        AND 	ap.pm_id 	= 1
        AND 	ap.vw_id IN (1,2,3,6)
        AND 	ap.vk_brutto IS NOT NULL 
	
WHERE dmm.nb_id  IN ( -111,99)                
;

UPDATE DBP_ETL.de_mseg_menge_1
 
SET betrag_vk_netto_vz = betrag_vk_vz_netto_

FROM
 (
         SELECT                                
		 mandant_id             AS mandant_id_
		,lagerbew_beleg_id      AS lagerbew_beleg_id_
		,lagerbew_beleg_pos_id  AS lagerbew_beleg_pos_id_
		,dat_buch               AS dat_buch_
		,kj                     AS kj_
		,art_id                 AS art_id_
		,wup_id                 AS wup_id_
		,nb_id                  AS nb_id_
		,COALESCE( CAST(menge_lagerbew_bme  * CAST(vk_netto  AS FLOAT) AS DECIMAL(18,4)),0) AS betrag_vk_vz_netto_
        FROM DBP_ETL.de_lagerbew_det_vk_anr_1
        QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id_, lagerbew_beleg_id_, lagerbew_beleg_pos_id_, dat_buch_, art_id_,wup_id_, nb_id_ ORDER BY ABS(betrag_vk_vz_netto_) DESC) = 1
) dt WHERE mandant_id 	= mandant_id_
AND   lagerbew_beleg_id = lagerbew_beleg_id_
AND   lagerbew_beleg_pos_id = lagerbew_beleg_pos_id_
AND   dat_buch 		= dat_buch_
AND   kj 		= kj_
AND   art_id 		= art_id_
AND   wup_id 		= wup_id_
AND   nb_id  		= nb_id_
;

DELETE 
FROM 	DBP_DATA.lagerbew_delta_1
WHERE 	(mandant_id, lagerbew_beleg_id,kj)
IN 	(SELECT mandant_id, lagerbew_beleg_id,kj
	 FROM DBP_ETL.de_mseg_menge_1
        )
;

INSERT INTO DBP_DATA.lagerbew_delta_1
( 
 mandant_id
,lagerbew_beleg_id
,kj
,vorgangsart_id
,dat_buch
,beleg_user_name
,ref_lagerbew_beleg_id
,dat_beleg
,dat_erfasst
,belegart_id
,belegkopftext
,waren_begl_schein_id
,system_id
,ref_lagerbew_beleg_id_num
,lief_gp_id
,zeit_erfasst
,transaktion_code
)
SELECT
 mandant_id
,lagerbew_beleg_id
,kj
,vorgangsart_id
,dat_buch
,beleg_user_name
,ref_lagerbew_beleg_id
,dat_beleg
,dat_erfasst
,belegart_id
,belegkopftext
,waren_begl_schein_id
,system_id
,ref_lagerbew_beleg_id_num
,lief_gp_id
,zeit_erfasst
,transaktion_code
FROM DBP_ETL.de_mseg_menge_1

QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id,lagerbew_beleg_id,kj ORDER BY lagerbew_beleg_pos_id DESC) = 1
;

DELETE 
FROM 	DBP_DATA.lagerbew_det_delta_1
WHERE 	(mandant_id, lagerbew_beleg_id,lagerbew_beleg_pos_id,kj)
IN
	(SELECT mandant_id, lagerbew_beleg_id,lagerbew_beleg_pos_id,kj
	 FROM 	DBP_ETL.de_mseg_menge_1
	)
;

INSERT INTO DBP_DATA.lagerbew_det_delta_1
(
         mandant_id
        ,lagerbew_beleg_id
        ,lagerbew_beleg_pos_id
        ,kj
        ,lager_bewart_id
        ,art_id
        ,grund_id
        ,wup_id
        ,nb_id
        ,auto_fg
        ,lagerort_id
        ,gp_id
        ,einkaufsorganisation_id
        ,soll_haben_kz
        ,wrg_id
        ,best_beleg_id
        ,best_beleg_pos_id
        ,betrag_lagerbew
        ,betrag_verkauf
        ,betrag_verkauf_ist
        ,erfsngs_menge_einh_id
        ,lagerplatz_id
        ,kunde_id
        ,mandant_id_kunde
        ,menge_lagerbew_kolli
        ,menge_lagerbew_bme
        ,menge_lagerbew_palette
        ,menge_lieferschein
        ,menge_lief
        ,menge_erf
        ,empfaenger_id
        ,mandant_id_empfaenger
        ,dat_buch
        ,lagerbew_beleg_storno_id
        ,lagerbew_beleg_pos_storno_id
        ,lagerbew_beleg_storno_kj
        ,betrag_vk_netto
        ,betrag_vk_netto_vz
        ,system_id
        ,betrag_belegfluss_wg_art
        ,bw_vorgang_id
        ,betrag_verkauf_ist_netto
        ,menge_bestand_bme
        ,wert_bestand
        ,buchungskreis_id
        ,shkum
        ,kostenstelle_id
        ,sachkonto_id
        ,art_id_empfaenger
        ,lagerort_id_empfaenger
        ,art_id_bf
        ,lagerbew_beleg_pos_mutter_id
        ,line_id
        ,endlief_fg
        ,xruem_fg
        ,betrag_exbwr
        ,betrag_bnk
        ,betrag_umbewertung
	,gp_id_zl
	,bq_findung_id
        ,display_art_id
)
SELECT 
	 mandant_id
        ,lagerbew_beleg_id
        ,lagerbew_beleg_pos_id
        ,kj
        ,lager_bewart_id
        ,art_id
        ,grund_id
        ,wup_id
        ,nb_id
        ,auto_fg
        ,lagerort_id
        ,gp_id
        ,einkaufsorganisation_id
        ,soll_haben_kz
        ,wrg_id
        ,best_beleg_id
        ,best_beleg_pos_id
        ,betrag_lagerbew
        ,betrag_verkauf
        ,betrag_verkauf_ist
        ,erfsngs_menge_einh_id
        ,lagerplatz_id
        ,kunde_id
        ,mandant_id_kunde
        ,COALESCE(menge_lagerbew_kolli,0)
        ,COALESCE(menge_lagerbew_bme,0)
        ,COALESCE(menge_lagerbew_palette,0)
        ,COALESCE(menge_lieferschein,0)
        ,COALESCE(menge_lief,0)
        ,COALESCE(menge_erf,0)
        ,empfaenger_id
        ,mandant_id_empfaenger
        ,dat_buch
        ,lagerbew_beleg_storno_id
        ,lagerbew_beleg_pos_storno_id
        ,lagerbew_beleg_storno_kj
        ,betrag_vk_netto
        ,betrag_vk_netto_vz
        ,system_id
        ,betrag_belegfluss_wg_art
        ,bw_vorgang_id
        ,COALESCE(betrag_verkauf_ist_netto, 0)
        ,menge_bestand_bme
        ,wert_bestand
        ,buchungskreis_id
        ,COALESCE(shkum ,'')
        ,COALESCE(kostenstelle_id ,'')
        ,COALESCE(sachkonto_id,'')
        ,art_id_empfaenger
        ,COALESCE(lagerort_id_empfaenger,'')
        ,art_id_bf
        ,lagerbew_beleg_parent_pos_sort_id as lagerbew_beleg_pos_mutter_id
        ,lagerbew_beleg_pos_sort_id as line_id
        ,endlief_fg
        ,xruem_fg
        ,betrag_exbwr
        ,betrag_bnk
        ,betrag_umbewertung
	,-1
	,0
        ,display_art_id
FROM DBP_ETL.de_mseg_menge_1
;

INSERT INTO DBP_DATA.l_vorgangsart_1
(
	mandant_id,
	vorgangsart_id
)
	SELECT
	 mandant_id
	,vorgangsart_id AS vorgangsart_id
	FROM DBP_ETL.de_mseg_menge_1
	WHERE vorgangsart_id IS NOT NULL AND
	(mandant_id, vorgangsart_id) NOT IN
		(SELECT mandant_id, vorgangsart_id
		 FROM DBP_DATA.l_vorgangsart_1
		)
GROUP BY 1,2
;

INSERT INTO DBP_DATA.vorgangsart_spr_zu_1
(
	mandant_id,
	vorgangsart_id,
	spr_id,
	vorgangsart_bez
)
SELECT
	  mm.mandant_id
	, mm.vorgangsart_id	AS vorgangsart_id
	, s.spr_id            	AS spr_id
	, 'system generated'  	AS vorgangsart_bez
FROM 	DBP_ETL.de_mseg_menge_1 mm_1

INNER JOIN DBP_DATA.mandant_spr_zu_1 man
	ON mm.mandant_id = man.mandant_id

INNER JOIN DBP_DATA.spr_1 s
	ON s.dwh_spr = 1
       AND s.spr_id = 22

WHERE (mm.mandant_id, mm.vorgangsart_id, s.spr_id) NOT IN
(	SELECT
	mandant_id,
	vorgangsart_id,
	spr_id
FROM DBP_DATA.vorgangsart_spr_zu_1
)
GROUP BY 1,2,3,4
;

UPDATE 	DBP_DATA.l_lager_bewgrund_1

SET  retourenart_id = retourenart_id_

FROM
	(SELECT	
		t1.mandant_id 		AS mandant_id_,
		t1.lager_bewart_id      AS lager_bewart_id_,
		t1.grund_id      	AS grund_id_,
		MAX(t1.retourenart_id) 	AS retourenart_id_
	FROM 	DBP_ETL.de_mseg_delta_1 t1_1

	WHERE 	t1.retourenart_id IS NOT NULL
	GROUP BY 1,2,3
	) x WHERE mandant_id      = mandant_id_
AND   lager_bewart_id = lager_bewart_id_
AND   grund_id        = grund_id_
AND   mandant_id = 1
;

