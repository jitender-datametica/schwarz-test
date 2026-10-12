-- STEP 1
-- Korrekte neue Maerkte in der aktuellen Zeitreihe ermitteln. Nur von
-- Maerkten, die noch nicht angefasst worden sind.
create or replace volatile table _step1 as (
select *
from dbp_etl_process.wup_transfer_per_1
where mandant_id = 1 and
      wup_aenderung_grund_id <> 0 and
     (mandant_id,wup_id_neu) in (select mandant_id,wup_id from dbp_data.wup_1 where dat_von = '2090-12-31' and mandant_id = 1) and
      current_date between dat_von and dat_bis
);

create or replace volatile table _step2 as (
select a.adresse_id
      ,b.wup_id_neu as aktuell_wup_id
      ,a.betriebsflaeche
      ,a.bewertungskreis_id
      ,a.breakevenumsatz
      ,a.breitengrad
      ,a.buchungskreis_id
      ,b.dat_von-1 as dat_bis
      ,a.dat_dayforce_ab
      ,a.dat_eroeffnung
      ,a.dat_eroeffnung_alt
      ,a.dat_letzter_facelift
      ,a.dat_letzter__facelift_von
      ,a.dat_letzte_modernisierung_bis
      ,a.dat_letzte_modernisierung_von
      ,a.dat_qbm_umstellung
      ,a.dat_umstellung_waage
      ,a.dat_von
      ,a.dat_von_alt
      ,a.dat_wiedereroeffnung
      ,a.eigentum_miete_kz
      ,a.einwohner_anzahl
      ,a.etagen_anz
      ,a.filialtyp_id
      ,a.fipo_pruef_objekt_id
      ,a.fleischsystem
      ,a.getraenkemarkt_fg
      ,a.gf_id
      ,a.gis_quali_id
      ,a.gln_id
      ,a.haupt_wup_id
      ,a.hl_id
      ,a.kassentyp
      ,a.kreistyp_gruppe_id
      ,a.kundenfaktor
      ,a.laengengrad
      ,a.land_id
      ,a.lead_mwst
      ,a.mandant_id
      ,a.mandant_id_ursprung
      ,a.nb_id
      ,a.orig_wup_id
      ,a.preiskategorie_food
      ,a.preiskategorie_nonfood
      ,a.qbm_id
      ,a.ref_wup_id
      ,a.region_id
      ,a.sondermarkt
      ,a.sortkategorie_food
      ,a.sortkategorie_nonfood
      ,a.systemrentabilitaet
      ,a.td_insert
      ,current_timestamp as td_update
      ,a.uebernahme_von
      ,a.umsatz_ea_eur
      ,a.umsatz_ea_land
      ,a.umsatz_erwartung_eur
      ,a.umzugsfiliale_fg
      ,a.verkaufsflaeche
      ,a.verkaufsorganisation_id
      ,a.vf_id
      ,a.vkl_id
      ,a.vs_id
      ,a.vw_id
      ,a.vz_wup_id
      ,a.wm_id
      ,b.wup_aenderung_grund_id
      ,a.wup_id
      ,a.wup_id_alt
      ,a.wup_name_e
      ,a.wup_name_v
      ,a.wup_plz
      ,a.wup_stadt
      ,a.wup_standort
      ,a.wup_str
      ,a.wup_typ_id
from dbp_data.wup_1 a
join _step1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.wup_id = a.aktuell_wup_id
where b.wup_aenderung_grund_id in (2,3)
);

insert into _step2
select a.adresse_id
      ,b.wup_id_neu as aktuell_wup_id
      ,a.betriebsflaeche
      ,a.bewertungskreis_id
      ,a.breakevenumsatz
      ,a.breitengrad
      ,b.buchungskreis_id_neu as buchungskreis_id
      ,b.dat_bis as dat_bis
      ,a.dat_dayforce_ab
      ,b.dat_von as dat_eroeffnung
      ,a.dat_von as dat_eroeffnung_alt
      ,a.dat_letzter_facelift
      ,a.dat_letzter__facelift_von
      ,a.dat_letzte_modernisierung_bis
      ,a.dat_letzte_modernisierung_von
      ,a.dat_qbm_umstellung
      ,a.dat_umstellung_waage
      ,b.dat_von as dat_von
      ,a.dat_von as dat_von_alt
      ,a.dat_wiedereroeffnung
      ,a.eigentum_miete_kz
      ,a.einwohner_anzahl
      ,a.etagen_anz
      ,a.filialtyp_id
      ,a.fipo_pruef_objekt_id
      ,a.fleischsystem
      ,a.getraenkemarkt_fg
      ,a.gf_id
      ,a.gis_quali_id
      ,a.gln_id
      ,a.haupt_wup_id
      ,a.hl_id
      ,a.kassentyp
      ,a.kreistyp_gruppe_id
      ,a.kundenfaktor
      ,a.laengengrad
      ,a.land_id
      ,a.lead_mwst
      ,a.mandant_id
      ,a.mandant_id_ursprung
      ,a.nb_id
      ,b.wup_id as orig_wup_id
      ,a.preiskategorie_food
      ,a.preiskategorie_nonfood
      ,a.qbm_id
      ,a.ref_wup_id
      ,a.region_id
      ,a.sondermarkt
      ,a.sortkategorie_food
      ,a.sortkategorie_nonfood
      ,a.systemrentabilitaet
      ,current_timestamp as td_insert
      ,current_timestamp as td_update
      ,a.uebernahme_von
      ,a.umsatz_ea_eur
      ,a.umsatz_ea_land
      ,a.umsatz_erwartung_eur
      ,a.umzugsfiliale_fg
      ,a.verkaufsflaeche
      ,a.verkaufsorganisation_id
      ,a.vf_id
      ,a.vkl_id
      ,a.vs_id
      ,a.vw_id
      ,a.vz_wup_id
      ,a.wm_id
      ,0 as wup_aenderung_grund_id
      ,b.wup_id_neu as wup_id
      ,a.wup_id_alt
      ,a.wup_name_e
      ,a.wup_name_v
      ,a.wup_plz
      ,a.wup_stadt
      ,a.wup_standort
      ,a.wup_str
      ,a.wup_typ_id
from dbp_data.wup_1 a
join _step1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id_neu
where b.wup_aenderung_grund_id in (2,3)
;

update _step2 from (select mandant_id,
                           wup_id,
                           dat_von,
                           dat_eroeffnung,
                           wup_aenderung_grund_id
                    from _step2
                    where wup_aenderung_grund_id in (2,3)) b
                      
set wup_id_alt = case when b.wup_aenderung_grund_id = 3 then null else b.wup_id end,
    dat_von_alt = b.dat_von,
    dat_eroeffnung_alt = b.dat_eroeffnung

where _step2.mandant_id = b.mandant_id and
      _step2.orig_wup_id = b.wup_id and
      _step2.wup_aenderung_grund_id = 0
;

update _step2 from (select a.mandant_id,
                           a.wup_id,
                           b.wup_id as wup_id_upd
                    from dbp_data.wup_1 a
                    join (select mandant_id,
                                 wup_id_alt,
                                 wup_id 
                          from _step2 
                          where wup_id_alt is not null
                          group by 1,2,3) b
                      on a.mandant_id = b.mandant_id and
                         a.wup_id = b.wup_id_alt) b
                         
set orig_wup_id = b.wup_id

where _step2.mandant_id = b.mandant_id and
      _step2.orig_wup_id = b.wup_id_upd
;

-- Austausch!
delete from dbp_data.wup_1
where (mandant_id,wup_id) in (select mandant_id,wup_id from _step2)
;

insert into dbp_data.wup_1 (adresse_id
                     ,aktuell_wup_id
                     ,betriebsflaeche
                     ,bewertungskreis_id
                     ,breakevenumsatz
                     ,breitengrad
                     ,buchungskreis_id
                     ,dat_bis
                     ,dat_dayforce_ab
                     ,dat_eroeffnung
                     ,dat_eroeffnung_alt
                     ,dat_letzter_facelift
                     ,dat_letzter__facelift_von
                     ,dat_letzte_modernisierung_bis
                     ,dat_letzte_modernisierung_von
                     ,dat_qbm_umstellung
                     ,dat_umstellung_waage
                     ,dat_von
                     ,dat_von_alt
                     ,dat_wiedereroeffnung
                     ,eigentum_miete_kz
                     ,einwohner_anzahl
                     ,etagen_anz
                     ,filialtyp_id
                     ,fipo_pruef_objekt_id
                     ,fleischsystem
                     ,getraenkemarkt_fg
                     ,gf_id
                     ,gis_quali_id
                     ,gln_id
                     ,haupt_wup_id
                     ,hl_id
                     ,kassentyp
                     ,kreistyp_gruppe_id
                     ,kundenfaktor
                     ,laengengrad
                     ,land_id
                     ,lead_mwst
                     ,mandant_id
                     ,mandant_id_ursprung
                     ,nb_id
                     ,orig_wup_id
                     ,preiskategorie_food
                     ,preiskategorie_nonfood
                     ,qbm_id
                     ,ref_wup_id
                     ,region_id
                     ,sondermarkt
                     ,sortkategorie_food
                     ,sortkategorie_nonfood
                     ,systemrentabilitaet
                     ,td_insert
                     ,td_update
                     ,uebernahme_von
                     ,umsatz_ea_eur
                     ,umsatz_ea_land
                     ,umsatz_erwartung_eur
                     ,umzugsfiliale_fg
                     ,verkaufsflaeche
                     ,verkaufsorganisation_id
                     ,vf_id
                     ,vkl_id
                     ,vs_id
                     ,vw_id
                     ,vz_wup_id
                     ,wm_id
                     ,wup_aenderung_grund_id
                     ,wup_id
                     ,wup_id_alt
                     ,wup_name_e
                     ,wup_name_v
                     ,wup_plz
                     ,wup_stadt
                     ,wup_standort
                     ,wup_str
                     ,wup_typ_id)
select adresse_id
      ,aktuell_wup_id
      ,betriebsflaeche
      ,bewertungskreis_id
      ,breakevenumsatz
      ,breitengrad
      ,buchungskreis_id
      ,dat_bis
      ,dat_dayforce_ab
      ,dat_eroeffnung
      ,dat_eroeffnung_alt
      ,dat_letzter_facelift
      ,dat_letzter__facelift_von
      ,dat_letzte_modernisierung_bis
      ,dat_letzte_modernisierung_von
      ,dat_qbm_umstellung
      ,dat_umstellung_waage
      ,dat_von
      ,dat_von_alt
      ,dat_wiedereroeffnung
      ,eigentum_miete_kz
      ,einwohner_anzahl
      ,etagen_anz
      ,filialtyp_id
      ,fipo_pruef_objekt_id
      ,fleischsystem
      ,getraenkemarkt_fg
      ,gf_id
      ,gis_quali_id
      ,gln_id
      ,haupt_wup_id
      ,hl_id
      ,kassentyp
      ,kreistyp_gruppe_id
      ,kundenfaktor
      ,laengengrad
      ,land_id
      ,lead_mwst
      ,mandant_id
      ,mandant_id_ursprung
      ,nb_id
      ,orig_wup_id
      ,preiskategorie_food
      ,preiskategorie_nonfood
      ,qbm_id
      ,ref_wup_id
      ,region_id
      ,sondermarkt
      ,sortkategorie_food
      ,sortkategorie_nonfood
      ,systemrentabilitaet
      ,td_insert
      ,td_update
      ,uebernahme_von
      ,umsatz_ea_eur
      ,umsatz_ea_land
      ,umsatz_erwartung_eur
      ,umzugsfiliale_fg
      ,verkaufsflaeche
      ,verkaufsorganisation_id
      ,vf_id
      ,vkl_id
      ,vs_id
      ,vw_id
      ,vz_wup_id
      ,wm_id
      ,wup_aenderung_grund_id
      ,wup_id
      ,wup_id_alt
      ,wup_name_e
      ,wup_name_v
      ,wup_plz
      ,wup_stadt
      ,wup_standort
      ,wup_str
      ,wup_typ_id
from _step2
;

update dbp_data.wup_1 from (select mandant_id,
                                 orig_wup_id,
                                 aktuell_wup_id
                          from _step2
                          group by 1,2,3) b
                      
set aktuell_wup_id = b.aktuell_wup_id

where dbp_data.wup.mandant_id = b.mandant_id and
      dbp_data.wup.wup_id = b.orig_wup_id
;

-- STEP 2
-- Korrekte neue Maerkte in der zukuenftigen Zeitreihe ermitteln. Nur von
-- Maerkten, die noch nicht angefasst worden sind.
create or replace volatile table _step1 as (
select *
from dbp_etl_process.wup_transfer_per_1
where mandant_id = 1 and
      wup_aenderung_grund_id <> 0 and
     (mandant_id,wup_id_neu) in (select mandant_id,wup_id from dbp_data.wup_1 where dat_von = '2090-12-31' and mandant_id = 1) and
      dat_von > current_date
);

create or replace volatile table _step2 as (
select a.adresse_id
      ,a.aktuell_wup_id as aktuell_wup_id
      ,a.betriebsflaeche
      ,a.bewertungskreis_id
      ,a.breakevenumsatz
      ,a.breitengrad
      ,b.buchungskreis_id_neu as buchungskreis_id
      ,b.dat_bis as dat_bis
      ,a.dat_dayforce_ab
      ,b.dat_von as dat_eroeffnung
      ,null as dat_eroeffnung_alt
      ,a.dat_letzter_facelift
      ,a.dat_letzter__facelift_von
      ,a.dat_letzte_modernisierung_bis
      ,a.dat_letzte_modernisierung_von
      ,a.dat_qbm_umstellung
      ,a.dat_umstellung_waage
      ,b.dat_von as dat_von
      ,null as dat_von_alt
      ,a.dat_wiedereroeffnung
      ,a.eigentum_miete_kz
      ,a.einwohner_anzahl
      ,a.etagen_anz
      ,a.filialtyp_id
      ,a.fipo_pruef_objekt_id
      ,a.fleischsystem
      ,a.getraenkemarkt_fg
      ,a.gf_id
      ,a.gis_quali_id
      ,a.gln_id
      ,a.haupt_wup_id
      ,a.hl_id
      ,a.kassentyp
      ,a.kreistyp_gruppe_id
      ,a.kundenfaktor
      ,a.laengengrad
      ,a.land_id
      ,a.lead_mwst
      ,a.mandant_id
      ,a.mandant_id_ursprung
      ,a.nb_id
      ,a.orig_wup_id as orig_wup_id
      ,a.preiskategorie_food
      ,a.preiskategorie_nonfood
      ,a.qbm_id
      ,a.ref_wup_id
      ,a.region_id
      ,a.sondermarkt
      ,a.sortkategorie_food
      ,a.sortkategorie_nonfood
      ,a.systemrentabilitaet
      ,current_timestamp as td_insert
      ,current_timestamp as td_update
      ,a.uebernahme_von
      ,a.umsatz_ea_eur
      ,a.umsatz_ea_land
      ,a.umsatz_erwartung_eur
      ,a.umzugsfiliale_fg
      ,a.verkaufsflaeche
      ,a.verkaufsorganisation_id
      ,a.vf_id
      ,a.vkl_id
      ,a.vs_id
      ,a.vw_id
      ,a.vz_wup_id
      ,a.wm_id
      ,b.wup_aenderung_grund_id
      ,b.wup_id_neu as wup_id
      ,a.wup_id_alt
      ,a.wup_name_e
      ,a.wup_name_v
      ,a.wup_plz
      ,a.wup_stadt
      ,a.wup_standort
      ,a.wup_str
      ,a.wup_typ_id
from dbp_data.wup_1 a
join _step1 b
  on a.mandant_id = b.mandant_id and
     a.orig_wup_id = b.wup_id and
     current_date between a.dat_von and a.dat_bis
);

-- Austausch!
delete from dbp_data.wup_1
where (mandant_id,wup_id) in (select mandant_id,wup_id from _step2)
;

insert into dbp_data.wup_1 (adresse_id
                     ,aktuell_wup_id
                     ,betriebsflaeche
                     ,bewertungskreis_id
                     ,breakevenumsatz
                     ,breitengrad
                     ,buchungskreis_id
                     ,dat_bis
                     ,dat_dayforce_ab
                     ,dat_eroeffnung
                     ,dat_eroeffnung_alt
                     ,dat_letzter_facelift
                     ,dat_letzter__facelift_von
                     ,dat_letzte_modernisierung_bis
                     ,dat_letzte_modernisierung_von
                     ,dat_qbm_umstellung
                     ,dat_umstellung_waage
                     ,dat_von
                     ,dat_von_alt
                     ,dat_wiedereroeffnung
                     ,eigentum_miete_kz
                     ,einwohner_anzahl
                     ,etagen_anz
                     ,filialtyp_id
                     ,fipo_pruef_objekt_id
                     ,fleischsystem
                     ,getraenkemarkt_fg
                     ,gf_id
                     ,gis_quali_id
                     ,gln_id
                     ,haupt_wup_id
                     ,hl_id
                     ,kassentyp
                     ,kreistyp_gruppe_id
                     ,kundenfaktor
                     ,laengengrad
                     ,land_id
                     ,lead_mwst
                     ,mandant_id
                     ,mandant_id_ursprung
                     ,nb_id
                     ,orig_wup_id
                     ,preiskategorie_food
                     ,preiskategorie_nonfood
                     ,qbm_id
                     ,ref_wup_id
                     ,region_id
                     ,sondermarkt
                     ,sortkategorie_food
                     ,sortkategorie_nonfood
                     ,systemrentabilitaet
                     ,td_insert
                     ,td_update
                     ,uebernahme_von
                     ,umsatz_ea_eur
                     ,umsatz_ea_land
                     ,umsatz_erwartung_eur
                     ,umzugsfiliale_fg
                     ,verkaufsflaeche
                     ,verkaufsorganisation_id
                     ,vf_id
                     ,vkl_id
                     ,vs_id
                     ,vw_id
                     ,vz_wup_id
                     ,wm_id
                     ,wup_aenderung_grund_id
                     ,wup_id
                     ,wup_id_alt
                     ,wup_name_e
                     ,wup_name_v
                     ,wup_plz
                     ,wup_stadt
                     ,wup_standort
                     ,wup_str
                     ,wup_typ_id)
select adresse_id
      ,aktuell_wup_id
      ,betriebsflaeche
      ,bewertungskreis_id
      ,breakevenumsatz
      ,breitengrad
      ,buchungskreis_id
      ,dat_bis
      ,dat_dayforce_ab
      ,dat_eroeffnung
      ,dat_eroeffnung_alt
      ,dat_letzter_facelift
      ,dat_letzter__facelift_von
      ,dat_letzte_modernisierung_bis
      ,dat_letzte_modernisierung_von
      ,dat_qbm_umstellung
      ,dat_umstellung_waage
      ,dat_von
      ,dat_von_alt
      ,dat_wiedereroeffnung
      ,eigentum_miete_kz
      ,einwohner_anzahl
      ,etagen_anz
      ,filialtyp_id
      ,fipo_pruef_objekt_id
      ,fleischsystem
      ,getraenkemarkt_fg
      ,gf_id
      ,gis_quali_id
      ,gln_id
      ,haupt_wup_id
      ,hl_id
      ,kassentyp
      ,kreistyp_gruppe_id
      ,kundenfaktor
      ,laengengrad
      ,land_id
      ,lead_mwst
      ,mandant_id
      ,mandant_id_ursprung
      ,nb_id
      ,orig_wup_id
      ,preiskategorie_food
      ,preiskategorie_nonfood
      ,qbm_id
      ,ref_wup_id
      ,region_id
      ,sondermarkt
      ,sortkategorie_food
      ,sortkategorie_nonfood
      ,systemrentabilitaet
      ,td_insert
      ,td_update
      ,uebernahme_von
      ,umsatz_ea_eur
      ,umsatz_ea_land
      ,umsatz_erwartung_eur
      ,umzugsfiliale_fg
      ,verkaufsflaeche
      ,verkaufsorganisation_id
      ,vf_id
      ,vkl_id
      ,vs_id
      ,vw_id
      ,vz_wup_id
      ,wm_id
      ,wup_aenderung_grund_id
      ,wup_id
      ,wup_id_alt
      ,wup_name_e
      ,wup_name_v
      ,wup_plz
      ,wup_stadt
      ,wup_standort
      ,wup_str
      ,wup_typ_id
from _step2
;

-- 04.02.2025, -dba-
-- Auf Wunsch von Alex sollen nun neu registrierte Maerkte mit ihrer Marktnummer
-- auch in aktuell_wup_id hinterlegt sein. orig_wup_id bleibt auf dem umgegliederten
-- Markt stehen.

update dbp_data.wup_1 set aktuell_wup_id = wup_id
where wup_aenderung_grund_id < 0
;

-- STEP 3
-- Zukuenftige Maerkte werden bei Erreichen des Datums aktiviert.
create or replace volatile table _upd as (
select mandant_id,
       wup_id,
       orig_wup_id,
       aktuell_wup_id,
       dat_von-1 as dat_bis,
       (-1)*wup_aenderung_grund_id as wup_aenderung_grund_id
from dbp_data.wup_1
where wup_aenderung_grund_id in (-2,-3) and
      mandant_id = 1 and
      current_date = dat_von
);

create or replace volatile table _upd2 as (
select a.mandant_id,
       b.wup_id,
       a.orig_wup_id,
       a.aktuell_wup_id,
       a.dat_von as dat_von_alt,
       a.dat_eroeffnung as dat_eroeffnung_alt
from dbp_data.wup_1 a
join _upd b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.orig_wup_id
where a.wup_aenderung_grund_id in (0) and
      a.mandant_id = 1
);

update dbp_data.wup_1 from (select *
                          from _upd2) b
                          
set dat_eroeffnung_alt = b.dat_eroeffnung_alt,
    dat_von_alt = b.dat_von_alt

where dbp_data.wup.mandant_id = b.mandant_id and
      dbp_data.wup.wup_id = b.orig_wup_id
;

update dbp_data.wup_1 from (select *
                          from _upd) b
                          
set dat_bis = b.dat_bis,
    wup_aenderung_grund_id = b.wup_aenderung_grund_id

where dbp_data.wup.mandant_id = b.mandant_id and
      dbp_data.wup.wup_id = b.orig_wup_id and
      dbp_data.wup.aktuell_wup_id = b.aktuell_wup_id and
      dbp_data.wup.wup_aenderung_grund_id = 0
;

update dbp_data.wup_1 from (select *
                          from _upd) b
                          
set aktuell_wup_id = b.wup_id,
    wup_aenderung_grund_id = 0,
    wup_id_alt = case when dbp_data.wup.wup_aenderung_grund_id = -2 then b.orig_wup_id else null end

where dbp_data.wup.mandant_id = b.mandant_id and
      dbp_data.wup.wup_id = b.wup_id and
      dbp_data.wup.wup_aenderung_grund_id in (-2,-3)
;

update dbp_data.wup_1 from (select *
                          from _upd) b
                   
set aktuell_wup_id = b.wup_id

where dbp_data.wup.mandant_id = b.mandant_id and
      dbp_data.wup.orig_wup_id = b.orig_wup_id
;
