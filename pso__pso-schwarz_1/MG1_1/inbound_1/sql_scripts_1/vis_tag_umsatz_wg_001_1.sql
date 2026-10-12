create or replace table dbp_etl.vis_tag_ums_wg_tmp_1 like dbp_msi_data.vis_tag_umsatz_wg_1;

insert into dbp_etl.vis_tag_ums_wg_tmp_1 (mandant_id
                                       ,dat
                                       ,nb_id
                                       ,wup_id
                                       ,wg_id
                                       ,arthiertyp_id
                                       ,wrg_id
                                       ,abt_id
                                       ,gj
                                       ,kjmo
                                       ,kjwo
                                       ,wtag_id
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
                                       ,ums_brutto
                                       ,ums_brutto_kvj
                                       ,ums_brutto_wvj
                                       ,menge_absatz
                                       ,menge_absatz_af
                                       ,menge_absatz_sa
                                       ,menge_absatz_kvj
                                       ,menge_absatz_af_kvj
                                       ,menge_absatz_sa_kvj
                                       ,menge_absatz_wvj
                                       ,menge_absatz_af_wvj
                                       ,menge_absatz_sa_wvj)
select dt1.mandant_id
      ,dt1.dat
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wg_id
      ,dt1.arthiertyp_id
      ,dt1.wrg_id
      ,dt1.abt_id
      ,dt1.gj
      ,dt1.kjmo
      ,dt1.kjwo
      ,dt1.wtag_id
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
      ,dt1.ums_brutto
      ,dt1.ums_brutto_kvj
      ,dt1.ums_brutto_wvj
      ,dt1.menge_absatz
      ,dt1.menge_absatz_af
      ,dt1.menge_absatz_sa
      ,dt1.menge_absatz_kvj
      ,dt1.menge_absatz_af_kvj
      ,dt1.menge_absatz_sa_kvj
      ,dt1.menge_absatz_wvj
      ,dt1.menge_absatz_af_wvj
      ,dt1.menge_absatz_sa_wvj
from (select mandant_id
            ,dat
            ,nb_id
            ,wup_id
            ,wrg_id
            ,arthiertyp_id
            ,abt_id
            ,wg_id
            ,gj
            ,kjmo
            ,kjwo
            ,wtag_id
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
      from dbp_etl.vis_artbew_tmp_1
      group by 1,2,3,4,5,6,7,8,9,10,11,12) dt1
;

insert into dbp_etl.vis_tag_ums_wg_tmp_1 (mandant_id
                                       ,dat
                                       ,nb_id
                                       ,wup_id
                                       ,wg_id
                                       ,arthiertyp_id
                                       ,wrg_id
                                       ,abt_id
                                       ,gj
                                       ,kjmo
                                       ,kjwo
                                       ,wtag_id
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
                                       ,ums_brutto
                                       ,ums_brutto_kvj
                                       ,ums_brutto_wvj
                                       ,menge_absatz
                                       ,menge_absatz_af
                                       ,menge_absatz_sa
                                       ,menge_absatz_kvj
                                       ,menge_absatz_af_kvj
                                       ,menge_absatz_sa_kvj
                                       ,menge_absatz_wvj
                                       ,menge_absatz_af_wvj
                                       ,menge_absatz_sa_wvj)
select t1.mandant_id
      ,t1.dat
      ,t1.nb_id
      ,t1.wup_id
      ,t1.wg_id
      ,t1.arthiertyp_id
      ,t2.nach_wrg_id as wgr_id
      ,t1.abt_id
      ,t1.gj
      ,t1.kjmo
      ,t1.kjwo
      ,t1.wtag_id
      ,t1.ums_netto * t2.umrechnungskurs
      ,t1.ums_netto_af * t2.umrechnungskurs
      ,t1.ums_netto_sa * t2.umrechnungskurs
      ,t1.ums_netto_wvj * t2.umrechnungskurs
      ,t1.ums_netto_af_wvj * t2.umrechnungskurs
      ,t1.ums_netto_sa_wvj * t2.umrechnungskurs
      ,t1.ums_netto_wvvj * t2.umrechnungskurs
      ,t1.ums_netto_af_wvvj * t2.umrechnungskurs
      ,t1.ums_netto_sa_wvvj * t2.umrechnungskurs
      ,t1.ums_netto_kvj * t2.umrechnungskurs
      ,t1.ums_netto_af_kvj * t2.umrechnungskurs
      ,t1.ums_netto_sa_kvj * t2.umrechnungskurs
      ,t1.ums_netto_kvvj * t2.umrechnungskurs
      ,t1.ums_netto_af_kvvj * t2.umrechnungskurs
      ,t1.ums_netto_sa_kvvj * t2.umrechnungskurs
      ,t1.ums_brutto * t2.umrechnungskurs
      ,t1.ums_brutto_kvj * t2.umrechnungskurs
      ,t1.ums_brutto_wvj * t2.umrechnungskurs
      ,t1.menge_absatz
      ,t1.menge_absatz_af
      ,t1.menge_absatz_sa
      ,t1.menge_absatz_kvj
      ,t1.menge_absatz_af_kvj
      ,t1.menge_absatz_sa_kvj
      ,t1.menge_absatz_wvj
      ,t1.menge_absatz_af_wvj
      ,t1.menge_absatz_sa_wvj
from dbp_etl.vis_tag_ums_wg_tmp_1 t1_1
join dbp_data.kurs_1 t2
  on t2.von_wrg_id = t1.wrg_id and 
     t2.dat_bis = '9999-12-31' and 
     t2.nach_wrg_id = 'EUR' and 
     t2.kurstyp_id = 3
where t1.wrg_id <> 'EUR'
;

delete from dbp_msi_data.vis_tag_umsatz_wg_1
where mandant_id in (select mandant_id from dbp_etl.vis_mandant_1)
;

insert into dbp_msi_data.vis_tag_umsatz_wg_1 (mandant_id
                                           ,dat
                                           ,nb_id
                                           ,wup_id
                                           ,wg_id
                                           ,arthiertyp_id
                                           ,wrg_id
                                           ,abt_id
                                           ,gj
                                           ,kjmo
                                           ,kjwo
                                           ,wtag_id
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
                                           ,ums_brutto
                                           ,ums_brutto_kvj
                                           ,ums_brutto_wvj
                                           ,menge_absatz
                                           ,menge_absatz_af
                                           ,menge_absatz_sa
                                           ,menge_absatz_kvj
                                           ,menge_absatz_af_kvj
                                           ,menge_absatz_sa_kvj
                                           ,menge_absatz_wvj
                                           ,menge_absatz_af_wvj
                                           ,menge_absatz_sa_wvj)
select mandant_id
      ,dat
      ,nb_id
      ,wup_id
      ,wg_id
      ,arthiertyp_id
      ,wrg_id
      ,abt_id
      ,gj
      ,kjmo
      ,kjwo
      ,wtag_id
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
      ,sum(ums_brutto_kvj) as ums_brutto_kvj
      ,sum(ums_brutto_wvj) as ums_brutto_wvj
      ,sum(menge_absatz) as menge_absatz
      ,sum(menge_absatz_af) as menge_absatz_af
      ,sum(menge_absatz_sa) as menge_absatz_sa
      ,sum(menge_absatz_kvj) as menge_absatz_kvj
      ,sum(menge_absatz_af_kvj) as menge_absatz_af_kvj
      ,sum(menge_absatz_sa_kvj) as menge_absatz_sa_kvj
      ,sum(menge_absatz_wvj) as menge_absatz_wvj
      ,sum(menge_absatz_af_wvj) as menge_absatz_af_wvj
      ,sum(menge_absatz_sa_wvj) as menge_absatz_sa_wvj
from dbp_etl.vis_tag_ums_wg_tmp_1
group by 1,2,3,4,5,6,7,8,9,10,11,12
;

delete from dbp_msi_data.vis_tag_umsatz_abt_1
where mandant_id in (select mandant_id from dbp_etl.vis_mandant_1)
;

insert into dbp_msi_data.vis_tag_umsatz_abt_1 (mandant_id
                                            ,nb_id
                                            ,wup_id
                                            ,wrg_id
                                            ,arthiertyp_id
                                            ,abt_id
                                            ,dat
                                            ,kjmo
                                            ,kjwo
                                            ,ums_netto
                                            ,ums_netto_wvj
                                            ,ums_netto_wvvj
                                            ,ums_netto_kvj
                                            ,ums_netto_kvvj)
select mandant_id
      ,nb_id
      ,wup_id
      ,wrg_id
      ,arthiertyp_id
      ,abt_id
      ,dat
      ,kjmo
      ,kjwo
      ,sum(ums_netto) as ums_netto
      ,sum(ums_netto_wvj) as ums_netto_wvj
      ,sum(ums_netto_wvvj) as ums_netto_wvvj
      ,sum(ums_netto_kvj) as ums_netto_kvj
      ,sum(ums_netto_kvvj) as ums_netto_kvvj
from dbp_msi_data.vis_tag_umsatz_wg_1
where mandant_id in (select mandant_id from dbp_etl.vis_mandant_1)
group by 1,2,3,4,5,6,7,8,9
;
