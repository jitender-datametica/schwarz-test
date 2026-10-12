create or replace table dbp_etl.vis_tag_ums_wup_tmp like dbp_msi_data.vis_tag_umsatz_kunde_wup;
alter table dbp_etl.vis_tag_ums_wup_tmp add datenart byteint;

insert into dbp_etl.vis_tag_ums_wup_tmp (mandant_id
                                        ,dat
                                        ,nb_id
                                        ,wup_id
                                        ,wrg_id
                                        ,gj
                                        ,akt_gj
                                        ,kjmo
                                        ,akt_mo
                                        ,kjwo
                                        ,akt_wo
                                        ,wtag_id
                                        ,akt_tag
                                        ,ums_netto
                                        ,ums_netto_af
                                        ,ums_netto_sa
                                        ,ums_netto_wvj
                                        ,ums_netto_af_wvj
                                        ,ums_netto_sa_wvj
                                        ,ums_netto_wvvj
                                        ,ums_netto_af_wvvj
                                        ,ums_netto_sa_wvvj
                                        ,ums_netto_kvj
                                        ,ums_netto_af_kvj
                                        ,ums_netto_sa_kvj
                                        ,ums_netto_kvvj
                                        ,ums_netto_af_kvvj
                                        ,ums_netto_sa_kvvj
                                        ,ums_netto_plan
                                        ,ums_netto_plan_extern
                                        ,ums_brutto
                                        ,ums_brutto_wvj
                                        ,ums_brutto_wvvj
                                        ,ums_brutto_kvj
                                        ,ums_brutto_kvvj
                                        ,anz_kunde
                                        ,anz_kunde_wvj
                                        ,anz_kunde_kvj
                                        ,anz_offen
                                        ,anz_offen_wvj
                                        ,anz_offen_wvvj
                                        ,anz_offen_kvj
                                        ,anz_offen_kvvj
                                        ,menge_absatz
                                        ,menge_absatz_af
                                        ,menge_absatz_sa
                                        ,menge_absatz_wvj
                                        ,menge_absatz_af_wvj
                                        ,menge_absatz_sa_wvj
                                        ,menge_absatz_kvj
                                        ,menge_absatz_af_kvj
                                        ,menge_absatz_sa_kvj
                                        ,menge_absatz_ohne_pfand_plan
                                        ,datenart)
select dt1.mandant_id
      ,dt1.dat
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.gj
      ,dt1.akt_gj
      ,dt1.kjmo
      ,dt1.akt_mo
      ,dt1.kjwo
      ,dt1.akt_wo
      ,dt1.wtag_id
      ,dt1.akt_tag
      ,dt1.ums_netto
      ,dt1.ums_netto_af
      ,dt1.ums_netto_sa
      ,dt1.ums_netto_wvj
      ,dt1.ums_netto_af_wvj
      ,dt1.ums_netto_sa_wvj
      ,dt1.ums_netto_wvvj
      ,dt1.ums_netto_af_wvvj
      ,dt1.ums_netto_sa_wvvj
      ,dt1.ums_netto_kvj
      ,dt1.ums_netto_af_kvj
      ,dt1.ums_netto_sa_kvj
      ,dt1.ums_netto_kvvj
      ,dt1.ums_netto_af_kvvj
      ,dt1.ums_netto_sa_kvvj
      ,0 as ums_netto_plan
      ,0 as ums_netto_plan_extern
      ,dt1.ums_brutto
      ,dt1.ums_brutto_wvj
      ,dt1.ums_brutto_wvvj
      ,dt1.ums_brutto_kvj
      ,dt1.ums_brutto_kvvj
      ,0 as anz_kunde
      ,0 as anz_kunde_wvj
      ,0 as anz_kunde_kvj
      ,0 as anz_offen
      ,0 as anz_offen_wvj
      ,0 as anz_offen_wvvj
      ,0 as anz_offen_kvj
      ,0 as anz_offen_kvvj
      ,dt1.menge_absatz
      ,dt1.menge_absatz_af
      ,dt1.menge_absatz_sa
      ,dt1.menge_absatz_wvj
      ,dt1.menge_absatz_af_wvj
      ,dt1.menge_absatz_sa_wvj
      ,dt1.menge_absatz_kvj
      ,dt1.menge_absatz_af_kvj
      ,dt1.menge_absatz_sa_kvj
      ,0 as menge_absatz_ohne_pfand_plan
      ,1 as datenart
from (select mandant_id
            ,dat
            ,nb_id
            ,wup_id
            ,wrg_id
            ,gj
            ,akt_gj
            ,kjmo
            ,akt_mo
            ,kjwo
            ,akt_wo
            ,wtag_id
            ,akt_tag
            ,sum(ums_netto) as ums_netto
            ,sum(ums_netto_af) as ums_netto_af
            ,sum(ums_netto_sa) as ums_netto_sa
            ,sum(ums_netto_wvj) as ums_netto_wvj
            ,sum(ums_netto_af_wvj) as ums_netto_af_wvj
            ,sum(ums_netto_sa_wvj) as ums_netto_sa_wvj
            ,sum(ums_netto_wvvj) as ums_netto_wvvj
            ,sum(ums_netto_af_wvvj) as ums_netto_af_wvvj
            ,sum(ums_netto_sa_wvvj) as ums_netto_sa_wvvj
            ,sum(ums_netto_kvj) as ums_netto_kvj
            ,sum(ums_netto_af_kvj) as ums_netto_af_kvj
            ,sum(ums_netto_sa_kvj) as ums_netto_sa_kvj
            ,sum(ums_netto_kvvj) as ums_netto_kvvj
            ,sum(ums_netto_af_kvvj) as ums_netto_af_kvvj
            ,sum(ums_netto_sa_kvvj) as ums_netto_sa_kvvj
            ,sum(ums_brutto) as ums_brutto
            ,sum(ums_brutto_wvj) as ums_brutto_wvj
            ,sum(ums_brutto_wvvj) as ums_brutto_wvvj
            ,sum(ums_brutto_kvj) as ums_brutto_kvj
            ,sum(ums_brutto_kvvj) as ums_brutto_kvvj
            ,sum(menge_absatz) as menge_absatz
            ,sum(menge_absatz_af) as menge_absatz_af
            ,sum(menge_absatz_sa) as menge_absatz_sa
            ,sum(menge_absatz_wvj) as menge_absatz_wvj
            ,sum(menge_absatz_af_wvj) as menge_absatz_af_wvj
            ,sum(menge_absatz_sa_wvj) as menge_absatz_sa_wvj
            ,sum(menge_absatz_kvj) as menge_absatz_kvj
            ,sum(menge_absatz_af_kvj) as menge_absatz_af_kvj
            ,sum(menge_absatz_sa_kvj) as menge_absatz_sa_kvj
      from dbp_etl.vis_artbew_tmp
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13) dt1
;

insert into dbp_etl.vis_tag_ums_wup_tmp (mandant_id
                                        ,dat
                                        ,nb_id
                                        ,wup_id
                                        ,wrg_id
                                        ,gj
                                        ,akt_gj
                                        ,kjmo
                                        ,akt_mo
                                        ,kjwo
                                        ,akt_wo
                                        ,wtag_id
                                        ,akt_tag
                                        ,ums_netto
                                        ,ums_netto_af
                                        ,ums_netto_sa
                                        ,ums_netto_wvj
                                        ,ums_netto_af_wvj
                                        ,ums_netto_sa_wvj
                                        ,ums_netto_wvvj
                                        ,ums_netto_af_wvvj
                                        ,ums_netto_sa_wvvj
                                        ,ums_netto_kvj
                                        ,ums_netto_af_kvj
                                        ,ums_netto_sa_kvj
                                        ,ums_netto_kvvj
                                        ,ums_netto_af_kvvj
                                        ,ums_netto_sa_kvvj
                                        ,ums_netto_plan
                                        ,ums_netto_plan_extern
                                        ,ums_brutto
                                        ,ums_brutto_wvj
                                        ,ums_brutto_wvvj
                                        ,ums_brutto_kvj
                                        ,ums_brutto_kvvj
                                        ,anz_kunde
                                        ,anz_kunde_wvj
                                        ,anz_kunde_kvj
                                        ,anz_offen
                                        ,anz_offen_wvj
                                        ,anz_offen_wvvj
                                        ,anz_offen_kvj
                                        ,anz_offen_kvvj
                                        ,menge_absatz
                                        ,menge_absatz_af
                                        ,menge_absatz_sa
                                        ,menge_absatz_wvj
                                        ,menge_absatz_af_wvj
                                        ,menge_absatz_sa_wvj
                                        ,menge_absatz_kvj
                                        ,menge_absatz_af_kvj
                                        ,menge_absatz_sa_kvj
                                        ,menge_absatz_ohne_pfand_plan
                                        ,datenart)
select dt1.mandant_id
      ,dt1.dat
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.gj
      ,dt1.akt_gj
      ,dt1.kjmo
      ,dt1.akt_mo
      ,dt1.kjwo
      ,dt1.akt_wo
      ,dt1.wtag_id
      ,dt1.akt_tag
      ,0 as ums_netto
      ,0 as ums_netto_af
      ,0 as ums_netto_sa
      ,0 as ums_netto_wvj
      ,0 as ums_netto_af_wvj
      ,0 as ums_netto_sa_wvj
      ,0 as ums_netto_wvvj
      ,0 as ums_netto_af_wvvj
      ,0 as ums_netto_sa_wvvj
      ,0 as ums_netto_kvj
      ,0 as ums_netto_af_kvj
      ,0 as ums_netto_sa_kvj
      ,0 as ums_netto_kvvj
      ,0 as ums_netto_af_kvvj
      ,0 as ums_netto_sa_kvvj
      ,coalesce(dt1.ums_netto_plan,0)
      ,coalesce(dt1.ums_netto_plan_extern,0)
      ,0 as ums_brutto
      ,0 as ums_brutto_wvj
      ,0 as ums_brutto_wvvj
      ,0 as ums_brutto_kvj
      ,0 as ums_brutto_kvvj
      ,0 as anz_kunde
      ,0 as anz_kunde_wvj
      ,0 as anz_kunde_kvj
      ,0 as anz_offen
      ,0 as anz_offen_wvj
      ,0 as anz_offen_wvvj
      ,0 as anz_offen_kvj
      ,0 as anz_offen_kvvj
      ,0 as menge_absatz
      ,0 as menge_absatz_af
      ,0 as menge_absatz_sa
      ,0 as menge_absatz_wvj
      ,0 as menge_absatz_af_wvj
      ,0 as menge_absatz_sa_wvj
      ,0 as menge_absatz_kvj
      ,0 as menge_absatz_af_kvj
      ,0 as menge_absatz_sa_kvj
      ,0 as menge_absatz_ohne_pfand_plan
      ,2 as datenart
from (select mandant_id
            ,dat
            ,nb_id
            ,wup_id
            ,wrg_id
            ,gj
            ,akt_gj
            ,kjmo
            ,akt_mo
            ,kjwo
            ,akt_wo
            ,wtag_id
            ,akt_tag
            ,sum(ums_netto_plan) as ums_netto_plan
	          ,sum(ums_netto_plan_extern) as ums_netto_plan_extern
      from dbp_etl.vis_plan_tag_wup_tmp
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13) dt1
;

insert into dbp_etl.vis_tag_ums_wup_tmp (mandant_id
                                        ,dat
                                        ,nb_id
                                        ,wup_id
                                        ,wrg_id
                                        ,gj
                                        ,akt_gj
                                        ,kjmo
                                        ,akt_mo
                                        ,kjwo
                                        ,akt_wo
                                        ,wtag_id
                                        ,akt_tag
                                        ,ums_netto
                                        ,ums_netto_af
                                        ,ums_netto_sa
                                        ,ums_netto_wvj
                                        ,ums_netto_af_wvj
                                        ,ums_netto_sa_wvj
                                        ,ums_netto_wvvj
                                        ,ums_netto_af_wvvj
                                        ,ums_netto_sa_wvvj
                                        ,ums_netto_kvj
                                        ,ums_netto_af_kvj
                                        ,ums_netto_sa_kvj
                                        ,ums_netto_kvvj
                                        ,ums_netto_af_kvvj
                                        ,ums_netto_sa_kvvj
                                        ,ums_netto_plan
                                        ,ums_netto_plan_extern
                                        ,ums_brutto
                                        ,ums_brutto_wvj
                                        ,ums_brutto_wvvj
                                        ,ums_brutto_kvj
                                        ,ums_brutto_kvvj
                                        ,anz_kunde
                                        ,anz_kunde_wvj
                                        ,anz_kunde_kvj
                                        ,anz_offen
                                        ,anz_offen_wvj
                                        ,anz_offen_wvvj
                                        ,anz_offen_kvj
                                        ,anz_offen_kvvj
                                        ,menge_absatz
                                        ,menge_absatz_af
                                        ,menge_absatz_sa
                                        ,menge_absatz_wvj
                                        ,menge_absatz_af_wvj
                                        ,menge_absatz_sa_wvj
                                        ,menge_absatz_kvj
                                        ,menge_absatz_af_kvj
                                        ,menge_absatz_sa_kvj
                                        ,menge_absatz_ohne_pfand_plan
                                        ,datenart)
select dt1.mandant_id
      ,dt1.dat
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.gj
      ,dt1.akt_gj
      ,dt1.kjmo
      ,dt1.akt_mo
      ,dt1.kjwo
      ,dt1.akt_wo
      ,dt1.wtag_id
      ,dt1.akt_tag
      ,0 as ums_netto
      ,0 as ums_netto_af
      ,0 as ums_netto_sa
      ,0 as ums_netto_wvj
      ,0 as ums_netto_af_wvj
      ,0 as ums_netto_sa_wvj
      ,0 as ums_netto_wvvj
      ,0 as ums_netto_af_wvvj
      ,0 as ums_netto_sa_wvvj
      ,0 as ums_netto_kvj
      ,0 as ums_netto_af_kvj
      ,0 as ums_netto_sa_kvj
      ,0 as ums_netto_kvvj
      ,0 as ums_netto_af_kvvj
      ,0 as ums_netto_sa_kvvj
      ,0 as ums_netto_plan
      ,0 as ums_netto_plan_extern
      ,0 as ums_brutto
      ,0 as ums_brutto_wvj
      ,0 as ums_brutto_wvvj
      ,0 as ums_brutto_kvj
      ,0 as ums_brutto_kvvj
      ,dt1.anz_kunde
      ,dt1.anz_kunde_wvj
      ,dt1.anz_kunde_kvj
      ,dt1.anz_offen
      ,dt1.anz_offen_wvj
      ,dt1.anz_offen_wvvj
      ,dt1.anz_offen_kvj
      ,dt1.anz_offen_kvvj
      ,0 as menge_absatz
      ,0 as menge_absatz_af
      ,0 as menge_absatz_sa
      ,0 as menge_absatz_wvj
      ,0 as menge_absatz_af_wvj
      ,0 as menge_absatz_sa_wvj
      ,0 as menge_absatz_kvj
      ,0 as menge_absatz_af_kvj
      ,0 as menge_absatz_sa_kvj
      ,0 as menge_absatz_ohne_pfand_plan
      ,3 as datenart
from (select mandant_id
            ,dat
            ,nb_id
            ,wup_id
            ,wrg_id
            ,gj
            ,akt_gj
            ,kjmo
            ,akt_mo
            ,kjwo
            ,akt_wo
            ,wtag_id
            ,akt_tag
            ,sum(anz_kunde) as anz_kunde
            ,sum(anz_kunde_wvj) as anz_kunde_wvj
            ,sum(anz_kunde_kvj) as anz_kunde_kvj
            ,sum(anz_offen) as anz_offen
            ,sum(anz_offen_wvj) as anz_offen_wvj
            ,sum(anz_offen_wvvj) as anz_offen_wvvj
            ,sum(anz_offen_kvj) as anz_offen_kvj
            ,sum(anz_offen_kvvj) as anz_offen_kvvj
      from dbp_etl.vis_kunde_wup_tmp
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13) dt1
;

insert into dbp_etl.vis_tag_ums_wup_tmp (mandant_id
                                        ,dat
                                        ,nb_id
                                        ,wup_id
                                        ,wrg_id
                                        ,gj
                                        ,akt_gj
                                        ,kjmo
                                        ,akt_mo
                                        ,kjwo
                                        ,akt_wo
                                        ,wtag_id
                                        ,akt_tag
                                        ,ums_netto
                                        ,ums_netto_af
                                        ,ums_netto_sa
                                        ,ums_netto_wvj
                                        ,ums_netto_af_wvj
                                        ,ums_netto_sa_wvj
                                        ,ums_netto_wvvj
                                        ,ums_netto_af_wvvj
                                        ,ums_netto_sa_wvvj
                                        ,ums_netto_kvj
                                        ,ums_netto_af_kvj
                                        ,ums_netto_sa_kvj
                                        ,ums_netto_kvvj
                                        ,ums_netto_af_kvvj
                                        ,ums_netto_sa_kvvj
                                        ,ums_netto_plan
                                        ,ums_netto_plan_extern
                                        ,ums_brutto
                                        ,ums_brutto_wvj
                                        ,ums_brutto_wvvj
                                        ,ums_brutto_kvj
                                        ,ums_brutto_kvvj
                                        ,anz_kunde
                                        ,anz_kunde_wvj
                                        ,anz_kunde_kvj
                                        ,anz_offen
                                        ,anz_offen_wvj
                                        ,anz_offen_wvvj
                                        ,anz_offen_kvj
                                        ,anz_offen_kvvj
                                        ,menge_absatz
                                        ,menge_absatz_af
                                        ,menge_absatz_sa
                                        ,menge_absatz_wvj
                                        ,menge_absatz_af_wvj
                                        ,menge_absatz_sa_wvj
                                        ,menge_absatz_kvj
                                        ,menge_absatz_af_kvj
                                        ,menge_absatz_sa_kvj
                                        ,menge_absatz_ohne_pfand_plan
                                        ,datenart)
select mandant_id
      ,dat
      ,nb_id
      ,wup_id
      ,wrg_id
      ,gj
      ,akt_gj
      ,kjmo
      ,akt_mo
      ,kjwo
      ,akt_wo
      ,wtag_id
      ,akt_tag
      ,0 as ums_netto
      ,0 as ums_netto_af
      ,0 as ums_netto_sa
      ,0 as ums_netto_wvj
      ,0 as ums_netto_af_wvj
      ,0 as ums_netto_sa_wvj
      ,0 as ums_netto_wvvj
      ,0 as ums_netto_af_wvvj
      ,0 as ums_netto_sa_wvvj
      ,0 as ums_netto_kvj
      ,0 as ums_netto_af_kvj
      ,0 as ums_netto_sa_kvj
      ,0 as ums_netto_kvvj
      ,0 as ums_netto_af_kvvj
      ,0 as ums_netto_sa_kvvj
      ,0 as ums_netto_plan
      ,0 as ums_netto_plan_extern
      ,0 as ums_brutto
      ,0 as ums_brutto_wvj
      ,0 as ums_brutto_wvvj
      ,0 as ums_brutto_kvj
      ,0 as ums_brutto_kvvj
      ,0 as anz_kunde
      ,0 as anz_kunde_wvj
      ,0 as anz_kunde_kvj
      ,0 as anz_offen
      ,0 as anz_offen_wvj
      ,0 as anz_offen_wvvj
      ,0 as anz_offen_kvj
      ,0 as anz_offen_kvvj
      ,0 as menge_absatz
      ,0 as menge_absatz_af
      ,0 as menge_absatz_sa
      ,0 as menge_absatz_wvj
      ,0 as menge_absatz_af_wvj
      ,0 as menge_absatz_sa_wvj
      ,0 as menge_absatz_kvj
      ,0 as menge_absatz_af_kvj
      ,0 as menge_absatz_sa_kvj
      ,0 as menge_absatz_ohne_pfand_plan
      ,4 as datenart
from dbp_etl.vis_bon_wup_bedienung_tmp
;



insert into dbp_etl.vis_tag_ums_wup_tmp (mandant_id
                                        ,dat
                                        ,nb_id
                                        ,wup_id
                                        ,wrg_id
                                        ,gj
                                        ,akt_gj
                                        ,kjmo
                                        ,akt_mo
                                        ,kjwo
                                        ,akt_wo
                                        ,wtag_id
                                        ,akt_tag
                                        ,ums_netto
                                        ,ums_netto_af
                                        ,ums_netto_sa
                                        ,ums_netto_wvj
                                        ,ums_netto_af_wvj
                                        ,ums_netto_sa_wvj
                                        ,ums_netto_wvvj
                                        ,ums_netto_af_wvvj
                                        ,ums_netto_sa_wvvj
                                        ,ums_netto_kvj
                                        ,ums_netto_af_kvj
                                        ,ums_netto_sa_kvj
                                        ,ums_netto_kvvj
                                        ,ums_netto_af_kvvj
                                        ,ums_netto_sa_kvvj
                                        ,ums_netto_plan
                                        ,ums_netto_plan_extern
                                        ,ums_brutto
                                        ,ums_brutto_wvj
                                        ,ums_brutto_wvvj
                                        ,ums_brutto_kvj
                                        ,ums_brutto_kvvj
                                        ,anz_kunde
                                        ,anz_kunde_wvj
                                        ,anz_kunde_kvj
                                        ,anz_offen
                                        ,anz_offen_wvj
                                        ,anz_offen_wvvj
                                        ,anz_offen_kvj
                                        ,anz_offen_kvvj
                                        ,menge_absatz
                                        ,menge_absatz_af
                                        ,menge_absatz_sa
                                        ,menge_absatz_wvj
                                        ,menge_absatz_af_wvj
                                        ,menge_absatz_sa_wvj
                                        ,menge_absatz_kvj
                                        ,menge_absatz_af_kvj
                                        ,menge_absatz_sa_kvj
                                        ,menge_absatz_ohne_pfand_plan
                                        ,datenart)
select t1.mandant_id
      ,t1.dat
      ,t1.nb_id
      ,t1.wup_id
      ,t2.nach_wrg_id as wgr_id
      ,t1.gj
      ,t1.akt_gj
      ,t1.kjmo
      ,t1.akt_mo
      ,t1.kjwo
      ,t1.akt_wo
      ,t1.wtag_id
      ,t1.akt_tag
      ,sum(t1.ums_netto * t2.umrechnungskurs)
      ,sum(t1.ums_netto_af * t2.umrechnungskurs)
      ,sum(t1.ums_netto_sa * t2.umrechnungskurs)
      ,sum(t1.ums_netto_wvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_af_wvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_sa_wvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_wvvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_af_wvvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_sa_wvvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_kvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_af_kvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_sa_kvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_kvvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_af_kvvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_sa_kvvj * t2.umrechnungskurs)
      ,sum(t1.ums_netto_plan * t2.umrechnungskurs)
      ,sum(t1.ums_netto_plan_extern * t2.umrechnungskurs)
      ,sum(t1.ums_brutto * t2.umrechnungskurs)
      ,sum(t1.ums_brutto_wvj * t2.umrechnungskurs)
      ,sum(t1.ums_brutto_wvvj * t2.umrechnungskurs)
      ,sum(t1.ums_brutto_kvj * t2.umrechnungskurs)
      ,sum(t1.ums_brutto_kvvj * t2.umrechnungskurs)
      ,sum(t1.anz_kunde)
      ,sum(t1.anz_kunde_wvj)
      ,sum(t1.anz_kunde_kvj)
      ,sum(t1.anz_offen)
      ,sum(t1.anz_offen_wvj)
      ,sum(t1.anz_offen_wvvj)
      ,sum(t1.anz_offen_kvj)
      ,sum(t1.anz_offen_kvvj)
      ,sum(t1.menge_absatz)
      ,sum(t1.menge_absatz_af)
      ,sum(t1.menge_absatz_sa)
      ,sum(t1.menge_absatz_wvj)
      ,sum(t1.menge_absatz_af_wvj)
      ,sum(t1.menge_absatz_sa_wvj)
      ,sum(t1.menge_absatz_kvj)
      ,sum(t1.menge_absatz_af_kvj)
      ,sum(t1.menge_absatz_sa_kvj)
      ,sum(t1.menge_absatz_ohne_pfand_plan)
      ,5 as datenart
from dbp_etl.vis_tag_ums_wup_tmp t1
join dbp_data.kurs t2
  on t2.von_wrg_id = t1.wrg_id and 
     t2.dat_bis = '9999-12-31' and 
     t2.nach_wrg_id = 'EUR' and 
     t2.kurstyp_id = 3
where t1.wrg_id <> 'EUR'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
;

delete from dbp_msi_data.vis_tag_umsatz_kunde_wup
where mandant_id in (${MANDANT}) and 
     (mandant_id, wup_id, dat, wrg_id) in (select mandant_id,wup_id,dat,wrg_id from dbp_etl.vis_tag_ums_wup_tmp)
;

delete from dbp_msi_data.vis_tag_umsatz_kunde_wup
where mandant_id in (${MANDANT}) and 
     (mandant_id,wup_id) in (select mandant_id,wup_id from dbp_data.wup where umzugsfiliale_fg = 1)
;

insert into dbp_msi_data.vis_tag_umsatz_kunde_wup (mandant_id
                                                  ,dat
                                                  ,nb_id
                                                  ,wup_id
                                                  ,wrg_id
                                                  ,gj
                                                  ,akt_gj
                                                  ,kjmo
                                                  ,akt_mo
                                                  ,kjwo
                                                  ,akt_wo
                                                  ,wtag_id
                                                  ,akt_tag
                                                  ,ums_netto
                                                  ,ums_netto_af
                                                  ,ums_netto_sa
                                                  ,ums_netto_wvj
                                                  ,ums_netto_af_wvj
                                                  ,ums_netto_sa_wvj
                                                  ,ums_netto_wvvj
                                                  ,ums_netto_af_wvvj
                                                  ,ums_netto_sa_wvvj
                                                  ,ums_netto_kvj
                                                  ,ums_netto_af_kvj
                                                  ,ums_netto_sa_kvj
                                                  ,ums_netto_kvvj
                                                  ,ums_netto_af_kvvj
                                                  ,ums_netto_sa_kvvj
                                                  ,ums_netto_plan
                                                  ,ums_netto_plan_extern
                                                  ,ums_brutto
                                                  ,ums_brutto_wvj
                                                  ,ums_brutto_wvvj
                                                  ,ums_brutto_kvj
                                                  ,ums_brutto_kvvj
                                                  ,anz_kunde
                                                  ,anz_kunde_wvj
                                                  ,anz_kunde_kvj
                                                  ,anz_offen
                                                  ,anz_offen_wvj
                                                  ,anz_offen_wvvj
                                                  ,anz_offen_kvj
                                                  ,anz_offen_kvvj
                                                  ,menge_absatz
                                                  ,menge_absatz_af
                                                  ,menge_absatz_sa
                                                  ,menge_absatz_wvj
                                                  ,menge_absatz_af_wvj
                                                  ,menge_absatz_sa_wvj
                                                  ,menge_absatz_kvj
                                                  ,menge_absatz_af_kvj
                                                  ,menge_absatz_sa_kvj
                                                  ,menge_absatz_ohne_pfand_plan)
select mandant_id
      ,dat
      ,nb_id
      ,wup_id
      ,wrg_id
      ,gj
      ,akt_gj
      ,kjmo
      ,akt_mo
      ,kjwo
      ,akt_wo
      ,wtag_id
      ,akt_tag
      ,sum(ums_netto)
      ,sum(ums_netto_af)
      ,sum(ums_netto_sa)
      ,sum(ums_netto_wvj)
      ,sum(ums_netto_af_wvj)
      ,sum(ums_netto_sa_wvj)
      ,sum(ums_netto_wvvj)
      ,sum(ums_netto_af_wvvj)
      ,sum(ums_netto_sa_wvvj)
      ,sum(ums_netto_kvj)
      ,sum(ums_netto_af_kvj)
      ,sum(ums_netto_sa_kvj)
      ,sum(ums_netto_kvvj)
      ,sum(ums_netto_af_kvvj)
      ,sum(ums_netto_sa_kvvj)
      ,sum(ums_netto_plan)
      ,sum(ums_netto_plan_extern)
      ,sum(ums_brutto)
      ,sum(ums_brutto_wvj)
      ,sum(ums_brutto_wvvj)
      ,sum(ums_brutto_kvj)
      ,sum(ums_brutto_kvvj)
      ,sum(anz_kunde)
      ,sum(anz_kunde_wvj)
      ,sum(anz_kunde_kvj)
      ,sum(anz_offen)
      ,sum(anz_offen_wvj)
      ,sum(anz_offen_wvvj)
      ,sum(anz_offen_kvj)
      ,sum(anz_offen_kvvj)
      ,sum(menge_absatz)
      ,sum(menge_absatz_af)
      ,sum(menge_absatz_sa)
      ,sum(menge_absatz_wvj)
      ,sum(menge_absatz_af_wvj)
      ,sum(menge_absatz_sa_wvj)
      ,sum(menge_absatz_kvj)
      ,sum(menge_absatz_af_kvj)
      ,sum(menge_absatz_sa_kvj)
      ,sum(menge_absatz_ohne_pfand_plan)
from dbp_etl.vis_tag_ums_wup_tmp
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
;

UPDATE dbp_msi_data.vis_tag_umsatz_kunde_wup e
SET e.menge_absatz_ohne_pfand_plan = b.menge_absatz_ohne_pfand_plan
FROM  DBP_DATA.WUP_PLAN_TAG b
WHERE 
e.mandant_id = b.mandant_id 
and e.wup_id = b.wup_id 
and e.dat = b.dat
and e.nb_id = b.nb_id
and e.wrg_id = b.wrg_id
;
