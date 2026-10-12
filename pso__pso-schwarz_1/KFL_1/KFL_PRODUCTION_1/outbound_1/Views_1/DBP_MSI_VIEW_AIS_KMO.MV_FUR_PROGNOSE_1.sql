CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_fur_prognose_1 (wup_id, nb_id, mandant_id, art_id, dat,
menge_prognose, menge_prognose_kolli, menge_prognose_bef, menge_prognose_bef_kolli, menge_prognose_max,
menge_prognose_max_kolli, menge_ofc, menge_ofc_kolli, gp_id, progn_groesser_fg, menge_af_groesser_fg) AS SELECT V01.wup_id
 ,
 V01.nb_id,
 V01.mandant_id,
 V01.art_id,
 V01.dat,
 CAST(V01.menge_prognose AS NUMERIC) AS menge_prognose,
 ROUND(CAST(V01.menge_prognose * COALESCE(V04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_prognose_kolli,
 CAST(V01.menge_prognose_bef AS NUMERIC) AS menge_prognose_bef,
 ROUND(CAST(V01.menge_prognose_bef * COALESCE(V04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_prognose_bef_kolli,
 CAST(V01.menge_prognose_max AS NUMERIC) AS menge_prognose_max,
 ROUND(CAST(V01.menge_prognose_max * COALESCE(V04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_prognose_max_kolli,
 CAST(V01.menge_ofc AS NUMERIC) AS menge_ofc,
 ROUND(CAST(V01.menge_ofc * COALESCE(V04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_ofc_kolli,
 V02.gp_id,
 V01.progn_groesser_fg,
 V01.menge_af_groesser_fg
FROM kfl_production_dbp_view.v_fur_prognose_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS V02 ON V01.art_id = V02.art_id AND V01.wup_id = V02.wup_id AND
    V01.mandant_id = V02.mandant_id AND V01.dat BETWEEN V02.dat_von AND V02.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V021 ON V01.mandant_id = V021.mandant_id AND V01.art_id = V021.art_id AND
   V021.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V03 ON V021.mandant_id = V03.mandant_id AND V021.art_id =
    V03.art_id AND V03.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.art_id
     = V04.art_id AND V03.ausg_menge_einh_id = V04.altnv_menge_einh_id AND V04.dat_bis = DATE '9999-12-31'
WHERE V01.mandant_id > 1
 AND V01.dispomerkmal IN ('S2', '10', '12', '14')
 AND V01.listung_id = 1
 AND V01.kdis = 0;