CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_13_AKT_1
(
	MANDANT_ID,
	KJWO_13,
	MATCHING_ID,
	A489,
	A497,
	A499,
	A495,
	A502,
	A506,
	A504,
	A505,
	A498,
	A501,
	A492,
	A494,
	A490,
	A503,
	A496,
	A491,
	A493
) 
AS
SELECT
t1.mandant_id,
t1.kjwo_13,
t1.matching_id,
CAST (SUM(t1.absatz_kl) AS DEC (18,0)) AS A489,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS A497,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS A499,
CAST(SUM(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS A495,
CAST(SUM(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS A502,
CAST((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS A506,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS A504,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS A505,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS A498,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS A501,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS A492,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS A494,
CAST(((CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END - CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) / CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS A490,
CAST(CASE
WHEN (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN NULL
ELSE (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS A503,
CAST(((CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS A496,
CAST(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS A491,
CAST(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS A493
FROM dbp_msi_v_view.v_tupel_13_wochen_1 t1_1
GROUP BY 1,2,3;