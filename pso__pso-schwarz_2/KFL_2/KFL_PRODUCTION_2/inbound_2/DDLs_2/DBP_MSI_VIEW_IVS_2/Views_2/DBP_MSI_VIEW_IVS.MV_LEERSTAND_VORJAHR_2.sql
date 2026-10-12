CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_LEERSTAND_VORJAHR_2
AS

   -- 2009-03-31
   -- Waehrung fix auf 'EUR'
   -- inklusive virtuelle mv_mvertrag_flaeche_zu_per_vj
   -- 2009KW17 REview; Anpassung mandant_wrg_typ
   -- 2011KW33 Anpassung nutzung_id von GF_2, HF, WO auf 310,300,320
   -- 2011KW33 in Basis-Taballe ivs_mietvertrag_fl_zu_per_2 fehlte dat_bis
   -- 2011KW33 flaeche_typ_id auskommentiert, da in MSI nicht verwendet bei dieser Tabelle
   -- 2011KW33 mietvertrag_id und konzessionaer_id von 0 auf '0' gestellt wegen Formatwechsel
   -- 2011KW33 flaecheart_id (A=T, ÷ entf‰llt, Z=A)
   -- 2011KW47 Ermittlung Flaechenstatus geaendert.
   -- 2011KW45 Ermittlung dat_frei_flaeche_seit aus ivs_flaeche_per_2
   -- 2013KW02 Transkription ergaenzt


   SELECT
   mvf.mandant_id,
   mvf.flaeche_id,
   mvf.dat_flaeche_uebergabe,
   mvf.dat_flaeche_rueckgabe AS leer_dat_flaeche_rueckgabe,
   mvf.dat_frei_flaeche_seit,
   mvf.flaeche_frei_seit_tagen AS leer_flaeche_frei_seit_tagen -- wichtig: alias
   ,
   mvf.miete_betrag,
   mvf.branche_id,
   b.branche_bez,
   mv.vertragart_id,
   mvf.immo_objekt_id,
   o.dat_objekt_oeffnung,
   dbp_process.transcriptc(o.objekt_ort) AS objekt_ort,
   vs.zustaendig_id  AS vorstand_Mitarbeiter_ID,
   vs.nachname       AS vorstand_nachname,
   ol.zustaendig_id  AS objektleiter_Mitarbeiter_ID,
   dbp_process.transcriptc(ol.nachname) AS objektleiter_nachname,
   f.flaecheart_id,
   CASE WHEN f.flaecheart_id IN ('I') THEN 4
   WHEN f.flaecheart_id IN ('V') THEN 5
   WHEN f.flaecheart_id IN ('T') THEN 7
   WHEN f.flaecheart_id IN ('U') THEN 8
   WHEN f.flaecheart_id IN ('A') THEN 9
   WHEN f.nutzung_id IN (300)    THEN 1
   WHEN f.nutzung_id IN (310)    THEN 2
   WHEN f.nutzung_id IN (320)    THEN 3
   ELSE 0
   END flaecheart_leerstand_id,
   CASE WHEN f.flaecheart_id IN ('I') THEN 'zu vermarktende Fl‰chen, nur mit Investitionsaufwand'
   WHEN f.flaecheart_id IN ('V') THEN 'Vermietungsfl‰chen an Vertrieb'
   WHEN f.flaecheart_id IN ('T') THEN 'Vetriebsfl‰chen an Vermietung'
   WHEN f.flaecheart_id IN ('U') THEN 'Umbaufl‰chen'
   WHEN f.flaecheart_id IN ('A') THEN 'zu vermietende Allgemeinfl‰chen'
   WHEN f.nutzung_id IN (300)    THEN 'Handelsfl‰chen'
   WHEN f.nutzung_id IN (310)    THEN 'Sonderfl‰chen'
   WHEN f.nutzung_id IN (320)    THEN 'Wohnungen'
   ELSE 'nicht definiert'
   END flaecheart_leerstand_bez,
   f.dat_existiert_seit,
   f.dat_existiert_bis,
   fs.std_vertragart_id,
   mvf.flaeche_status_id AS flaeche_status_id_neu,
   f.flaeche_groesse  leer_flaeche_groesse_vorjahr -- wichtig: alias
   ,
   CASE WHEN (mvf.flaeche_status_id NOT IN (4, 6, 7) AND leer_flaeche_frei_seit_tagen >= 30)
   OR f.flaecheart_id IN ('T')
   THEN 1
   ELSE 0
   END leerstand_vorjahr_fg,
   k.intern_fg,
   p.plan_wert_vormonat_avg AS leer_plan_wert_vorjahr -- wichtig: alias
   ,
   'EUR'::CHAR(3) AS wrg_id,
   0::BYTEINT AS wrg_typ_id
   FROM
   (
   SELECT
   mvf1.mandant_id  mandant_id,
   mvf1.flaeche_id  flaeche_id,
   MAX(mvf1.mietvertrag_id)  mietvertrag_id,
   MAX(mvf1.immo_objekt_id)  immo_objekt_id,
   MAX(COALESCE(mvfhist.dat_flaeche_rueckgabe, mvf1.dat_flaeche_rueckgabe))  dat_flaeche_rueckgabe,
   MAX(mvf1.dat_frei_flaeche_seit)  dat_frei_flaeche_seit,
   MAX(mvf1.flaeche_frei_seit_tagen)  flaeche_frei_seit_tagen,
   MAX(mvf1.dat_von )  dat_von,
   MAX(mvf1.dat_bis)  dat_bis,
   MAX(mvf1.dat_flaeche_uebergabe )  dat_flaeche_uebergabe,
   MAX(mvf1.miete_betrag )  miete_betrag,
   MAX(mvf1.branche_id)  branche_id,
   MAX(mvf1.flaeche_status_id) AS flaeche_status_id
   FROM
   (
   -- Vorjahr (analog mv_mvertrag_flaeche_zu_per_vm)
   SELECT
   mvf.mandant_id,
   mvf.mietvertrag_id,
   mvf.flaeche_id,
   mvf.dat_von,
   mvf.dat_bis,
   mvf.vertrag_aktiv_fg,
   mvf.immo_objekt_id,
   mvf.branche_id,
   mvf.dat_flaeche_uebergabe,
   mvf.dat_flaeche_rueckgabe,
   mvf.nebenkosten_betrag,
   mvf.miete_betrag,
   mvf.nebenkosten_abschlag,
   mvf.miete_umsatz_prozent,
   mvf.miete_referenz_id,
   mvf.mietart_id,
   f.dat_frei_flaeche_seit,
   CASE WHEN ADD_MONTHS(CURRENT_DATE,-12) >= f.dat_frei_flaeche_seit
   THEN ADD_MONTHS(CURRENT_DATE,-12) - f.dat_frei_flaeche_seit
   ELSE NULL
   END flaeche_frei_seit_tagen,
   mvf.miete_umsatz_abschlag,
   mvf.investmiete_betrag,
   mvf.sonst_betrag,
   mvf.immo_verw_betrag,
   mfszp.flaeche_status_id
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2  mvf
   INNER JOIN
   ( -- 2008-07-30 ABGRENZUNG (in Liste) zeitabh‰ngig
   SELECT
   mandant_id,
   flaeche_id,
   MAX(dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2
   WHERE wrg_id = 'EUR'
   AND (mandant_id, flaeche_id, dat_bis) IN
   (
   SELECT
   mandant_id,
   flaeche_id,
   MAX(dat_bis) dat_bis
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2

   WHERE ADD_MONTHS(CURRENT_DATE,-12) BETWEEN dat_von AND dat_bis

   GROUP BY mandant_id, flaeche_id
   )
   GROUP BY mandant_id, flaeche_id
   ) mvmax
   ON mvf.mandant_id = mvmax.mandant_id
   AND mvf.flaeche_id = mvmax.flaeche_id
   AND mvf.dat_flaeche_rueckgabe = mvmax.dat_flaeche_rueckgabe
   INNER JOIN dbp_view.v_ivs_Miet_Fl_Stat_Zu_Per_2 mfszp
   ON mfszp.Mandant_Id = mvf.Mandant_Id
   AND mfszp.Flaeche_Id = mvf.Flaeche_Id
   AND mfszp.mietvertrag_id = mvf.mietvertrag_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN mfszp.dat_von AND mfszp.dat_bis
   INNER JOIN dbp_view.v_ivs_flaeche_per_2 f
   ON mvf.mandant_id = f.mandant_id
   AND mvf.flaeche_id = f.flaeche_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN f.dat_von AND f.dat_bis

   WHERE ADD_MONTHS(CURRENT_DATE,-12) BETWEEN mvf.dat_von AND mvf.dat_bis
   AND mvf.wrg_id = 'EUR'

   UNION

   -- Flaechen die im Vorjahr im Leerstand waren
   SELECT
   f.mandant_id,
   '0' AS mietvertrag_id,
   f.flaeche_id,
   to_date('1900-01-01','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/ AS dat_von,
   to_date('9999-12-31','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/ AS dat_bis,
   '0' AS vertrag_aktiv_fg,
   f.immo_objekt_id,
   fs.std_branche_id AS branche_id,
   to_date('1900-01-01','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/ AS dat_flaeche_uebergabe,
   to_date('9999-12-31','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/ AS dat_flaeche_rueckgabe,
   0 AS nebenkosten_betrag,
   fs.std_miete_betrag AS miete_betrag,
   0 AS nebenkosten_abschlag,
   fs.std_miete_prozent AS miete_umsatz_prozent,
   NULL AS miete_referenz_id,
   NULL AS mietart_id,
   COALESCE(f.dat_frei_flaeche_seit, f.dat_existiert_seit) AS dat_frei_flaeche_seit,
   CASE WHEN ADD_MONTHS(CURRENT_DATE,-12) >= COALESCE(f.dat_frei_flaeche_seit, f.dat_existiert_seit)
   THEN ADD_MONTHS(CURRENT_DATE,-12) - COALESCE(f.dat_frei_flaeche_seit, f.dat_existiert_seit)
   ELSE NULL
   END AS flaeche_frei_seit_tagen,
   0 AS miete_umsatz_abschlag,
   0 AS investmiete_betrag,
   0 AS sonst_betrag,
   0 AS immo_verw_betrag,
   mfszp.flaeche_status_id
   FROM dbp_view.v_ivs_flaeche_per_2 f

   JOIN dbp_view.v_ivs_flaeche_standard_per_2 fs
   ON f.mandant_id = fs.mandant_id
   AND f.flaeche_id = fs.flaeche_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN fs.dat_von AND fs.dat_bis
   INNER JOIN dbp_view.v_ivs_Miet_Fl_Stat_Zu_Per_2 mfszp
   ON mfszp.Mandant_Id = f.Mandant_Id
   AND mfszp.Flaeche_Id = f.Flaeche_Id
   AND mfszp.mietvertrag_id = '0'
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN mfszp.dat_von AND mfszp.dat_bis

   WHERE ADD_MONTHS(CURRENT_DATE,-12) BETWEEN f.dat_von AND f.dat_bis
   AND (f.flaeche_id, f.mandant_id) NOT IN
   (
   SELECT
   flaeche_id,
   mandant_id
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2

   WHERE ADD_MONTHS(CURRENT_DATE,-12) BETWEEN dat_von AND dat_bis
   )
   ) mvf1
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id,
   flaeche_id,
   MAX(dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2

   WHERE dat_flaeche_rueckgabe IS NOT NULL
   AND dat_flaeche_rueckgabe < to_date('9999-12-31','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN dat_von AND dat_bis AND wrg_id='EUR'

   GROUP BY mandant_id, flaeche_id
   ) mvfhist
   ON mvf1.mandant_id = mvfhist.mandant_id
   AND mvf1.flaeche_id = mvfhist.flaeche_id

   GROUP BY
   mvf1.mandant_id
   ,mvf1.flaeche_id
   ) mvf
   LEFT OUTER JOIN dbp_view.v_ivs_flaeche_per_2 f
   ON mvf.flaeche_id = f.flaeche_id
   AND mvf.mandant_id = f.mandant_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN f.dat_von AND f.dat_bis
   LEFT OUTER JOIN dbp_view.v_ivs_flaeche_standard_per_2 fs
   ON mvf.flaeche_id = fs.flaeche_id
   AND mvf.mandant_id = fs.mandant_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN fs.dat_von AND fs.dat_bis
   LEFT OUTER JOIN
   (
   SELECT
   mv1.mandant_id,
   mv1.mietvertrag_id,
   mv1.dat_von,
   mv1.dat_bis,
   mv1.vertragart_id,
   mv1.vertrag_status_fg,
   mv1.konzessionaer_id,
   mv1.vermieter_id
   FROM dbp_view.v_ivs_mietvertrag_per_2 mv1
   WHERE ADD_MONTHS(CURRENT_DATE,-12) BETWEEN mv1.dat_von AND mv1.dat_bis

   UNION

   SELECT
   mm.mandant_id,
   '0' AS mietvertrag_id,
   to_date('1900-01-01','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/ AS dat_von,
   to_date('9999-12-31','YYYY-MM_2-DD') /*WARNING: CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED.*/ AS dat_bis,
   '000' AS vertragart_id,
   '0' AS vertrag_status_fg,
   '0' AS konzessionaer_id,
   mm.mandant_id * -1  AS vermieter_id
   FROM dbp_view.v_mandant_2 mm_2
   )  mv
   ON mvf.mietvertrag_id = mv.mietvertrag_id
   AND mvf.mandant_id = mv.mandant_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN mv.dat_von AND mv.dat_bis
   LEFT OUTER JOIN dbp_view.v_ivs_immo_objekt_per_2 o
   ON f.immo_objekt_id = o.immo_objekt_id
   AND f.mandant_id = o.mandant_id
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN o.dat_von AND o.dat_bis

   JOIN dbp_view.v_ivs_objekt_zustaendig_zu_per_2  o_vs
   ON o.immo_objekt_id = o_vs.immo_objekt_id
   AND o.mandant_id = o_vs.mandant_id
   AND o_vs.zustaendig_typ_id = 1
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN o_vs.dat_von AND o_vs.dat_bis

   JOIN dbp_view.v_ivs_immo_zustaendig_2  vs_2
   ON o_vs.zustaendig_id = vs.zustaendig_id

   JOIN dbp_view.v_ivs_objekt_zustaendig_zu_per_2 o_ol
   ON o.immo_objekt_id = o_ol.immo_objekt_id
   AND o.mandant_id = o_ol.mandant_id
   AND o_ol.zustaendig_typ_id = 2
   AND ADD_MONTHS(CURRENT_DATE,-12) BETWEEN o_ol.dat_von AND o_ol.dat_bis

   JOIN dbp_view.v_ivs_immo_zustaendig_2 ol
   ON o_ol.zustaendig_id = ol.zustaendig_id
   LEFT OUTER JOIN dbp_msi_view_ivs.mv_l_branche_2 b
   ON mvf.branche_id = b.branche_id
   AND mvf.mandant_id = b.mandant_id
   LEFT OUTER JOIN
   (
   SELECT
   konzessionaer_ID,
   mandant_ID,
   konzessionaer_branche_id,
   konzessionaer_rechtsform,
   CASE WHEN konzessionaer_id = '0'
   THEN 'E'
   ELSE intern_fg
   END::CHAR(1) intern_fg,
   dat_insolvenz_eintritt,
   CASE WHEN konzessionaer_id = '0'
   THEN ' '
   ELSE konzessionaer_name
   END konzessionaer_name,
   konzessionaer_strasse,
   land_id,
   konzessionaer_pLZ,
   konzessionaer_ort
   FROM dbp_view.v_ivs_konzessionaer_per_2
   WHERE ADD_MONTHS(CURRENT_DATE,-12) BETWEEN dat_von AND dat_bis
   ) k
   ON mv.konzessionaer_id = k.konzessionaer_id
   AND mv.mandant_id = k.mandant_id
   LEFT OUTER JOIN
   (
   SELECT
   p1.mandant_id,
   p1.plan_objekt_id,
   SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END)  anzahl,
   CASE WHEN anzahl = 0
   THEN SUM(p1.plan_wert)
   ELSE TRUNC( SUM(p1.plan_wert)/CAST(anzahl AS DECIMAL(18,6)))
   END AS plan_wert_vormonat_avg
   FROM dbp_view.v_ivs_plan_2 p1

   JOIN dbp_view.v_monat_2 mo1
   ON p1.kjmo = mo1.kjmo

   WHERE p1.plantyp_id =1
   AND p1.plandetail_id IN (1,80)
   AND (CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
   THEN mo1.akt_gj+1
   ELSE mo1.akt_gj
   END) = 0

   GROUP BY
   p1.mandant_id
   ,p1.plan_objekt_id
   )  p
   ON mvf.flaeche_id = p.plan_objekt_id
   AND mvf.mandant_id = p.mandant_id
   ;