
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_leerstand_1 AS SELECT mvf.mandant_id,
 mvf.flaeche_id,
 mvf.mietvertrag_id,
 mvf.dat_von,
 mvf.dat_bis,
 mvf.dat_flaeche_uebergabe,
 mvf.dat_flaeche_rueckgabe AS leer_dat_flaeche_rueckgabe,
 mvf.dat_frei_flaeche_seit,
 mvf.flaeche_frei_seit_tagen AS leer_flaeche_frei_seit_tagen,
 mvf.miete_betrag,
 mvf.branche_id,
 B.branche_bez,
 MV0.vertragart_id,
 mvf.immo_objekt_id,
 O.dat_objekt_oeffnung,
 kfl_production_dbp_process.transcriptc(O.objekt_ort) AS objekt_ort,
 O.eigenmiete_pro_qm AS leer_eigenmiete_qm,
 V.mitarbeiter_id AS vorstand_mitarbeiter_id,
 V.nachname AS vorstand_nachname,
 OL.mitarbeiter_id AS objektleiter_mitarbeiter_id,
 kfl_production_dbp_process.transcriptc(OL.nachname) AS objektleiter_nachname,
 FAKTIV.aktivitaeten_gesamt,
 FAKTIV.ergebniss_gesamt,
 F0.flaecheart_id,
 F0.flaecheart_leerstand_id,
 F0.flaecheart_leerstand_bez,
 F0.dat_existiert_seit,
 F0.dat_existiert_bis,
 F0.std_vertragart_id,
 F0.flaeche_status_id,
 F0.flaeche_groesse AS leer_flaeche_groesse,
  CASE
  WHEN mvf.branche_id IN ('107', '150', '143')
  THEN 0
  ELSE F0.flaeche_groesse
  END AS leer_flaeche_groesse_ohne_bm,
  F0.flaeche_groesse * O.eigenmiete_pro_qm AS mietaufwand_akt_monat,
  CASE
  WHEN F0.flaecheart_id = 'T'
  THEN F0.flaeche_groesse * O.eigenmiete_pro_qm * TRUNC(CAST(DATE_DIFF(CURRENT_DATE, TEMP.gj_anfang, DAY) / 30.00 AS BIGNUMERIC)
    )
  ELSE CASE
   WHEN mvf.dat_frei_flaeche_seit > TEMP.gj_anfang
   THEN F0.flaeche_groesse * O.eigenmiete_pro_qm * TRUNC(CAST(mvf.flaeche_frei_seit_tagen / 30.00 AS BIGNUMERIC))
   WHEN mvf.dat_frei_flaeche_seit IS NULL
   THEN NULL
   ELSE F0.flaeche_groesse * O.eigenmiete_pro_qm * TRUNC(CAST(DATE_DIFF(CURRENT_DATE, TEMP.gj_anfang, DAY) / 30.00 AS BIGNUMERIC)
     )
   END
  END AS mietaufwand_aufg_gj,
 p.plan_wert_avg AS leer_plan_wert_avg,
  CASE
  WHEN F0.flaecheart_id = 'T'
  THEN p.plan_wert_tag * DATE_DIFF(CURRENT_DATE, TEMP.gj_anfang, DAY)
  ELSE CASE
   WHEN mvf.dat_frei_flaeche_seit > TEMP.gj_anfang
   THEN p.plan_wert_tag * mvf.flaeche_frei_seit_tagen
   WHEN mvf.dat_frei_flaeche_seit IS NULL
   THEN NULL
   ELSE p.plan_wert_tag * DATE_DIFF(CURRENT_DATE, TEMP.gj_anfang, DAY)
   END
  END AS leer_plan_wert_tag,
  CASE
  WHEN F0.flaeche_status_id NOT IN (4, 6, 7) AND mvf.flaeche_frei_seit_tagen >= 30 OR DATE_DIFF(CURRENT_DATE, mvf.dat_flaeche_uebergabe
       ,DAY) BETWEEN 0 AND 30 AND mvf.vorher_leer_fg = 1 OR F0.flaecheart_id IN ('T')
  THEN 1
  ELSE 0
  END AS leerstandsbericht_fg,
  CASE
  WHEN DATE_DIFF(CURRENT_DATE, mvf.dat_flaeche_uebergabe, DAY) BETWEEN 0 AND 30 AND mvf.vorher_leer_fg = 1
  THEN 0
  ELSE 1
  END AS echter_leerstand_fg,
 mvf.vorher_leer_fg,
 SUBSTR(CAST(K.intern_fg AS STRING), 1, 1) AS intern_fg,
 mvf.wrg_id,
 mvf.wrg_typ_id
FROM (SELECT MVF1.mandant_id,
    MVF1.flaeche_id,
    MVF1.wrg_id,
    MVF1.wrg_typ_id,
    MAX(MVF1.mietvertrag_id) AS mietvertrag_id,
    MAX(MVF1.immo_objekt_id) AS immo_objekt_id,
    MAX(MVF1.dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe,
    MAX(MVF1.dat_frei_flaeche_seit) AS dat_frei_flaeche_seit,
    MAX(MVF1.flaeche_frei_seit_tagen) AS flaeche_frei_seit_tagen,
    MAX(MVF1.dat_von) AS dat_von,
    MAX(MVF1.dat_bis) AS dat_bis,
    MAX(MVF1.dat_flaeche_uebergabe) AS dat_flaeche_uebergabe,
    MAX(MVF1.miete_betrag) AS miete_betrag,
    MAX(MVF1.branche_id) AS branche_id,
    CAST(MAX(CASE
       WHEN DATE_ADD(COALESCE(mvfhist.dat_flaeche_rueckgabe, fp2.dat_existiert_seit), INTERVAL 30 DAY) <= MVF1.dat_flaeche_uebergabe
       THEN 1
       ELSE 0
       END) AS BIGNUMERIC) AS vorher_leer_fg
   FROM kfl_production_dbp_msi_view_ivs.mv_mietvertrag_flaeche_zu_per_1 AS MVF1
    LEFT JOIN (SELECT mandant_id,
      flaeche_id,
      wrg_id,
      MAX(dat_flaeche_rueckgabe) AS dat_flaeche_rueckgabe
     FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_1
     WHERE dat_flaeche_rueckgabe < PARSE_DATE('%F', '9999-12-31')
     GROUP BY mandant_id,
      flaeche_id,
      wrg_id) AS mvfhist ON MVF1.mandant_id = mvfhist.mandant_id AND MVF1.flaeche_id = mvfhist.flaeche_id
    LEFT JOIN (SELECT mandant_id,
      flaeche_id,
      dat_existiert_seit,
      dat_existiert_bis
     FROM kfl_production_dbp_view.v_ivs_flaeche_per_1
     WHERE CURRENT_DATE BETWEEN dat_existiert_seit AND dat_existiert_bis
      AND dat_bis = PARSE_DATE('%F', '9999-12-31')) AS fp2 ON MVF1.mandant_id = fp2.mandant_id AND MVF1.flaeche_id = fp2
      .flaeche_id
   WHERE MVF1.wrg_id = 'EUR'
    AND MVF1.wrg_typ_id = 0
    AND (MVF1.mandant_id, MVF1.flaeche_id) NOT IN (SELECT (MVF.mandant_id, MVF.flaeche_id)
      FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_1 AS MVF
       INNER JOIN kfl_production_dbp_view.v_ivs_mietvertrag_per_1 AS MV ON MVF.mandant_id = MV.mandant_id AND MVF.mietvertrag_id
          = MV.mietvertrag_id
       INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_per_1 AS F ON MVF.mandant_id = F.mandant_id AND MVF.flaeche_id = F
         .flaeche_id
      WHERE MVF.dat_bis = PARSE_DATE('%F', '9999-12-31')
       AND CURRENT_DATE BETWEEN MVF.dat_flaeche_uebergabe AND MVF.dat_flaeche_rueckgabe
       AND MVF.dat_flaeche_uebergabe > PARSE_DATE('%F', '1900-01-01')
       AND CAST(MV.vertragart_id AS FLOAT64) = 360
       AND MV.dat_bis = PARSE_DATE('%F', '9999-12-31')
       AND CURRENT_DATE BETWEEN MV.dat_vertrag_beginn AND MV.dat_vertrag_ende
       AND F.dat_bis = PARSE_DATE('%F', '9999-12-31')
       AND CURRENT_DATE BETWEEN F.dat_existiert_seit AND F.dat_existiert_bis
       AND F.flaeche_status_id = 4)
   GROUP BY MVF1.mandant_id,
    MVF1.flaeche_id,
    MVF1.wrg_id,
    MVF1.wrg_typ_id
   UNION ALL
   SELECT MVF.mandant_id,
    MVF.flaeche_id,
    'EUR' AS wrg_id,
    0 AS wrg_typ_id,
    MVF.mietvertrag_id,
    MVF.immo_objekt_id,
    MVF.dat_flaeche_rueckgabe,
    CURRENT_DATE AS dat_frei_flaeche_seit,
    0 AS flaeche_frei_seit_tagen,
    MVF.dat_von,
    MVF.dat_bis,
    MVF.dat_flaeche_uebergabe,
    MVF.miete_betrag,
    MVF.branche_id,
    - 1 AS vorher_leer_fg
   FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per_1 AS MVF
    INNER JOIN kfl_production_dbp_view.v_ivs_mietvertrag_per_1 AS MV ON MVF.mandant_id = MV.mandant_id AND MVF.mietvertrag_id
       = MV.mietvertrag_id
    INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_per_1 AS F ON MVF.mandant_id = F.mandant_id AND MVF.flaeche_id = F.flaeche_id
      
   WHERE MVF.dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND CURRENT_DATE BETWEEN MVF.dat_flaeche_uebergabe AND MVF.dat_flaeche_rueckgabe
    AND MVF.dat_flaeche_uebergabe > PARSE_DATE('%F', '1900-01-01')
    AND CAST(MV.vertragart_id AS FLOAT64) = 360
    AND MV.dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND CURRENT_DATE BETWEEN MV.dat_vertrag_beginn AND MV.dat_vertrag_ende
    AND F.dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND CURRENT_DATE BETWEEN F.dat_existiert_seit AND F.dat_existiert_bis
    AND F.flaeche_status_id = 4) AS mvf
 LEFT JOIN (SELECT P1.mandant_id,
   P1.plan_objekt_id AS flaeche_id,
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
    THEN SUM(P1.plan_wert * KURS.kurs_1)
    ELSE TRUNC(CAST(SUM(P1.plan_wert * KURS.kurs_1) / CAST(SUM(CASE
          WHEN P1.plan_wert > 0
          THEN 1
          ELSE 0
          END) AS NUMERIC) AS BIGNUMERIC))
    END AS plan_wert_avg,
   TRUNC(CAST(CASE
       WHEN SUM(CASE
          WHEN P1.plan_wert > 0
          THEN 1
          ELSE 0
          END) = 0
       THEN SUM(P1.plan_wert * KURS.kurs_1)
       ELSE TRUNC(CAST(SUM(P1.plan_wert * KURS.kurs_1) / CAST(SUM(CASE
             WHEN P1.plan_wert > 0
             THEN 1
             ELSE 0
             END) AS NUMERIC) AS BIGNUMERIC))
       END / 30 AS BIGNUMERIC)) AS plan_wert_tag
  FROM kfl_production_dbp_view.v_ivs_plan_1 AS P1
   INNER JOIN kfl_production_dbp_view.v_monat_1 AS MO1 ON P1.kjmo = MO1.kjmo
   INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1 AS KURS_1 ON P1.mandant_id = KURS.mandant_id AND
      CURRENT_DATE BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis AND KURS.wrg_typ_id = 0
  WHERE P1.plantyp_id = 1
   AND P1.plandetail_id IN (1, 80)
   AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
     THEN MO1.akt_gj + 1
     ELSE MO1.akt_gj
     END = 0
  GROUP BY P1.mandant_id,
   flaeche_id) AS p ON mvf.flaeche_id = p.flaeche_id AND mvf.mandant_id = p.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_flaeche_per_1 AS F0 ON mvf.flaeche_id = F0.flaeche_id AND mvf.mandant_id =
     F0.mandant_id AND mvf.wrg_id = F0.wrg_id AND mvf.wrg_typ_id = F0.wrg_typ_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_flaeche_dn_aktivitaet_1 AS FAKTIV ON F0.flaeche_id = FAKTIV.flaeche_id AND
   F0.mandant_id = FAKTIV.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_immo_objekt_per_1 AS O ON F0.immo_objekt_id = O.immo_objekt_id AND F0.mandant_id
      = O.mandant_id AND mvf.wrg_id = O.wrg_id AND mvf.wrg_typ_id = O.wrg_typ_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_mietvertrag_per_1 AS MV0 ON mvf.mietvertrag_id = MV0.mietvertrag_id AND mvf
     .mandant_id = MV0.mandant_id AND mvf.wrg_id = MV0.wrg_id AND mvf.wrg_typ_id = MV0.wrg_typ_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_wup_vorstand_zu_per_1 AS WV ON O.immo_objekt_id = WV.immo_objekt_id AND O.mandant_id
    = WV.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_vorstand_1 AS V ON WV.mitarbeiter_id = V.mitarbeiter_id AND WV.mandant_id =
   V.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_wup_objektleiter_zu_per_1 AS WO ON O.immo_objekt_id = WO.immo_objekt_id AND
   O.mandant_id = WO.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_objektleiter_1 AS OL ON WO.mitarbeiter_id = OL.mitarbeiter_id AND WO.mandant_id
    = OL.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_l_branche_1 AS B ON mvf.branche_id = B.branche_id AND mvf.mandant_id = B.mandant_id
   
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_konzessionaer_per_1 AS K ON MV0.konzessionaer_id = K.konzessionaer_id AND
   MV0.mandant_id = K.mandant_id
 INNER JOIN (SELECT PARSE_DATE('%Y%m%d', CAST(kjmo AS STRING) || '01') AS gj_anfang
  FROM kfl_production_dbp_view.v_monat_1
  WHERE akt_gj = 0
   AND mo_gj = 1) AS TEMP ON TRUE;
