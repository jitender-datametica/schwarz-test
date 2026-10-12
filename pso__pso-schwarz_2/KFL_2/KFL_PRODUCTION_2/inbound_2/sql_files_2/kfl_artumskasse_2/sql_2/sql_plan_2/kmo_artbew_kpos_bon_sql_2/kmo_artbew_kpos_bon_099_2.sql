create or replace table dbp_etl.kmo_artbew_bon_aktion_relevant_2 (
  mandant_id  byteint not null,
  aktion_id   char(10) collate 'en-ci' not null,
  bewart_id   smallint not null,
  dat         date not null,
  art_id      integer not null,
  wup_id      integer not null,
  nb_id       smallint not null,
  anz_aktion  smallint not null
);

create or replace table dbp_etl.artbew_kmo_tmp_2 (
  wup_id integer not null,
  mandant_id byteint not null,
  bewart_id smallint not null ,
  bewart_det_id int not null,
  gp_id integer not null,
  nb_id smallint not null ,
  art_id integer not null,
  dat date not null,
  aktion_id char(10) collate 'en-ci' not null default '          '   ,
  promo_fg byteint not null default 0  ,
  ean_kasse decimal(26,0) not null default 0 ,
  einkaufsorganisation_id smallint ,
  herst_id integer ,
  mwst_id byteint not null ,
  menge decimal(18,3) ,
  wrg_2 char(3) collate 'en-ci' ,
  umsatz_netto decimal(18,4),
  diff_umsatz_netto_konz decimal(18,4) ,
  umsatz_mwst_betrag decimal(18,4),
  diff_umsatz_mwst_betrag_konz decimal(18,4) ,
  ek_brutto decimal(18,4),
  diff_ek_brutto_konz decimal(18,4),
  ek_netto decimal(18,4),
  diff_ek_netto_konz decimal(18,4),
  ek_nettonetto decimal(18,4),
  diff_ek_nettonetto_konz decimal(18,4),
  ek_kal_basis decimal(18,4),
  diff_ek_kal_basis_konz decimal(18,4),
  ek_mep decimal(18,4),
  diff_ek_mep_konz decimal(18,4),
  einstandspreis decimal(18,4),
  diff_einstandspreis_konz decimal(18,4),
  logkostenzuschlag decimal(18,4),
  diff_logkostenzuschlag_konz decimal(18,4),
  bezugsweg_id byteint ,
  ek_netto_bnk decimal(18,4),
  diff_ek_netto_bnk_konz decimal(18,4),
  ek_netto_bnk_sachk decimal(18,4),
  diff_ek_netto_bnk_sachk_konz decimal(18,4),
  posten_id char(2) collate 'en-ci' ,
  bq_findung_id byteint ,
  ek_gld decimal(18,4) ,
  diff_ek_gld_konz decimal(18,4) ,
  pv_aktion decimal(18,4),
  pv_bby decimal(18,4),
  pv_kdn_bby decimal(18,4),
  pv_kdp_bby decimal(18,4),
  pv_aktion_bby decimal(18,4),
  pv_aktion_kdn_bby decimal(18,4),
  pv_aktion_kdp_bby decimal(18,4)
);

create or replace table dbp_etl.artbew_kmo_tmp_crm_2 (
  wup_id integer not null,
  mandant_id byteint not null,
  bewart_id smallint not null ,
  gp_id integer not null,
  nb_id smallint not null ,
  art_id integer not null,
  dat date not null,
  aktion_id char(10) collate 'en-ci' not null default '          '   ,
  promo_fg byteint not null default 0  ,
  ean_kasse decimal(26,0) not null default 0 ,
  einkaufsorganisation_id smallint ,
  herst_id integer ,
  mwst_id byteint not null ,
  menge decimal(18,3) ,
  wrg_2 char(3) collate 'en-ci' ,
  umsatz_netto decimal(18,4),
  diff_umsatz_netto_konz decimal(18,4) ,
  umsatz_mwst_betrag decimal(18,4),
  diff_umsatz_mwst_betrag_konz decimal(18,4) ,
  ek_brutto decimal(18,4),
  diff_ek_brutto_konz decimal(18,4),
  ek_netto decimal(18,4),
  diff_ek_netto_konz decimal(18,4),
  ek_nettonetto decimal(18,4),
  diff_ek_nettonetto_konz decimal(18,4),
  ek_kal_basis decimal(18,4),
  diff_ek_kal_basis_konz decimal(18,4),
  ek_mep decimal(18,4),
  diff_ek_mep_konz decimal(18,4),
  einstandspreis decimal(18,4),
  diff_einstandspreis_konz decimal(18,4),
  logkostenzuschlag decimal(18,4),
  diff_logkostenzuschlag_konz decimal(18,4),
  bezugsweg_id byteint ,
  ek_netto_bnk decimal(18,4),
  diff_ek_netto_bnk_konz decimal(18,4),
  ek_netto_bnk_sachk decimal(18,4),
  diff_ek_netto_bnk_sachk_konz decimal(18,4),
  posten_id char(2) collate 'en-ci' ,
  bq_findung_id byteint ,
  ek_gld decimal(18,4) ,
  diff_ek_gld_konz decimal(18,4) ,
  kundenkarte_id varchar(255) collate 'en-ci',
  bon_id varchar(25) collate 'en-cs'
);

create or replace table dbp_etl.kmo_wpuums_art_gp_wup_zu_2  (
  mandant_id         byteint not null,
  art_id             integer not null,
  wup_id             integer not null,
  nb_id              smallint not null,
  dat                date not null,
  bezugsweg_id       byteint,
  anz_ek_infosatz    smallint,   -- anzahl infosätze (1 wenn nur ungültige vorhanden sind)
  anz_ek_orderbuch   smallint,   -- anzahl orderbuch gepflegt
  bq_gp_id           integer,    -- gp_2 nach bezugsquellenfindung
  bq_ekorg           smallint,   -- ekorg nach bezugsquellenfindung
  bq_findung_id      byteint,    -- ausstiegspunkt der bezugsquellenfindung
  regel_gp_id        integer,    -- regel gp_2 aus einkaufsinfosatz
  regel_ekorg        smallint,   -- regel ekorg aus einkaufsinfosatz
  ref_wup_id         integer,    -- vz aus kreisprozess für bezugsweg 4 oder wup_id für bezugsweg 1 für zugriff auf eina_2 und eord_2
  ref_nb_id          smallint,   -- vz aus kreisprozess für bezugsweg 4 oder wup_id für bezugsweg 1 für zugriff auf eina_2 und eord_2
  kreistyp_gruppe_id char(4) collate 'en-ci', -- kreistyp_gruppe aus marktstamm.
  wg_id              smallint,   -- warengruppe für zugriff auf vz_wup_wg_zu_per
  umrechnungskurs    float       -- kurs_2 für die umrechnung von landeswährung in euro
);

delete from dbp_etl_process.artbew_pv_subset_2;
insert into dbp_etl_process.artbew_pv_subset_2 (mandant_id
                                             ,wup_id
                                             ,lkp_nb_id
                                             ,lkp_art_id
                                             ,lkp_posten_id
                                             ,dat_booking
                                             ,lkp_mwst
                                             ,lkp_mwst_id
                                             ,lkp_wrg
                                             ,lkp_umrechnungskurs
                                             ,promo_fg
                                             ,ean_kasse
                                             ,aktion_id
                                             ,kundenkarte_id
                                             ,kundenkarte_typ_id
                                             ,bonuskauf_id
                                             ,aktion_typ_id
                                             ,konditionsart_id
                                             ,vk_aktion_brutto
                                             ,vk_brutto
                                             ,bonuskauf_id_lb
                                             ,bde_kundenkarte_id
                                             ,bewart_det_id
                                             ,customer_promotion_fg
                                             ,promotion_art
                                             ,betrag_promo_brutto_kdn
                                             ,betrag_promo_brutto_kdp
                                             ,betrag_promo_brutto_null
                                             ,umsatz_brutto_
                                             ,menge_
                                             ,umsatz_promotion_brutto_
                                             ,pv_aktion
                                             ,pv_bby
                                             ,pv_kdn_bby
                                             ,pv_kdp_bby
                                             ,pv_aktion_bby
                                             ,pv_aktion_kdn_bby
                                             ,pv_aktion_kdp_bby)
select mandant_id,
       wup_id,
       lkp_nb_id,
       lkp_art_id,
       lkp_posten_id,
       dat_booking,
       lkp_mwst,
       lkp_mwst_id,
       lkp_wrg,
       lkp_umrechnungskurs,
       promo_fg,
       ean_kasse,
       aktion_id,
       kundenkarte_id,
       kundenkarte_typ_id,
       bonuskauf_id,
       aktion_typ_id,
       konditionsart_id,
       vk_aktion_brutto as vk_aktion_brutto,
       vk_brutto as vk_brutto,
       bonuskauf_id_lb,
       bde_kundenkarte_id,
       888888 as bewart_det_id,
       0 as customer_promotion_fg,
       '' as promotion_art,
       sum(betrag_promo_brutto_kdn) as betrag_promo_brutto_kdn,
       sum(betrag_promo_brutto_kdp) as betrag_promo_brutto_kdp,
       sum(betrag_promo_brutto_null) as betrag_promo_brutto_null,
       sum(umsatz_brutto) as umsatz_brutto_,
       sum(menge) as menge_,
       sum(umsatz_promotion_brutto) as umsatz_promotion_brutto_,
       sum(cast(0 as float)) as pv_aktion,
       sum(cast(0 as float)) as pv_bby,
       sum(cast(0 as float)) as pv_kdn_bby,
       sum(cast(0 as float)) as pv_kdp_bby,
       sum(cast(0 as float)) as pv_aktion_bby,
       sum(cast(0 as float)) as pv_aktion_kdn_bby,
       sum(cast(0 as float)) as pv_aktion_kdp_bby
from (select z.mandant_id,
             z.bon_id,
             z.wup_id,
             z.lkp_nb_id,
             z.lkp_art_id,
             z.lkp_posten_id,
             z.dat_booking,
             z.bon_zeile,
             z.umsatz_brutto,
             z.menge,
             z.lkp_mwst,
             z.lkp_mwst_id,
             z.lkp_wrg,
             z.lkp_umrechnungskurs,
             coalesce(promotion_brutto, 0) as
             umsatz_promotion_brutto,
             case
               when umsatz_promotion_brutto <> 0 and 
                    z.bonuskauf_id is not null and 
                    z.bonuskauf_id <> 0
               then 1
               else 0
             end as promo_fg,
             z.ean_kasse,
             case
               when z.dat_booking >= x.dat and
                    p.aktion_id <> ''
               then p.aktion_id
               else z.aktion_id
             end aktion_id,
             z.kundenkarte_id,
             z.kundenkarte_typ_id,
             z.bonuskauf_id,
             z.aktion_typ_id,
             z.vk_aktion_brutto,
             z.vk_brutto,
             z.betrag_promo_brutto_kdn,
             z.betrag_promo_brutto_kdp,
             z.betrag_promo_brutto_null,
             z.konditionsart_id,
             z.bonuskauf_id_lb,
             z.bde_kundenkarte_id
      from dbp_etl.kmo_artbew_bon_2 z
      join dbp_etl_process.kpos_bon_bby_dates_2 x
        on z.mandant_id = x.mandant_id
      left join (select a.mandant_id,
                        a.bon_id,
                        a.dat_booking,
                        a.bon_zeile,
                        max(coalesce(b.aktion_id, '')) as aktion_id,
                        sum(a.umsatz_brutto) as promotion_brutto
                 from dbp_etl.kmo_artbew_bon_promotion_2 a
                 left join dbp_data.l_bonuskauf_2 b
                   on a.mandant_id = b.mandant_id and 
                      a.bonuskauf_id = b.bonuskauf_id and 
                      a.dat_booking between b.dat_von and b.dat_bis
                 group by 1,2,3,4) p
        on z.mandant_id = p.mandant_id and 
           z.bon_id = p.bon_id and 
           z.dat_booking = p.dat_booking and 
           z.bon_zeile = p.bon_zeile)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
;

-- start bewart_det_id --

execute immediate $$
begin
  let max_cnt integer := (select count(*) from dbp_etl_process.artbew_pv_logic_2 where key_field = 'bewart_det_id' and logic = 'old');
  let counter integer default 0;
  let i integer default 1;
  for i in 1 to max_cnt do
      let statement string := (select statement from dbp_etl_process.artbew_pv_logic_2 where key_field = 'bewart_det_id' and logic = 'old' and key_value = :i);
      execute immediate :statement;
      counter := counter+1;
  end for;
  return counter;
end;
$$;

-- start pv-bbys values --

execute immediate $$
begin
  let max_cnt integer := (select count(*) from dbp_etl_process.artbew_pv_logic_2 where key_field = 'pv_values' and logic = 'old');
  let counter integer default 0;
  let i integer default 1;
  for i in 1 to max_cnt do
      let statement string := (select statement from dbp_etl_process.artbew_pv_logic_2 where key_field = 'pv_values' and logic = 'old' and key_value = :i);
      execute immediate :statement;
      counter := counter+1;
  end for;
  return counter;
end;
$$;

create or replace transient table dbp_etl.artbew_subset2_2 as (
select mandant_id,
       wup_id,
       lkp_nb_id,
       lkp_art_id,
       lkp_posten_id,
       dat_booking,
       lkp_mwst,
       lkp_mwst_id,
       lkp_wrg,
       lkp_umrechnungskurs,
       promo_fg,
       ean_kasse,
       aktion_id,
       sum(umsatz_brutto_) as umsatz_brutto,
       sum(menge_) as menge,
       sum(umsatz_promotion_brutto_) as umsatz_promotion_brutto,
       bewart_det_id,
       sum(pv_aktion) as pv_aktion,
       sum(pv_bby) as pv_bby,
       sum(pv_kdn_bby) as pv_kdn_bby,
       sum(pv_kdp_bby) as pv_kdp_bby,
       sum(pv_aktion_bby) as pv_aktion_bby,
       sum(pv_aktion_kdn_bby) as pv_aktion_kdn_bby,
       sum(pv_aktion_kdp_bby) as pv_aktion_kdp_bby
from dbp_etl_process.artbew_pv_subset_2 l
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,17
);

insert into dbp_etl.artbew_kmo_tmp_2 (mandant_id,
                                    wup_id,
                                    nb_id,
                                    art_id,
                                    gp_id,
                                    einkaufsorganisation_id,
                                    bewart_id,
                                    dat,
                                    aktion_id,
                                    herst_id,
                                    mwst_id,
                                    wrg_2,
                                    posten_id,
                                    bezugsweg_id,
                                    menge,
                                    umsatz_netto,
                                    umsatz_mwst_betrag,
                                    promo_fg,
                                    ean_kasse,
                                    diff_umsatz_netto_konz,
                                    diff_umsatz_mwst_betrag_konz,
                                    bewart_det_id,
                                    pv_aktion,
                                    pv_bby,
                                    pv_kdn_bby,
                                    pv_kdp_bby,
                                    pv_aktion_bby,
                                    pv_aktion_kdn_bby,
                                    pv_aktion_kdp_bby)
select g.mandant_id,
       g.wup_id,
       g.nb_id,
       g.art_id,
       g.gp_id,
       g.einkaufsorganisation_id,
       g.bewart_id,
       g.dat,
       g.aktion_id,
       g.herst_id,
       g.mwst_id,
       g.wrg_2,
       g.posten_id,
       g.bezugsweg_id,
       g.menge,
       g.umsatz_netto,
       g.umsatz_mwst_betrag,
       g.promo_fg,
       g.ean_kasse,
       g.diff_umsatz_netto_konz,
       g.diff_umsatz_mwst_betrag_konz,
       g.bewart_det_id,
       g.pv_aktion,
       g.pv_bby,
       g.pv_kdn_bby,
       g.pv_kdp_bby,
       g.pv_aktion_bby,
       g.pv_aktion_kdn_bby,
       g.pv_aktion_kdp_bby
from (select l.mandant_id as mandant_id,
             l.wup_id as wup_id,
             lkp_nb_id as nb_id,
             lkp_art_id as art_id,
             -1 as gp_id,
             -1 as einkaufsorganisation_id,
             case
               when l.dat_booking >= x.dat 
               then
                 case
                   when trim(l.aktion_id) <> ''
                   then 1002
                   else 1001
                 end
               else coalesce(r.bewart_id, 1001)
             end bewart_id,
             dat_booking as dat,
             case
               when l.dat_booking >= x.dat
               then trim(l.aktion_id)
               else coalesce(r.aktion_id, '')
             end as aktion_id,
             -1 as herst_id,
             lkp_mwst_id as mwst_id,
             lkp_wrg as wrg_2,
             coalesce(lkp_posten_id, ' ') as posten_id,
             0 as bezugsweg_id,
             menge,
             cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as umsatz_brutto_ohne_promo,
             cast(umsatz_brutto * lkp_umrechnungskurs as decimal(20,8)) as umsatz_brutto_ohne_promo_conv,
             cast(umsatz_brutto_ohne_promo/(1+(lkp_mwst/100)) as decimal(20,8)) AS umsatz_netto,
             cast(umsatz_brutto_ohne_promo-umsatz_netto as decimal(20,8)) as umsatz_mwst_betrag,
             promo_fg,
             ean_kasse,
             cast(umsatz_brutto/(1+(lkp_mwst/100)) * lkp_umrechnungskurs  as decimal(20,8)) as diff_umsatz_netto_konz,
             cast(umsatz_brutto_ohne_promo_conv-diff_umsatz_netto_konz as decimal(20,8)) as diff_umsatz_mwst_betrag_konz,
             bewart_det_id,
             cast(pv_aktion as decimal(20,8)) as pv_aktion,
             cast(pv_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as pv_bby,
             cast(pv_kdn_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as pv_kdn_bby,
             cast(pv_kdp_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as pv_kdp_bby,
             cast(pv_aktion_bby as decimal(20,8)) as pv_aktion_bby,
             cast(pv_aktion_kdn_bby as decimal(20,8)) as pv_aktion_kdn_bby,
             cast(pv_aktion_kdp_bby as decimal(20,8)) as pv_aktion_kdp_bby
      from dbp_etl.artbew_subset2_2 l
      join dbp_etl_process.kpos_bon_bby_dates_2 x
        on l.mandant_id = x.mandant_id
      left join (select a.*,
                        1 as conv_fg
                 from dbp_data.mandant_wrg_zu_per_2 a
                 where a.von_wrg_id is not null and
                       a.wrg_id <> a.von_wrg_id and
                       current_date between a.dat_von and a.dat_bis) y
        on l.mandant_id = y.mandant_id and
           l.lkp_wrg = y.wrg_id
      left join dbp_etl_process.marktabschriften_stamm_2 r
        on l.mandant_id = r.mandant_id and 
           l.lkp_art_id = r.art_id and 
           l.wup_id = r.wup_id and 
           l.lkp_nb_id = r.nb_id and 
           l.dat_booking = r.dat) g
;

delete from dbp_data.artbew_2 a
where a.dat in (select dat from dbp_etl.kmo_artbew_bon_dat_2) and 
     (a.mandant_id, a.wup_id, a.dat) in (select mandant_id,wup_id,dat from dbp_etl.artbew_kmo_tmp_2) and
      a.bewart_id <> 1010
;

delete from dbp_data.artbew_promotion_zu_2 a
where a.dat in (select dat from dbp_etl.kmo_artbew_bon_dat_2) and 
     (a.mandant_id, a.wup_id, a.dat) in (select mandant_id,wup_id,dat from dbp_etl.artbew_kmo_tmp_2 where promo_fg = 1) and
      a.konditionsart_id <> 'RB19'
;

insert into dbp_data.artbew_2 (mandant_id
                            ,wup_id
                            ,nb_id
                            ,art_id
                            ,promo_fg
                            ,gp_id
                            ,einkaufsorganisation_id
                            ,bewart_id
                            ,dat
                            ,aktion_id
                            ,herst_id
                            ,mwst_id
                            ,wrg_2
                            ,posten_id
                            ,bezugsweg_id
                            ,menge
                            ,umsatz_netto
                            ,umsatz_mwst_betrag
                            ,ek_brutto
                            ,ek_netto
                            ,ek_nettonetto
                            ,ek_kal_basis
                            ,ek_mep
                            ,einstandspreis
                            ,logkostenzuschlag
                            ,ek_netto_bnk
                            ,ek_netto_bnk_sachk
                            ,ean_kasse
                            ,diff_umsatz_netto_konz
                            ,diff_umsatz_mwst_betrag_konz
                            ,bewart_det_id
                            ,pv_aktion
                            ,pv_bby
                            ,pv_kdn_bby
                            ,pv_kdp_bby
                            ,pv_aktion_bby  
                            ,pv_aktion_kdn_bby
                            ,pv_aktion_kdp_bby 
                            ,td_insert
                            ,td_update
                            ,ek_mep_vor_fwu
                            ,ek_mep_vor_fwu_konz
                            ,bonusbasis
                            ,bonusbasis_konz)
select mandant_id
      ,wup_id
      ,nb_id
      ,art_id
      ,promo_fg
      ,gp_id
      ,einkaufsorganisation_id
      ,bewart_id
      ,dat
      ,aktion_id
      ,herst_id
      ,mwst_id
      ,wrg_2
      ,posten_id
      ,bezugsweg_id
      ,menge_sum
      ,umsatz_netto_sum
      ,umsatz_mwst_betrag_sum
      ,zero_enc as ek_brutto
      ,zero_enc as ek_netto
      ,zero_enc as ek_nettonetto
      ,zero_enc as ek_kal_basis
      ,zero_enc as ek_mep
      ,zero_enc as einstandspreis
      ,0 as logkostenzuschlag
      ,zero_enc as ek_netto_bnk
      ,zero_enc as ek_netto_bnk_sachk
      ,ean_kasse
      ,diff_umsatz_netto_konz
      ,diff_umsatz_mwst_betrag_konz
      ,bewart_det_id
      ,pv_aktion
      ,pv_bby
      ,pv_kdn_bby
      ,pv_kdp_bby
      ,pv_aktion_bby  
      ,pv_aktion_kdn_bby
      ,pv_aktion_kdp_bby   
      ,current_timestamp as td_insert
      ,current_timestamp as td_update
      ,0 as ek_mep_vor_fwu
      ,null as ek_mep_vor_fwu_konz
      ,0 as bonusbasis
      ,null as bonusbasis_konz
from (select mandant_id
            ,wup_id
            ,nb_id
            ,art_id
            ,promo_fg
            ,gp_id
            ,einkaufsorganisation_id
            ,bewart_id
            ,dat
            ,aktion_id
            ,herst_id
            ,mwst_id
            ,wrg_2
            ,posten_id
            ,bezugsweg_id
            ,sum(menge) as menge_sum
            ,sum(umsatz_netto) as umsatz_netto_sum
            ,sum(umsatz_mwst_betrag) as umsatz_mwst_betrag_sum
            ,0 as zero_enc
            ,ean_kasse
            ,sum(diff_umsatz_netto_konz) diff_umsatz_netto_konz
            ,sum(diff_umsatz_mwst_betrag_konz) diff_umsatz_mwst_betrag_konz 
            ,bewart_det_id
            ,pv_aktion
            ,pv_bby
            ,pv_kdn_bby
            ,pv_kdp_bby
            ,pv_aktion_bby  
            ,pv_aktion_kdn_bby
            ,pv_aktion_kdp_bby 	
      from dbp_etl.artbew_kmo_tmp_2
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,19,20,23,24,25,26,27,28,29,30) a
;

delete from dbp_etl.kmo_artbew_bon_promotion_2
where coalesce(umsatz_brutto, 0) = 0
;

insert into dbp_data.artbew_promotion_zu_2 (mandant_id
                                         ,wup_id
                                         ,nb_id
                                         ,art_id
                                         ,dat
                                         ,bonuskauf_id
                                         ,konditionsart_id
                                         ,wrg_id
                                         ,betrag_promo_netto
                                         ,betrag_mwst
                                         ,umrechnungskurs
                                         ,system_id
                                         ,ean_kasse
                                         ,menge_promo
                                         ,umsatz_promo_netto
                                         ,umsatz_mwst)
select mandant_id
      ,wup_id
      ,nb_id
      ,art_id
      ,dat
      ,bonuskauf_id
      ,konditionsart_id
      ,wrg_id
      ,sum(coalesce(betrag_promo_netto,0))
      ,sum(betrag_mwst)
      ,umrechnungskurs
      ,system_id
      ,ean_kasse
      ,sum(coalesce(menge_promo,0))
      ,sum(coalesce(umsatz_promo_netto,0))
      ,sum(coalesce(umsatz_mwst,0))
from (select l.mandant_id as mandant_id
            ,l.wup_id as wup_id
            ,l.lkp_nb_id as nb_id
            ,l.lkp_art_id as art_id
            ,l.dat_booking as dat
            ,p.bonuskauf_id
            ,p.konditionsart_id
            ,l.lkp_wrg as wrg_id
            ,cast(p.umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as umsatz_brutto_conv
            ,cast(p.umsatz_promo_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as umsatz_promo_brutto_conv
            ,cast(umsatz_brutto_conv / (1+(lkp_mwst/100)) as decimal(20,8)) as betrag_promo_netto
            ,cast(umsatz_brutto_conv - betrag_promo_netto as decimal(20,8)) as betrag_mwst
            ,lkp_umrechnungskurs as umrechnungskurs
            ,coalesce(k.system_id, 0) as system_id
            ,l.ean_kasse
            ,menge_promo as menge_promo
            ,cast(umsatz_promo_brutto_conv / (1+(lkp_mwst/100)) as decimal(20,8)) as umsatz_promo_netto
            ,cast(umsatz_promo_brutto_conv - umsatz_promo_netto as decimal(20,8)) as umsatz_mwst
      from dbp_etl.kmo_artbew_bon_2 l
      left join (select a.*,
                  1 as conv_fg
           from dbp_data.mandant_wrg_zu_per_2 a
           where a.von_wrg_id is not null and
                 a.wrg_id <> a.von_wrg_id and
                 current_date between a.dat_von and a.dat_bis) y
        on l.mandant_id = y.mandant_id and
           l.lkp_wrg = y.wrg_id
      join dbp_etl.kmo_artbew_bon_promotion_2 p
        on l.mandant_id = p.mandant_id and 
           l.bon_id = p.bon_id and 
           l.dat_booking = p.dat_booking and 
           l.bon_zeile = p.bon_zeile
      left join dbp_data.l_konditionsart_2 k
        on p.mandant_id = k.mandant_id and 
           p.konditionsart_id = k.konditionsart_id) p
group by 1,2,3,4,5,6,7,8,11,12,13
;

insert into dbp_data.artbew_agg_wt_2 (mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,dat)
select mandant_id
      ,wup_id
      ,nb_id
      ,dat
from dbp_etl.artbew_kmo_tmp_2
where (mandant_id,wup_id,nb_id,dat) not in (select mandant_id,wup_id,nb_id,dat from dbp_data.artbew_agg_wt_2)
group by 1,2,3,4
;

insert into dbp_etl_process.uapc_artbew_delta_2 (mandant_id
                                              ,wup_id
                                              ,dat
                                              ,row_id
                                              ,td_insert
                                              ,td_update)
select mandant_id,
       wup_id,
       dat,
      (row_number() over (order by mandant_id,wup_id,dat) + coalesce((select max(row_id) from dbp_etl_process.uapc_artbew_delta_2),0)) as row_id,
       current_timestamp as td_insert,
       current_timestamp as td_update
from dbp_etl.artbew_kmo_tmp_2
group by 1,2,3
;

update dbp_data.wupcal_2

set datenlieferung_artbew = 1
   ,dat_extrakt_umsatz = current_date
   ,umsatz_brutto_ods_verkauf = (umsatz_netto_sum + umsatz_mwst_betrag_sum)
   ,wrg_id = wrg_
   ,td_update = CURRENT_TIMESTAMP
from (select mandant_id mandant_id_
            ,wup_id wup_id_
            ,nb_id nb_id_
            ,dat dat_
            ,wrg_2 wrg_
            ,sum(umsatz_netto) as umsatz_netto_sum
            ,sum(umsatz_mwst_betrag) as umsatz_mwst_betrag_sum
      from dbp_etl.artbew_kmo_tmp_2
      group by 1,2,3,4,5 ) x1

where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      nb_id = nb_id_ and 
      dat = dat_
;

update dbp_data.wupcal_2

set bonanzahl = anz_kunden_
   ,bonanzahl_imbiss = anz_kunden_imbiss_
   ,umsatz_brutto_ods_kassenabschluss = umsatz_brutto_ods_kassenabschluss_
   ,datenlieferung_bonanzahl = 1
   ,wrg_id = wrg_id_

from (select k.mandant_id mandant_id_,
             k.wup_id wup_id_,
             k.bon_dat dat_,
             sum(k.anz_kunden)-sum(k.anz_kunden_imbiss) anz_kunden_,
             sum(k.anz_kunden_imbiss) anz_kunden_imbiss_,
             sum(k.umsatz_brutto * coalesce(x.umrech,1)) umsatz_brutto_ods_kassenabschluss_,
             min(x.wrg_id) wrg_id_
      from dbp_ods.ods_bon_kassenabschluss_2 k
      join dbp_data.mandant_wrg_zu_per_2 wrg_2 
        on k.mandant_id = wrg.mandant_id
        and k.bon_dat between wrg.dat_von and wrg.dat_bis
      join dbp_data.mandant_2 y
        on k.mandant_id = y.mandant_id
      left join (select *,
                        cast(1 as float)/cast(umrechnungskurs as float) as umrech
                 from dbp_data.mandant_wrg_zu_per_2
                 where von_wrg_id is not null and
                       wrg_id <> von_wrg_id and
                       current_date between dat_von and dat_bis) x
        on k.mandant_id = x.mandant_id and
           wrg.wrg_id = x.von_wrg_id
      join (select mandant_id,
                   wup_id,
                   dat 
            from dbp_etl.artbew_kmo_tmp_2
            group by 1,2,3) a
        on a.mandant_id = k.mandant_id and 
           a.wup_id = k.wup_id and 
           a.dat = k.bon_dat
      group by 1,2,3) s 

where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      dat = dat_
;

/* 
Jetzt kann nachträglich noch eine_2 Kassenabschluss kommen.
Wir benötigen dann die Summe der beiden Werte in der wupcal_2 Spalte.
*/

create or replace table dbp_etl.wupcal_correction_2 as 
    select distinct 
       mandant_id, 
       wup_id, 
       bon_dat, 
       --sum(umsatz_brutto) AS
       --umsatz_brutto 
    from dbp_ods.ods_bon_kassenabschluss_2 
        where (mandant_id, wup_id, bon_dat) in 
         (
          select  mandant_id, wup_id,bon_dat from 
            (
               select mandant_id, wup_id,bon_dat, count(bon_id) 
                     from dbp_ods.ods_bon_kassenabschluss_2
                        where
                          mandant_id > 1 and
                          bon_dat between current_date - 7 and current_date
                        group by all
                        having count(1) > 1
             )
          ) 
    --group by all
    order by mandant_id, wup_id, bon_dat desc
;

update dbp_data.wupcal_2
set bonanzahl = anz_kunden_
   ,bonanzahl_imbiss = anz_kunden_imbiss_
   ,umsatz_brutto_ods_kassenabschluss = umsatz_brutto_ods_kassenabschluss_
   ,datenlieferung_bonanzahl = 1
   ,wrg_id = wrg_id_
from (select k.mandant_id mandant_id_,
             k.wup_id wup_id_,
             k.bon_dat dat_,
             sum(k.anz_kunden)-sum(k.anz_kunden_imbiss) anz_kunden_,
             sum(k.anz_kunden_imbiss) anz_kunden_imbiss_,
             sum(k.umsatz_brutto * coalesce(x.umrech,1)) umsatz_brutto_ods_kassenabschluss_,
             min(x.wrg_id) wrg_id_
      from dbp_ods.ods_bon_kassenabschluss_2 k
      join dbp_data.mandant_wrg_zu_per_2 wrg_2 
        on k.mandant_id = wrg.mandant_id
        and k.bon_dat between wrg.dat_von and wrg.dat_bis
      join dbp_data.mandant_2 y
        on k.mandant_id = y.mandant_id
      left join (select *,
                        cast(1 as float)/cast(umrechnungskurs as float) as umrech
                 from dbp_data.mandant_wrg_zu_per_2
                 where von_wrg_id is not null and
                       wrg_id <> von_wrg_id and
                       current_date between dat_von and dat_bis) x
        on k.mandant_id = x.mandant_id and
           wrg.wrg_id = x.von_wrg_id
      join (select mandant_id,
                   wup_id,
                   bon_dat 
            from dbp_etl.wupcal_correction_2
            group by 1,2,3) a
        on a.mandant_id = k.mandant_id and 
           a.wup_id = k.wup_id and 
           a.bon_dat = k.bon_dat
      group by 1,2,3) s 
where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      dat = dat_
;



update dbp_data.wup_2 set kassentyp  = 'KPO'
where (mandant_id,nb_id,wup_id) in (select mandant_id,nb_id,wup_id from dbp_etl.artbew_kmo_tmp_2)
;

insert into dbp_etl.kmo_wpuums_art_gp_wup_zu_2 (mandant_id
                                             ,wup_id
                                             ,nb_id
                                             ,art_id
                                             ,dat
                                             ,bezugsweg_id
                                             ,anz_ek_infosatz
                                             ,anz_ek_orderbuch
                                             ,bq_gp_id
                                             ,bq_ekorg
                                             ,bq_findung_id
                                             ,regel_gp_id
                                             ,regel_ekorg
                                             ,ref_wup_id
                                             ,ref_nb_id
                                             ,wg_id
                                             ,kreistyp_gruppe_id
                                             ,umrechnungskurs)
select mandant_id
      ,wup_id
      ,lkp_nb_id
      ,lkp_art_id
      ,dat_booking
      ,0 as bezugsweg_id
      ,0 as anz_ek_infosatz
      ,0 as anz_ek_orderbuch
      ,0 as bq_gp_id
      ,0 as bq_ekorg
      ,0 as bq_findung_id
      ,0 as regel_gp_id
      ,0 as regel_ekorg
      ,0 as ref_wup_id
      ,0 as ref_nb_id
      ,0 as wg_id
      ,'' as kreistyp_gruppe_id
      ,max(lkp_umrechnungskurs)
from dbp_etl.kmo_artbew_bon_2 a
where (mandant_id,wup_id,lkp_nb_id,lkp_art_id,dat_booking) not in (select mandant_id,wup_id,nb_id,art_id,dat from dbp_etl.kmo_wpuums_art_gp_wup_zu_2)
group by 1,2,3,4,5
;

update dbp_ods.bon_load_status_2 set artbew_fg = 1
where xml_name in (select xml_name from dbp_etl.kmo_artbew_bon_delta_2)
;

-- crm_kartebew_2

insert into dbp_etl.artbew_kmo_tmp_crm_2 (mandant_id
                                       ,wup_id
                                       ,nb_id
                                       ,art_id
                                       ,gp_id
                                       ,einkaufsorganisation_id
                                       ,bewart_id
                                       ,dat
                                       ,aktion_id
                                       ,herst_id
                                       ,mwst_id
                                       ,wrg_2
                                       ,posten_id
                                       ,bezugsweg_id
                                       ,menge
                                       ,umsatz_netto
                                       ,umsatz_mwst_betrag
                                       ,promo_fg
                                       ,ean_kasse
                                       ,diff_umsatz_netto_konz
                                       ,diff_umsatz_mwst_betrag_konz
                                       ,kundenkarte_id
                                       ,bon_id)
select mandant_id
      ,wup_id
      ,nb_id
      ,art_id
      ,gp_id
      ,einkaufsorganisation_id
      ,bewart_id
      ,dat
      ,aktion_id
      ,herst_id
      ,mwst_id
      ,wrg_2
      ,posten_id
      ,bezugsweg_id
      ,menge
      ,umsatz_netto
      ,umsatz_mwst_betrag
      ,promo_fg
      ,ean_kasse
      ,diff_umsatz_netto_konz
      ,diff_umsatz_mwst_betrag_konz
      ,kundenkarte_id
      ,bon_id
from (select l.mandant_id as mandant_id
            ,l.wup_id as wup_id
            ,lkp_nb_id as nb_id
            ,lkp_art_id as art_id
            ,-1 as gp_id
            ,-1 as einkaufsorganisation_id
            ,case
               when l.dat_booking >= x.dat 
               then
                 case
                   when trim(l.aktion_id) <> ''
                   then 1002
                   else 1001
                 end
               else coalesce(r.bewart_id, 1001)
             end bewart_id
            ,dat_booking as dat
            ,case
               when l.dat_booking >= x.dat
               then trim(l.aktion_id)
               else coalesce(r.aktion_id, '')
             end as aktion_id
            ,-1 as herst_id
            ,lkp_mwst_id as mwst_id
            ,lkp_wrg as wrg_2
            ,coalesce(lkp_posten_id, ' ') as posten_id
            ,0 as bezugsweg_id
            ,menge_ as menge
            ,cast(umsatz_brutto_ * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as decimal(20,8)) as umsatz_brutto_ohne_promo
            ,cast(umsatz_brutto_ * lkp_umrechnungskurs as decimal(20,8)) as umsatz_brutto_ohne_promo_conv
            ,cast(umsatz_brutto_ohne_promo / (1+(lkp_mwst/100)) as decimal(20,8)) as umsatz_netto
            ,cast(umsatz_brutto_ohne_promo - umsatz_netto  as decimal(20,8)) as umsatz_mwst_betrag
            ,promo_fg
            ,ean_kasse
            ,lkp_umrechnungskurs as umrechnungskurs
            ,cast((cast(umsatz_brutto_/(1+(lkp_mwst/100)) as decimal(18, 4))) * lkp_umrechnungskurs as decimal(20,8)) as diff_umsatz_netto_konz
            ,cast(umsatz_brutto_ohne_promo_conv-diff_umsatz_netto_konz as decimal(20,8)) as diff_umsatz_mwst_betrag_konz
            ,kundenkarte_id
            ,bon_id
      from (select mandant_id
                  ,wup_id
                  ,lkp_nb_id
                  ,lkp_art_id
                  ,lkp_posten_id
                  ,dat_booking
                  ,lkp_mwst
                  ,lkp_mwst_id
                  ,lkp_wrg
                  ,lkp_umrechnungskurs
                  ,promo_fg
                  ,ean_kasse
                  ,aktion_id
                  ,kundenkarte_id
                  ,bon_id
                  ,sum(umsatz_brutto) as umsatz_brutto_
                  ,sum(menge) as menge_
                  ,sum(umsatz_promotion_brutto) as umsatz_promotion_brutto_
            from (select z.mandant_id
                        ,z.bon_id
                        ,z.wup_id
                        ,z.lkp_nb_id
                        ,z.lkp_art_id
                        ,z.lkp_posten_id
                        ,z.dat_booking
                        ,z.bon_zeile
                        ,z.umsatz_brutto
                        ,z.menge
                        ,z.lkp_mwst
                        ,z.lkp_mwst_id
                        ,z.lkp_wrg
                        ,z.lkp_umrechnungskurs
                        ,coalesce(promotion_brutto, 0) as umsatz_promotion_brutto
                        ,case 
                           when umsatz_promotion_brutto <> 0
                           then 1
                           else 0
                         end as promo_fg
                        ,z.ean_kasse
                        ,case
                           when z.dat_booking >= x.dat and
                                p.aktion_id <> ''
                           then p.aktion_id
                           else z.aktion_id
                         end aktion_id
                        ,z.kundenkarte_id
                  from dbp_etl.kmo_artbew_bon_2 z
                  join dbp_etl_process.kpos_bon_bby_dates_2 x
                    on z.mandant_id = x.mandant_id
                  left join (select a.mandant_id
                                   ,a.bon_id
                                   ,a.dat_booking
                                   ,a.bon_zeile
                                   ,max(coalesce(b.aktion_id,'')) as aktion_id
                                   ,sum(a.umsatz_brutto) as promotion_brutto
                             from dbp_etl.kmo_artbew_bon_promotion_2 a
                             left join dbp_data.l_bonuskauf_2 b
                               on a.mandant_id = b.mandant_id and
                                  a.bonuskauf_id = b.bonuskauf_id and
                                  a.dat_booking between b.dat_von and b.dat_bis
                             group by 1,2,3,4) p
                    on z.mandant_id = p.mandant_id and 
                       z.bon_id = p.bon_id and 
                       z.dat_booking = p.dat_booking and 
                       z.bon_zeile = p.bon_zeile
                  where ((z.mandant_id in (2,4,7,6,5,8)) or
                         (z.mandant_id in (3) and z.kundenkarte_typ_id = 2))) z
            group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) l
      join dbp_etl_process.kpos_bon_bby_dates_2 x
        on l.mandant_id = x.mandant_id
      left join (select *,
                        1 as conv_fg
                 from dbp_data.mandant_wrg_zu_per_2
                 where von_wrg_id is not null and
                       wrg_id <> von_wrg_id and
                       current_date between dat_von and dat_bis) y
        on l.mandant_id = y.mandant_id and
           l.lkp_wrg = y.wrg_id
      left join dbp_etl_process.marktabschriften_stamm_2 r
        on l.mandant_id = r.mandant_id and 
           l.lkp_art_id = r.art_id and 
           l.wup_id = r.wup_id and 
           l.lkp_nb_id = r.nb_id and 
           l.dat_booking = r.dat) a
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
;

delete from dbp_data.crm_kartebew_2 a
where a.dat in (select distinct dat from dbp_etl.kmo_artbew_bon_dat_2) and 
     (a.mandant_id,a.wup_id,a.dat) in (select distinct mandant_id,wup_id,dat from dbp_etl.artbew_kmo_tmp_crm_2)
;

insert into dbp_data.crm_kartebew_2 (mandant_id
                                  ,wup_id
                                  ,nb_id
                                  ,kundenkarte_id
                                  ,dat
                                  ,wrg_id
                                  ,umsatz_netto_sa
                                  ,umsatz_netto_af
                                  ,umsatz_brutto_sa
                                  ,umsatz_brutto_af
                                  ,anz_bons)
select aktc.mandant_id,
       aktc.wup_id,
       aktc.nb_id,
       aktc.kundenkarte_id,
       aktc.dat,
       aktc.wrg_2,
       sum(case when aktc.bewart_id = 1002 then aktc.umsatz_netto else 0 end) as umsatz_netto_sa,
       sum(case when aktc.bewart_id = 1001 then aktc.umsatz_netto else 0 end) as umsatz_netto_af,
       sum(case when aktc.bewart_id = 1002 then aktc.umsatz_netto + aktc.umsatz_mwst_betrag else 0 end) as umsatz_brutto_sa,
       sum(case when aktc.bewart_id = 1001 then aktc.umsatz_netto + aktc.umsatz_mwst_betrag else 0 end) as umsatz_brutto_af,
       count(distinct aktc.bon_id) as anz_bons
from dbp_etl.artbew_kmo_tmp_crm_2 aktc
left join dbp_data.bewart_det_ecommerce_2 bde
  on aktc.mandant_id = bde.mandant_id and 
     aktc.kundenkarte_id = bde.kundenkarte_id
where aktc.kundenkarte_id is not null and 
      bde.kundenkarte_id is null
group by 1,2,3,4,5,6
;

drop table if exists dbp_etl.artbew_kmo_tmp_2;
drop table if exists dbp_etl.artbew_kmo_tmp_crm_2;
drop table if exists dbp_etl.kmo_artbew_bon_aktion_relevant_2;
