delete from dbp_data.artbew_mo_ek_cp_sum_1
where kjmo between (select min(kjmo) from dbp_etl.zeitraum_fww_kmo_gld_1) and (select max(kjmo) from dbp_etl.zeitraum_fww_kmo_gld_1) and
      preis_abschrift_netto = 0 and
      preis_abschrift_netto_vj = 0 and
      werbe_abschrift_netto = 0 and
      werbe_abschrift_netto_vj = 0
;

insert into dbp_data.artbew_mo_ek_cp_sum_1 (mandant_id
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
from dbp_etl.monat_wa_kalk_final_cz_1
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
from dbp_etl.monat_wa_kalk_final_pl_1
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
from dbp_etl.monat_wa_kalk_final_md_1
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
from dbp_etl.monat_wa_kalk_final_sk_1
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
from dbp_etl.monat_wa_kalk_final_hr_1
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
from dbp_etl.monat_wa_kalk_final_ro_1
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
from dbp_etl.monat_wa_kalk_final_bg_1
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
from dbp_etl.monat_wa_kalk_final_de_1
;
