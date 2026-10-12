-- 1st update with 1:n-supplier logic

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT a.mandant_id,
                                                  a.art_id,
                                                  MAX(a.akt_gp_id) AS akt_gp_id
                                           FROM dbp_msi_view2.mv_art_gp_nm_zu_aktuell a
                                           GROUP BY 1,2
                                           UNION
                                           SELECT mandant_id,
                                                  art_id,
                                                  MAX(akt_gp_id) AS akt_gp_id
                                           FROM dbp_msi_view_ais_kmo.tbl_mv_art_gp_nm_zu_aktuell
                                           GROUP BY 1,2) b

SET a16_akt_lieferant_id = b.akt_gp_id

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung)
;

-- 2nd update with old "leitlager" logic for Germany

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT a.mandant_id,
                                                  a.art_id,
                                                  MAX(a.gp_id) AS akt_gp_id
                                           FROM dbp_msi_view2.mv_art_gp_zu_per a
                                           where a.aktuell_fg = 'a'
                                           GROUP BY 1,2) b
                                           
SET a16_akt_lieferant_id = b.akt_gp_id

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung) and
      dbp_etl_process.tupel_mat_etl.a16_akt_lieferant_id is null
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT a.mandant_id,
                                                  a.gp_id,
                                                  a.art_id,
                                                  a.herst_id,
                                                  b.gp_name
                                           FROM dbp_data.art_gp_zu_per a
                                           JOIN dbp_data.gp b
                                             ON a.mandant_id = b.mandant_id AND
                                                a.herst_id = b.gp_id
                                           WHERE a.mandant_id = 1 AND
                                                 CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
                                           GROUP BY 1,2,3,4,5) b

SET A419_hersteller_id = b.herst_id,
    A447_hersteller_bez_latein = b.gp_name

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT mandant_id,
                                                  art_id,
                                                  Min(dat_von) AS min_dat
                                           FROM dbp_data.art_list_wup_zu_per
                                           WHERE list_quelle_id <> '2'
                                           GROUP BY 1,2) b

SET A37_listung_erster_markt = b.min_dat

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT a.mandant_id,
                                                  a.gp_id,
                                                  a.gp_name
                                           FROM dbp_data.gp a
                                           GROUP BY 1,2,3) b

SET A446_lieferant_bez_latein = b.gp_name

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a16_akt_lieferant_id = b.gp_id
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT b.mandant_id,
                                                  b.art_matching_id,
                                                  Min(a.dat_erst_listung) AS dat_erst_listung_
                                           FROM dbp_data.art_vw_listung_von a
                                           JOIN (SELECT mandant_id,
                                                        art_matching_id,
                                                        art_id,
                                                        status
                                                 FROM dbp_etl.art_matching_nielsen_per
                                                 WHERE art_id <> -1
                                                 GROUP BY 1,2,3,4) b
                                             ON a.art_id = b.art_id AND
                                                a.mandant_id = b.mandant_id
                                           JOIN dbp_etl_process.tupel_mat_etl c
                                             ON b.art_matching_id = c.matching_id AND
                                                b.mandant_id = c.mandant_id
                                           WHERE a.mandant_id = 1
                                           GROUP BY 1,2
                                           UNION
                                           SELECT b.mandant_id,
                                                  b.art_matching_id,
                                                  Min(a.dat_erst_listung) AS dat_erst_listung_
                                           FROM dbp_data.art_vw_listung_von a
                                           JOIN (SELECT mandant_id,
                                                        art_matching_id,
                                                        art_id,
                                                        status
                                                 FROM dbp_etl.art_matching_nielsen_per_kmo
                                                 WHERE art_id <> -1
                                                 GROUP BY 1,2,3,4) b
                                             ON a.art_id = b.art_id AND
                                                a.mandant_id = b.mandant_id
                                           JOIN dbp_etl_process.tupel_mat_etl c
                                             ON b.art_matching_id = c.matching_id AND
                                                b.mandant_id = c.mandant_id
                                           WHERE a.mandant_id > 1
                                           GROUP BY 1,2) b

SET A406_letzte_listungsanderung_sst_ksst = b.dat_erst_listung_

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id
;

--de
create or replace volatile table _einkaufspreisstamm as
(
select * from dbp_msi_view2.mv_einkaufspreisstamm where (mandant_id,art_id) not in (select MANDANT_ID, ART_ID from dbp_msi_view2.mv_einkaufspreisstamm group by 1,2 having count(*) > 1) 
union
select * from dbp_msi_view2.mv_einkaufspreisstamm where (mandant_id,art_id) in (select MANDANT_ID, ART_ID from dbp_msi_view2.mv_einkaufspreisstamm group by 1,2 having count(*) > 1) and BEZUGSWEG_ID = 4
);

UPDATE dbp_etl_process.tupel_mat_etl FROM ( SELECT DISTINCT
                                                  MANDANT_ID,
                                                  ART_ID,
                                                  EK_KAL_BASIS,
                                                  LOGISTIKKOSTENZUSCHLAG,
                                                  (EK_KAL_BASIS - LOGISTIKKOSTENZUSCHLAG) as A30_KB_oLK_EK4NDZ_STAMM
                                           FROM _einkaufspreisstamm ) b

SET A30_KB_oLK_EK4NDZ_STAMM = b.A30_KB_oLK_EK4NDZ_STAMM

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung where mandant_id = 1 )
;

--kmo
UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT mandant_id,
                                                  art_id,
                                                  kjmo,
                                                  ek_kb_stamm AS ek_kal_basis
                                           FROM dbp_data.sal_kmo
                                           GROUP BY 1,2,3,4) b

SET A30_KB_oLK_EK4NDZ_STAMM = b.ek_kal_basis

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.A425_kjmo = b.kjmo
;


UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT mandant_id,
                                                  art_matching_id,
                                                  Max(umrech_faktor) AS umrech_faktor
                                           FROM dbp_etl.art_matching_nielsen_per
                                           WHERE art_id <> -1
                                           GROUP BY 1,2) b

SET umrech_faktor = b.umrech_faktor

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id
;


UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT mandant_id,
                                                  art_id,
                                                  MAX(koll_faktor_zl) as koll_faktor_zl,
                                                  MAX(kolli_faktor_dz) as kolli_faktor_dz
                                           FROM dbp_msi_view2.mv_kolli_faktor_dz_zl
                                           group by 1,2
                                           union
                                           SELECT mandant_id,
                                                  art_id,
                                                  MAX(ausg_menge_einh_inhalt) as koll_faktor_zl,
                                                  MAX(best_menge_einh_inhalt) as kolli_faktor_dz
                                           FROM dbp_msi_view_ais_kmo.mv_best_ausg_menge_einh
                                           group by 1,2) b

SET A402_kolli_la = b.koll_faktor_zl,
    A401_kolli_bst = b.kolli_faktor_dz

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT A500_kjwo_update,
                                                  mandant_id,
                                                  A7_wg_id,
                                                  Sum(A21_kassenumsatz_kl_absolut_netto) AS kassenumsatz_kl_absolut_netto_wg,
                                                  Sum(A27_totalabschriften_wert_netto_absolut) AS totalabschriften_wert_netto_absolut_wg,
                                                  Sum(A313_preisabschriften_preisanderungen_wert_netto_absolut) AS preisabschriften_preisanderungen_wert_netto_absolut_wg
                                           FROM dbp_etl_process.tupel_mat_etl
                                           GROUP BY 1,2,3) b

SET kassenumsatz_kl_absolut_netto_wg = b.kassenumsatz_kl_absolut_netto_wg,
    totalabschriften_wert_netto_absolut_wg = b.totalabschriften_wert_netto_absolut_wg,
    preisabschriften_preisanderungen_wert_netto_absolut_wg = b.preisabschriften_preisanderungen_wert_netto_absolut_wg

WHERE dbp_etl_process.tupel_mat_etl.A500_kjwo_update = b.A500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.A7_wg_id = b.A7_wg_id
;

UPDATE dbp_etl_process.tupel_mat_etl SET a14_art_status_de = ''
WHERE art_id IS NOT NULL AND
      a14_art_status_de IS NULL
;

UPDATE dbp_etl_process.tupel_mat_etl SET A51_listung_sst_pflege   = CASE WHEN TRIM(A51_listung_sst_pflege)   = '' THEN NULL ELSE A51_listung_sst_pflege   END,
                                         A52_listung_k_sst_pflege = CASE WHEN TRIM(A52_listung_k_sst_pflege) = '' THEN NULL ELSE A52_listung_k_sst_pflege END,
                                         A50_listungsaktion       = CASE WHEN TRIM(A50_listungsaktion)       = '' THEN NULL ELSE A50_listungsaktion       END
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT *
                                           FROM dbp_data.art
                                           WHERE TRIM(artikelrolle_id) <> '') b
                                          
SET A416_artikelrolle_id = b.artikelrolle_id

WHERE dbp_etl_process.tupel_mat_etl.art_id IS NOT NULL AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT DISTINCT 
                                                  a.mandant_id 
                                                 ,a.art_id
                                                 ,b.art_bez
                                                 ,a.loesch_id
                                                 ,a.zek_id
                                                 ,a.aldi_id
                                                 ,a.discount_id
                                                 ,a.lactose_fg
                                                 ,a.vegan_fg
                                                 ,a.gluten_fg
                                                 ,a.bio_fg
                                                 ,a.eigenmarke_id
                                                 ,a.tierwohl_kz
                                                 ,Coalesce(x.mwst, 0) AS mwst
                                                 ,a.posten_kz_sap
                                                 ,a.mhd_zeitraum
                                                 ,a.sustain_concat
                                           FROM dbp_data.art a
                                           JOIN dbp_data.art_spr_zu b
                                             ON a.art_id = b.art_id AND 
                                                a.mandant_id = b.mandant_id AND
                                                b.spr_id = 22
                                           LEFT JOIN dbp_data.mwst_per x
                                             ON a.mandant_id = x.mandant_id AND
                                                a.mwst_id = x.mwst_id AND
                                                x.dat_bis = '9999-12-31') b

SET  art_bez_deutsch = b.art_bez
    ,A389_zek_id = b.zek_id
    ,A391_disc_pe = b.aldi_id
    ,A392_disc_ohne_etikett = b.discount_id
    ,A400_lcf = CASE WHEN b.lactose_fg = 1 THEN 'X' ELSE '' end
    ,A393_vegan = CASE WHEN b.vegan_fg = 1 THEN 'X' ELSE '' end
    ,A394_gluten = CASE WHEN b.gluten_fg = 1 THEN 'X' ELSE '' end
    ,A395_bio = CASE WHEN b.bio_fg = 1 THEN 'X' ELSE '' end
    ,A396_eigenmarke = b.eigenmarke_id
    ,A397_tierwohl = b.tierwohl_kz
    ,A398_posten_food = b.posten_kz_sap
    ,A403_restlaufzeit_zl = b.mhd_zeitraum
    ,A339_umsatzsteuer = b.mwst
    ,sustain_concat = b.sustain_concat

WHERE dbp_etl_process.tupel_mat_etl.art_id IS NOT NULL AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id
;
/*
--A14_art_status_de

create or replace volatile table _loesch_de as
(
SELECT distinct 
b.mandant_id, b.art_id,a.loesch_id, b.art_matching_id, b.kjwo_update
FROM dbp_data.art a
join dbp_etl.art_matching_nielsen_per b
on
a.mandant_id = b.mandant_id and
a.art_id = b.art_id
where b.mandant_id = 1 and b.art_id <> - 1 and b.kjwo_update = (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per)
) ;

create or replace volatile table _loesch_kmo as
(
SELECT distinct 
b.mandant_id, b.art_id,a.loesch_id, b.art_matching_id, b.kjwo_update
FROM dbp_data.art a
join dbp_etl.art_matching_nielsen_per_kmo b
on
a.mandant_id = b.mandant_id and
a.art_id = b.art_id
where b.art_id <> - 1 and (b.mandant_id,b.kjwo_update) in (select mandant_id, max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo group by 1)
) ;

create or replace volatile table _loesch_de_2 as
(
select 
mandant_id,
art_id,
loesch_id,
art_matching_id,
kjwo_update,
count(art_id) over (partition by mandant_id,art_matching_id) as art_id_count,
count(loesch_id) over (partition by mandant_id,art_matching_id,loesch_id) as loesch_id_count
from _loesch_de
);

create or replace volatile table _loesch_kmo_2 as
(
select 
mandant_id,
art_id,
loesch_id,
art_matching_id,
kjwo_update,
count(art_id) over (partition by mandant_id,art_matching_id) as art_id_count,
count(loesch_id) over (partition by mandant_id,art_matching_id,loesch_id) as loesch_id_count
from _loesch_kmo
);

UPDATE dbp_etl_process.tupel_mat_etl FROM (select * from _loesch_de_2 where art_id_count=loesch_id_count and LOESCH_ID = 'L') b

SET  A14_art_status_de = b.loesch_id
WHERE dbp_etl_process.tupel_mat_etl.art_id IS NOT NULL AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.kjwo_update
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (select * from _loesch_kmo_2 where art_id_count=loesch_id_count and LOESCH_ID = 'L') b

SET  A14_art_status_de = b.loesch_id
WHERE dbp_etl_process.tupel_mat_etl.art_id IS NOT NULL AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.kjwo_update
;

---
*/

UPDATE dbp_etl_process.tupel_mat_etl FROM (select DISTINCT
                                           mandant_id,
                                           art_id,
                                           loesch_id
                                           from dbp_data.art where mandant_id = 1) b

SET  A14_art_status_de = b.loesch_id
WHERE dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per where mandant_id = 1)
;


UPDATE dbp_etl_process.tupel_mat_etl FROM (select DISTINCT
                                           mandant_id,
                                           art_id,
                                           loesch_id
                                           from dbp_data.art where mandant_id > 1) b

SET  A14_art_status_de = b.loesch_id
WHERE dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per where mandant_id > 1)
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT mandant_id,
                                                  art_matching_id,
                                                  MAX(kjwo_update) as kjwo_update,
                                                  Max(art_nielsen_id) AS art_nielsen_id
                                           FROM dbp_etl.art_matching_nielsen_per
                                           WHERE art_nielsen_id <> -1
                                           GROUP BY 1,2
                                           UNION
                                           SELECT mandant_id,
                                                  art_matching_id,
                                                  MAX(kjwo_update) as kjwo_update,
                                                  Max(art_nielsen_id) AS art_nielsen_id
                                           FROM dbp_etl.art_matching_nielsen_per_kmo
                                           WHERE art_nielsen_id <> -1
                                           GROUP BY 1,2) b

SET A450_art_nielsen_nr = b.art_nielsen_id

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.A500_kjwo_update = b.kjwo_update
;

UPDATE dbp_etl_process.tupel_mat_etl FROM (SELECT mandant_id,
                                                  kjwo_update,
                                                  owg_id,
                                                  wg_id,
                                                  wug_id,
                                                  SUM(CASE
                                                        WHEN anz_maerkte_listung_gesamt IS NOT NULL AND
                                                             anz_maerkte_listung_gesamt > 0
                                                        THEN 1
                                                        ELSE 0
                                                      END) AS anz_artikel
                                           FROM dbp_data.sortiment_leistung
                                           WHERE kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung)
                                           GROUP BY 1,2,3,4,5) b
                                    
SET a445_anz_tupel_listung_wgi = b.anz_artikel

WHERE dbp_etl_process.tupel_mat_etl.A5_owg_id = b.owg_id AND
      dbp_etl_process.tupel_mat_etl.A7_wg_id = b.wg_id AND
      dbp_etl_process.tupel_mat_etl.wug_id = b.wug_id AND
      dbp_etl_process.tupel_mat_etl.A500_kjwo_update = b.kjwo_update AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id
;

-- article groupings checking

create or replace volatile table _check_groups1 as (
select mandant_id,
       a500_kjwo_update,
       matching_id,
       value as art_id,
       cast(0 as integer) as art_gruppe_id
from dbp_etl_process.tupel_mat_etl, lateral strtok_split_to_table(dbp_etl_process.tupel_mat_etl.kl_art_id,',')
where a500_kjwo_update IN (SELECT Max(a500_kjwo_update) FROM dbp_etl_process.tupel_mat_etl where mandant_id = 1) and
      mandant_id = 1 and 
     (mandant_id,matching_id) in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_groups)
);

update _check_groups1 from (select *
                            from dbp_data.art
                            where mandant_id = 1 and
                                  dat_bis = '9999-12-31') b
                                  
set art_id = b.art_id

where _check_groups1.mandant_id = b.mandant_id and
      _check_groups1.art_id = b.kl_art_id
;

update _check_groups1 from (select mandant_id,
                                   art_matching_id,
                                   art_gruppe_id
                            from dbp_etl_process.art_art_nielsen_groups
                            where mandant_id = 1
                            group by 1,2,3) b
                                  
set art_gruppe_id = b.art_gruppe_id

where _check_groups1.mandant_id = b.mandant_id and
      _check_groups1.matching_id = b.art_matching_id
;

create or replace volatile table _groups_diff as (
select x.art_matching_id,
       a.art_gruppe_id,
       x.anz as anz_am,
       b.anz as anz_ag
from (select art_matching_id,
             art_gruppe_id
      from dbp_etl_process.art_art_nielsen_groups
      group by 1,2) a
join (select matching_id as art_matching_id,
             count(distinct art_id) as anz
      from _check_groups1
      group by 1) x
  on a.art_matching_id = x.art_matching_id
join (select b.art_gruppe_id,
             count(*) as anz
      from dbp_data.art_gruppe a
      join dbp_data.art_gruppe_art_zu b
        on a.art_gruppe_id = b.art_gruppe_id
      where a.art_gruppe_kategorie = 'sortimentstool' and
            b.mandant_id = 1 
      group by 1) b
on a.art_gruppe_id = b.art_gruppe_id and
   x.anz <> b.anz
);

update dbp_etl_process.tupel_mat_etl from (select a.art_matching_id,
                                                       substr(REPLACE(TRIM((LISTAGG(lpad(cast(cast(LPAD(CAST(floor(b.art_id/100) AS VARCHAR(600)),8,'0') as int) as varchar(8)),8,'0'), ',') within group (ORDER BY floor(b.art_id/100)) ), ','),' ', ''),1,300) AS kl_art_id
                                                from _groups_diff a
                                                join dbp_etl_process.art_art_nielsen_groups b
                                                  on a.art_matching_id = b.art_matching_id
                                                group by 1) b
                                                
set kl_art_id = b.kl_art_id

where dbp_etl_process.tupel_mat_etl.mandant_id = 1 and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update in (SELECT Max(a500_kjwo_update) FROM dbp_etl_process.tupel_mat_etl where mandant_id = 1) and
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id
;

create or replace volatile table _update_kl_art_id_1
as
(
select
mandant_id,
art_matching_id,
LPAD((CAST(floor(art_id/100) AS VARCHAR(600))),8,'0') as ART_ID
from dbp_etl.art_matching_nielsen_per where art_id <> -1 and kjwo_update in (select MAX(kjwo_update) from dbp_etl.art_matching_nielsen_per)
GROUP BY 1,2,3
);

create or replace volatile table _update_kl_art_id_2
as
(
select
mandant_id,
art_matching_id,
listagg(DISTINCT ART_ID,',') WITHIN GROUP (ORDER BY ART_ID) AS kl_art_id
from _update_kl_art_id_1
GROUP BY 1,2
);

UPDATE dbp_etl_process.tupel_mat_etl FROM (select * from _update_kl_art_id_2) b
SET
kl_art_id = b.kl_art_id
WHERE
dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id and
dbp_etl_process.tupel_mat_etl.a500_kjwo_update = (select MAX(kjwo_update) from dbp_etl.art_matching_nielsen_per);


create or replace volatile table _dup_free as (
select mandant_id
,a500_kjwo_update
,matching_id
,a425_kjmo
,max(wrg_id                                                       )      wrg_id                                                        
,max(a5_owg_id                                                    )      a5_owg_id                                                     
,max(a7_wg_id                                                     )      a7_wg_id                                                      
,max(wug_id                                                       )      wug_id                                                        
,max(art_id                                                       )      art_id                                                        
,max(kl_art_id                                                    )      kl_art_id                                                     
,max(a450_art_nielsen_nr                                          )      a450_art_nielsen_nr                                           
,max(art_bez_deutsch                                              )      art_bez_deutsch                                               
,max(a14_art_status_de                                            )      a14_art_status_de                                             
,max(nielsen_art_bez                                              )      nielsen_art_bez                                               
,max(nielsen_gtin                                                 )      nielsen_gtin                                                  
,max(a58_rang_umsatz_owg                                          )      a58_rang_umsatz_owg                                           
,max(a2_rang_umsatz_wg                                            )      a2_rang_umsatz_wg                                             
,max(a59_rang_absatz_wg                                           )      a59_rang_absatz_wg                                            
,max(a16_akt_lieferant_id                                         )      a16_akt_lieferant_id                                          
,max(a419_hersteller_id                                           )      a419_hersteller_id                                            
,max(a446_lieferant_bez_latein                                    )      a446_lieferant_bez_latein                                     
,max(a447_hersteller_bez_latein                                   )      a447_hersteller_bez_latein                                    
,max(lieferant_nielsen                                            )      lieferant_nielsen                                             
,max(a389_zek_id                                                  )      a389_zek_id                                                   
,max(a391_disc_pe                                                 )      a391_disc_pe                                                  
,max(a392_disc_ohne_etikett                                       )      a392_disc_ohne_etikett                                        
,max(a400_lcf                                                     )      a400_lcf                                                      
,max(a393_vegan                                                   )      a393_vegan                                                    
,max(a394_gluten                                                  )      a394_gluten                                                   
,max(a395_bio                                                     )      a395_bio                                                      
,max(a396_eigenmarke                                              )      a396_eigenmarke                                               
,max(a397_tierwohl                                                )      a397_tierwohl                                                 
,max(a398_posten_food                                             )      a398_posten_food                                              
,max(a399_posten_nonfood                                          )      a399_posten_nonfood                                           
,max(a339_umsatzsteuer                                            )      a339_umsatzsteuer                                             
,max(a36_gewichtete_distribution                                  )      a36_gewichtete_distribution                                   
,max(a60_muki_vk_kz                                               )      a60_muki_vk_kz                                                
,max(a61_muki_vk_kl_art_id_verkettung                             )      a61_muki_vk_kl_art_id_verkettung                              
,max(anzahl_markt_wochen_kombis_abverkauf_af                      )      anzahl_markt_wochen_kombis_abverkauf_af                       
,max(anzahl_markt_wochen_kombis_abverkauf_sa                      )      anzahl_markt_wochen_kombis_abverkauf_sa                       
,max(anzahl_markt_wochen_kombis_abverkauf_af_vj                   )      anzahl_markt_wochen_kombis_abverkauf_af_vj                    
,max(anzahl_markt_wochen_kombis_abverkauf_sa_vj                   )      anzahl_markt_wochen_kombis_abverkauf_sa_vj                    
,max(a273_kassenumsatz_kl_absolut_brutto                          )      a273_kassenumsatz_kl_absolut_brutto                           
,max(kassenumsatz_af_kl_absolut_brutto                            )      kassenumsatz_af_kl_absolut_brutto                             
,max(kassenumsatz_sa_kl_absolut_brutto                            )      kassenumsatz_sa_kl_absolut_brutto                             
,max(kassenumsatz_kl_absolut_brutto_vj                            )      kassenumsatz_kl_absolut_brutto_vj                             
,max(kassenumsatz_af_kl_absolut_brutto_vj                         )      kassenumsatz_af_kl_absolut_brutto_vj                          
,max(kassenumsatz_sa_kl_absolut_brutto_vj                         )      kassenumsatz_sa_kl_absolut_brutto_vj                          
,max(a21_kassenumsatz_kl_absolut_netto                            )      a21_kassenumsatz_kl_absolut_netto                             
,max(kassenumsatz_af_kl_absolut_netto                             )      kassenumsatz_af_kl_absolut_netto                              
,max(kassenumsatz_sa_kl_absolut_netto                             )      kassenumsatz_sa_kl_absolut_netto                              
,max(kassenumsatz_kl_absolut_netto_vj                             )      kassenumsatz_kl_absolut_netto_vj                              
,max(kassenumsatz_af_kl_absolut_netto_vj                          )      kassenumsatz_af_kl_absolut_netto_vj                           
,max(kassenumsatz_sa_kl_absolut_netto_vj                          )      kassenumsatz_sa_kl_absolut_netto_vj                           
,max(a17_absatz_kl                                                )      a17_absatz_kl                                                 
,max(absatz_af_kl                                                 )      absatz_af_kl                                                  
,max(absatz_sa_kl                                                 )      absatz_sa_kl                                                  
,max(absatz_kl_vj                                                 )      absatz_kl_vj                                                  
,max(absatz_af_kl_vj                                              )      absatz_af_kl_vj                                               
,max(absatz_sa_kl_vj                                              )      absatz_sa_kl_vj                                               
,max(a76_absatz_sst1                                              )      a76_absatz_sst1                                               
,max(a78_absatz_sst2                                              )      a78_absatz_sst2                                               
,max(a80_absatz_sst3                                              )      a80_absatz_sst3                                               
,max(a82_absatz_sst4                                              )      a82_absatz_sst4                                               
,max(a84_absatz_sst5                                              )      a84_absatz_sst5                                               
,max(a86_absatz_sst6                                              )      a86_absatz_sst6                                               
,max(a88_absatz_sst7                                              )      a88_absatz_sst7                                               
,max(a62_absatz_ksst1                                             )      a62_absatz_ksst1                                              
,max(a64_absatz_ksst2                                             )      a64_absatz_ksst2                                              
,max(a66_absatz_ksst3                                             )      a66_absatz_ksst3                                              
,max(a68_absatz_ksst4                                             )      a68_absatz_ksst4                                              
,max(a70_absatz_ksst5                                             )      a70_absatz_ksst5                                              
,max(a72_absatz_ksst6                                             )      a72_absatz_ksst6                                              
,max(a74_absatz_ksst7                                             )      a74_absatz_ksst7                                              
,max(a90_absatz_ost_basis                                         )      a90_absatz_ost_basis                                          
,max(a92_absatz_ost_gross                                         )      a92_absatz_ost_gross                                          
,max(a94_absatz_sued_ost                                          )      a94_absatz_sued_ost                                           
,max(a96_absatz_sued_west                                         )      a96_absatz_sued_west                                          
,max(a98_absatz_west                                              )      a98_absatz_west                                               
,max(a100_absatz_nord                                             )      a100_absatz_nord                                              
,max(markt_wochen_sst1                                            )      markt_wochen_sst1                                             
,max(markt_wochen_sst2                                            )      markt_wochen_sst2                                             
,max(markt_wochen_sst3                                            )      markt_wochen_sst3                                             
,max(markt_wochen_sst4                                            )      markt_wochen_sst4                                             
,max(markt_wochen_sst5                                            )      markt_wochen_sst5                                             
,max(markt_wochen_sst6                                            )      markt_wochen_sst6                                             
,max(markt_wochen_sst7                                            )      markt_wochen_sst7                                             
,max(markt_wochen_ksst1                                           )      markt_wochen_ksst1                                            
,max(markt_wochen_ksst2                                           )      markt_wochen_ksst2                                            
,max(markt_wochen_ksst3                                           )      markt_wochen_ksst3                                            
,max(markt_wochen_ksst4                                           )      markt_wochen_ksst4                                            
,max(markt_wochen_ksst5                                           )      markt_wochen_ksst5                                            
,max(markt_wochen_ksst6                                           )      markt_wochen_ksst6                                            
,max(markt_wochen_ksst7                                           )      markt_wochen_ksst7                                            
,max(markt_wochen_ost_basis                                       )      markt_wochen_ost_basis                                        
,max(markt_wochen_ost_gross                                       )      markt_wochen_ost_gross                                        
,max(markt_wochen_sued_ost                                        )      markt_wochen_sued_ost                                         
,max(markt_wochen_sued_west                                       )      markt_wochen_sued_west                                        
,max(markt_wochen_west                                            )      markt_wochen_west                                             
,max(markt_wochen_nord                                            )      markt_wochen_nord                                             
,max(anzahl_markt_wochen_kombis_abverkauf_mit_listung             )      anzahl_markt_wochen_kombis_abverkauf_mit_listung              
,max(anzahl_markt_wochen_kombis_listung                           )      anzahl_markt_wochen_kombis_listung                            
,max(a31_vk_brutto_kl_pk_1                                        )      a31_vk_brutto_kl_pk_1                                         
,max(a333_vk_brutto_kl_pk_2                                       )      a333_vk_brutto_kl_pk_2                                        
,max(a54_vk_brutto_kl_pk_3                                        )      a54_vk_brutto_kl_pk_3                                         
,max(a334_vk_brutto_kl_pk_4                                       )      a334_vk_brutto_kl_pk_4                                        
,max(a432_vk_brutto_kl_pk_5                                       )      a432_vk_brutto_kl_pk_5                                        
,max(a433_vk_brutto_kl_pk_6                                       )      a433_vk_brutto_kl_pk_6                                        
,max(a434_vk_brutto_kl_pk_7                                       )      a434_vk_brutto_kl_pk_7                                        
,max(a435_vk_brutto_kl_pk_8                                       )      a435_vk_brutto_kl_pk_8                                        
,max(a436_vk_brutto_kl_pk_9                                       )      a436_vk_brutto_kl_pk_9                                        
,max(a437_vk_brutto_kl_pk_10                                      )      a437_vk_brutto_kl_pk_10                                       
,max(A30_KB_oLK_EK4NDZ_STAMM                                          )      A30_KB_oLK_EK4NDZ_STAMM                                           
,max(a23_rohertrag_ekmep_olk_4n                                   )      a23_rohertrag_ekmep_olk_4n                                    
,max(a51_listung_sst_pflege                                       )      a51_listung_sst_pflege                                        
,max(a52_listung_k_sst_pflege                                     )      a52_listung_k_sst_pflege                                      
,max(a426_ost_basis_pflege                                        )      a426_ost_basis_pflege                                         
,max(a427_ost_gross_pflege                                        )      a427_ost_gross_pflege                                         
,max(a428_sued_ost_pflege                                         )      a428_sued_ost_pflege                                          
,max(a429_sued_west_pflege                                        )      a429_sued_west_pflege                                         
,max(a430_west_pflege                                             )      a430_west_pflege                                              
,max(a431_nord_pflege                                             )      a431_nord_pflege                                              
,max(a50_listungsaktion                                           )      a50_listungsaktion                                            
,max(a411_stk_rohertrag_pflege                                    )      a411_stk_rohertrag_pflege                                     
,max(a415_kannibalisierungsfaktor                                 )      a415_kannibalisierungsfaktor                                  
,max(a412_umsatz_brutto_hochrechnung                              )      a412_umsatz_brutto_hochrechnung                               
,max(a413_absatz_hochrechnung                                     )      a413_absatz_hochrechnung                                      
,max(a414_rohertrag_hochrechnung                                  )      a414_rohertrag_hochrechnung                                   
,max(a36_gewichtete_distribution_nielsen                          )      a36_gewichtete_distribution_nielsen                           
,max(a32_umsatz_anteil_wgi_nielsen                                )      a32_umsatz_anteil_wgi_nielsen                                 
,max(a33_umsatz_anteil_wgi_kumuliert_nielsen                      )      a33_umsatz_anteil_wgi_kumuliert_nielsen                       
,max(a34_vk_brutto_durchschnitt_nielsen                           )      a34_vk_brutto_durchschnitt_nielsen                            
,max(a35_umsatz_nielsen                                           )      a35_umsatz_nielsen                                            
,max(anz_wochen_de_anz_monate_kmo_nielsen                         )      anz_wochen_de_anz_monate_kmo_nielsen                          
,max(absatz_nielsen                                               )      absatz_nielsen                                                
,max(a376_kl_marktanteil_wg_nielsen                               )      a376_kl_marktanteil_wg_nielsen                                
,max(a380_marktanteilbewertung_nielsen                            )      a380_marktanteilbewertung_nielsen                             
,max(a377_durchschnitt_anz_maerkte_nielsen                        )      a377_durchschnitt_anz_maerkte_nielsen                         
,max(a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen      )      a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen       
,max(a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen)     a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen
,max(a384_durchschn_preis_einheit_gl_normiert_nielsen             )      a384_durchschn_preis_einheit_gl_normiert_nielsen              
,max(a385_numerische_distribution_nielsen                         )      a385_numerische_distribution_nielsen                          
,max(a386_inhaltsmengen_nielsen                                   )      a386_inhaltsmengen_nielsen                                    
,max(a387_duft_geschmack_nielsen                                  )      a387_duft_geschmack_nielsen                                   
,max(a388_einheit_nielsen                                         )      a388_einheit_nielsen                                          
,max(eigenmarke_fg_nielsen                                        )      eigenmarke_fg_nielsen                                         
,max(a39_listung_sst_mvke                                         )      a39_listung_sst_mvke                                          
,max(a38_listung_k_sst_mvke                                       )      a38_listung_k_sst_mvke                                        
,max(a40_ost_basis                                                )      a40_ost_basis                                                 
,max(a41_ost_gross                                                )      a41_ost_gross                                                 
,max(a42_sued_ost                                                 )      a42_sued_ost                                                  
,max(a43_sued_west                                                )      a43_sued_west                                                 
,max(a44_west                                                     )      a44_west                                                      
,max(a45_nord                                                     )      a45_nord                                                      
,max(a37_listung_erster_markt                                     )      a37_listung_erster_markt                                      
,max(a59_anz_maerkte_sst                                          )      a59_anz_maerkte_sst                                           
,max(a449_anz_maerkte_k_sst                                       )      a449_anz_maerkte_k_sst                                        
,max(a46_max_anz_maerkte_sst                                      )      a46_max_anz_maerkte_sst                                       
,max(a47_max_anz_maerkte_k_sst                                    )      a47_max_anz_maerkte_k_sst                                     
,max(a53_anz_maerkte_listung_gesamt                               )      a53_anz_maerkte_listung_gesamt                                
,max(a57_anz_maerkte_listung_einzel                               )      a57_anz_maerkte_listung_einzel                                
,max(anz_maerkte_baustein_sonstige                                )      anz_maerkte_baustein_sonstige                                 
,max(anz_bons_af                                                  )      anz_bons_af                                                   
,max(anz_bons_sa                                                  )      anz_bons_sa                                                   
,max(anz_bons_gesamt                                              )      anz_bons_gesamt                                               
,max(rohertrag_ekmep_olk_4n_vj                                    )      rohertrag_ekmep_olk_4n_vj                                     
,max(rohertrag_ekmep_olk_4n_af                                    )      rohertrag_ekmep_olk_4n_af                                     
,max(rohertrag_ekmep_olk_4n_sa                                    )      rohertrag_ekmep_olk_4n_sa                                     
,max(rohertrag_ekmep_olk_4n_af_vj                                 )      rohertrag_ekmep_olk_4n_af_vj                                  
,max(rohertrag_ekmep_olk_4n_sa_vj                                 )      rohertrag_ekmep_olk_4n_sa_vj                                  
,max(a381_preislagenverteilung                                    )      a381_preislagenverteilung                                     
,max(a27_totalabschriften_wert_netto_absolut                      )      a27_totalabschriften_wert_netto_absolut                       
,max(a313_preisabschriften_preisanderungen_wert_netto_absolut     )      a313_preisabschriften_preisanderungen_wert_netto_absolut      
,max(totalabschriften_wert_netto_absolut_vj                       )      totalabschriften_wert_netto_absolut_vj                        
,max(preisabschriften_preisanderungen_wert_netto_absolut_vj       )      preisabschriften_preisanderungen_wert_netto_absolut_vj        
,max(a402_kolli_la                                                )      a402_kolli_la                                                 
,max(a401_kolli_bst                                               )      a401_kolli_bst                                                
,max(a403_restlaufzeit_zl                                         )      a403_restlaufzeit_zl                                          
,max(a404_restlaufzeit_dz                                         )      a404_restlaufzeit_dz                                          
,max(a405_basismengeneinheit                                      )      a405_basismengeneinheit                                       
,max(a406_letzte_listungsanderung_sst_ksst                        )      a406_letzte_listungsanderung_sst_ksst                         
,max(a407_verhandler                                              )      a407_verhandler                                               
,max(a408_display_komponente_kz                                   )      a408_display_komponente_kz                                    
,max(a409_kl_art_id_display                                       )      a409_kl_art_id_display                                        
,max(a416_artikelrolle_id                                         )      a416_artikelrolle_id                                          
,max(kassenumsatz_kl_absolut_netto_wg                             )      kassenumsatz_kl_absolut_netto_wg                              
,max(anz_bons_tupel                                               )      anz_bons_tupel                                                
,max(restbon_summe                                                )      restbon_summe                                                 
,max(totalabschriften_wert_netto_absolut_wg                       )      totalabschriften_wert_netto_absolut_wg                        
,max(preisabschriften_preisanderungen_wert_netto_absolut_wg       )      preisabschriften_preisanderungen_wert_netto_absolut_wg        
,max(ANZ_BONS_AF_MARKT_TAG                                        )      ANZ_BONS_AF_MARKT_TAG                                               
,max(ANZ_BONS_SA_MARKT_TAG                                        )      ANZ_BONS_SA_MARKT_TAG                                               
,max(cpq_tupel                                                    )      cpq_tupel                                                     
,max(cp_bons_af                                                   )      cp_bons_af                                                    
,max(cp_bons_sa                                                   )      cp_bons_sa                                                    
,max(umrech_faktor                                                )      umrech_faktor                                                 
,max(lagerprozent                                                 )      lagerprozent                                                  
,max(absatz_af_kl_listungswochen                                  )      absatz_af_kl_listungswochen                                   
,max(absatz_af_kl_vj_listungswochen                               )      absatz_af_kl_vj_listungswochen                                
,max(absatz_sa_kl_listungswochen                                  )      absatz_sa_kl_listungswochen                                   
,max(absatz_sa_kl_vj_listungswochen                               )      absatz_sa_kl_vj_listungswochen                                
,max(kassenumsatz_af_kl_absolut_netto_listungswochen              )      kassenumsatz_af_kl_absolut_netto_listungswochen               
,max(kassenumsatz_af_kl_absolut_netto_vj_listungswochen           )      kassenumsatz_af_kl_absolut_netto_vj_listungswochen            
,max(kassenumsatz_sa_kl_absolut_netto_listungswochen              )      kassenumsatz_sa_kl_absolut_netto_listungswochen               
,max(kassenumsatz_sa_kl_absolut_netto_vj_listungswochen           )      kassenumsatz_sa_kl_absolut_netto_vj_listungswochen            
,max(rohertrag_ekmep_olk_4n_af_listungswochen                     )      rohertrag_ekmep_olk_4n_af_listungswochen                      
,max(rohertrag_ekmep_olk_4n_af_vj_listungswochen                  )      rohertrag_ekmep_olk_4n_af_vj_listungswochen                   
,max(rohertrag_ekmep_olk_4n_sa_listungswochen                     )      rohertrag_ekmep_olk_4n_sa_listungswochen                      
,max(rohertrag_ekmep_olk_4n_sa_vj_listungswochen                  )      rohertrag_ekmep_olk_4n_sa_vj_listungswochen                   
,max(a445_anz_tupel_listung_wgi                                   )      a445_anz_tupel_listung_wgi                                   
,max(td_insert) as td_insert
,max(td_update) as td_update
,max(sustain_concat                                               )      sustain_concat                                                
,max(check_fg                                                     )      check_fg 
,MAX(tupel_typ                                                    )      tupel_typ      
,MAX(a471_marke_nielsen_bez                                       )      a471_marke_nielsen_bez                                                     
,MAX(a515_bio_organic_nielsen_kz                                  )      a515_bio_organic_nielsen_kz                                                     
,MAX(a516_veggy_split_nielsen_kz                                  )      a516_veggy_split_nielsen_kz                                                     
,MAX(a517_laktosefrei_nielsen_kz                                  )      a517_laktosefrei_nielsen_kz                                                     
,MAX(a518_glutenfrei_nielsen_kz                                   )      a518_glutenfrei_nielsen_kz                                                     
,MAX(A510_MUKI_EK_KZ                                              )      A510_MUKI_EK_KZ                                                     
,MAX(A511_MUKI_EK_KL_ART_ID_VERKETTUNG                            )      A511_MUKI_EK_KL_ART_ID_VERKETTUNG                                                     
,MAX(A512_MUKI_WB_KZ                                              )      A512_MUKI_WB_KZ                                                     
,MAX(A513_MUKI_WB_KL_ART_ID_VERKETTUNG                            )      A513_MUKI_WB_KL_ART_ID_VERKETTUNG                                                     
,MAX(A519_UMSATZ_ANTEIL_WG_NIELSEN                                )      A519_UMSATZ_ANTEIL_WG_NIELSEN                                                     
,MAX(A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN                      )      A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN   
,MAX(a521_Inhalt_menge                                            )      a521_Inhalt_menge                                                                                      
from dbp_etl_process.tupel_mat_etl
where a500_kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung)
group by 1,2,3,4
);

delete from dbp_etl_process.tupel_mat_etl
where a500_kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung)
;

insert into dbp_etl_process.tupel_mat_etl (mandant_id
                                          ,a500_kjwo_update
                                          ,matching_id
                                          ,a425_kjmo
                                          ,wrg_id
                                          ,a5_owg_id
                                          ,a7_wg_id
                                          ,wug_id
                                          ,art_id
                                          ,kl_art_id
                                          ,a450_art_nielsen_nr
                                          ,art_bez_deutsch
                                          ,a14_art_status_de
                                          ,nielsen_art_bez
                                          ,nielsen_gtin
                                          ,a58_rang_umsatz_owg
                                          ,a2_rang_umsatz_wg
                                          ,a59_rang_absatz_wg
                                          ,a16_akt_lieferant_id
                                          ,a419_hersteller_id
                                          ,a446_lieferant_bez_latein
                                          ,a447_hersteller_bez_latein
                                          ,lieferant_nielsen
                                          ,a389_zek_id
                                          ,a391_disc_pe
                                          ,a392_disc_ohne_etikett
                                          ,a400_lcf
                                          ,a393_vegan
                                          ,a394_gluten
                                          ,a395_bio
                                          ,a396_eigenmarke
                                          ,a397_tierwohl
                                          ,a398_posten_food
                                          ,a399_posten_nonfood
                                          ,a339_umsatzsteuer
                                          ,a36_gewichtete_distribution
                                          ,a60_muki_vk_kz
                                          ,a61_muki_vk_kl_art_id_verkettung
                                          ,anzahl_markt_wochen_kombis_abverkauf_af
                                          ,anzahl_markt_wochen_kombis_abverkauf_sa
                                          ,anzahl_markt_wochen_kombis_abverkauf_af_vj
                                          ,anzahl_markt_wochen_kombis_abverkauf_sa_vj
                                          ,a273_kassenumsatz_kl_absolut_brutto
                                          ,kassenumsatz_af_kl_absolut_brutto
                                          ,kassenumsatz_sa_kl_absolut_brutto
                                          ,kassenumsatz_kl_absolut_brutto_vj
                                          ,kassenumsatz_af_kl_absolut_brutto_vj
                                          ,kassenumsatz_sa_kl_absolut_brutto_vj
                                          ,a21_kassenumsatz_kl_absolut_netto
                                          ,kassenumsatz_af_kl_absolut_netto
                                          ,kassenumsatz_sa_kl_absolut_netto
                                          ,kassenumsatz_kl_absolut_netto_vj
                                          ,kassenumsatz_af_kl_absolut_netto_vj
                                          ,kassenumsatz_sa_kl_absolut_netto_vj
                                          ,a17_absatz_kl
                                          ,absatz_af_kl
                                          ,absatz_sa_kl
                                          ,absatz_kl_vj
                                          ,absatz_af_kl_vj
                                          ,absatz_sa_kl_vj
                                          ,a76_absatz_sst1
                                          ,a78_absatz_sst2
                                          ,a80_absatz_sst3
                                          ,a82_absatz_sst4
                                          ,a84_absatz_sst5
                                          ,a86_absatz_sst6
                                          ,a88_absatz_sst7
                                          ,a62_absatz_ksst1
                                          ,a64_absatz_ksst2
                                          ,a66_absatz_ksst3
                                          ,a68_absatz_ksst4
                                          ,a70_absatz_ksst5
                                          ,a72_absatz_ksst6
                                          ,a74_absatz_ksst7
                                          ,a90_absatz_ost_basis
                                          ,a92_absatz_ost_gross
                                          ,a94_absatz_sued_ost
                                          ,a96_absatz_sued_west
                                          ,a98_absatz_west
                                          ,a100_absatz_nord
                                          ,markt_wochen_sst1
                                          ,markt_wochen_sst2
                                          ,markt_wochen_sst3
                                          ,markt_wochen_sst4
                                          ,markt_wochen_sst5
                                          ,markt_wochen_sst6
                                          ,markt_wochen_sst7
                                          ,markt_wochen_ksst1
                                          ,markt_wochen_ksst2
                                          ,markt_wochen_ksst3
                                          ,markt_wochen_ksst4
                                          ,markt_wochen_ksst5
                                          ,markt_wochen_ksst6
                                          ,markt_wochen_ksst7
                                          ,markt_wochen_ost_basis
                                          ,markt_wochen_ost_gross
                                          ,markt_wochen_sued_ost
                                          ,markt_wochen_sued_west
                                          ,markt_wochen_west
                                          ,markt_wochen_nord
                                          ,anzahl_markt_wochen_kombis_abverkauf_mit_listung
                                          ,anzahl_markt_wochen_kombis_listung
                                          ,a31_vk_brutto_kl_pk_1
                                          ,a333_vk_brutto_kl_pk_2
                                          ,a54_vk_brutto_kl_pk_3
                                          ,a334_vk_brutto_kl_pk_4
                                          ,a432_vk_brutto_kl_pk_5
                                          ,a433_vk_brutto_kl_pk_6
                                          ,a434_vk_brutto_kl_pk_7
                                          ,a435_vk_brutto_kl_pk_8
                                          ,a436_vk_brutto_kl_pk_9
                                          ,a437_vk_brutto_kl_pk_10
                                          ,A30_KB_oLK_EK4NDZ_STAMM
                                          ,a23_rohertrag_ekmep_olk_4n
                                          ,a51_listung_sst_pflege
                                          ,a52_listung_k_sst_pflege
                                          ,a426_ost_basis_pflege
                                          ,a427_ost_gross_pflege
                                          ,a428_sued_ost_pflege
                                          ,a429_sued_west_pflege
                                          ,a430_west_pflege
                                          ,a431_nord_pflege
                                          ,a50_listungsaktion
                                          ,a411_stk_rohertrag_pflege
                                          ,a415_kannibalisierungsfaktor
                                          ,a412_umsatz_brutto_hochrechnung
                                          ,a413_absatz_hochrechnung
                                          ,a414_rohertrag_hochrechnung
                                          ,a36_gewichtete_distribution_nielsen
                                          ,a32_umsatz_anteil_wgi_nielsen
                                          ,a33_umsatz_anteil_wgi_kumuliert_nielsen
                                          ,a34_vk_brutto_durchschnitt_nielsen
                                          ,a35_umsatz_nielsen
                                          ,anz_wochen_de_anz_monate_kmo_nielsen
                                          ,absatz_nielsen
                                          ,a376_kl_marktanteil_wg_nielsen
                                          ,a380_marktanteilbewertung_nielsen
                                          ,a377_durchschnitt_anz_maerkte_nielsen
                                          ,a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen
                                          ,a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen
                                          ,a384_durchschn_preis_einheit_gl_normiert_nielsen
                                          ,a385_numerische_distribution_nielsen
                                          ,a386_inhaltsmengen_nielsen
                                          ,a387_duft_geschmack_nielsen
                                          ,a388_einheit_nielsen
                                          ,eigenmarke_fg_nielsen
                                          ,a39_listung_sst_mvke
                                          ,a38_listung_k_sst_mvke
                                          ,a40_ost_basis
                                          ,a41_ost_gross
                                          ,a42_sued_ost
                                          ,a43_sued_west
                                          ,a44_west
                                          ,a45_nord
                                          ,a37_listung_erster_markt
                                          ,a59_anz_maerkte_sst
                                          ,a449_anz_maerkte_k_sst
                                          ,a46_max_anz_maerkte_sst
                                          ,a47_max_anz_maerkte_k_sst
                                          ,a53_anz_maerkte_listung_gesamt
                                          ,a57_anz_maerkte_listung_einzel
                                          ,anz_maerkte_baustein_sonstige
                                          ,anz_bons_af
                                          ,anz_bons_sa
                                          ,anz_bons_gesamt
                                          ,rohertrag_ekmep_olk_4n_vj
                                          ,rohertrag_ekmep_olk_4n_af
                                          ,rohertrag_ekmep_olk_4n_sa
                                          ,rohertrag_ekmep_olk_4n_af_vj
                                          ,rohertrag_ekmep_olk_4n_sa_vj
                                          ,a381_preislagenverteilung
                                          ,a27_totalabschriften_wert_netto_absolut
                                          ,a313_preisabschriften_preisanderungen_wert_netto_absolut
                                          ,totalabschriften_wert_netto_absolut_vj
                                          ,preisabschriften_preisanderungen_wert_netto_absolut_vj
                                          ,a402_kolli_la
                                          ,a401_kolli_bst
                                          ,a403_restlaufzeit_zl
                                          ,a404_restlaufzeit_dz
                                          ,a405_basismengeneinheit
                                          ,a406_letzte_listungsanderung_sst_ksst
                                          ,a407_verhandler
                                          ,a408_display_komponente_kz
                                          ,a409_kl_art_id_display
                                          ,a416_artikelrolle_id
                                          ,kassenumsatz_kl_absolut_netto_wg
                                          ,anz_bons_tupel
                                          ,restbon_summe
                                          ,totalabschriften_wert_netto_absolut_wg
                                          ,preisabschriften_preisanderungen_wert_netto_absolut_wg
                                          ,ANZ_BONS_AF_MARKT_TAG
                                          ,ANZ_BONS_SA_MARKT_TAG
                                          ,cpq_tupel
                                          ,cp_bons_af
                                          ,cp_bons_sa
                                          ,umrech_faktor
                                          ,lagerprozent
                                          ,absatz_af_kl_listungswochen
                                          ,absatz_af_kl_vj_listungswochen
                                          ,absatz_sa_kl_listungswochen
                                          ,absatz_sa_kl_vj_listungswochen
                                          ,kassenumsatz_af_kl_absolut_netto_listungswochen
                                          ,kassenumsatz_af_kl_absolut_netto_vj_listungswochen
                                          ,kassenumsatz_sa_kl_absolut_netto_listungswochen
                                          ,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
                                          ,rohertrag_ekmep_olk_4n_af_listungswochen
                                          ,rohertrag_ekmep_olk_4n_af_vj_listungswochen
                                          ,rohertrag_ekmep_olk_4n_sa_listungswochen
                                          ,rohertrag_ekmep_olk_4n_sa_vj_listungswochen
                                          ,a445_anz_tupel_listung_wgi
                                          ,td_insert
                                          ,td_update
                                          ,sustain_concat
                                          ,check_fg
                                          ,tupel_typ
                                          ,a471_marke_nielsen_bez
                                          ,a515_bio_organic_nielsen_kz            
                                          ,a516_veggy_split_nielsen_kz            
                                          ,a517_laktosefrei_nielsen_kz            
                                          ,a518_glutenfrei_nielsen_kz             
                                          ,A510_MUKI_EK_KZ                        
                                          ,A511_MUKI_EK_KL_ART_ID_VERKETTUNG      
                                          ,A512_MUKI_WB_KZ                        
                                          ,A513_MUKI_WB_KL_ART_ID_VERKETTUNG      
                                          ,A519_UMSATZ_ANTEIL_WG_NIELSEN          
                                          ,A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN
                                          ,a521_Inhalt_menge)
select mandant_id
      ,a500_kjwo_update
      ,matching_id
      ,a425_kjmo
      ,wrg_id
      ,a5_owg_id
      ,a7_wg_id
      ,wug_id
      ,art_id
      ,kl_art_id
      ,a450_art_nielsen_nr
      ,art_bez_deutsch
      ,a14_art_status_de
      ,nielsen_art_bez
      ,nielsen_gtin
      ,a58_rang_umsatz_owg
      ,a2_rang_umsatz_wg
      ,a59_rang_absatz_wg
      ,a16_akt_lieferant_id
      ,a419_hersteller_id
      ,a446_lieferant_bez_latein
      ,a447_hersteller_bez_latein
      ,lieferant_nielsen
      ,a389_zek_id
      ,a391_disc_pe
      ,a392_disc_ohne_etikett
      ,a400_lcf
      ,a393_vegan
      ,a394_gluten
      ,a395_bio
      ,a396_eigenmarke
      ,a397_tierwohl
      ,a398_posten_food
      ,a399_posten_nonfood
      ,a339_umsatzsteuer
      ,a36_gewichtete_distribution
      ,a60_muki_vk_kz
      ,a61_muki_vk_kl_art_id_verkettung
      ,anzahl_markt_wochen_kombis_abverkauf_af
      ,anzahl_markt_wochen_kombis_abverkauf_sa
      ,anzahl_markt_wochen_kombis_abverkauf_af_vj
      ,anzahl_markt_wochen_kombis_abverkauf_sa_vj
      ,a273_kassenumsatz_kl_absolut_brutto
      ,kassenumsatz_af_kl_absolut_brutto
      ,kassenumsatz_sa_kl_absolut_brutto
      ,kassenumsatz_kl_absolut_brutto_vj
      ,kassenumsatz_af_kl_absolut_brutto_vj
      ,kassenumsatz_sa_kl_absolut_brutto_vj
      ,a21_kassenumsatz_kl_absolut_netto
      ,kassenumsatz_af_kl_absolut_netto
      ,kassenumsatz_sa_kl_absolut_netto
      ,kassenumsatz_kl_absolut_netto_vj
      ,kassenumsatz_af_kl_absolut_netto_vj
      ,kassenumsatz_sa_kl_absolut_netto_vj
      ,a17_absatz_kl
      ,absatz_af_kl
      ,absatz_sa_kl
      ,absatz_kl_vj
      ,absatz_af_kl_vj
      ,absatz_sa_kl_vj
      ,a76_absatz_sst1
      ,a78_absatz_sst2
      ,a80_absatz_sst3
      ,a82_absatz_sst4
      ,a84_absatz_sst5
      ,a86_absatz_sst6
      ,a88_absatz_sst7
      ,a62_absatz_ksst1
      ,a64_absatz_ksst2
      ,a66_absatz_ksst3
      ,a68_absatz_ksst4
      ,a70_absatz_ksst5
      ,a72_absatz_ksst6
      ,a74_absatz_ksst7
      ,a90_absatz_ost_basis
      ,a92_absatz_ost_gross
      ,a94_absatz_sued_ost
      ,a96_absatz_sued_west
      ,a98_absatz_west
      ,a100_absatz_nord
      ,markt_wochen_sst1
      ,markt_wochen_sst2
      ,markt_wochen_sst3
      ,markt_wochen_sst4
      ,markt_wochen_sst5
      ,markt_wochen_sst6
      ,markt_wochen_sst7
      ,markt_wochen_ksst1
      ,markt_wochen_ksst2
      ,markt_wochen_ksst3
      ,markt_wochen_ksst4
      ,markt_wochen_ksst5
      ,markt_wochen_ksst6
      ,markt_wochen_ksst7
      ,markt_wochen_ost_basis
      ,markt_wochen_ost_gross
      ,markt_wochen_sued_ost
      ,markt_wochen_sued_west
      ,markt_wochen_west
      ,markt_wochen_nord
      ,anzahl_markt_wochen_kombis_abverkauf_mit_listung
      ,anzahl_markt_wochen_kombis_listung
      ,a31_vk_brutto_kl_pk_1
      ,a333_vk_brutto_kl_pk_2
      ,a54_vk_brutto_kl_pk_3
      ,a334_vk_brutto_kl_pk_4
      ,a432_vk_brutto_kl_pk_5
      ,a433_vk_brutto_kl_pk_6
      ,a434_vk_brutto_kl_pk_7
      ,a435_vk_brutto_kl_pk_8
      ,a436_vk_brutto_kl_pk_9
      ,a437_vk_brutto_kl_pk_10
      ,A30_KB_oLK_EK4NDZ_STAMM
      ,a23_rohertrag_ekmep_olk_4n
      ,a51_listung_sst_pflege
      ,a52_listung_k_sst_pflege
      ,a426_ost_basis_pflege
      ,a427_ost_gross_pflege
      ,a428_sued_ost_pflege
      ,a429_sued_west_pflege
      ,a430_west_pflege
      ,a431_nord_pflege
      ,a50_listungsaktion
      ,a411_stk_rohertrag_pflege
      ,a415_kannibalisierungsfaktor
      ,a412_umsatz_brutto_hochrechnung
      ,a413_absatz_hochrechnung
      ,a414_rohertrag_hochrechnung
      ,a36_gewichtete_distribution_nielsen
      ,a32_umsatz_anteil_wgi_nielsen
      ,a33_umsatz_anteil_wgi_kumuliert_nielsen
      ,a34_vk_brutto_durchschnitt_nielsen
      ,a35_umsatz_nielsen
      ,anz_wochen_de_anz_monate_kmo_nielsen
      ,absatz_nielsen
      ,a376_kl_marktanteil_wg_nielsen
      ,a380_marktanteilbewertung_nielsen
      ,a377_durchschnitt_anz_maerkte_nielsen
      ,a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen
      ,a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen
      ,a384_durchschn_preis_einheit_gl_normiert_nielsen
      ,a385_numerische_distribution_nielsen
      ,a386_inhaltsmengen_nielsen
      ,a387_duft_geschmack_nielsen
      ,a388_einheit_nielsen
      ,eigenmarke_fg_nielsen
      ,a39_listung_sst_mvke
      ,a38_listung_k_sst_mvke
      ,a40_ost_basis
      ,a41_ost_gross
      ,a42_sued_ost
      ,a43_sued_west
      ,a44_west
      ,a45_nord
      ,a37_listung_erster_markt
      ,a59_anz_maerkte_sst
      ,a449_anz_maerkte_k_sst
      ,a46_max_anz_maerkte_sst
      ,a47_max_anz_maerkte_k_sst
      ,a53_anz_maerkte_listung_gesamt
      ,a57_anz_maerkte_listung_einzel
      ,anz_maerkte_baustein_sonstige
      ,anz_bons_af
      ,anz_bons_sa
      ,anz_bons_gesamt
      ,rohertrag_ekmep_olk_4n_vj
      ,rohertrag_ekmep_olk_4n_af
      ,rohertrag_ekmep_olk_4n_sa
      ,rohertrag_ekmep_olk_4n_af_vj
      ,rohertrag_ekmep_olk_4n_sa_vj
      ,a381_preislagenverteilung
      ,a27_totalabschriften_wert_netto_absolut
      ,a313_preisabschriften_preisanderungen_wert_netto_absolut
      ,totalabschriften_wert_netto_absolut_vj
      ,preisabschriften_preisanderungen_wert_netto_absolut_vj
      ,a402_kolli_la
      ,a401_kolli_bst
      ,a403_restlaufzeit_zl
      ,a404_restlaufzeit_dz
      ,a405_basismengeneinheit
      ,a406_letzte_listungsanderung_sst_ksst
      ,a407_verhandler
      ,a408_display_komponente_kz
      ,a409_kl_art_id_display
      ,a416_artikelrolle_id
      ,kassenumsatz_kl_absolut_netto_wg
      ,anz_bons_tupel
      ,restbon_summe
      ,totalabschriften_wert_netto_absolut_wg
      ,preisabschriften_preisanderungen_wert_netto_absolut_wg
      ,ANZ_BONS_AF_MARKT_TAG
      ,ANZ_BONS_SA_MARKT_TAG
      ,cpq_tupel
      ,cp_bons_af
      ,cp_bons_sa
      ,umrech_faktor
      ,lagerprozent
      ,absatz_af_kl_listungswochen
      ,absatz_af_kl_vj_listungswochen
      ,absatz_sa_kl_listungswochen
      ,absatz_sa_kl_vj_listungswochen
      ,kassenumsatz_af_kl_absolut_netto_listungswochen
      ,kassenumsatz_af_kl_absolut_netto_vj_listungswochen
      ,kassenumsatz_sa_kl_absolut_netto_listungswochen
      ,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
      ,rohertrag_ekmep_olk_4n_af_listungswochen
      ,rohertrag_ekmep_olk_4n_af_vj_listungswochen
      ,rohertrag_ekmep_olk_4n_sa_listungswochen
      ,rohertrag_ekmep_olk_4n_sa_vj_listungswochen
      ,a445_anz_tupel_listung_wgi
      ,td_insert
      ,td_update
      ,sustain_concat
      ,check_fg
      ,tupel_typ
      ,a471_marke_nielsen_bez
      ,a516_veggy_split_nielsen_kz            
      ,a517_laktosefrei_nielsen_kz            
      ,a515_bio_organic_nielsen_kz            
      ,a518_glutenfrei_nielsen_kz             
      ,A510_MUKI_EK_KZ                        
      ,A511_MUKI_EK_KL_ART_ID_VERKETTUNG      
      ,A512_MUKI_WB_KZ                        
      ,A513_MUKI_WB_KL_ART_ID_VERKETTUNG      
      ,A519_UMSATZ_ANTEIL_WG_NIELSEN          
      ,A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN
      ,a521_Inhalt_menge                      
from _dup_free
;
