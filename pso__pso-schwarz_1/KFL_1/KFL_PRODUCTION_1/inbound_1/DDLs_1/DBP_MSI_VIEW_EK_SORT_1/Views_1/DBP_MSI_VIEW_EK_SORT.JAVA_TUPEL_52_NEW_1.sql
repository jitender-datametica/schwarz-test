create or replace view DBP_MSI_VIEW_EK_SORT.JAVA_TUPEL_52_NEW_1(
	MANDANT_ID,
	MATCHING_ID,
	A5,
	A7,
	A9,
	E282,
	E286,
	E224,
	E266,
	E222,
	E116,
	E118,
	E120,
	E122,
	E124,
	E126,
	E128,
	E102,
	E104,
	E106,
	E108,
	E110,
	E112,
	E114,
	E130,
	E132,
	E134,
	E136,
	E138,
	E140,
	E117,
	E119,
	E121,
	E123,
	E125,
	E127,
	E129,
	E103,
	E105,
	E107,
	E109,
	E111,
	E113,
	E115,
	E131,
	E133,
	E135,
	E137,
	E139,
	E141,
	E361,
	E228,
	E234,
	E262,
	E270,
	E225,
	E349,
	E353,
	E229,
	E294,
	E298,
	E302,
	E306,
	E373,
	E230,
	E231,
	E310,
	E223,
	E226,
	E278,
	E290,
	E227,
	E274,
	E232,
	E314,
	E318,
	E233,
	E326,
	E330,
	USER_ID
) as
SELECT
t1.mandant_id 
,t1.matching_id
,t2.A5_owg_id AS A5
,t2.A7_wg_id AS A7
,t2.wug_id AS A9
,t1.kassenumsatz_af_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_af AS E282
,((t1.kassenumsatz_af_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.kassenumsatz_af_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.kassenumsatz_af_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 AS E286
,t1.absatz_af_kl / t1.anzahl_markt_wochen_kombis_abverkauf_af AS E224
,((t1.absatz_af_kl / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.absatz_af_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.absatz_af_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 AS E266
,absatz_kl AS E222
,absatz_sst1 AS E116
,absatz_sst2 AS E118
,absatz_sst3 AS E120
,absatz_sst4 AS E122
,absatz_sst5 AS E124
,absatz_sst6 AS E126
,absatz_sst7 AS E128
,absatz_ksst1 AS E102
,absatz_ksst2 AS E104
,absatz_ksst3 AS E106
,absatz_ksst4 AS E108
,absatz_ksst5 AS E110
,absatz_ksst6 AS E112
,absatz_ksst7 AS E114
,absatz_ost_basis AS E130
,absatz_ost_gross AS E132
,absatz_sued_ost AS E134
,absatz_sued_west AS E136
,absatz_west AS E138
,absatz_nord AS E140
,absatz_sst1 / t1.markt_wochen_sst1 AS E117
,absatz_sst2 / t1.markt_wochen_sst2 AS E119
,absatz_sst3 / t1.markt_wochen_sst3 AS E121
,absatz_sst4 / t1.markt_wochen_sst4 AS E123
,absatz_sst5 / t1.markt_wochen_sst5 AS E125
,absatz_sst6 / t1.markt_wochen_sst6 AS E127
,absatz_sst7 / t1.markt_wochen_sst7 AS E129
,absatz_ksst1 / t1.markt_wochen_ksst1 AS E103
,absatz_ksst2 / t1.markt_wochen_ksst2 AS E105
,absatz_ksst3 / t1.markt_wochen_ksst3 AS E107
,absatz_ksst4 / t1.markt_wochen_ksst4 AS E109
,absatz_ksst5 / t1.markt_wochen_ksst5 AS E111
,absatz_ksst6 / t1.markt_wochen_ksst6 AS E113
,absatz_ksst7 / t1.markt_wochen_ksst7 AS E115
,t1.absatz_ost_basis / t1.markt_wochen_ost_basis AS E131
,t1.absatz_ost_gross / t1.markt_wochen_ost_gross AS E133
,t1.absatz_sued_ost / t1.markt_wochen_sued_ost AS E135
,t1.absatz_sued_west / t1.markt_wochen_sued_west AS E137
,t1.absatz_west / t1.markt_wochen_west AS E139
,t1.absatz_nord / t1.markt_wochen_nord AS E141
,t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung / t1.anzahl_markt_wochen_kombis_listung *100 AS E361
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE rohertrag_ekmep_olk_4n END AS E228
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE rohertrag_ekmep_olk_4n / absatz_kl END AS E234
,t1.absatz_sa_kl / t1.anzahl_markt_wochen_kombis_abverkauf_sa AS E262
,((t1.absatz_sa_kl / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.absatz_sa_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.absatz_sa_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 AS E270
,t1.absatz_sa_kl / t1.absatz_kl * 100 AS E225
,t1.anz_bons_af / t1.anz_bons_gesamt AS E349
,t1.anz_bons_sa / t1.anz_bons_gesamt AS E353
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n - t1.rohertrag_ekmep_olk_4n_vj END AS E229
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_af / t1.anzahl_markt_wochen_kombis_abverkauf_af END AS E294
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_sa / t1.anzahl_markt_wochen_kombis_abverkauf_sa END AS E298
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE ((t1.rohertrag_ekmep_olk_4n_af / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.rohertrag_ekmep_olk_4n_af_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.rohertrag_ekmep_olk_4n_af_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 END AS E302
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE ((t1.rohertrag_ekmep_olk_4n_sa / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.rohertrag_ekmep_olk_4n_sa_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.rohertrag_ekmep_olk_4n_sa_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 END AS E306
,t1.kassenumsatz_af_kl_absolut_brutto / t1.absatz_af_kl AS E373
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE A23_rohertrag_ekmep_olk_4n / t1.kassenumsatz_kl_absolut_netto * 100 END AS E230
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_af / t1.kassenumsatz_af_kl_absolut_netto END AS E231
,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_sa / t1.kassenumsatz_sa_kl_absolut_netto END AS E310
,(t1.absatz_kl - t1.absatz_kl_vj) / t1.absatz_kl_vj * 100 AS E223
,kassenumsatz_kl_absolut_netto AS E226
,t1.kassenumsatz_sa_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_sa AS E278
,((t1.kassenumsatz_sa_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.kassenumsatz_sa_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.kassenumsatz_sa_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 AS E290
,(t1.kassenumsatz_kl_absolut_netto - t1.kassenumsatz_kl_absolut_netto_vj) / t1.kassenumsatz_kl_absolut_netto_vj * 100 AS E227
,t1.kassenumsatz_kl_absolut_brutto AS E274
,t1.totalabschriften_wert_netto_absolut AS E232
,t1.preisabschriften_preisanderungen_wert_netto_absolut AS E314
,t1.preisabschriften_preisanderungen_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto * 100 AS E318
,t1.totalabschriften_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto * 100 AS E233
,((t1.totalabschriften_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto) - (t1.totalabschriften_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj)) / (t1.totalabschriften_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj) * 100 AS E326
,((t1.preisabschriften_preisanderungen_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto) - (t1.preisabschriften_preisanderungen_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj)) / (t1.preisabschriften_preisanderungen_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj) * 100 AS E330
,t3.user_id
FROM dbp_msi_view_ek_sort.tupel_kw_hilfsview_1 t1_1
JOIN dbp_data.tupel_mat_1 t2
ON t1.mandant_id=t2.mandant_id
AND t1.matching_id=t2.matching_id
LEFT JOIN dbp_security.user_zek_zu_1 t3
ON t1.mandant_id=t3.mandant_id
AND t2.a389_zek_id=t3.zek_id;