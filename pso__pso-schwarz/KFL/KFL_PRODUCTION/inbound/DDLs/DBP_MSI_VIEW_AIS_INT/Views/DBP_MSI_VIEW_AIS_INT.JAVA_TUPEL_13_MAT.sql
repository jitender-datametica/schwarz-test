CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_13_MAT
(
	MANDANT_ID,
	KJWO_13,
	MATCHING_ID,
	A472,
	A480,
	A482,
	A478,
	A484,
	A488,
	A486,
	A487,
	A481,
	A483,
	A475,
	A477,
	A473,
	A485,
	A479,
	A474,
	A476
) 
AS
SELECT
t1.mandant_id,
t1.kjwo_13,
t1.matching_id,
CAST (SUM(t1.absatz_kl) AS DEC (18,0)) AS A472,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS A480,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS A482,
CAST(SUM(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS A478,
CAST(SUM(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS A484,
CAST((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS A488,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS A486,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS A487,
CAST((((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS A481,
CAST((((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS A483,
CAST((((CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS A475,
CAST((((CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS A477,
CAST(((CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END - CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) / CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS A473,
CAST(CASE
WHEN (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN NULL
ELSE (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS A485,
CAST(((CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS A479,
CAST(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS A474,
CAST(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS A476
FROM dbp_msi_v_view.v_tupel_13_wochen t1 --JOIN dbp_msi_data.sort_monat_woche t2
 --ON t1.a500_kjwo_update = t2.kjwo_sort_bis
GROUP BY 1,2,3;