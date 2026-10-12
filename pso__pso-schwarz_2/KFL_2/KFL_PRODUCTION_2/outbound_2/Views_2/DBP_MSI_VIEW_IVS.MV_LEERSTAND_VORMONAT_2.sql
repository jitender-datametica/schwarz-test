CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_leerstand_vormonat_2 AS SELECT mvf.mandant_id,
 mvf.flaeche_id,
 mvf.dat_flaeche_uebergabe,
 mvf.dat_flaeche_rueckgabe AS leer_dat_flaeche_rueckgabe,
 mvf.dat_frei_flaeche_seit,
 mvf.flaeche_frei_seit_tagen AS leer_flaeche_frei_seit_tagen,
 mvf.miete_betrag,
 mvf.branche_id,
 B.branche_bez,
 mv.vertragart_id,
 mvf.immo_objekt_id,
 O.dat_objekt_oeffnung,
 kfl_production_dbp_process.transcriptc(O.objekt_ort) AS objekt_ort,
 VS.zustaendig_id AS vorstand_mitarbeiter_id,
 VS.nachname AS vorstand_nachname,
 OL.zustaendig_id AS objektleiter_mitarbeiter_id,
 kfl_production_dbp_process.transcriptc(OL.nachname) AS objektleiter_nachname,
 F0.flaecheart_id,
  CASE
  WHEN F0.flaecheart_id IN ('I')
  THEN 4
  WHEN F0.flaecheart_id IN ('V')
  THEN 5
  WHEN F0.flaecheart_id IN ('T')
  THEN 7
  WHEN F0.flaecheart_id IN ('U')
  THEN 8
  WHEN F0.flaecheart_id IN ('A')
  THEN 9
  WHEN F0.nutzung_id IN (300)
  THEN 1
  WHEN F0.nutzung_id IN (310)
  THEN 2
  WHEN F0.nutzung_id IN (320)
  THEN 3
  ELSE 0
  END AS flaecheart_leerstand_id,
  CASE
  WHEN F0.flaecheart_id IN ('I')
  THEN 'zu vermarktende Fl‰chen, nur mit Investitionsaufwand'
  WHEN F0.flaecheart_id IN ('V')
  THEN 'Vermietungsfl‰chen an Vertrieb'
  WHEN F0.flaecheart_id IN ('T')
  THEN 'Vetriebsfl‰chen an Vermietung'
  WHEN F0.flaecheart_id IN ('U')
  THEN 'Umbaufl‰chen'
  WHEN F0.flaecheart_id IN ('A')
  THEN 'zu vermietende Allgemeinfl‰chen'
  WHEN F0.nutzung_id IN (300)
  THEN 'Handelsfl‰chen'
  WHEN F0.nutzung_id IN (310)
  THEN 'Sonderfl‰chen'
  WHEN F0.nutzung_id IN (320)
  THEN 'Wohnungen'
  ELSE 'nicht definiert'
  END AS flaecheart_leerstand_bez,
 F0.dat_existiert_seit,
 F0.dat_existiert_bis,
 FS0.std_vertragart_id,
 mvf.flaeche_status_id AS flaeche_status_id_neu,
 F0.flaeche_groesse AS leer_flaeche_groesse_vormonat,
  CASE
  WHEN mvf.flaeche_status_id NOT IN (4, 6, 7) AND mvf.flaeche_frei_seit_tagen >= 30 OR F0.flaecheart_id IN ('T')
  THEN 1
  ELSE 0
  END AS leerstand_vormonat_fg,
 k.intern_fg,
 p.plan_wert_vormonat_avg AS leer_plan_wert_vormonat,
 SUBSTR('EUR', 1, 3) AS wrg_id,
 0 AS wrg_typ_id
FROM (SELECT mvf1.mandant_id,
   mvf1.flaeche_id,
   MAX(mvf1.mietvertrag_id) AS mietvertrag_id,
   MAX(mvf1.immo_objekt_id) AS immo_objekt_id,
   MAX(COALESCE(mvfhist.dat_flaeche_rueckgabe, mvf1.dat_flaeche_rueckgabe)) AS dat_flaeche_rueckgabe,
   MAX(mvf1.dat_frei_flaeche_seit) AS dat_frei_flaeche_seit,
   MAX(mvf1.flaeche_frei_seit_tagen) AS flaeche_frei_seit_tagen,
   MAX(mvf1.dat_von) AS dat_von,
   MAX(mvf1.dat_bis) AS dat_bis,
   MAX(mvf1.dat_flaeche_uebergabe) AS dat_flaeche_uebergabe,
   MAX(mvf1.miete_betrag) AS miete_betrag,
   MAX(mvf1.branche_id) AS branche_id,
   MAX(mvf1.flaeche_status_id) AS flaeche_status_id
  FROM (SELECT MVF.mandant_id,
      MVF.mietvertrag_id,
      MVF.flaeche_id,
      MVF.dat_von,
      MVF.dat_bis,
      MVF.vertrag_aktiv_fg,
      MVF.immo_objekt_id,
      MVF.branche_id,
      MVF.dat_flaeche_uebergabe,
      MVF.dat_flaeche_rueckgabe,
      MVF.nebenkosten_betrag,
      MVF.miete_betrag,
      MVF.nebenkosten_abschlag,
      MVF.miete_umsatz_prozent,
      MVF.miete_referenz_id,
      MVF.mietart_id,
      F.dat_frei_flaeche_seit,
       CASE
       WHEN IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
          ,INTERVAL - 1 MONTH)) >= F.dat_frei_flaeche_seit
       THEN DATE_DIFF(IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)),
         DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), F.dat_frei_flaeche_seit, DAY)
       ELSE NULL
       END AS flaeche_frei_seit_tagen,
      MVF.miete_umsatz_abschlag,
      MVF.investmiete_betrag,
      MVF.sonst_betrag,
      MVF.immo_verw_betrag,
      MFSZP.flaeche_status_id
     FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_2 AS MVF
      INNER JOIN (SELECT mandant_id,
        flaeche_id,
        MAX(dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe
       FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_2
       WHERE wrg_id = 'EUR'
        AND (mandant_id, flaeche_id, dat_bis) IN (SELECT (mandant_id, flaeche_id, MAX(dat_bis))
          FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_2
          WHERE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
              ,INTERVAL - 1 MONTH)) BETWEEN dat_von AND dat_bis
          GROUP BY mandant_id,
           flaeche_id)
       GROUP BY mandant_id,
        flaeche_id) AS mvmax ON MVF.mandant_id = mvmax.mandant_id AND MVF.flaeche_id = mvmax.flaeche_id AND MVF.dat_flaeche_rueckgabe
         = mvmax.dat_flaeche_rueckgabe
      INNER JOIN kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2 AS MFSZP ON MVF.mandant_id = MFSZP.mandant_id AND MVF
          .flaeche_id = MFSZP.flaeche_id AND MVF.mietvertrag_id = MFSZP.mietvertrag_id AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE
           ), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN
        MFSZP.dat_von AND MFSZP.dat_bis
      INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_per_2 AS F ON MVF.mandant_id = F.mandant_id AND MVF.flaeche_id = F
         .flaeche_id AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH))
         , DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN F.dat_von AND F.dat_bis
     WHERE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
         ,INTERVAL - 1 MONTH)) BETWEEN MVF.dat_von AND MVF.dat_bis
      AND MVF.wrg_id = 'EUR'
     UNION DISTINCT
     SELECT F.mandant_id,
      '0' AS mietvertrag_id,
      F.flaeche_id,
      PARSE_DATE('%F', '1900-01-01') AS dat_von,
      PARSE_DATE('%F', '9999-12-31') AS dat_bis,
      '0' AS vertrag_aktiv_fg,
      F.immo_objekt_id,
      FS.std_branche_id AS branche_id,
      PARSE_DATE('%F', '1900-01-01') AS dat_flaeche_uebergabe,
      PARSE_DATE('%F', '9999-12-31') AS dat_flaeche_rueckgabe,
      0 AS nebenkosten_betrag,
      FS.std_miete_betrag AS miete_betrag,
      0 AS nebenkosten_abschlag,
      FS.std_miete_prozent AS miete_umsatz_prozent,
      CAST(NULL AS STRING) AS miete_referenz_id,
      CAST(NULL AS STRING) AS mietart_id,
      COALESCE(F.dat_frei_flaeche_seit, F.dat_existiert_seit) AS dat_frei_flaeche_seit,
       CASE
       WHEN IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
          ,INTERVAL - 1 MONTH)) >= COALESCE(F.dat_frei_flaeche_seit, F.dat_existiert_seit)
       THEN DATE_DIFF(IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)),
         DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), COALESCE(F.dat_frei_flaeche_seit, F.dat_existiert_seit), DAY)
       ELSE NULL
       END AS flaeche_frei_seit_tagen,
      0 AS miete_umsatz_abschlag,
      0 AS investmiete_betrag,
      0 AS sonst_betrag,
      0 AS immo_verw_betrag,
      MFSZP.flaeche_status_id
     FROM kfl_production_dbp_view.v_ivs_flaeche_per_2 AS F
      INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_standard_per_2 AS FS ON F.mandant_id = FS.mandant_id AND F.flaeche_id
          = FS.flaeche_id AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1
           MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN FS.dat_von AND FS.dat_bis
      INNER JOIN kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2 AS MFSZP ON F.mandant_id = MFSZP.mandant_id AND F.flaeche_id
           = MFSZP.flaeche_id AND MFSZP.mietvertrag_id = '0' AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE
           ,INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN MFSZP.dat_von AND MFSZP.dat_bis
     WHERE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
         ,INTERVAL - 1 MONTH)) BETWEEN F.dat_von AND F.dat_bis
      AND (F.flaeche_id, F.mandant_id) NOT IN (SELECT (flaeche_id, mandant_id)
        FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_2
        WHERE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
            ,INTERVAL - 1 MONTH)) BETWEEN dat_von AND dat_bis)) AS mvf1
   LEFT JOIN (SELECT mandant_id,
     flaeche_id,
     MAX(dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe
    FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_2
    WHERE dat_flaeche_rueckgabe IS NOT NULL
     AND dat_flaeche_rueckgabe < PARSE_DATE('%F', '9999-12-31')
     AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
        ,INTERVAL - 1 MONTH)) BETWEEN dat_von AND dat_bis
    GROUP BY mandant_id,
     flaeche_id) AS mvfhist ON mvf1.mandant_id = mvfhist.mandant_id AND mvf1.flaeche_id = mvfhist.flaeche_id
  GROUP BY mvf1.mandant_id,
   mvf1.flaeche_id) AS mvf
 LEFT JOIN kfl_production_dbp_view.v_ivs_flaeche_per_2 AS F0 ON mvf.flaeche_id = F0.flaeche_id AND mvf.mandant_id = F0.mandant_id
     AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL - 1 MONTH)) BETWEEN F0.dat_von AND F0.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_ivs_flaeche_standard_per_2 AS FS0 ON mvf.flaeche_id = FS0.flaeche_id AND mvf.mandant_id
     = FS0.mandant_id AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)
     ), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN FS0.dat_von AND FS0.dat_bis
 LEFT JOIN (SELECT mandant_id,
    mietvertrag_id,
    dat_von,
    dat_bis,
    vertragart_id,
    vertrag_status_fg,
    konzessionaer_id,
    vermieter_id
   FROM kfl_production_dbp_view.v_ivs_mietvertrag_per_2 AS MV1
   WHERE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL - 1 MONTH)) BETWEEN dat_von AND dat_bis
   UNION DISTINCT
   SELECT mandant_id,
    '0' AS mietvertrag_id,
    PARSE_DATE('%F', '1900-01-01') AS dat_von,
    PARSE_DATE('%F', '9999-12-31') AS dat_bis,
    '000' AS vertragart_id,
    '0' AS vertrag_status_fg,
    '0' AS konzessionaer_id,
     mandant_id * - 1 AS vermieter_id
   FROM kfl_production_dbp_view.v_mandant_2 AS MM_2) AS mv ON mvf.mietvertrag_id = mv.mietvertrag_id AND mvf.mandant_id = mv
    .mandant_id AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)),
    DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN mv.dat_von AND mv.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_ivs_immo_objekt_per_2 AS O ON F0.immo_objekt_id = O.immo_objekt_id AND F0.mandant_id
    = O.mandant_id AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)),
    DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN O.dat_von AND O.dat_bis
 INNER JOIN kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS O_VS ON O.immo_objekt_id = O_VS.immo_objekt_id AND
     O.mandant_id = O_VS.mandant_id AND O_VS.zustaendig_typ_id = 1 AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE),
    LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN O_VS.dat_von
   AND O_VS.dat_bis
 INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_2 AS VS_2 ON O_VS.zustaendig_id = VS.zustaendig_id
 INNER JOIN kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS O_OL ON O.immo_objekt_id = O_OL.immo_objekt_id AND
     O.mandant_id = O_OL.mandant_id AND O_OL.zustaendig_typ_id = 2 AND IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE),
    LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)) BETWEEN O_OL.dat_von
   AND O_OL.dat_bis
 INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_2 AS OL ON O_OL.zustaendig_id = OL.zustaendig_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_l_branche_2 AS B ON mvf.branche_id = B.branche_id AND mvf.mandant_id = B.mandant_id
   
 LEFT JOIN (SELECT konzessionaer_id,
   mandant_id,
   konzessionaer_branche_id,
   konzessionaer_rechtsform,
   SUBSTR(CAST(CASE
      WHEN konzessionaer_id = '0'
      THEN 'E'
      ELSE intern_fg
      END AS STRING), 1, 1) AS intern_fg,
   dat_insolvenz_eintritt,
    CASE
    WHEN konzessionaer_id = '0'
    THEN ' '
    ELSE konzessionaer_name
    END AS konzessionaer_name,
   konzessionaer_strasse,
   land_id,
   konzessionaer_plz,
   konzessionaer_ort
  FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_2
  WHERE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE
      ,INTERVAL - 1 MONTH)) BETWEEN dat_von AND dat_bis) AS k ON mv.konzessionaer_id = k.konzessionaer_id AND mv.mandant_id
    = k.mandant_id
 LEFT JOIN (SELECT P1.mandant_id,
   P1.plan_objekt_id,
   SUM(CASE
     WHEN P1.plan_wert > 0
     THEN 1
     ELSE 0
     END) AS anzahl,
    CASE
    WHEN SUM(CASE
       WHEN P1.plan_wert > 0
       THEN 1
       ELSE 0
       END) = 0
    THEN SUM(P1.plan_wert)
    ELSE TRUNC(CAST(SUM(P1.plan_wert) / CAST(SUM(CASE
          WHEN P1.plan_wert > 0
          THEN 1
          ELSE 0
          END) AS NUMERIC) AS BIGNUMERIC))
    END AS plan_wert_vormonat_avg
  FROM kfl_production_dbp_view.v_ivs_plan_2 AS P1
   INNER JOIN kfl_production_dbp_view.v_monat_2 AS MO1 ON P1.kjmo = MO1.kjmo
  WHERE P1.plantyp_id = 1
   AND P1.plandetail_id IN (1, 80)
   AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
     THEN MO1.akt_gj + 1
     ELSE MO1.akt_gj
     END = 0
  GROUP BY P1.mandant_id,
   P1.plan_objekt_id) AS p ON mvf.flaeche_id = p.plan_objekt_id AND mvf.mandant_id = p.mandant_id;

