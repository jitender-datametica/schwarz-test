/*
#------------------------------------------------------------------------------
# Skriptname   : artbew_scanning.btq
# Erstelldatum : 20.01.2016
#------------------------------------------------------------------------------
# Projekt      : AIS
# Kommentar    : Die Scanningqualitaet der EANs werden geprueft!
#
# Datenquellen : dbp_data.artbew, dbp_ods.ods_bon_kopf, dbp_ods.ods_bon_verkauf,
#                dbp_data.art, dbp_data.art_gp_zu_per
#
# Datenziele   : dbp_data.artbew_scanning
#------------------------------------------------------------------------------
# Historie:
# 20.01.2016  D.Bayraktar   Ersterstellung
# 10.08.2016  D.Bayraktar   PLUs ausschliessen
# 18.09.2019  D.Bayraktar   Performance!
# 21.01.2022  SPEC0142119   remove filter ean_kasse>9999
#------------------------------------------------------------------------------
# Verarbeitungsschritte
#  1)  Logon auf der Datenbank.
#  2)  Relevante Tage rausziehen.
#  3)  Die benoetigten Bon-Daten ziehen.
#  4)  Die benoetigten Artbew-Daten ziehen.
#  5)  Berechnung der Scanningtreffer.
#  6)  Promo-Flag aus Artbew uebertragen.
#  7)  Austausch der Daten.
#  8)  Bteq beenden.
#------------------------------------------------------------------------------
*/

/*
#-----------------------------------------------------------------------------------
# 2) Relevante Tage rausziehen.
#-----------------------------------------------------------------------------------
*/

create or replace transient table _tage as (
select dat
from dbp_data.tag
where dat between current_date-4 and current_date-1
group by 1
);

/*
#-----------------------------------------------------------------------------------
# 3) Die benoetigten Bon-Daten ziehen.
#-----------------------------------------------------------------------------------
*/

create or replace transient table _snapshot1 as (
select a.*,
       x.kasse_typ_id
from dbp_ods.ods_bon_kopf x
join dbp_ods.ods_bon_verkauf a
on x.mandant_id = a.mandant_id and
   x.wup_id = a.wup_id and
   x.bon_id = a.bon_id and
   x.bon_dat = a.bon_dat
where x.bon_dat between current_date-4 and current_date-1 and
      x.kasse_typ_id in (1,8,9) and
      a.einh_id not in ('LGB','PND','LGK','LGF') and
      a.menge > 0
);

/*
#-----------------------------------------------------------------------------------
# 4) Die benoetigten Artbew-Daten ziehen.
#-----------------------------------------------------------------------------------
*/

create or replace transient table _artbew as (
select *
from dbp_data.artbew
where dat between current_date-4 and current_date-1
);

/*
#-----------------------------------------------------------------------------------
# 5) Berechnung der Scanningtreffer.
#-----------------------------------------------------------------------------------
*/

create or replace transient table _ergebnis as (
select a.mandant_id,
       a.wup_id,
       0 as nb_id,
       case
         when a.aktion_id not in ('0','0000000000','')
         then 1002
         else 1001
       end as bewart_id,
       cast(null as integer) as gp_id,
       b.art_id,
       a.bon_dat as dat,
       a.aktion_id,
       cast(0 as byteint) as promo_fg,
       a.kasse_typ_id,
       coalesce(case
                  when trim(a.barcode_string) = '' 
                  then a.ean_kasse
                  when length(a.barcode_string) > 26
                  then -9999
                  when try_to_number(a.barcode_string) is not null
                  then cast(to_number(a.barcode_string) as decimal(26,0))
                  else a.ean_kasse
                end,a.ean_kasse) as gtin_kasse,
       sum(case
             when a.erfassung_id = 'SC'
             then 1
             else 0
           end) as vorgang_scanned,
       sum(case
             when a.erfassung_id = 'KE'
             then 1
             else 0
           end) as vorgang_keyed,
       sum(case
             when a.erfassung_id = 'SC' and
                ((a.einh_id = 'ST' and a.menge <> 1) or
                 (a.einh_id = 'KGM'))
             then 1
             else 0
           end) as vorgang_scanned_einzeln,
       sum(case
             when a.erfassung_id = 'KE' and
                ((a.einh_id = 'ST' and a.menge <> 1) or
                 (a.einh_id = 'KGM'))
             then 1
             else 0
           end) as vorgang_keyed_einzeln,
       count(distinct bon_id) as anzahl_bon,
       sum(case
             when a.einh_id = 'KGM'
             then 1
             else a.menge
           end) as anzahl_registriert
from _snapshot1 a
join dbp_data.art b
  on a.mandant_id = b.mandant_id and
     a.kl_art_id = b.kl_art_id and
     b.dat_bis = '9999-12-31'
group by 1,2,3,4,5,6,7,8,9,10,11
);

/*
#-----------------------------------------------------------------------------------
# 6) Promo-Flag aus Artbew uebertragen.
#-----------------------------------------------------------------------------------
*/

update _ergebnis from (select mandant_id,
                              wup_id,
                              art_id,
                              aktion_id,
                              ean_kasse,
                              dat,
                              promo_fg
                       from _artbew
                       where promo_fg = 1
                       group by 1,2,3,4,5,6,7) b

set promo_fg = b.promo_fg

where _ergebnis.mandant_id = b.mandant_id and
      _ergebnis.wup_id = b.wup_id and
      _ergebnis.art_id = b.art_id and
      _ergebnis.aktion_id = b.aktion_id and
      _ergebnis.gtin_kasse = b.ean_kasse and
      _ergebnis.dat = b.dat
;

-- (1) Update des GP aus der ARTBEW.

update _ergebnis from (select mandant_id,
                              wup_id,
                              art_id,
                              dat,
                              max(gp_id) as gp_id
                       from _artbew
                       group by 1,2,3,4) b

set gp_id = b.gp_id

where _ergebnis.mandant_id = b.mandant_id and
      _ergebnis.wup_id = b.wup_id and
      _ergebnis.art_id = b.art_id and
      _ergebnis.dat = b.dat
;

-- (2) Uebrige NULLs werden durch ART_GP_NM_ZU_PER bereinigt.

update _ergebnis from (select a.mandant_id,
                              a.wup_id,
                              a.art_id,
                              a.dat,
                              max(b.gp_id) as gp_id
                       from (select *
                             from _ergebnis
                             where gp_id is null) a
                       join dbp_data.art_gp_nm_zu_per b
                         on a.mandant_id = b.mandant_id and
                            a.wup_id = b.wup_id and
                            a.art_id = b.art_id and
                            a.dat between b.dat_von and b.dat_bis
                       group by 1,2,3,4) b

set gp_id = b.gp_id

where _ergebnis.mandant_id = b.mandant_id and
      _ergebnis.wup_id = b.wup_id and
      _ergebnis.art_id = b.art_id and
      _ergebnis.dat = b.dat and
      _ergebnis.gp_id is null
;

delete from _ergebnis
where gp_id is null
;

/*
#-----------------------------------------------------------------------------------
# 7) Austausch der Daten.
#-----------------------------------------------------------------------------------
*/

delete from dbp_data.artbew_scanning
where dat between current_date-4 and current_date-1
;

insert into dbp_data.artbew_scanning (wup_id
                                     ,mandant_id
                                     ,bewart_id
                                     ,gp_id
                                     ,nb_id
                                     ,art_id
                                     ,dat
                                     ,aktion_id
                                     ,promo_fg
                                     ,gtin_kasse
                                     ,kasse_typ_id
                                     ,vorgang_scanned
                                     ,vorgang_keyed
                                     ,vorgang_scanned_einzeln
                                     ,vorgang_keyed_einzeln
                                     ,anzahl_bon
                                     ,anzahl_registriert)
select wup_id
      ,mandant_id
      ,bewart_id
      ,gp_id
      ,nb_id
      ,art_id
      ,dat
      ,aktion_id
      ,promo_fg
      ,coalesce(gtin_kasse,-9999)
      ,kasse_typ_id
      ,vorgang_scanned
      ,vorgang_keyed
      ,vorgang_scanned_einzeln
      ,vorgang_keyed_einzeln
      ,anzahl_bon
      ,anzahl_registriert
from _ergebnis
;

/*
#------------------------------------------------------------------------------
# 8) Bteq beenden.
#------------------------------------------------------------------------------
*/

