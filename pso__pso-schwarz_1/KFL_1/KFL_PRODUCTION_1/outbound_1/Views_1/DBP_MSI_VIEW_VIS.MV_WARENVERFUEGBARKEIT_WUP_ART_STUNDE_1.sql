CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_warenverfuegbarkeit_wup_art_stunde_1 (mandant_id, nb_id, wup_id
, art_id, dat, zeit_stunde, bewart_id, ausverkauft_fg, eckartikel_fg, topseller_fg, anz_bon_gesamt, anz_bon_artikel,
menge_absatz, std_offen, std_von, std_bis, anz_std_ausverkauft, anz_std_verfuegbar, max_std_verfuegbar, anz_std_mit,
anz_std_ohne, kernzeit_bis, kernzeit_fg, kernzeit_offen, kernzeit_std_ausverkauft, kernzeit_std_verfuegbar,
land_filialen, land_std_offen, land_std_von, land_std_bis, land_std_ausverkauft, land_avg_ausverkauft,
land_std_verfuegbar, land_avg_verfuegbar, land_max_verfuegbar, land_kernzeit_std_ausverkauft,
land_kernzeit_avg_ausverkauft, land_kernzeit_std_verfuegbar, land_kernzeit_avg_verfuegbar) AS SELECT WV.mandant_id,
 WV.nb_id,
 WV.wup_id,
 WV.art_id,
 WV.dat_auswertung AS dat,
 WV.zeit_stunde,
 COALESCE(WV.bewart_id, - 1) AS bewart_id,
 WV.ausverkauft_fg,
 WV.eckartikel_fg,
 WV.topseller_fg,
 WV.anz_bon_gesamt,
 WV.anz_bon_artikel,
 WV.menge_verkauft AS menge_absatz,
 COUNT(WV.zeit_stunde) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING)
    , WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS std_offen,
 MIN(WV.zeit_stunde) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING)
    , WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS std_von,
 MAX(WV.zeit_stunde) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING)
    , WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS std_bis,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 1
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_std_ausverkauft,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 0
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_std_verfuegbar,
 MAX(CASE
   WHEN WV.ausverkauft_fg = 0
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_std_verfuegbar,
 COUNT(CASE
   WHEN WV.menge_verkauft > 0
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_std_mit,
 COUNT(CASE
   WHEN WV.menge_verkauft = 0
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_std_ohne,
  CASE
  WHEN WG.owg_id = 1008 AND WV.mandant_id = 1 OR WG.owg_id = 1008 AND WV.mandant_id > 1
  THEN 18
  WHEN WG.owg_id = 1010 AND WV.mandant_id = 1 OR WG.owg_id = 1010 AND WV.mandant_id > 1 OR WG.owg_id = 1013 AND WV.mandant_id
       = 1 OR WG.owg_id = 1013 AND WV.mandant_id > 1
  THEN 20
  ELSE 24
  END AS kernzeit_bis,
 CAST(CASE
   WHEN WV.zeit_stunde < CASE
     WHEN WG.owg_id = 1008 AND WV.mandant_id = 1 OR WG.owg_id = 1008 AND WV.mandant_id > 1
     THEN 18
     WHEN WG.owg_id = 1010 AND WV.mandant_id = 1 OR WG.owg_id = 1010 AND WV.mandant_id > 1 OR WG.owg_id = 1013 AND WV.mandant_id = 1 OR WG.owg_id = 1013 AND WV.mandant_id > 1
     THEN 20
     ELSE 24
     END
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS kernzeit_fg,
 COUNT(CASE
   WHEN WV.zeit_stunde < CASE
     WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
     THEN 18
     WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
     THEN 18
     WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
     THEN 20
     WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
     THEN 20
     WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
     THEN 20
     WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
     THEN 20
     ELSE 24
     END
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kernzeit_offen,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 1 AND WV.zeit_stunde < CASE
      WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
      THEN 18
      WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
      THEN 18
      WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
      THEN 20
      ELSE 24
      END
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kernzeit_std_ausverkauft,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 0 AND WV.zeit_stunde < CASE
      WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
      THEN 18
      WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
      THEN 18
      WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
      THEN 20
      ELSE 24
      END
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.wup_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kernzeit_std_verfuegbar,
 COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_filialen,
 COUNT(WV.zeit_stunde) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_std_offen,
 MIN(WV.zeit_stunde) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_std_von,
 MAX(WV.zeit_stunde) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_std_bis,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 1
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_std_ausverkauft,
   (COUNT(CASE
     WHEN WV.ausverkauft_fg = 1
     THEN WV.zeit_stunde
     ELSE NULL
     END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING)
        , CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0,
   NULL, COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS land_avg_ausverkauft,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 0
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_std_verfuegbar,
   (COUNT(CASE
     WHEN WV.ausverkauft_fg = 0
     THEN WV.zeit_stunde
     ELSE NULL
     END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING)
        , CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0,
   NULL, COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS land_avg_verfuegbar,
 MAX(CASE
   WHEN WV.ausverkauft_fg = 0
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_max_verfuegbar,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 1 AND WV.zeit_stunde < CASE
      WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
      THEN 18
      WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
      THEN 18
      WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
      THEN 20
      ELSE 24
      END
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_kernzeit_std_ausverkauft,
   (COUNT(CASE
     WHEN WV.ausverkauft_fg = 1 AND WV.zeit_stunde < CASE
        WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
        THEN 18
        WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
        THEN 18
        WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
        THEN 20
        WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
        THEN 20
        WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
        THEN 20
        WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
        THEN 20
        ELSE 24
        END
     THEN WV.zeit_stunde
     ELSE NULL
     END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING)
        , CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0,
   NULL, COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS land_kernzeit_avg_ausverkauft,
 COUNT(CASE
   WHEN WV.ausverkauft_fg = 0 AND WV.zeit_stunde < CASE
      WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
      THEN 18
      WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
      THEN 18
      WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
      THEN 20
      WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
      THEN 20
      ELSE 24
      END
   THEN WV.zeit_stunde
   ELSE NULL
   END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS land_kernzeit_std_verfuegbar,
   (COUNT(CASE
     WHEN WV.ausverkauft_fg = 0 AND WV.zeit_stunde < CASE
        WHEN WG.owg_id = 1008 AND WV.mandant_id = 1
        THEN 18
        WHEN WG.owg_id = 1008 AND WV.mandant_id > 1
        THEN 18
        WHEN WG.owg_id = 1010 AND WV.mandant_id = 1
        THEN 20
        WHEN WG.owg_id = 1010 AND WV.mandant_id > 1
        THEN 20
        WHEN WG.owg_id = 1013 AND WV.mandant_id = 1
        THEN 20
        WHEN WG.owg_id = 1013 AND WV.mandant_id > 1
        THEN 20
        ELSE 24
        END
     THEN WV.zeit_stunde
     ELSE NULL
     END) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING)
        , CAST(WV.art_id AS STRING), WV.dat_auswertung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0,
   NULL, COUNT(WV.wup_id) OVER (PARTITION BY CAST(WV.mandant_id AS STRING), CAST(WV.art_id AS STRING), WV.dat_auswertung
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS land_kernzeit_avg_verfuegbar
FROM kfl_production_dbp_data.warenverfuegbarkeit_wup_art_stunde_1 AS WV
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_art_wg_zu_1 AS ART_1 ON WV.art_id = ART.art_id AND WV.mandant_id = ART.mandant_id
   
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON ART.wg_id = WG.wg_id;