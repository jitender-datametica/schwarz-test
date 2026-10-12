CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_LEERSTAND_2
AS
   -- 2009-03-31
   -- Berichtsview denormalisiert
   -- Waehrung fix auf EUR
   -- 2012KW25 : Initial von IVS nach VIS, ohne Währungsumrechnung
   -- 2013KW03 : Transkription
   -- 2013KW10 Erweiterung Kurs_2/Waehrungsumrechnung
   -- 20130409 UPDATE Logik Zwischenvermietung

   SELECT
   mvf.mandant_id, mvf.flaeche_id, mvf.mietvertrag_id, mvf.dat_von, mvf.dat_bis, mvf.dat_flaeche_uebergabe, mvf.dat_flaeche_rueckgabe  leer_dat_flaeche_rueckgabe, mvf.dat_frei_flaeche_seit, mvf.flaeche_frei_seit_tagen leer_flaeche_frei_seit_tagen  -- wichtig: alias
   , mvf.miete_betrag, mvf.branche_id, b.branche_bez, mv.vertragart_id, mvf.immo_objekt_id, o.dat_objekt_oeffnung, dbp_process.transcriptc(o.objekt_ort) AS objekt_ort, o.eigenmiete_pro_qm  leer_eigenmiete_qm, v.mitarbeiter_id     vorstand_Mitarbeiter_ID, v.nachname           vorstand_nachname, ol.mitarbeiter_id    objektleiter_Mitarbeiter_ID, dbp_process.transcriptc(ol.nachname) AS objektleiter_nachname, faktiv.aktivitaeten_gesamt, faktiv.ergebniss_gesamt, f.flaecheart_id, f.flaecheart_leerstand_id, f.flaecheart_leerstand_bez, f.dat_existiert_seit, f.dat_existiert_bis, f.std_vertragart_id, f.flaeche_status_id, f.flaeche_groesse AS leer_flaeche_groesse  -- wichtig: alias
   , CASE WHEN mvf.branche_id IN ('107','150','143')
   THEN 0
   ELSE f.flaeche_groesse
   END leer_flaeche_groesse_ohne_BM, f.flaeche_groesse * o.eigenmiete_pro_qm  mietaufwand_akt_monat, CASE WHEN f.flaecheart_id = 'T'
   THEN mietaufwand_akt_monat * ((CURRENT_DATE - temp.gj_anfang) / 30.00)
   ELSE CASE WHEN mvf.dat_frei_flaeche_seit > temp.gj_anfang THEN mietaufwand_akt_monat * (leer_flaeche_frei_seit_tagen / 30.00)
   WHEN mvf.dat_frei_flaeche_seit IS NULL          THEN NULL
   ELSE mietaufwand_akt_monat * ((CURRENT_DATE - temp.gj_anfang) / 30.00)
   END
   END  mietaufwand_aufg_gj, p.plan_wert_avg  leer_plan_wert_avg -- zusätzliches Feld
   , CASE WHEN f.flaecheart_id = 'T'
   THEN p.plan_wert_tag * (CURRENT_DATE - temp.gj_anfang)
   ELSE CASE WHEN mvf.dat_frei_flaeche_seit > temp.gj_anfang THEN p.plan_wert_tag * (leer_flaeche_frei_seit_tagen)
   WHEN mvf.dat_frei_flaeche_seit IS NULL THEN NULL
   ELSE p.plan_wert_tag * (CURRENT_DATE - temp.gj_anfang)
   END
   END  leer_plan_wert_tag  -- Berechnung analog mietaufwand_aufg_gj
   , CASE WHEN (f.flaeche_status_id NOT IN (4, 6, 7) AND leer_flaeche_frei_seit_tagen >= 30)
   OR (CURRENT_DATE - mvf.dat_flaeche_uebergabe BETWEEN 0 AND 30 AND mvf.vorher_leer_fg = 1)
   OR f.flaecheart_id IN ('T')
   THEN 1
   ELSE 0
   END  leerstandsbericht_fg, CASE WHEN (CURRENT_DATE - mvf.dat_flaeche_uebergabe BETWEEN 0 AND 30 AND mvf.vorher_leer_fg = 1)
   THEN 0
   ELSE 1
   END echter_leerstand_fg, mvf.vorher_leer_fg, k.intern_fg::CHAR(1) intern_fg, mvf.wrg_id
   FROM
   (
   SELECT
   mvf1.mandant_id  mandant_id, mvf1.flaeche_id  flaeche_id, mvf1.wrg_id, MAX(mvf1.mietvertrag_id)  mietvertrag_id, MAX(mvf1.immo_objekt_id)  immo_objekt_id, MAX(mvf1.dat_flaeche_rueckgabe)  dat_flaeche_rueckgabe, MAX(mvf1.dat_frei_flaeche_seit)  dat_frei_flaeche_seit, MAX(mvf1.flaeche_frei_seit_tagen)  flaeche_frei_seit_tagen, MAX(mvf1.dat_von)  dat_von, MAX(mvf1.dat_bis)  dat_bis, MAX(mvf1.dat_flaeche_uebergabe)  dat_flaeche_uebergabe, MAX(mvf1.miete_betrag)  miete_betrag, MAX(mvf1.branche_id)  branche_id, MAX(CASE WHEN COALESCE(mvfhist.dat_flaeche_rueckgabe, fp2.dat_existiert_seit) + 30 <= mvf1.dat_flaeche_uebergabe THEN 1 ELSE 0 END)::INTEGER vorher_leer_fg
   FROM dbp_msi_view_vis.mv_ivs_mietvertrag_flaeche_z_p_2  mvf1
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id, flaeche_id, wrg_id, MAX(dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2
   WHERE dat_flaeche_rueckgabe < to_date('9999-12-31','YYYY-MM_2-DD')
   GROUP BY mandant_id, flaeche_id, wrg_id
   ) mvfhist
   ON mvf1.mandant_id = mvfhist.mandant_id
   AND mvf1.flaeche_id = mvfhist.flaeche_id
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id, flaeche_id, dat_existiert_seit, dat_existiert_bis
   FROM dbp_view.v_ivs_flaeche_per_2
   WHERE CURRENT_DATE BETWEEN dat_existiert_seit AND dat_existiert_bis
   AND dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
   ) fp2
   ON mvf1.mandant_id = fp2.mandant_id
   AND mvf1.flaeche_id = fp2.flaeche_id

   WHERE mvf1.wrg_id = 'EUR'

   AND (mvf1.mandant_id, mvf1.flaeche_id) NOT IN ( -- ohne Zwischnenvermietung
   SELECT
   mvf.mandant_id, mvf.flaeche_id

   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2 mvf

   JOIN dbp_view.v_ivs_mietvertrag_per_2 mv
   ON mvf.mandant_id=mv.mandant_id
   AND mvf.mietvertrag_id=mv.mietvertrag_id

   JOIN dbp_view.v_ivs_flaeche_per_2 f
   ON mvf.mandant_id=f.mandant_id
   AND mvf.flaeche_id=f.flaeche_id

   WHERE mvf.dat_bis=to_date('9999-12-31','YYYY-MM_2-DD')
   AND CURRENT_DATE BETWEEN mvf.dat_flaeche_uebergabe AND mvf.dat_flaeche_rueckgabe
   AND mvf.dat_flaeche_uebergabe > to_date('1900-01-01','YYYY-MM_2-DD')

   AND mv.vertragart_id=360 AND mv.dat_bis=to_date('9999-12-31','YYYY-MM_2-DD')
   AND CURRENT_DATE BETWEEN mv.dat_vertrag_beginn AND mv.dat_vertrag_ende

   AND f.dat_bis=to_date('9999-12-31','YYYY-MM_2-DD')
   AND CURRENT_DATE BETWEEN f.dat_existiert_seit AND f.dat_existiert_bis
   AND f.flaeche_status_id=4
   )

   GROUP BY
   mvf1.mandant_id
   , mvf1.flaeche_id
   , mvf1.wrg_id


   UNION ALL
   -- Zwischnenvermietung

   SELECT
   mvf.mandant_id  mandant_id, mvf.flaeche_id  flaeche_id, 'EUR' AS wrg_id, mvf.mietvertrag_id  mietvertrag_id, mvf.immo_objekt_id  immo_objekt_id, mvf.dat_flaeche_rueckgabe  dat_flaeche_rueckgabe, CURRENT_DATE AS  dat_frei_flaeche_seit, 0 AS  flaeche_frei_seit_tagen, mvf.dat_von  dat_von, mvf.dat_bis  dat_bis, mvf.dat_flaeche_uebergabe  dat_flaeche_uebergabe, mvf.miete_betrag  miete_betrag, mvf.branche_id  branche_id, -1::INTEGER AS vorher_leer_fg
   FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2 mvf

   JOIN dbp_view.v_ivs_mietvertrag_per_2 mv
   ON mvf.mandant_id=mv.mandant_id
   AND mvf.mietvertrag_id=mv.mietvertrag_id

   JOIN dbp_view.v_ivs_flaeche_per_2 f
   ON mvf.mandant_id=f.mandant_id
   AND mvf.flaeche_id=f.flaeche_id

   WHERE mvf.dat_bis=to_date('9999-12-31','YYYY-MM_2-DD')
   AND CURRENT_DATE BETWEEN mvf.dat_flaeche_uebergabe AND mvf.dat_flaeche_rueckgabe
   AND mvf.dat_flaeche_uebergabe > to_date('1900-01-01','YYYY-MM_2-DD')

   AND mv.vertragart_id=360 AND mv.dat_bis=to_date('9999-12-31','YYYY-MM_2-DD')
   AND CURRENT_DATE BETWEEN mv.dat_vertrag_beginn AND mv.dat_vertrag_ende

   AND f.dat_bis=to_date('9999-12-31','YYYY-MM_2-DD')
   AND CURRENT_DATE BETWEEN f.dat_existiert_seit AND f.dat_existiert_bis
   AND f.flaeche_status_id=4
   ) mvf
   LEFT OUTER JOIN
   (
   SELECT
   p1.mandant_id, p1.plan_objekt_id  flaeche_id, SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) anzahl, CASE WHEN anzahl = 0 THEN SUM(p1.plan_wert * kurs_2)
   ELSE SUM(p1.plan_wert * kurs_2) / CAST(anzahl AS DECIMAL(18,6))
   END AS plan_wert_avg, plan_wert_avg / 30 AS  plan_wert_tag
   FROM dbp_view.v_ivs_plan_2 p1

   JOIN dbp_view.v_monat_2 mo1
   ON p1.kjmo = mo1.kjmo
   INNER JOIN dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per_2  kurs_2
   ON kurs.mandant_id = p1.mandant_id

   WHERE p1.plantyp_id = 1 AND p1.plandetail_id IN (1, 80)
   AND (CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
   THEN mo1.akt_gj + 1
   ELSE mo1.akt_gj
   END) = 0

   GROUP BY
   p1.mandant_id
   ,p1.plan_objekt_id
   )  p
   ON mvf.flaeche_id = p.flaeche_id
   AND mvf.mandant_id = p.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_flaeche_per_2 f
   ON mvf.flaeche_id = f.flaeche_id
   AND mvf.mandant_id = f.mandant_id
   AND f.wrg_id = mvf.wrg_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_flaeche_dn_aktivitaet_2  faktiv
   ON f.flaeche_id = faktiv.flaeche_id
   AND f.mandant_id = faktiv.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_immo_objekt_per_2 o
   ON f.immo_objekt_id = o.immo_objekt_id
   AND f.mandant_id = o.mandant_id
   AND o.wrg_id = mvf.wrg_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_mietvertrag_per_2 mv
   ON mvf.mietvertrag_id = mv.mietvertrag_id
   AND mvf.mandant_id = mv.mandant_id
   AND  mv.wrg_id = mvf.wrg_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_wup_vorstand_zu_per_2  wv
   ON o.immo_objekt_id = wv.immo_objekt_id
   AND o.mandant_id = wv.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_vorstand_2  v
   ON wv.mitarbeiter_id = v.mitarbeiter_id
   AND wv.mandant_id = v.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_wup_objektleiter_zu_per_2 wo
   ON o.immo_objekt_id = wo.immo_objekt_id
   AND o.mandant_id = wo.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_objektleiter_2 ol
   ON wo.mitarbeiter_id = ol.mitarbeiter_id
   AND wo.mandant_id = ol.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_l_branche_2     b
   ON mvf.branche_id = b.branche_id
   AND mvf.mandant_id = b.mandant_id
   LEFT OUTER JOIN dbp_msi_view_vis.mv_ivs_konzessionaer_per_2     k
   ON mv.konzessionaer_id = k.konzessionaer_id
   AND mv.mandant_id = k.mandant_id
   CROSS JOIN
   (
    SELECT
      to_date(to_char(kjmo) || '01', 'YYYYMMDD') gj_anfang
   FROM dbp_view.v_monat_2
   WHERE akt_gj = 0 AND mo_gj = 1
   ) TEMP
   ;