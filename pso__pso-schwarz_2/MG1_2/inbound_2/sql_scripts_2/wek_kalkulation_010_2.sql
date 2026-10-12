delete from dbp_data.artbew_mo_ek_cp_sum_2
where kjmo between (select min(kjmo) from dbp_etl.zeitraum_fww_kmo_gld_2) and (select max(kjmo) from dbp_etl.zeitraum_fww_kmo_gld_2) and
      preis_abschrift_netto = 0 and
      preis_abschrift_netto_vj = 0 and
      werbe_abschrift_netto = 0 and
      werbe_abschrift_netto_vj = 0
;

insert into dbp_data.artbew_mo_ek_cp_sum_2 (mandant_id
                                         ,art_id
                                         ,bewart_id
                                         ,bewart_det_id
                                         ,wup_id
                                         ,nb_id
                                         ,kjmo
                                         ,wrg_id
                                         ,wup_bereinigt_fg
                                         ,zek_id
                                         ,eigenmarke_fg
                                         ,umsatz_netto
                                         ,umsatz_netto_vj
                                         ,betrag_kmep
                                         ,betrag_kmep_vj
                                         ,logkostenzuschlag
                                         ,logkostenzuschlag_vj
                                         ,werbe_abschrift_netto
                                         ,werbe_abschrift_netto_vj
                                         ,preis_abschrift_netto
                                         ,preis_abschrift_netto_vj
                                         ,betrag_kmep_o_fwu
                                         ,betrag_kmep_o_fwu_vj
                                         ,umrechnungskurs_hist)
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_cz_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_pl_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_md_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,1 as umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_sk_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,1 as umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_hr_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_ro_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_bg_2
union all
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,betrag_kmep
      ,betrag_kmep_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,coalesce(betrag_kmep_o_fwu,0)
      ,coalesce(betrag_kmep_o_fwu_vj,0)
      ,1 as umrechnungskurs_hist
from dbp_etl.monat_wa_kalk_final_de_2
;
