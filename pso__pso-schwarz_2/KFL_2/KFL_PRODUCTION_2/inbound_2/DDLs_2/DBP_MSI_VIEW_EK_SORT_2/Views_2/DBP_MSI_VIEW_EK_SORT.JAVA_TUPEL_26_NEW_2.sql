create or replace view DBP_MSI_VIEW_EK_SORT.JAVA_TUPEL_26_NEW_2(
	MANDANT_ID,
	MATCHING_ID,
	A5,
	A7,
	A9,
	E283,
	E287,
	E237,
	E267,
	E235,
	E156,
	E158,
	E160,
	E162,
	E164,
	E166,
	E168,
	E142,
	E144,
	E146,
	E148,
	E150,
	E152,
	E154,
	E170,
	E172,
	E174,
	E176,
	E178,
	E180,
	E157,
	E159,
	E161,
	E163,
	E165,
	E167,
	E169,
	E143,
	E145,
	E147,
	E149,
	E151,
	E153,
	E155,
	E171,
	E173,
	E175,
	E177,
	E179,
	E181,
	E362,
	E241,
	E247,
	E263,
	E271,
	E238,
	E350,
	E354,
	E242,
	E295,
	E299,
	E303,
	E307,
	E374,
	E243,
	E244,
	E311,
	E236,
	E239,
	E279,
	E291,
	E240,
	E275,
	E245,
	E315,
	E319,
	E246,
	E327,
	E331,
	USER_ID
) as

SELECT

t1.mandant_id

,t1.matching_id

,t2.A5_owg_id AS A5

,t2.A7_wg_id AS A7

,t2.wug_id AS A9

,t1.kassenumsatz_af_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_af AS E283

,((t1.kassenumsatz_af_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.kassenumsatz_af_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.kassenumsatz_af_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 AS E287

,t1.absatz_af_kl / t1.anzahl_markt_wochen_kombis_abverkauf_af AS E237

,((t1.absatz_af_kl / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.absatz_af_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.absatz_af_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 AS E267

,absatz_kl AS E235

,absatz_sst1 AS E156

,absatz_sst2 AS E158

,absatz_sst3 AS E160

,absatz_sst4 AS E162

,absatz_sst5 AS E164

,absatz_sst6 AS E166

,absatz_sst7 AS E168

,absatz_ksst1 AS E142

,absatz_ksst2 AS E144

,absatz_ksst3 AS E146

,absatz_ksst4 AS E148

,absatz_ksst5 AS E150

,absatz_ksst6 AS E152

,absatz_ksst7 AS E154

,absatz_ost_basis AS E170

,absatz_ost_gross AS E172

,absatz_sued_ost AS E174

,absatz_sued_west AS E176

,absatz_west AS E178

,absatz_nord AS E180

,absatz_sst1 / t1.markt_wochen_sst1 AS E157

,absatz_sst2 / t1.markt_wochen_sst2 AS E159

,absatz_sst3 / t1.markt_wochen_sst3 AS E161

,absatz_sst4 / t1.markt_wochen_sst4 AS E163

,absatz_sst5 / t1.markt_wochen_sst5 AS E165

,absatz_sst6 / t1.markt_wochen_sst6 AS E167

,absatz_sst7 / t1.markt_wochen_sst7 AS E169

,absatz_ksst1 / t1.markt_wochen_ksst1 AS E143

,absatz_ksst2 / t1.markt_wochen_ksst2 AS E145

,absatz_ksst3 / t1.markt_wochen_ksst3 AS E147

,absatz_ksst4 / t1.markt_wochen_ksst4 AS E149

,absatz_ksst5 / t1.markt_wochen_ksst5 AS E151

,absatz_ksst6 / t1.markt_wochen_ksst6 AS E153

,absatz_ksst7 / t1.markt_wochen_ksst7 AS E155

,t1.absatz_ost_basis / t1.markt_wochen_ost_basis AS E171

,t1.absatz_ost_gross / t1.markt_wochen_ost_gross AS E173

,t1.absatz_sued_ost / t1.markt_wochen_sued_ost AS E175

,t1.absatz_sued_west / t1.markt_wochen_sued_west AS E177

,t1.absatz_west / t1.markt_wochen_west AS E179

,t1.absatz_nord / t1.markt_wochen_nord AS E181

,t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung / t1.anzahl_markt_wochen_kombis_listung *100 AS E362

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE rohertrag_ekmep_olk_4n END AS E241

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE rohertrag_ekmep_olk_4n / absatz_kl END AS E247

,t1.absatz_sa_kl / t1.anzahl_markt_wochen_kombis_abverkauf_sa AS E263

,((t1.absatz_sa_kl / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.absatz_sa_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.absatz_sa_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 AS E271

,t1.absatz_sa_kl / t1.absatz_kl * 100 AS E238

,t1.anz_bons_af / t1.anz_bons_gesamt AS E350

,t1.anz_bons_sa / t1.anz_bons_gesamt AS E354

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n - t1.rohertrag_ekmep_olk_4n_vj END AS E242

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_af / t1.anzahl_markt_wochen_kombis_abverkauf_af END AS E295

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_sa / t1.anzahl_markt_wochen_kombis_abverkauf_sa END AS E299

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE ((t1.rohertrag_ekmep_olk_4n_af / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.rohertrag_ekmep_olk_4n_af_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.rohertrag_ekmep_olk_4n_af_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 END AS E303

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE ((t1.rohertrag_ekmep_olk_4n_sa / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.rohertrag_ekmep_olk_4n_sa_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.rohertrag_ekmep_olk_4n_sa_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 END AS E307

,t1.kassenumsatz_af_kl_absolut_brutto / t1.absatz_af_kl AS E374

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE A23_rohertrag_ekmep_olk_4n / t1.kassenumsatz_kl_absolut_netto * 100 END AS E243

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_af / t1.kassenumsatz_af_kl_absolut_netto END AS E244

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_sa / t1.kassenumsatz_sa_kl_absolut_netto END AS E311

,(t1.absatz_kl - t1.absatz_kl_vj) / t1.absatz_kl_vj * 100 AS E236

,kassenumsatz_kl_absolut_netto AS E239

,t1.kassenumsatz_sa_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_sa AS E279

,((t1.kassenumsatz_sa_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.kassenumsatz_sa_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.kassenumsatz_sa_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 AS E291

,(t1.kassenumsatz_kl_absolut_netto - t1.kassenumsatz_kl_absolut_netto_vj) / t1.kassenumsatz_kl_absolut_netto_vj * 100 AS E240

,t1.kassenumsatz_kl_absolut_brutto AS E275

,t1.totalabschriften_wert_netto_absolut AS E245

,t1.preisabschriften_preisanderungen_wert_netto_absolut AS E315

,t1.preisabschriften_preisanderungen_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto * 100 AS E319

,t1.totalabschriften_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto * 100 AS E246

,((t1.totalabschriften_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto) - (t1.totalabschriften_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj)) / (t1.totalabschriften_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj) * 100 AS E327

,((t1.preisabschriften_preisanderungen_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto) - (t1.preisabschriften_preisanderungen_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj)) / (t1.preisabschriften_preisanderungen_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj) * 100 AS E331

,t3.user_id

FROM dbp_msi_view_ek_sort.tupel_kw_hilfsview_2 t1_2

JOIN dbp_data.tupel_mat_2 t2

ON t1.mandant_id=t2.mandant_id

AND t1.matching_id=t2.matching_id

LEFT JOIN dbp_security.user_zek_zu_2 t3

ON t1.mandant_id=t3.mandant_id

AND t2.a389_zek_id=t3.zek_id;