create or replace volatile table _track1 as (
select eket.mandant_id,
       eket.dat_lief_wunsch,
       eket.best_beleg_id,
       eket.best_beleg_pos_id
from dbp_data.lief_einteilung eket
left join dbp_data.besch_best_det ekpo 
  on eket.mandant_id = ekpo.mandant_id and 
     eket.best_beleg_id = ekpo.best_beleg_id and 
     eket.best_beleg_pos_id = ekpo.best_beleg_pos_id
where eket.mandant_id = 1 and 
      eket.dat_lief_wunsch >= current_date and
      ekpo.loesch_fg is null
group by 1,2,3,4
);

create or replace table dbp_etl.besch_best_det_eket_tmp (
    mandant_id                byteint not null,
    best_beleg_id             decimal(18,0) not null,
    best_beleg_pos_id         integer not null,
    art_id                    integer,
    wup_id                    integer,
    nb_id                     smallint,
    lagerort_id               char(4) ,
    loesch_fg                 byteint,
    menge_best_bme            decimal(18,3),
    selbstabhol_fg            byteint,
    best_preis_menge_einh_id  char(3) ,
    best_menge_einh_id        char(3) ,
    menge_best_kolli          decimal(18,3),
    menge_best_palette        decimal(18,3),
    endlief_fg                byteint,
    dat_aenderung             date,
    kunde_id                  varchar(10),
    dat_best_beleg            date,
    wg_verkett_id             smallint,
    fremd_lagerort_id         char(4),
    ean_id                    decimal(26,0),
    betrag_kond_zw_sum2       decimal(18,4),
    pos_kostenlos_fg          byteint, 
    betrag_pos_netto          decimal(18,4),
    betrag_pos_netto_best_wrg decimal(18,4),
    wrg_id                    char(3) ,
    betrag_best               decimal(18,4),
    gp_id                     integer,
    ek_netto_bnk              decimal(18,4),
    ek_netto                  decimal(18,4),
    komponentenmenge          decimal(18,4), 
    kopf_wup_id               integer,
    gp_teilsortiment_id       varchar(10) collate 'en-ci',
    zentral_best_fg           byteint  ,
    dat_best_beleg_orig       date,
    anforderer_name           varchar(20) collate 'en-ci'
);

insert into dbp_etl.besch_best_det_eket_tmp
(
  mandant_id
, best_beleg_id
, best_beleg_pos_id
, art_id
, wup_id
, nb_id
, lagerort_id
, loesch_fg
, menge_best_bme
, selbstabhol_fg
, best_preis_menge_einh_id
, best_menge_einh_id
, menge_best_kolli
, menge_best_palette
, endlief_fg
, dat_aenderung
, kunde_id
, dat_best_beleg
, wg_verkett_id
, fremd_lagerort_id
, ean_id
, betrag_kond_zw_sum2
, pos_kostenlos_fg
, betrag_pos_netto
, betrag_pos_netto_best_wrg
, wrg_id
, betrag_best
, gp_id
, ek_netto_bnk
, ek_netto
, komponentenmenge
, kopf_wup_id
, gp_teilsortiment_id
, zentral_best_fg
, dat_best_beleg_orig
, anforderer_name

)
select
  ekpo.mandant_id
, ekpo.best_beleg_id
, ekpo.best_beleg_pos_id
, ekpo.art_id
, ekpo.wup_id
, ekpo.nb_id
, ekpo.lagerort_id
, ekpo.loesch_fg
, ekpo.menge_best_bme
, ekpo.selbstabhol_fg
, ekpo.best_preis_menge_einh_id
, ekpo.best_menge_einh_id
, ekpo.menge_best_kolli
, ekpo.menge_best_palette
, ekpo.endlief_fg
, ekpo.dat_aenderung
, ekpo.kunde_id
, y.dat_best_beleg
, ekpo.wg_verkett_id
, ekpo.fremd_lagerort_id
, ekpo.ean_id
, ekpo.betrag_kond_zw_sum2
, ekpo.pos_kostenlos_fg
, ekpo.betrag_pos_netto
, ekpo.betrag_pos_netto_best_wrg 
, ekpo.wrg_id
, ekpo.betrag_best
, gp.gp_id
 ,case when (ekpo.nb_id_ber in(99, -111))
         then /* zentral */
           coalesce(agw.ek_netto_bnk,
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
                     --0)
		     (0 )
           )
         else /* dezentral (lager kann nicht richtig sein) */
           coalesce(agw9.ek_netto_bnk,
                     agw10.ek_netto_bnk,
                     agw11.ek_netto_bnk,
                     agw12.ek_netto_bnk,
                     agw2.ek_netto_bnk,
                     agw4.ek_netto_bnk,
                     agw6.ek_netto_bnk,
                     agw8.ek_netto_bnk,
                     --0)
		     (0 )
          )
   end as ek_netto_bnk_   
   
  ,case when (ekpo.nb_id_ber in (99, -111))
         then /* zentral */
           coalesce(agw.ek_netto,
                     agw2.ek_netto,
                     agw3.ek_netto,
                     agw4.ek_netto,
                     agw5.ek_netto,
                     agw6.ek_netto,
                     agw7.ek_netto,
                     agw8.ek_netto,
                     agw9.ek_netto,
                     agw10.ek_netto,
                     agw11.ek_netto,
                     agw12.ek_netto,
                     --0)
		     (0 ) 
           )
         else /* dezentral (lager kann nicht richtig sein) */
           coalesce(agw9.ek_netto,
                     agw10.ek_netto,
                     agw11.ek_netto,
                     agw12.ek_netto,
                     agw2.ek_netto,
                     agw4.ek_netto,
                     agw6.ek_netto,
                     agw8.ek_netto,
                    -- 0)
		     (0 ) 
           )
   end as ek_netto_   
   
  ,case when (ekpo.nb_id_ber  in(99,-111))
       then /* zentral */
         coalesce(agw.komponentenmenge,
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
       else /* dezentral (lager kann nicht richtig sein) */
         coalesce(agw9.komponentenmenge,
                   agw10.komponentenmenge,
                   agw11.komponentenmenge,
                   agw12.komponentenmenge,
                   agw2.komponentenmenge,
                   agw4.komponentenmenge,
                   agw6.komponentenmenge,
                   agw8.komponentenmenge,
                   1
         )
   end	 as komponentenmenge_
, ekpo.kopf_wup_id  
, ekpo.gp_teilsortiment_id
, ekpo.zentral_best_fg
, x.dat_lief_wunsch
, ekpo.anforderer_name

from dbp_etl.de_ekpo_eket ekpo

join dbp_data.besch_best y
  on ekpo.mandant_id = y.mandant_id and
     ekpo.best_beleg_id = y.best_beleg_id

join _track1 x
  on ekpo.mandant_id = x.mandant_id and
     ekpo.best_beleg_id = x.best_beleg_id and
     ekpo.best_beleg_pos_id = x.best_beleg_pos_id

---ek_preis holen

left outer join dbp_data.art_gp_zu_per gp
   on gp.art_id = ekpo.art_id and gp.mandant_id = ekpo.mandant_id
  and ekpo.dat_best_beleg between gp.dat_von and gp.dat_bis

/*
zentral
lager       richtig
datum       richtig
lieferant   richtig
*/

left outer join dbp_etl.ek01_ekpo agw
   on ekpo.art_id = agw.art_id
  and ekpo.dat_best_beleg between agw.dat_von and agw.dat_bis  /* richtiges datum */
  and ekpo.werks_ber = agw.wup_id                            /* richtiges lager */
  and gp.gp_id = agw.gp_id                             /* richtiger lieferant */

/*
zentral
lager       falsch
datum       richtig
lieferant   richtig
*/

left outer join dbp_etl.ek02_ekpo agw2
   on ekpo.art_id = agw2.art_id
  and ekpo.dat_best_beleg between agw2.dat_von and agw2.dat_bis  /* richtiges datum */
  and gp.gp_id = agw2.gp_id                              /* richtiger lieferant */

/*
zentral
lager       richtig
datum       falsch
lieferant   richtig
*/

left outer join dbp_etl.ek03_ekpo agw3
   on ekpo.art_id = agw3.art_id
  and ekpo.werks_ber = agw3.wup_id                            /* richtiges lager */
  and gp.gp_id = agw3.gp_id                             /* richtiger lieferant */

/*
zentral
lager       falsch
datum       falsch
lieferant   richtig
*/

left outer join dbp_etl.ek04_ekpo agw4
   on ekpo.art_id = agw4.art_id
  and gp.gp_id = agw4.gp_id                           /* richtiger lieferant */

/*
zentral
lager       richtig
datum       richtig
lieferant   falsch
*/

left outer join dbp_etl.ek05_ekpo agw5
   on ekpo.art_id = agw5.art_id
  and ekpo.dat_best_beleg between agw5.dat_von and agw5.dat_bis  /* richtiges datum */
  and ekpo.werks_ber = agw5.wup_id                             /* richtiges lager */

/*
zentral
lager       falsch
datum       richtig
lieferant   falsch
*/

left outer join dbp_etl.ek06_ekpo agw6
   on ekpo.art_id = agw6.art_id
  and ekpo.dat_best_beleg between agw6.dat_von and agw6.dat_bis   /* richtiges datum */

/*
zentral
lager       richtig
datum       falsch
lieferant   falsch
*/

left outer join dbp_etl.ek07_ekpo agw7
   on ekpo.art_id = agw7.art_id
  and ekpo.werks_ber = agw7.wup_id                     /* richtiges lager */

/*
zentral
lager       falsch
datum       falsch
lieferant   falsch
*/

left outer join dbp_etl.ek08_ekpo agw8
   on ekpo.art_id = agw8.art_id

/*
dezentral
lager       -1
datum       richtig
lieferant   richtig
*/

left outer join dbp_etl.ek09_ekpo agw9
   on ekpo.art_id = agw9.art_id
  and gp.gp_id = agw9.gp_id                              /* richtiger lieferant */
  and ekpo.dat_best_beleg between agw9.dat_von and agw9.dat_bis  /* richtiges datum */

/*
dezentral
lager       -1
datum       falsch
lieferant   richtig
*/

left outer join dbp_etl.ek10_ekpo agw10
   on ekpo.art_id = agw10.art_id
  and gp.gp_id = agw10.gp_id                        /* richtiger lieferant */

/*
dezentral
lager       -1
datum       richtig
lieferant   falsch
*/

left outer join dbp_etl.ek11_ekpo agw11
   on ekpo.art_id = agw11.art_id
  and ekpo.dat_best_beleg between agw11.dat_von and agw11.dat_bis         /* richtiges datum */


/*
dezentral
lager       -1
datum       falsch
lieferant   falsch
*/

left outer join dbp_etl.ek12_ekpo agw12
   on ekpo.art_id = agw12.art_id

qualify row_number() over (partition by ekpo.mandant_id,ekpo.best_beleg_id,ekpo.best_beleg_pos_id order by cast((ek_netto_bnk_ ) as decimal(18,4)) desc, komponentenmenge_ desc) = 1
;

create or replace volatile table _ekpo_eket as (
select
	  t.mandant_id
	, t.best_beleg_id
	, t.best_beleg_pos_id
	, t.art_id
	, t.wup_id
	, t.nb_id
	, t.lagerort_id
	, t.loesch_fg
	, cast(t.menge_best_kolli / (coalesce(aukolli.umrech_faktor , aukolli_alternativ.umrech_faktor, 1))
	  as decimal(18,3)) as  menge_best_neu
	, t.selbstabhol_fg
	, t.best_preis_menge_einh_id
	, t.best_menge_einh_id
	, menge_best_kolli 
	,
	      (case	
		when	aupalette.umrech_faktor is null
		then cast(menge_best_neu as decimal(18,3))
		else cast( ( cast(menge_best_neu as decimal (18,3)) 
			     *
			     aupalette.umrech_faktor  )
		as decimal(18,3) )
	       end) as menge_best_palette
	, t.endlief_fg
	, t.dat_aenderung
	, t.kunde_id
	, t.dat_best_beleg
	, t.ean_id
	, t.betrag_kond_zw_sum2
	, t.pos_kostenlos_fg
        , t.betrag_pos_netto
	, t.betrag_pos_netto_best_wrg
	, t.wrg_id
	, (                                                                         
			cast(menge_best_neu *                                                                 
			cast(cast(  (t.ek_netto_bnk ) as decimal(18,4))
			  *  t.komponentenmenge  as float) as decimal(18,2) 
			     )                                          
	   )  as betrag_best    
	  ,t.gp_teilsortiment_id
	  ,0 as menge_block_bestand
	, case when wgfz.wg_id is not null then 1  else 0 end as flw_fg
	, zentral_best_fg as zentral_best_fg
        , t.anforderer_name
from dbp_etl.besch_best_det_eket_tmp t

-- datum ermitteln
inner join
( select
	best_beleg_id, 
	dat_best_beleg
  from dbp_data.besch_best
  where mandant_id = 1
) la
  on t.best_beleg_id = la.best_beleg_id
  
left outer join dbp_data.art_wg_zu_per awzp
   on   awzp.mandant_id  = 1
  and awzp.art_id = t.art_id 
  and awzp.arthiertyp_id= 2
  and awzp.dat_bis = to_date('9999-12-31','yyyy-mm-dd') 

-- umrechnungsfaktor fuer basismenge mit umrechnungsfaktor aus der bestellung holen
left outer join
( select
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  from dbp_data.art_umrechnung_faktor_per
  where mandant_id = 1
) aukolli
   on t.art_id = aukolli.art_id and t.best_menge_einh_id = aukolli.altnv_menge_einh_id
  and la.dat_best_beleg between aukolli.dat_von and aukolli.dat_bis
  
-- palettenfaktor und default mengeneinheit holen
left outer join
( select
    art_id, paletten_faktor_einh_id, ausg_menge_einh_id, dat_von, dat_bis
  from dbp_data.art_vorschlagswert_per
  where mandant_id = 1
) av
   on t.art_id = av.art_id
  and la.dat_best_beleg between av.dat_von and av.dat_bis

-- umrechnungsfaktor fuer palettenfaktor holen
left outer join
( select
    art_id, umrech_faktor, altnv_menge_einh_id, dat_von, dat_bis
  from dbp_data.art_umrechnung_faktor_per
  where mandant_id = 1
) aupalette
  on t.art_id = aupalette.art_id and av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
     and la.dat_best_beleg between aupalette.dat_von and aupalette.dat_bis

-- default umrechnungsfaktor fuer basismenge holen, wenn umrechnungsfaktor aus bestellung null ist 
left outer join
( select
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  from dbp_data.art_umrechnung_faktor_per
  where mandant_id = 1
) aukolli_alternativ
  on t.art_id = aukolli_alternativ.art_id and av.ausg_menge_einh_id = aukolli_alternativ.altnv_menge_einh_id
     and la.dat_best_beleg between aukolli_alternativ.dat_von and aukolli_alternativ.dat_bis

left join dbp_data.wg_filter_zu as wgfz
on wgfz.wg_id = awzp.wg_id
and wgfz.mandant_id = awzp.mandant_id
and wgfz.wg_filter_id = 23
and wgfz.arthiertyp_id = 2
);

insert into dbp_data.besch_best_det (mandant_id
	                            ,best_beleg_id
	                            ,best_beleg_pos_id
	                            ,art_id
	                            ,wup_id
	                            ,nb_id
	                            ,lagerort_id
	                            ,loesch_fg
	                            ,menge_best_bme
	                            ,selbstabhol_fg
	                            ,best_preis_menge_einh_id
	                            ,best_menge_einh_id
	                            ,menge_best_kolli
	                            ,menge_best_palette
	                            ,endlief_fg
	                            ,dat_aenderung
	                            ,kunde_id
	                            ,dat_best_beleg
	                            ,ean_id
	                            ,betrag_kond_zw_sum2
	                            ,pos_kostenlos_fg
	                            ,betrag_pos_netto
	                            ,betrag_pos_netto_best_wrg
	                            ,wrg_id
	                            ,betrag_best
	                            ,gp_teilsortiment_id
	                            ,menge_block_bestand
	                            ,flw_fg
	                            ,zentral_best_fg
                                    ,anforderer_name)
select mandant_id
      ,best_beleg_id
      ,best_beleg_pos_id
      ,art_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,loesch_fg
      ,menge_best_neu as menge_best_bme
      ,selbstabhol_fg
      ,best_preis_menge_einh_id
      ,best_menge_einh_id
      ,menge_best_kolli
      ,menge_best_palette
      ,endlief_fg
      ,dat_aenderung
      ,kunde_id
      ,dat_best_beleg
      ,ean_id
      ,betrag_kond_zw_sum2
      ,pos_kostenlos_fg
      ,betrag_pos_netto
      ,betrag_pos_netto_best_wrg
      ,wrg_id
      ,betrag_best
      ,gp_teilsortiment_id
      ,menge_block_bestand
      ,flw_fg
      ,zentral_best_fg
      ,anforderer_name
from _ekpo_eket
;
