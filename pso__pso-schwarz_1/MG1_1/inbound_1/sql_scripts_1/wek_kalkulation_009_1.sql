delete from dbp_data.artbew_dat_ek_cp_sum_1
where dat between (select min(dat) from dbp_etl.zeitraum_fww_kmo_gld_1) and (select max(dat) from dbp_etl.zeitraum_fww_kmo_gld_1) and
      transaktion_typ_id = 0
;

insert into dbp_data.artbew_dat_ek_cp_sum_1 (mandant_id
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
                                           ,umrechnungskurs_hist)
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_cz_1
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_pl_1 a
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_md_1
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_sk_1
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_hr_1
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_ro_1
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_bg_1
union all
select mandant_id
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
      ,coalesce(betrag_kmep_o_fwu_km,0)
      ,coalesce(betrag_kmep_o_fwu_km_vj,0)
      ,coalesce(betrag_kmep_o_fwu_kw,0)
      ,coalesce(betrag_kmep_o_fwu_kw_vj,0)
      ,coalesce(betrag_kmep_o_fwu_ww,0)
      ,coalesce(betrag_kmep_o_fwu_ww_vj,0)
      ,1 as umrechnungskurs_hist
from dbp_etl.tag_wa_kalk_final_de_1
;
