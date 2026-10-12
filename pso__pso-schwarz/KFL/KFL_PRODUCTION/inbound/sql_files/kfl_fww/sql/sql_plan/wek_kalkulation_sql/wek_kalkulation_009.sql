delete from dbp_data.artbew_dat_ek_cp_sum
where dat between (select min(dat) from dbp_etl.zeitraum_fww_kmo_gld) and (select max(dat) from dbp_etl.zeitraum_fww_kmo_gld) and
      transaktion_typ_id = 0
;

insert into dbp_data.artbew_dat_ek_cp_sum (mandant_id
                                           ,art_id
                                           ,bewart_id
                                           ,bewart_det_id
                                           ,wup_id
                                           ,nb_id
                                           ,dat
                                           ,wrg_id
                                           ,zek_id
                                           ,eigenmarke_fg
                                           ,wup_bereinigt_fg
                                           ,umsatz_netto
                                           ,umsatz_netto_vj
                                           ,logkostenzuschlag
                                           ,logkostenzuschlag_vj
                                           ,betrag_kmep_kw
                                           ,betrag_kmep_kw_vj
                                           ,betrag_kmep_ww
                                           ,betrag_kmep_ww_vj
                                           ,werbe_abschrift_netto
                                           ,werbe_abschrift_netto_vj
                                           ,preis_abschrift_netto
                                           ,preis_abschrift_netto_vj
                                           ,betrag_kmep_km
                                           ,betrag_kmep_km_vj
                                           ,betrag_kmep_o_fwu_km
                                           ,betrag_kmep_o_fwu_km_vj
                                           ,betrag_kmep_o_fwu_kw
                                           ,betrag_kmep_o_fwu_kw_vj
                                           ,betrag_kmep_o_fwu_ww
                                           ,betrag_kmep_o_fwu_ww_vj
                                           ,umrechnungskurs_hist
                                           ,gp_id)
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,a.umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_cz a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,a.umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_pl a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,a.umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_md a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_sk a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_hr a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,a.umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_ro a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_bg a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
union all
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,coalesce(a.betrag_kmep_o_fwu_km,0)
      ,coalesce(a.betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw,0)
      ,coalesce(a.betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww,0)
      ,coalesce(a.betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_de a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
;
