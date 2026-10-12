CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pep_plan_tag_1 (mandant_id, wup_id, nb_id, dat_plan,
dat_plan_tag_monat, dat_plan_wochentag, getraenkemarkt_fg, getraenkemarkt_bez, ref_wup_id, ref_dat_vj, ref_dat_vj_man,
ums_steigerung_faktor, ums_brutto_plan, ums_brutto_plan_hochrechnung, ums_brutto_plan_man, offen_fg_plan,
ref_betrag_bon_pos_brutto, ref_betrag_bon_brutto, anz_kunde_plan, registrierzeit_plan, zahlzeit_plan, kassierzeit_plan,
kassierzeit_pep_plan, kassierzeit_pep_ist, kassierzeit_bon_ist, kassierzeit_bon_std, kassierzeit_plan_inkl_ll,
kassierzeit_bon_std_inkl_ll, ums_brutto_ist_bondaten, registrierzeit_bon_ist, zahlzeit_bon_ist, anz_artikel, anz_kunden
, ereignistyp_id, ereignis_id) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_plan,
 CAST(FORMAT_DATE('%d.%m', V01.dat_plan) AS STRING) AS dat_plan_tag_monat,
 SUBSTR(V03.wtag_bez, 1, 2) AS dat_plan_wochentag,
 V01.getraenkemarkt_fg,
  CASE
  WHEN V01.getraenkemarkt_fg = 0
  THEN 'nur Markt'
  ELSE 'nur seperater Getränkemarkt'
  END AS getraenkemarkt_bez,
 V01.ref_wup_id,
 V01.ref_dat_vj,
 V01.ref_dat_vj_man,
 V01.ums_steigerung_faktor,
 V01.ums_brutto_plan,
  CASE
  WHEN V01.ums_brutto_plan_man <> 0
  THEN V01.ums_brutto_plan_man
  ELSE V01.ums_brutto_plan
  END AS ums_brutto_plan_hochrechnung,
 V01.ums_brutto_plan_man,
 V01.offen_fg_plan,
 V01.ref_betrag_bon_pos_brutto,
 V01.ref_betrag_bon_brutto,
 V01.anz_kunde_plan,
 V01.registrierzeit_plan,
 V01.zahlzeit_plan,
 V01.kassierzeit_plan,
 V01.kassierzeit_pep_plan,
 V01.kassierzeit_pep_ist,
 V01.kassierzeit_bon_ist,
 V01.kassierzeit_bon_std,
 V01.kassierzeit_plan_inkl_ll,
 V01.kassierzeit_bon_std_inkl_ll,
 V01.ums_brutto_ist_bondaten,
 V01.registrierzeit_bon_ist,
 V01.zahlzeit_bon_ist,
 V01.anz_artikel,
 V01.anz_kunden,
 v04.ereignistyp_id,
 v04.ereignis_id
FROM kfl_production_dbp_msi_v_view.v_pep_plan_tag_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat_plan = V02.dat
 INNER JOIN kfl_production_dbp_view.v_wtag_spr_zu_1 AS V03 ON V02.wtag_id = V03.wtag_id AND 22 = V03.spr_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   dat,
   ereignistyp_id,
   ereignis_id
  FROM kfl_production_dbp_view.v_wupcal_ereignis_zu_1 AS V04_1
  WHERE ereignistyp_id = 100) AS v04 ON V01.mandant_id = v04.mandant_id AND V01.wup_id = v04.wup_id AND V01.nb_id = v04
    .nb_id AND DATE_SUB(V01.dat_plan, INTERVAL 364 DAY) = v04.dat;