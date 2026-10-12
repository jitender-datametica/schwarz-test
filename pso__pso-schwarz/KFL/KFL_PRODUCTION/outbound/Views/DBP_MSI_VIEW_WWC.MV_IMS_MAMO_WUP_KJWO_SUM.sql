CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_ims_mamo_wup_kjwo_sum AS -- ,v01.hwg_id
 SELECT V01.mandant_id
 ,
 V01.wup_id,
 V01.nb_id,
 V04.wup_standort,
 V06.dat_massnahme_von AS start_bu,
 V06.dat_massnahme_bis AS eroeffnung,
 V01.kjwo,
 V01.zaehler_woche,
 V02.qualifier_id,
 V05.qualifier_bez,
 SUM(V01.umsatz_netto_kum) AS umsatz_netto_kum,
 SUM(V01.umsatz_netto_vp_kum) AS umsatz_netto_kum_vj,
  CASE
  WHEN SUM(V01.umsatz_netto_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.umsatz_netto_vp_kum)) / SUM(V01.umsatz_netto_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS umsatz_netto_kum_deltavj,
 SUM(V03.umsatz_netto_kum) AS umsatz_netto_ref_kum,
 SUM(V03.umsatz_netto_vp_kum) AS umsatz_netto_ref_kum_vj,
  CASE
  WHEN SUM(V03.umsatz_netto_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.umsatz_netto_vp_kum)) / SUM(V03.umsatz_netto_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS umsatz_netto_ref_kum_deltavj,
   CASE
   WHEN SUM(V01.umsatz_netto_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.umsatz_netto_vp_kum)) / SUM(V01.umsatz_netto_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.umsatz_netto_vp_kum)) / SUM(V03.umsatz_netto_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS umsatz_netto_kum_deltavj_deltaref,
 SUM(V01.umsatz_netto_sa_kum) AS umsatz_netto_sa_kum,
 SUM(V01.umsatz_netto_sa_vp_kum) AS umsatz_netto_sa_kum_vj,
  CASE
  WHEN SUM(V01.umsatz_netto_sa_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_sa_kum) - SUM(V01.umsatz_netto_sa_vp_kum)) / SUM(V01.umsatz_netto_sa_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS umsatz_netto_sa_kum_deltavj,
 SUM(V03.umsatz_netto_sa_kum) AS umsatz_netto_sa_ref_kum,
 SUM(V03.umsatz_netto_sa_vp_kum) AS umsatz_netto_sa_ref_kum_vj,
  CASE
  WHEN SUM(V03.umsatz_netto_sa_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_sa_kum) - SUM(V03.umsatz_netto_sa_vp_kum)) / SUM(V03.umsatz_netto_sa_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS umsatz_netto_sa_ref_kum_deltavj,
   CASE
   WHEN SUM(V01.umsatz_netto_sa_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_sa_kum) - SUM(V01.umsatz_netto_sa_vp_kum)) / SUM(V01.umsatz_netto_sa_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_sa_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_sa_kum) - SUM(V03.umsatz_netto_sa_vp_kum)) / SUM(V03.umsatz_netto_sa_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS umsatz_netto_sa_kum_deltavj_deltaref,
 MAX(V01.bonanzahl_sug_kum) AS kunden_anzahl_kum,
 MAX(V01.bonanzahl_sug_vp_kum) AS kunden_anzahl_kum_vj,
  CASE
  WHEN MAX(V01.bonanzahl_sug_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V01.bonanzahl_sug_kum) - MAX(V01.bonanzahl_sug_vp_kum)) / MAX(V01.bonanzahl_sug_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS kunden_anzahl_kum_deltavj,
 MAX(V03.bonanzahl_sug_kum) AS kunden_anzahl_ref_kum,
 MAX(V03.bonanzahl_sug_vp_kum) AS kunden_anzahl_ref_kum_vj,
  CASE
  WHEN MAX(V03.bonanzahl_sug_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V03.bonanzahl_sug_kum) - MAX(V03.bonanzahl_sug_vp_kum)) / MAX(V03.bonanzahl_sug_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS kunden_anzahl_ref_kum_deltavj,
   CASE
   WHEN MAX(V01.bonanzahl_sug_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V01.bonanzahl_sug_kum) - MAX(V01.bonanzahl_sug_vp_kum)) / MAX(V01.bonanzahl_sug_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN MAX(V03.bonanzahl_sug_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V03.bonanzahl_sug_kum) - MAX(V03.bonanzahl_sug_vp_kum)) / MAX(V03.bonanzahl_sug_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS kunden_anzahl_kum_deltavj_deltaref,
 MAX(V01.vis_umsatz_netto_kum) AS vis_umsatz_netto_kum,
 MAX(V01.vis_umsatz_netto_vp_kum) AS vis_umsatz_netto_kum_vj,
  CASE
  WHEN MAX(V01.vis_umsatz_netto_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V01.vis_umsatz_netto_kum) - MAX(V01.vis_umsatz_netto_vp_kum)) / MAX(V01.vis_umsatz_netto_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS vis_umsatz_netto_kum_deltavj,
 MAX(V03.vis_umsatz_netto_kum) AS vis_umsatz_netto_ref_kum,
 MAX(V03.vis_umsatz_netto_vp_kum) AS vis_umsatz_netto_ref_kum_vj,
  CASE
  WHEN MAX(V03.vis_umsatz_netto_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V03.vis_umsatz_netto_kum) - MAX(V03.vis_umsatz_netto_vp_kum)) / MAX(V03.vis_umsatz_netto_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS vis_umsatz_netto_ref_kum_deltavj,
   CASE
   WHEN MAX(V01.vis_umsatz_netto_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V01.vis_umsatz_netto_kum) - MAX(V01.vis_umsatz_netto_vp_kum)) / MAX(V01.vis_umsatz_netto_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN MAX(V03.vis_umsatz_netto_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V03.vis_umsatz_netto_kum) - MAX(V03.vis_umsatz_netto_vp_kum)) / MAX(V03.vis_umsatz_netto_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS vis_umsatz_netto_kum_deltavj_deltaref,
 MAX(V01.vis_netto_stunden_kum) AS nettostunden_kum,
 MAX(V01.vis_netto_stunden_vp_kum) AS nettostunden_kum_vj,
  CASE
  WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V01.vis_netto_stunden_kum) - MAX(V01.vis_netto_stunden_vp_kum)) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS nettostunden_kum_deltavj,
 MAX(V03.vis_netto_stunden_kum) AS nettostunden_ref_kum,
 MAX(V03.vis_netto_stunden_vp_kum) AS nettostunden_ref_kum_vj,
  CASE
  WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V03.vis_netto_stunden_kum) - MAX(V03.vis_netto_stunden_vp_kum)) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS nettostunden_ref_kum_deltavj,
   CASE
   WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V01.vis_netto_stunden_kum) - MAX(V01.vis_netto_stunden_vp_kum)) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V03.vis_netto_stunden_kum) - MAX(V03.vis_netto_stunden_vp_kum)) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS nettostunden_kum_deltavj_deltaref,
  CASE
  WHEN MAX(V01.vis_netto_stunden_kum) <> 0
  THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_kum) / MAX(V01.vis_netto_stunden_kum) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_kum,
  CASE
  WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
  THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_kum_vj,
  CASE
  WHEN CASE
    WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
    THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
    ELSE NULL
    END <> 0
  THEN TRUNC(CAST((CASE
         WHEN MAX(V01.vis_netto_stunden_kum) <> 0
         THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_kum) / MAX(V01.vis_netto_stunden_kum) AS BIGNUMERIC))
         ELSE NULL
         END - CASE
         WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
         THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
         ELSE NULL
         END) / CASE
       WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
       THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
       ELSE NULL
       END AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS nettoleistung_kum_deltavj,
  CASE
  WHEN MAX(V03.vis_netto_stunden_kum) <> 0
  THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_kum) / MAX(V03.vis_netto_stunden_kum) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_ref_kum,
  CASE
  WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
  THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_ref_kum_vj,
  CASE
  WHEN CASE
    WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
    THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
    ELSE NULL
    END <> 0
  THEN TRUNC(CAST((CASE
         WHEN MAX(V03.vis_netto_stunden_kum) <> 0
         THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_kum) / MAX(V03.vis_netto_stunden_kum) AS BIGNUMERIC))
         ELSE NULL
         END - CASE
         WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
         THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
         ELSE NULL
         END) / CASE
       WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
       THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
       ELSE NULL
       END AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS nettoleistung_ref_kum_deltavj,
   CASE
   WHEN CASE
     WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
     THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
     ELSE NULL
     END <> 0
   THEN TRUNC(CAST((CASE
          WHEN MAX(V01.vis_netto_stunden_kum) <> 0
          THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_kum) / MAX(V01.vis_netto_stunden_kum) AS BIGNUMERIC))
          ELSE NULL
          END - CASE
          WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
          THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
          ELSE NULL
          END) / CASE
        WHEN MAX(V01.vis_netto_stunden_vp_kum) <> 0
        THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp_kum) / MAX(V01.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
        ELSE NULL
        END AS BIGNUMERIC)) * 100
   ELSE NULL
   END - CASE
   WHEN CASE
     WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
     THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
     ELSE NULL
     END <> 0
   THEN TRUNC(CAST((CASE
          WHEN MAX(V03.vis_netto_stunden_kum) <> 0
          THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_kum) / MAX(V03.vis_netto_stunden_kum) AS BIGNUMERIC))
          ELSE NULL
          END - CASE
          WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
          THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
          ELSE NULL
          END) / CASE
        WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
        THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp_kum) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC))
        ELSE NULL
        END AS BIGNUMERIC)) * 100
   ELSE NULL
   END AS nettoleistung_kum_deltavj_deltaref,
  SUM(V01.umsatz_netto_kum) - SUM(V01.ek_mep_kum) AS ertrag_kum,
  SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum) AS ertrag_kum_vj,
  CASE
  WHEN SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.ek_mep_kum) - (SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum))) / (SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum)) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_kum_deltavj,
  SUM(V03.umsatz_netto_kum) - SUM(V03.ek_mep_kum) AS ertrag_kum_ref,
  SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum) AS ertrag_kum_ref_vj,
  CASE
  WHEN SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.ek_mep_kum) - (SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum))) / (SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum)) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_kum_ref_deltavj,
   CASE
   WHEN SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.ek_mep_kum) - (SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum))) / (SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum)) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.ek_mep_kum) - (SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum))) / (SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum)) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS ertrag_kum_deltavj_deltaref,
  CASE
  WHEN SUM(V01.umsatz_netto_kum) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.ek_mep_kum)) / SUM(V01.umsatz_netto_kum) AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_kum,
  CASE
  WHEN SUM(V01.umsatz_netto_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum)) / SUM(V01.umsatz_netto_vp_kum) AS BIGNUMERIC)
   )
  ELSE NULL
  END AS mep_spanne_kum_vj,
   CASE
   WHEN SUM(V01.umsatz_netto_kum) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.ek_mep_kum)) / SUM(V01.umsatz_netto_kum) AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN SUM(V01.umsatz_netto_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum)) / SUM(V01.umsatz_netto_vp_kum) AS BIGNUMERIC)
    )
   ELSE NULL
   END AS mep_spanne_kum_deltavj,
  CASE
  WHEN SUM(V03.umsatz_netto_kum) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.ek_mep_kum)) / SUM(V03.umsatz_netto_kum) AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref_kum,
  CASE
  WHEN SUM(V03.umsatz_netto_vp_kum) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum)) / SUM(V03.umsatz_netto_vp_kum) AS BIGNUMERIC)
   )
  ELSE NULL
  END AS mep_spanne_ref_kum_vj,
   CASE
   WHEN SUM(V03.umsatz_netto_kum) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.ek_mep_kum)) / SUM(V03.umsatz_netto_kum) AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_vp_kum) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum)) / SUM(V03.umsatz_netto_vp_kum) AS BIGNUMERIC)
    )
   ELSE NULL
   END AS mep_spanne_ref_kum_deltavj,
    CASE
    WHEN SUM(V01.umsatz_netto_kum) <> 0
    THEN TRUNC(CAST((SUM(V01.umsatz_netto_kum) - SUM(V01.ek_mep_kum)) / SUM(V01.umsatz_netto_kum) AS BIGNUMERIC))
    ELSE NULL
    END - CASE
    WHEN SUM(V01.umsatz_netto_vp_kum) <> 0
    THEN TRUNC(CAST((SUM(V01.umsatz_netto_vp_kum) - SUM(V01.ek_mep_vp_kum)) / SUM(V01.umsatz_netto_vp_kum) AS BIGNUMERIC)
     )
    ELSE NULL
    END - (CASE
     WHEN SUM(V03.umsatz_netto_kum) <> 0
     THEN TRUNC(CAST((SUM(V03.umsatz_netto_kum) - SUM(V03.ek_mep_kum)) / SUM(V03.umsatz_netto_kum) AS BIGNUMERIC))
     ELSE NULL
     END - CASE
     WHEN SUM(V03.umsatz_netto_vp_kum) <> 0
     THEN TRUNC(CAST((SUM(V03.umsatz_netto_vp_kum) - SUM(V03.ek_mep_vp_kum)) / SUM(V03.umsatz_netto_vp_kum) AS BIGNUMERIC)
      )
     ELSE NULL
     END) AS mep_spanne_kum_deltavj_deltaref,
 SUM(V01.umsatz_netto) AS umsatz_netto,
 SUM(V01.umsatz_netto_vp) AS umsatz_netto_vj,
  CASE
  WHEN SUM(V01.umsatz_netto_vp) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.umsatz_netto_vp)) / SUM(V01.umsatz_netto_vp) AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_deltavj,
 SUM(V03.umsatz_netto) AS umsatz_netto_ref,
 SUM(V03.umsatz_netto_vp) AS umsatz_netto_ref_vj,
  CASE
  WHEN SUM(V03.umsatz_netto_vp) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.umsatz_netto_vp)) / SUM(V03.umsatz_netto_vp) AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS umsatz_netto_ref_deltavj,
   CASE
   WHEN SUM(V01.umsatz_netto_vp) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.umsatz_netto_vp)) / SUM(V01.umsatz_netto_vp) AS BIGNUMERIC)) * 100
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_vp) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.umsatz_netto_vp)) / SUM(V03.umsatz_netto_vp) AS BIGNUMERIC)) * 100
   ELSE NULL
   END AS umsatz_netto_deltavj_deltaref,
 SUM(V01.umsatz_netto_sa) AS umsatz_netto_sa,
 SUM(V01.umsatz_netto_sa_vp) AS umsatz_netto_sa_vj,
  CASE
  WHEN SUM(V01.umsatz_netto_sa_vp) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_sa) - SUM(V01.umsatz_netto_sa_vp)) / SUM(V01.umsatz_netto_sa_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS umsatz_netto_sa_deltavj,
 SUM(V03.umsatz_netto_sa) AS umsatz_netto_sa_ref,
 SUM(V03.umsatz_netto_sa_vp) AS umsatz_netto_sa_ref_vj,
  CASE
  WHEN SUM(V03.umsatz_netto_sa_vp) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_sa) - SUM(V03.umsatz_netto_sa_vp)) / SUM(V03.umsatz_netto_sa_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS umsatz_netto_sa_ref_deltavj,
   CASE
   WHEN SUM(V01.umsatz_netto_sa_vp) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_sa) - SUM(V01.umsatz_netto_sa_vp)) / SUM(V01.umsatz_netto_sa_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_sa_vp) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_sa) - SUM(V03.umsatz_netto_sa_vp)) / SUM(V03.umsatz_netto_sa_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS umsatz_netto_sa_deltavj_deltaref,
 MAX(V01.bonanzahl_sug) AS kunden_anzahl,
 MAX(V01.bonanzahl_sug_vp) AS kunden_anzahl_vj,
  CASE
  WHEN MAX(V01.bonanzahl_sug_vp) <> 0
  THEN TRUNC(CAST((MAX(V01.bonanzahl_sug) - MAX(V01.bonanzahl_sug_vp)) / MAX(V01.bonanzahl_sug_vp) AS BIGNUMERIC)) * 100
   
  ELSE NULL
  END AS kunden_anzahl_deltavj,
 MAX(V03.bonanzahl_sug) AS kunden_anzahl_ref,
 MAX(V03.bonanzahl_sug_vp) AS kunden_anzahl_ref_vj,
  CASE
  WHEN MAX(V03.bonanzahl_sug_vp) <> 0
  THEN TRUNC(CAST((MAX(V03.bonanzahl_sug) - MAX(V03.bonanzahl_sug_vp)) / MAX(V03.bonanzahl_sug_vp) AS BIGNUMERIC)) * 100
   
  ELSE NULL
  END AS kunden_anzahl_ref_deltavj,
   CASE
   WHEN MAX(V01.bonanzahl_sug_vp) <> 0
   THEN TRUNC(CAST((MAX(V01.bonanzahl_sug) - MAX(V01.bonanzahl_sug_vp)) / MAX(V01.bonanzahl_sug_vp) AS BIGNUMERIC)) *
    100
   ELSE NULL
   END - CASE
   WHEN MAX(V03.bonanzahl_sug_vp) <> 0
   THEN TRUNC(CAST((MAX(V03.bonanzahl_sug) - MAX(V03.bonanzahl_sug_vp)) / MAX(V03.bonanzahl_sug_vp) AS BIGNUMERIC)) *
    100
   ELSE NULL
   END AS kunden_anzahl_deltavj_deltaref,
 MAX(V01.vis_umsatz_netto) AS vis_umsatz_netto,
 MAX(V01.vis_umsatz_netto_vp) AS vis_umsatz_netto_vj,
  CASE
  WHEN MAX(V01.vis_umsatz_netto_vp) <> 0
  THEN TRUNC(CAST((MAX(V01.vis_umsatz_netto) - MAX(V01.vis_umsatz_netto_vp)) / MAX(V01.vis_umsatz_netto_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS vis_umsatz_netto_deltavj,
 MAX(V03.vis_umsatz_netto) AS vis_umsatz_netto_ref,
 MAX(V03.vis_umsatz_netto_vp) AS vis_umsatz_netto_ref_vj,
  CASE
  WHEN MAX(V03.vis_umsatz_netto_vp) <> 0
  THEN TRUNC(CAST((MAX(V03.vis_umsatz_netto) - MAX(V03.vis_umsatz_netto_vp)) / MAX(V03.vis_umsatz_netto_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS vis_umsatz_netto_ref_deltavj,
   CASE
   WHEN MAX(V01.vis_umsatz_netto_vp) <> 0
   THEN TRUNC(CAST((MAX(V01.vis_umsatz_netto) - MAX(V01.vis_umsatz_netto_vp)) / MAX(V01.vis_umsatz_netto_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN MAX(V03.vis_umsatz_netto_vp) <> 0
   THEN TRUNC(CAST((MAX(V03.vis_umsatz_netto) - MAX(V03.vis_umsatz_netto_vp)) / MAX(V03.vis_umsatz_netto_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS vis_umsatz_netto_deltavj_deltaref,
 MAX(V01.vis_netto_stunden) AS nettostunden,
 MAX(V01.vis_netto_stunden_vp) AS nettostunden_vj,
  CASE
  WHEN MAX(V01.vis_netto_stunden_vp) <> 0
  THEN TRUNC(CAST((MAX(V01.vis_netto_stunden) - MAX(V01.vis_netto_stunden_vp)) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS nettostunden_deltavj,
 MAX(V03.vis_netto_stunden) AS nettostunden_ref,
 MAX(V03.vis_netto_stunden_vp_kum) AS nettostunden_ref_vj,
  CASE
  WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
  THEN TRUNC(CAST((MAX(V03.vis_netto_stunden) - MAX(V03.vis_netto_stunden_vp_kum)) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS nettostunden_ref_deltavj,
   CASE
   WHEN MAX(V01.vis_netto_stunden_vp) <> 0
   THEN TRUNC(CAST((MAX(V01.vis_netto_stunden) - MAX(V01.vis_netto_stunden_vp)) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN MAX(V03.vis_netto_stunden_vp_kum) <> 0
   THEN TRUNC(CAST((MAX(V03.vis_netto_stunden) - MAX(V03.vis_netto_stunden_vp_kum)) / MAX(V03.vis_netto_stunden_vp_kum) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS nettostunden_deltavj_deltaref,
  CASE
  WHEN MAX(V01.vis_netto_stunden) <> 0
  THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto) / MAX(V01.vis_netto_stunden) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung,
  CASE
  WHEN MAX(V01.vis_netto_stunden_vp) <> 0
  THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_vj,
  CASE
  WHEN CASE
    WHEN MAX(V01.vis_netto_stunden_vp) <> 0
    THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
    ELSE NULL
    END <> 0
  THEN TRUNC(CAST((CASE
         WHEN MAX(V01.vis_netto_stunden) <> 0
         THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto) / MAX(V01.vis_netto_stunden) AS BIGNUMERIC))
         ELSE NULL
         END - CASE
         WHEN MAX(V01.vis_netto_stunden_vp) <> 0
         THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
         ELSE NULL
         END) / CASE
       WHEN MAX(V01.vis_netto_stunden_vp) <> 0
       THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
       ELSE NULL
       END AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS nettoleistung_deltavj,
  CASE
  WHEN MAX(V03.vis_netto_stunden) <> 0
  THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto) / MAX(V03.vis_netto_stunden) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_ref,
  CASE
  WHEN MAX(V03.vis_netto_stunden_vp) <> 0
  THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
  ELSE NULL
  END AS nettoleistung_ref_vj,
  CASE
  WHEN CASE
    WHEN MAX(V03.vis_netto_stunden_vp) <> 0
    THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
    ELSE NULL
    END <> 0
  THEN TRUNC(CAST((CASE
         WHEN MAX(V03.vis_netto_stunden) <> 0
         THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto) / MAX(V03.vis_netto_stunden) AS BIGNUMERIC))
         ELSE NULL
         END - CASE
         WHEN MAX(V03.vis_netto_stunden_vp) <> 0
         THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
         ELSE NULL
         END) / CASE
       WHEN MAX(V03.vis_netto_stunden_vp) <> 0
       THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
       ELSE NULL
       END AS BIGNUMERIC)) * 100
  ELSE NULL
  END AS nettoleistung_ref_deltavj,
   CASE
   WHEN CASE
     WHEN MAX(V01.vis_netto_stunden_vp) <> 0
     THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
     ELSE NULL
     END <> 0
   THEN TRUNC(CAST((CASE
          WHEN MAX(V01.vis_netto_stunden) <> 0
          THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto) / MAX(V01.vis_netto_stunden) AS BIGNUMERIC))
          ELSE NULL
          END - CASE
          WHEN MAX(V01.vis_netto_stunden_vp) <> 0
          THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
          ELSE NULL
          END) / CASE
        WHEN MAX(V01.vis_netto_stunden_vp) <> 0
        THEN TRUNC(CAST(MAX(V01.vis_umsatz_netto_vp) / MAX(V01.vis_netto_stunden_vp) AS BIGNUMERIC))
        ELSE NULL
        END AS BIGNUMERIC)) * 100
   ELSE NULL
   END - CASE
   WHEN CASE
     WHEN MAX(V03.vis_netto_stunden_vp) <> 0
     THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
     ELSE NULL
     END <> 0
   THEN TRUNC(CAST((CASE
          WHEN MAX(V03.vis_netto_stunden) <> 0
          THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto) / MAX(V03.vis_netto_stunden) AS BIGNUMERIC))
          ELSE NULL
          END - CASE
          WHEN MAX(V03.vis_netto_stunden_vp) <> 0
          THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
          ELSE NULL
          END) / CASE
        WHEN MAX(V03.vis_netto_stunden_vp) <> 0
        THEN TRUNC(CAST(MAX(V03.vis_umsatz_netto_vp) / MAX(V03.vis_netto_stunden_vp) AS BIGNUMERIC))
        ELSE NULL
        END AS BIGNUMERIC)) * 100
   ELSE NULL
   END AS nettoleistung_deltavj_deltaref,
  SUM(V01.umsatz_netto) - SUM(V01.ek_mep) AS ertrag,
  SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp) AS ertrag_vj,
  CASE
  WHEN SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.ek_mep) - (SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp))) / (SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp)) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_deltavj,
  SUM(V03.umsatz_netto) - SUM(V03.ek_mep) AS ertrag_ref,
  SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp) AS ertrag_ref_vj,
  CASE
  WHEN SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.ek_mep) - (SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp))) / (SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp)) AS BIGNUMERIC)
    ) * 100
  ELSE NULL
  END AS ertrag_ref_deltavj,
   CASE
   WHEN SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.ek_mep) - (SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp))) / (SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp)) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.ek_mep) - (SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp))) / (SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp)) AS BIGNUMERIC)
     ) * 100
   ELSE NULL
   END AS ertrag_deltavj_deltaref,
  CASE
  WHEN SUM(V01.umsatz_netto) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.ek_mep)) / SUM(V01.umsatz_netto) AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne,
  CASE
  WHEN SUM(V01.umsatz_netto_vp) <> 0
  THEN TRUNC(CAST((SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp)) / SUM(V01.umsatz_netto_vp) AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_vj,
   CASE
   WHEN SUM(V01.umsatz_netto) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.ek_mep)) / SUM(V01.umsatz_netto) AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN SUM(V01.umsatz_netto_vp) <> 0
   THEN TRUNC(CAST((SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp)) / SUM(V01.umsatz_netto_vp) AS BIGNUMERIC))
   ELSE NULL
   END AS mep_spanne_deltavj,
  CASE
  WHEN SUM(V03.umsatz_netto) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.ek_mep)) / SUM(V03.umsatz_netto) AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref,
  CASE
  WHEN SUM(V03.umsatz_netto_vp) <> 0
  THEN TRUNC(CAST((SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp)) / SUM(V03.umsatz_netto_vp) AS BIGNUMERIC))
  ELSE NULL
  END AS mep_spanne_ref_vj,
   CASE
   WHEN SUM(V03.umsatz_netto) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.ek_mep)) / SUM(V03.umsatz_netto) AS BIGNUMERIC))
   ELSE NULL
   END - CASE
   WHEN SUM(V03.umsatz_netto_vp) <> 0
   THEN TRUNC(CAST((SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp)) / SUM(V03.umsatz_netto_vp) AS BIGNUMERIC))
   ELSE NULL
   END AS mep_spanne_ref_deltavj,
    CASE
    WHEN SUM(V01.umsatz_netto) <> 0
    THEN TRUNC(CAST((SUM(V01.umsatz_netto) - SUM(V01.ek_mep)) / SUM(V01.umsatz_netto) AS BIGNUMERIC))
    ELSE NULL
    END - CASE
    WHEN SUM(V01.umsatz_netto_vp) <> 0
    THEN TRUNC(CAST((SUM(V01.umsatz_netto_vp) - SUM(V01.ek_mep_vp)) / SUM(V01.umsatz_netto_vp) AS BIGNUMERIC))
    ELSE NULL
    END - (CASE
     WHEN SUM(V03.umsatz_netto) <> 0
     THEN TRUNC(CAST((SUM(V03.umsatz_netto) - SUM(V03.ek_mep)) / SUM(V03.umsatz_netto) AS BIGNUMERIC))
     ELSE NULL
     END - CASE
     WHEN SUM(V03.umsatz_netto_vp) <> 0
     THEN TRUNC(CAST((SUM(V03.umsatz_netto_vp) - SUM(V03.ek_mep_vp)) / SUM(V03.umsatz_netto_vp) AS BIGNUMERIC))
     ELSE NULL
     END) AS mep_spanne_deltavj_deltaref
FROM kfl_production_dbp_view.v_ims_mamo_wup_kjwo_sum AS V01
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_wup_qualifier_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id
     = V02.wup_id AND V01.nb_id = V02.nb_id
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_wup_qualifier_kjwo_sum AS V03 ON V01.mandant_id = V03.mandant_id AND V01
      .wup_id = V03.wup_id AND V01.nb_id = V03.nb_id AND V01.kjwo = V03.kjwo AND V01.hwg_id = V03.hwg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS V04 ON V01.mandant_id = V04.mandant_id AND V01.wup_id = V04.wup_id AND V01
   .nb_id = V04.nb_id
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_qualifier AS V05 ON V02.mandant_id = V05.mandant_id AND V02.qualifier_id
   = V05.qualifier_id
 INNER JOIN kfl_production_dbp_view.v_ims_mamo_wup_massnahme_per AS V06 ON V01.mandant_id = V06.mandant_id AND V01.wup_id
      = V06.wup_id AND V01.nb_id = V06.nb_id AND V06.modernisierung_art = 'FL'
GROUP BY V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V04.wup_standort,
 start_bu,
 eroeffnung,
 V01.kjwo,
 V01.zaehler_woche,
 V02.qualifier_id,
 V05.qualifier_bez;