CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_ims_mamo_wup_hwg_mo_sum_1 AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V04.wup_standort,
 V06.dat_massnahme_von AS start_bu,
 V06.dat_massnahme_bis AS eroeffnung,
 V01.kjmo,
 V01.zaehler_monat,
 V01.hwg_id,
 V02.qualifier_id,
 V05.qualifier_bez,
 V01.umsatz_netto_kum,
 V01.umsatz_netto_vp_kum AS umsatz_netto_kum_vj,
  CASE
  WHEN V01.umsatz_netto_vp_kum <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.umsatz_netto_vp_kum) / V01.umsatz_netto_vp_kum AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_kum_deltavj,
 V03.umsatz_netto_kum AS umsatz_netto_ref_kum,
 V03.umsatz_netto_vp_kum AS umsatz_netto_ref_kum_vj,
  CASE
  WHEN V03.umsatz_netto_vp_kum <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.umsatz_netto_vp_kum) / V03.umsatz_netto_vp_kum AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_ref_kum_deltavj,
   CASE
   WHEN V01.umsatz_netto_vp_kum <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.umsatz_netto_vp_kum) / V01.umsatz_netto_vp_kum AS BIGNUMERIC)) * 100
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_vp_kum <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.umsatz_netto_vp_kum) / V03.umsatz_netto_vp_kum AS BIGNUMERIC)) * 100
   ELSE NULL
   END AS umsatz_netto_kum_deltavj_deltaref,
 V01.umsatz_netto_sa_kum,
 V01.umsatz_netto_sa_vp_kum AS umsatz_netto_sa_kum_vj,
  CASE
  WHEN V01.umsatz_netto_sa_vp_kum <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_sa_kum - V01.umsatz_netto_sa_vp_kum) / V01.umsatz_netto_sa_vp_kum AS BIGNUMERIC)) *
   100
  ELSE NULL
  END AS umsatz_netto_sa_kum_deltavj,
 V03.umsatz_netto_sa_kum AS umsatz_netto_sa_ref_kum,
 V03.umsatz_netto_sa_vp_kum AS umsatz_netto_sa_ref_kum_vj,
  CASE
  WHEN V03.umsatz_netto_sa_vp_kum <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_sa_kum - V03.umsatz_netto_sa_vp_kum) / V03.umsatz_netto_sa_vp_kum AS BIGNUMERIC)) *
   100
  ELSE NULL
  END AS umsatz_netto_sa_ref_kum_deltavj,
   CASE
   WHEN V01.umsatz_netto_sa_vp_kum <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_sa_kum - V01.umsatz_netto_sa_vp_kum) / V01.umsatz_netto_sa_vp_kum AS BIGNUMERIC)) *
    100
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_sa_vp_kum <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_sa_kum - V03.umsatz_netto_sa_vp_kum) / V03.umsatz_netto_sa_vp_kum AS BIGNUMERIC)) *
    100
   ELSE NULL
   END AS umsatz_netto_sa_kum_deltavj_deltaref,
 NULL AS kunden_anzahl_kum,
 NULL AS kunden_anzahl_kum_vj,
 NULL AS kunden_anzahl_kum_deltavj,
 NULL AS kunden_anzahl_ref_kum,
 NULL AS kunden_anzahl_ref_kum_vj,
 NULL AS kunden_anzahl_ref_kum_deltavj,
 NULL AS kunden_anzahl_kum_deltavj_deltaref,
 NULL AS vis_umsatz_netto_kum,
 NULL AS vis_umsatz_netto_kum_vj,
 NULL AS vis_umsatz_netto_kum_deltavj,
 NULL AS vis_umsatz_netto_ref_kum,
 NULL AS vis_umsatz_netto_ref_kum_vj,
 NULL AS vis_umsatz_netto_ref_kum_deltavj,
 NULL AS vis_umsatz_netto_kum_deltavj_deltaref,
 NULL AS nettostunden_kum,
 NULL AS nettostunden_kum_vj,
 NULL AS nettostunden_kum_deltavj,
 NULL AS nettostunden_ref_kum,
 NULL AS nettostunden_ref_kum_vj,
 NULL AS nettostunden_ref_kum_deltavj,
 NULL AS nettostunden_kum_deltavj_deltaref,
 NULL AS nettoleistung_kum,
 NULL AS nettoleistung_kum_vj,
 NULL AS nettoleistung_kum_deltavj,
 NULL AS nettoleistung_ref_kum,
 NULL AS nettoleistung_ref_kum_vj,
 NULL AS nettoleistung_ref_kum_deltavj,
 NULL AS nettoleistung_kum_deltavj_deltaref,
  V01.umsatz_netto_kum - V01.ek_mep_kum AS ertrag_kum,
  V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum AS ertrag_kum_vj,
  CASE
  WHEN V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.ek_mep_kum - (V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum)) / (V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_kum_deltavj,
  V03.umsatz_netto_kum - V03.ek_mep_kum AS ertrag_kum_ref,
  V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum AS ertrag_kum_ref_vj,
  CASE
  WHEN V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.ek_mep_kum - (V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum)) / (V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_kum_ref_deltavj,
   CASE
   WHEN V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.ek_mep_kum - (V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum)) / (V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.ek_mep_kum - (V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum)) / (V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS ertrag_kum_deltavj_deltaref,
  CASE
  WHEN V01.umsatz_netto_kum <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.ek_mep_kum) / V01.umsatz_netto_kum AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_kum,
  CASE
  WHEN V01.umsatz_netto_vp_kum <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum) / V01.umsatz_netto_vp_kum AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_kum_vj,
   CASE
   WHEN V01.umsatz_netto_kum <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.ek_mep_kum) / V01.umsatz_netto_kum AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN V01.umsatz_netto_vp_kum <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum) / V01.umsatz_netto_vp_kum AS BIGNUMERIC))
   ELSE NULL
   END AS mep_spanne_kum_deltavj,
  CASE
  WHEN V03.umsatz_netto_kum <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.ek_mep_kum) / V03.umsatz_netto_kum AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref_kum,
  CASE
  WHEN V03.umsatz_netto_vp_kum <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum) / V03.umsatz_netto_vp_kum AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref_kum_vj,
   CASE
   WHEN V03.umsatz_netto_kum <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.ek_mep_kum) / V03.umsatz_netto_kum AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_vp_kum <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum) / V03.umsatz_netto_vp_kum AS BIGNUMERIC))
   ELSE NULL
   END AS mep_spanne_ref_kum_deltavj,
    CASE
    WHEN V01.umsatz_netto_kum <> 0
    THEN TRUNC(CAST((V01.umsatz_netto_kum - V01.ek_mep_kum) / V01.umsatz_netto_kum AS BIGNUMERIC))
    ELSE NULL
    END - CASE
    WHEN V01.umsatz_netto_vp_kum <> 0
    THEN TRUNC(CAST((V01.umsatz_netto_vp_kum - V01.ek_mep_vp_kum) / V01.umsatz_netto_vp_kum AS BIGNUMERIC))
    ELSE NULL
    END - (CASE
     WHEN V03.umsatz_netto_kum <> 0
     THEN TRUNC(CAST((V03.umsatz_netto_kum - V03.ek_mep_kum) / V03.umsatz_netto_kum AS BIGNUMERIC))
     ELSE NULL
     END - CASE
     WHEN V03.umsatz_netto_vp_kum <> 0
     THEN TRUNC(CAST((V03.umsatz_netto_vp_kum - V03.ek_mep_vp_kum) / V03.umsatz_netto_vp_kum AS BIGNUMERIC))
     ELSE NULL
     END) AS mep_spanne_kum_deltavj_deltaref,
 V01.umsatz_netto,
 V01.umsatz_netto_vp AS umsatz_netto_vj,
  CASE
  WHEN V01.umsatz_netto_vp <> 0
  THEN TRUNC(CAST((V01.umsatz_netto - V01.umsatz_netto_vp) / V01.umsatz_netto_vp AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_deltavj,
 V03.umsatz_netto AS umsatz_netto_ref,
 V03.umsatz_netto_vp AS umsatz_netto_ref_vj,
  CASE
  WHEN V03.umsatz_netto_vp <> 0
  THEN TRUNC(CAST((V03.umsatz_netto - V03.umsatz_netto_vp) / V03.umsatz_netto_vp AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_ref_deltavj,
   CASE
   WHEN V01.umsatz_netto_vp <> 0
   THEN TRUNC(CAST((V01.umsatz_netto - V01.umsatz_netto_vp) / V01.umsatz_netto_vp AS BIGNUMERIC)) * 100
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_vp <> 0
   THEN TRUNC(CAST((V03.umsatz_netto - V03.umsatz_netto_vp) / V03.umsatz_netto_vp AS BIGNUMERIC)) * 100
   ELSE NULL
   END AS umsatz_netto_deltavj_deltaref,
 V01.umsatz_netto_sa,
 V01.umsatz_netto_sa_vp AS umsatz_netto_sa_vj,
  CASE
  WHEN V01.umsatz_netto_sa_vp <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_sa - V01.umsatz_netto_sa_vp) / V01.umsatz_netto_sa_vp AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_sa_deltavj,
 V03.umsatz_netto_sa AS umsatz_netto_sa_ref,
 V03.umsatz_netto_sa_vp AS umsatz_netto_sa_ref_vj,
  CASE
  WHEN V03.umsatz_netto_sa_vp <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_sa - V03.umsatz_netto_sa_vp) / V03.umsatz_netto_sa_vp AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_sa_ref_deltavj,
   CASE
   WHEN V01.umsatz_netto_sa_vp <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_sa - V01.umsatz_netto_sa_vp) / V01.umsatz_netto_sa_vp AS BIGNUMERIC)) * 100
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_sa_vp <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_sa - V03.umsatz_netto_sa_vp) / V03.umsatz_netto_sa_vp AS BIGNUMERIC)) * 100
   ELSE NULL
   END AS umsatz_netto_sa_deltavj_deltaref,
 NULL AS kunden_anzahl,
 NULL AS kunden_anzahl_vj,
 NULL AS kunden_anzahl_deltavj,
 NULL AS kunden_anzahl_ref,
 NULL AS kunden_anzahl_ref_vj,
 NULL AS kunden_anzahl_ref_deltavj,
 NULL AS kunden_anzahl_deltavj_deltaref,
 NULL AS vis_umsatz_netto,
 NULL AS vis_umsatz_netto_vj,
 NULL AS vis_umsatz_netto_deltavj,
 NULL AS vis_umsatz_netto_ref,
 NULL AS vis_umsatz_netto_ref_vj,
 NULL AS vis_umsatz_netto_ref_deltavj,
 NULL AS vis_umsatz_netto_deltavj_deltaref,
 NULL AS nettostunden,
 NULL AS nettostunden_vj,
 NULL AS nettostunden_deltavj,
 NULL AS nettostunden_ref,
 NULL AS nettostunden_ref_vj,
 NULL AS nettostunden_ref_deltavj,
 NULL AS nettostunden_deltavj_deltaref,
 NULL AS nettoleistung,
 NULL AS nettoleistung_vj,
 NULL AS nettoleistung_deltavj,
 NULL AS nettoleistung_ref,
 NULL AS nettoleistung_ref_vj,
 NULL AS nettoleistung_ref_deltavj,
 NULL AS nettoleistung_deltavj_deltaref,
  V01.umsatz_netto - V01.ek_mep AS ertrag,
  V01.umsatz_netto_vp - V01.ek_mep_vp AS ertrag_vj,
  CASE
  WHEN V01.umsatz_netto_vp - V01.ek_mep_vp <> 0
  THEN TRUNC(CAST((V01.umsatz_netto - V01.ek_mep - (V01.umsatz_netto_vp - V01.ek_mep_vp)) / (V01.umsatz_netto_vp - V01.ek_mep_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_deltavj,
  V03.umsatz_netto - V03.ek_mep AS ertrag_ref,
  V03.umsatz_netto_vp - V03.ek_mep_vp AS ertrag_ref_vj,
  CASE
  WHEN V03.umsatz_netto_vp - V03.ek_mep_vp <> 0
  THEN TRUNC(CAST((V03.umsatz_netto - V03.ek_mep - (V03.umsatz_netto_vp - V03.ek_mep_vp)) / (V03.umsatz_netto_vp - V03.ek_mep_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_ref_deltavj,
   CASE
   WHEN V01.umsatz_netto_vp - V01.ek_mep_vp <> 0
   THEN TRUNC(CAST((V01.umsatz_netto - V01.ek_mep - (V01.umsatz_netto_vp - V01.ek_mep_vp)) / (V01.umsatz_netto_vp - V01.ek_mep_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_vp - V03.ek_mep_vp <> 0
   THEN TRUNC(CAST((V03.umsatz_netto - V03.ek_mep - (V03.umsatz_netto_vp - V03.ek_mep_vp)) / (V03.umsatz_netto_vp - V03.ek_mep_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS ertrag_deltavj_deltaref,
  CASE
  WHEN V01.umsatz_netto <> 0
  THEN TRUNC(CAST((V01.umsatz_netto - V01.ek_mep) / V01.umsatz_netto AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne,
  CASE
  WHEN V01.umsatz_netto_vp <> 0
  THEN TRUNC(CAST((V01.umsatz_netto_vp - V01.ek_mep_vp) / V01.umsatz_netto_vp AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_vj,
   CASE
   WHEN V01.umsatz_netto <> 0
   THEN TRUNC(CAST((V01.umsatz_netto - V01.ek_mep) / V01.umsatz_netto AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN V01.umsatz_netto_vp <> 0
   THEN TRUNC(CAST((V01.umsatz_netto_vp - V01.ek_mep_vp) / V01.umsatz_netto_vp AS BIGNUMERIC))
   ELSE NULL
   END AS mep_spanne_deltavj,
  CASE
  WHEN V03.umsatz_netto <> 0
  THEN TRUNC(CAST((V03.umsatz_netto - V03.ek_mep) / V03.umsatz_netto AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref,
  CASE
  WHEN V03.umsatz_netto_vp <> 0
  THEN TRUNC(CAST((V03.umsatz_netto_vp - V03.ek_mep_vp) / V03.umsatz_netto_vp AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref_vj,
   CASE
   WHEN V03.umsatz_netto <> 0
   THEN TRUNC(CAST((V03.umsatz_netto - V03.ek_mep) / V03.umsatz_netto AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN V03.umsatz_netto_vp <> 0
   THEN TRUNC(CAST((V03.umsatz_netto_vp - V03.ek_mep_vp) / V03.umsatz_netto_vp AS BIGNUMERIC))
   ELSE NULL
   END AS mep_spanne_ref_deltavj,
    CASE
    WHEN V01.umsatz_netto <> 0
    THEN TRUNC(CAST((V01.umsatz_netto - V01.ek_mep) / V01.umsatz_netto AS BIGNUMERIC))
    ELSE NULL
    END - CASE
    WHEN V01.umsatz_netto_vp <> 0
    THEN TRUNC(CAST((V01.umsatz_netto_vp - V01.ek_mep_vp) / V01.umsatz_netto_vp AS BIGNUMERIC))
    ELSE NULL
    END - (CASE
     WHEN V03.umsatz_netto <> 0
     THEN TRUNC(CAST((V03.umsatz_netto - V03.ek_mep) / V03.umsatz_netto AS BIGNUMERIC))
     ELSE NULL
     END - CASE
     WHEN V03.umsatz_netto_vp <> 0
     THEN TRUNC(CAST((V03.umsatz_netto_vp - V03.ek_mep_vp) / V03.umsatz_netto_vp AS BIGNUMERIC))
     ELSE NULL
     END) AS mep_spanne_deltavj_deltaref
FROM kfl_production_dbp_view.v_ims_mamo_wup_mo_sum_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_wup_qualifier_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id
     = V02.wup_id AND V01.nb_id = V02.nb_id
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_wup_qualifier_mo_sum_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id
       = V03.wup_id AND V01.nb_id = V03.nb_id AND V01.kjmo = V03.kjmo AND V01.hwg_id = V03.hwg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.wup_id = V04.wup_id AND V01
   .nb_id = V04.nb_id
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_qualifier_1 AS V05 ON V02.mandant_id = V05.mandant_id AND V02.qualifier_id
   = V05.qualifier_id
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_wup_massnahme_per_1 AS V06 ON V01.mandant_id = V06.mandant_id AND V01.wup_id
      = V06.wup_id AND V01.nb_id = V06.nb_id AND V06.modernisierung_art = 'MM_1';