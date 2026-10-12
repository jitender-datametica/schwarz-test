CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_tupel_13_mat_2
AS
SELECT
t1.mandant_id,
t1.kjwo_13,
t1.matching_id,
Cast (Sum(t1.absatz_kl) AS DEC (18,0)) AS A472,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS A480,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS A482,
Cast(Sum(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS A478,
Cast(Sum(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS A484,
Cast((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS A488,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS A486,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS A487,
Cast((((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS A481,
Cast((((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS A483,
Cast((((CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS A475,
Cast((((CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS A477,
Cast(((CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END - CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) / CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS A473,
Cast(CASE
WHEN (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN null
ELSE (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS A485,
Cast(((CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS A479,
Cast(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS A474,
Cast(CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS A476
FROM dbp_msi_v_view.v_tupel_13_wochen_2 t1_2 --JOIN dbp_msi_data.sort_monat_woche_2 t2
 --ON t1.a500_kjwo_update = t2.kjwo_sort_bis
GROUP BY 1,2,3;