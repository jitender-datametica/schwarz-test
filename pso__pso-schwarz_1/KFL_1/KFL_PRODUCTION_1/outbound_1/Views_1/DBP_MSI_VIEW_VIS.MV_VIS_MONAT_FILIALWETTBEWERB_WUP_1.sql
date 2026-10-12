/* Transformation Projektion IST */
/* FAKT DENORM : Filialwettbewerb Markt des Monats 
	2023-03-08 ssch0611 : Updated. Dense ranking with filter. AP0154666 
	2023-04-14 ssch0611 : Update. Filter GJ2023 (CZ) + Definition K-Card (PL)
	2024-03-11 ssch0611 : Update GJ2024. Umsatzanteil O&G/Backshop, K-Card Delta , Google [AP0195212]
	2024-03-21 ssch0611 : Ausschluss SK1420 (202402)
	2024-04-08 ssch0611 : Filialfilter GJ2024
	2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]
	2024-08-15 muellerpatri: Ausschluss D1430 - Anfrage Fachbereich
	2024-11-14 muellerpatri : Filialausschluss mandant_id = 2 AND wup.wup_id IN (1700, 6800) AND vis0.kjmo > 202409
	2025-01-30 muellerpatri : Erweiterung um neuen Kurzcheck Gesamt (KCG)
	2025-04-10 ssch0611 : Anpassung Filter GJ2025. Basis CTE. Deaktivierung/NULL von KFB/KC (alt) [NSR5150325][AP0263138]
	2025-04-23 ssch0611 : Fix Zeit_1 Filter NEO
	2025-11-17 ssch0611 : Fix Filter Umgliederungen (dat_bis Altfiliale) */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_filialwettbewerb_wup_1 AS WITH ZEIT_1 AS (SELECT gj,
   akt_gj /* GJ Wechsel am 02. März - hier nicht verwendet */,
    akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) AS akt_gj_mo,
   kjmo,
   kjmo_vj /* Kalendermonat im VJ */,
   akt_mo,
   min_dat /* Datum Monatsanfang */,
   max_dat /* Datum Monatsende */
  FROM kfl_production_dbp_data.monat_1 AS ZEIT_1
  WHERE akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) = 0
   AND akt_mo < 0), WUP_1 AS (SELECT mandant_id,
   nb_id,
   vs_id,
   aktuell_wup_id,
   wup_id,
   COALESCE(dat_eroeffnung_alt, dat_eroeffnung) AS neo_dat,
   IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL) AS dat_umgl,
   COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL), SUBSTR(CAST(dat_bis AS STRING), 1, 20)) AS stl_dat,
    EXTRACT(YEAR FROM COALESCE(dat_eroeffnung_alt, dat_eroeffnung)) - IF(EXTRACT(MONTH FROM COALESCE(dat_eroeffnung_alt
        , dat_eroeffnung)) < 3, 1, 0) AS neo_gj,
    EXTRACT(YEAR FROM CAST(COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31', NULL), SUBSTR(CAST(dat_bis AS STRING),
        1, 20)) AS DATETIME)) - IF(EXTRACT(MONTH FROM SAFE_CAST(COALESCE(IF(wup_aenderung_grund_id = 3, '9999-12-31',
          NULL), SUBSTR(CAST(dat_bis AS STRING), 1, 20)) as DATETIME)) < 3, 1, 0) AS stl_gj,
    CASE
    WHEN mandant_id = 1 AND wup_id IN (1263, 1273, 3166, 6623, 8120, 8563, 8940, 5876) OR mandant_id = 3 AND wup_id IN (1010
         ) OR mandant_id = 7 AND wup_id IN (1110, 1410, 6210, 6310, 6410)
    THEN 1 /* RO Sonderverkauf/Zeltverkauf */ /* Ausschluss Markt des Monats -- 2025-04 */
    /* Ausschluss CZ (temporär) 2 Filialen von 202409 bis 202602 */
    WHEN mandant_id = 2 AND wup_id IN (1700, 6800)
    THEN 2
    ELSE 0
    END AS aus_fg
  FROM kfl_production_dbp_data.wup_1 AS WUP_1
  WHERE nb_id = 0
   AND dat_eroeffnung < DATE '2090-12-31') (/* Filialen inkl Mapping Umgliederungen, ohne ZF, ohne Ausschluss */
  /* Eröffnungsdatum - EÖ der ursprünglichen Filiale ist gemappt */ /* Umgliederung : Dummy_1 (keine Schließung) */
  /* Schließungsdatum - keine Schließung bei Altfilialen/Umgliederung */ /* GJ der Eröffnung */ /* GJ der Schließung */
  /* Ausschluss Filialwettbewerb -- 2025-04 */ /* DE Sonderverkauf/Getränkemärkte */ /* PL Sonderverkauf */
  /* Filialen ohne Dummy_1 NEÖ */ /* Zeit_1 akt. GJ (Monatsreporting) bis Vormonat / Wechsel am 02. April */
  /* GJ Wechsel am 02. April */ /* MAIN */ /* 01 Umsatz netto - Delta Plan DESC */
  /* 02 Umsatzanteil Obst und Gemüse - Delta VJ DESC */ /* 03 Umsatzanteil Backshop - Delta VJ DESC */
  /* 04 Abschriften_1 operativ - Delta Plan DESC */ /* 05 Nettoleistung - Delta Plan DESC */
  /* 06 Kundgarantie Anzahl Warten Kasse - Wert ASC DENSE */ /* 07 Kundgarantie Anzahl Warten Theke - Wert ASC DENSE */
  /* 08 Kundenanteil K-Card - Wert DESC */ /* 09 Kundenanteil K-Card - Delta VJ DESC */
  /* 10 Google Reviews Kaufland - Sterne DESC DENSE - ab Jan 2024 */
  /* 11 Kurzcheck Gesamt NEU - NOK% ASC DENSE -- Daten ab August 2024 >> Monatswerte aktuell nicht verwendet! */
  /* 1x Kurzcheck KC_ALT - NOK% ASC DENSE -- Daten bis Juli 2024 */
  /* 1x Kundenfeedback KFB - NOK% ASC DENSE -- Daten bis Juli 2023 */
  /* vis_monat : Monatsumsatz und Nettostunden (Referenz) */ /* Filiale muss 1 komplettes GJ geöffnet sein */
  /* ohne temp. Ausschluss CZ */ /* vis_tag : Tagesumsatz für Abschriften_1 und Anteile */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */
  /* Filiale muss 1 komplettes GJ geöffnet sein */ /* ohne temp. Ausschluss CZ */ SELECT vis.mandant_id,
   vis.nb_id,
   vis.vs_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.kjmo,
   vis.offen_ist AS mdm_offen,
   vis.ums_netto_ist AS mdm_ums_netto_ist,
   vis.ums_netto_plan AS mdm_ums_netto_plan,
     (vis.ums_netto_ist - vis.ums_netto_plan) / IF(vis.ums_netto_plan = 0, NULL, vis.ums_netto_plan) AS mdm_ums_netto,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY ((vis.ums_netto_ist - vis.ums_netto_plan) / IF(vis.ums_netto_plan = 0, NULL, vis.ums_netto_plan)) IS NULL
      , (vis.ums_netto_ist - vis.ums_netto_plan) / IF(vis.ums_netto_plan = 0, NULL, vis.ums_netto_plan)) AS
   mdm_ums_netto_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY ((vis.ums_netto_ist - vis.ums_netto_plan) / IF(vis.ums_netto_plan = 0, NULL, vis.ums_netto_plan)) IS NULL
      , (vis.ums_netto_ist - vis.ums_netto_plan) / IF(vis.ums_netto_plan = 0, NULL, vis.ums_netto_plan)) AS
   mdm_ums_netto_dense,
   vistag.ums_tag_ist AS mdm_ums_tag_ist,
   vistag.ums_tag_kvj AS mdm_ums_tag_kvj,
   vishwg.ums_og_ist AS mdm_ums_og_ist,
   vishwg.ums_og_kvj AS mdm_ums_og_kvj,
    vishwg.ums_og_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) AS mdm_ums_anteil_og_ist,
    vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) AS mdm_ums_anteil_og_kvj,
     vishwg.ums_og_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj
          = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj
       )) AS mdm_ums_anteil_og,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (vishwg.ums_og_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(vishwg.ums_og_kvj / IF(vistag
             .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj = 0, NULL
           , vistag.ums_tag_kvj))) IS NULL, vishwg.ums_og_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) -
       IF(vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_og_kvj / IF(vistag
           .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj))) AS mdm_ums_anteil_og_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (vishwg.ums_og_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(vishwg.ums_og_kvj / IF(vistag
             .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj = 0, NULL
           , vistag.ums_tag_kvj))) IS NULL, vishwg.ums_og_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) -
       IF(vishwg.ums_og_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_og_kvj / IF(vistag
           .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj))) AS mdm_ums_anteil_og_dense,
   vishwg.ums_bs_ist AS mdm_ums_bs_ist,
   vishwg.ums_bs_kvj AS mdm_ums_bs_kvj,
    vishwg.ums_bs_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) AS mdm_ums_anteil_bs_ist,
    vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) AS mdm_ums_anteil_bs_kvj,
     vishwg.ums_bs_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj
          = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj
       )) AS mdm_ums_anteil_bs,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (vishwg.ums_bs_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(vishwg.ums_bs_kvj / IF(vistag
             .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj = 0, NULL
           , vistag.ums_tag_kvj))) IS NULL, vishwg.ums_bs_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) -
       IF(vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_bs_kvj / IF(vistag
           .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj))) AS mdm_ums_anteil_bs_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (vishwg.ums_bs_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(vishwg.ums_bs_kvj / IF(vistag
             .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj = 0, NULL
           , vistag.ums_tag_kvj))) IS NULL, vishwg.ums_bs_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) -
       IF(vishwg.ums_bs_kvj / IF(vistag.ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj) = 0, NULL, vishwg.ums_bs_kvj / IF(vistag
           .ums_tag_kvj = 0, NULL, vistag.ums_tag_kvj))) AS mdm_ums_anteil_bs_dense,
   visabs.abs_op_ist AS mdm_abs_op_ist,
   planowg.abs_owg_plan AS mdm_abs_owg_plan,
   planowg.ums_owg_plan AS mdm_ums_owg_plan,
    visabs.abs_op_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) AS mdm_abschrift_op_ist,
    planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan) AS mdm_abschrift_op_plan,
     visabs.abs_op_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(planowg.abs_owg_plan / IF(planowg.ums_owg_plan
          = 0, NULL, planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg
       .ums_owg_plan)) AS mdm_abschrift_op,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (visabs.abs_op_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(planowg.abs_owg_plan / IF(planowg
             .ums_owg_plan = 0, NULL, planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan / IF(planowg.ums_owg_plan =
            0, NULL, planowg.ums_owg_plan))) IS NULL, visabs.abs_op_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist
         ) - IF(planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan
          / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan))) AS mdm_abschrift_op_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (visabs.abs_op_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist) - IF(planowg.abs_owg_plan / IF(planowg
             .ums_owg_plan = 0, NULL, planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan / IF(planowg.ums_owg_plan =
            0, NULL, planowg.ums_owg_plan))) IS NULL, visabs.abs_op_ist / IF(vistag.ums_tag_ist = 0, NULL, vistag.ums_tag_ist
         ) - IF(planowg.abs_owg_plan / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan) = 0, NULL, planowg.abs_owg_plan
          / IF(planowg.ums_owg_plan = 0, NULL, planowg.ums_owg_plan))) AS mdm_abschrift_op_dense,
   vis.nettostd_ist AS mdm_nettostd_ist,
   vis.nettostd_plan AS mdm_nettostd_plan,
    vis.ums_netto_ist / IF(vis.nettostd_ist = 0, NULL, vis.nettostd_ist) AS mdm_nettoleist_ist,
    vis.ums_netto_plan / IF(vis.nettostd_plan = 0, NULL, vis.nettostd_plan) AS mdm_nettoleist_plan,
     vis.ums_netto_ist / IF(vis.nettostd_ist = 0, NULL, vis.nettostd_ist) - IF(vis.ums_netto_plan / IF(vis.nettostd_plan
          = 0, NULL, vis.nettostd_plan) = 0, NULL, vis.ums_netto_plan / IF(vis.nettostd_plan = 0, NULL, vis.nettostd_plan
       )) AS mdm_nettoleist,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (vis.ums_netto_ist / IF(vis.nettostd_ist = 0, NULL, vis.nettostd_ist) - IF(vis.ums_netto_plan / IF(vis.nettostd_plan
              = 0, NULL, vis.nettostd_plan) = 0, NULL, vis.ums_netto_plan / IF(vis.nettostd_plan = 0, NULL, vis.nettostd_plan
           ))) IS NULL, vis.ums_netto_ist / IF(vis.nettostd_ist = 0, NULL, vis.nettostd_ist) - IF(vis.ums_netto_plan /
          IF(vis.nettostd_plan = 0, NULL, vis.nettostd_plan) = 0, NULL, vis.ums_netto_plan / IF(vis.nettostd_plan = 0,
          NULL, vis.nettostd_plan))) AS mdm_nettoleist_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (vis.ums_netto_ist / IF(vis.nettostd_ist = 0, NULL, vis.nettostd_ist) - IF(vis.ums_netto_plan / IF(vis.nettostd_plan
              = 0, NULL, vis.nettostd_plan) = 0, NULL, vis.ums_netto_plan / IF(vis.nettostd_plan = 0, NULL, vis.nettostd_plan
           ))) IS NULL, vis.ums_netto_ist / IF(vis.nettostd_ist = 0, NULL, vis.nettostd_ist) - IF(vis.ums_netto_plan /
          IF(vis.nettostd_plan = 0, NULL, vis.nettostd_plan) = 0, NULL, vis.ums_netto_plan / IF(vis.nettostd_plan = 0,
          NULL, vis.nettostd_plan))) AS mdm_nettoleist_dense,
   rekl.wkasse AS mdm_warten_kasse,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY rekl.wkasse IS NULL, rekl.wkasse) AS mdm_warten_kasse_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY rekl.wkasse IS NULL, rekl.wkasse) AS mdm_warten_kasse_dense,
   rekl.wtheke AS mdm_warten_theke,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY rekl.wtheke IS NULL, rekl.wtheke) AS mdm_warten_theke_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY rekl.wtheke IS NULL, rekl.wtheke) AS mdm_warten_theke_dense,
   wcal.bonanz AS mdm_bonanzahl,
   wcal.bonkcard AS mdm_bon_kcard,
    wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) AS mdm_kcard,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz)) IS NULL, wcal.bonkcard / IF(wcal.bonanz = 0,
        NULL, wcal.bonanz)) AS mdm_kcard_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz)) IS NULL, wcal.bonkcard / IF(wcal.bonanz = 0,
        NULL, wcal.bonanz)) AS mdm_kcard_dense,
   wcal.bonanz AS mdm_bonanzahl_ist,
   wcal.bonkcard AS mdm_bon_kcard_ist,
   wcal_kvj.bonanz AS mdm_bonanzahl_kvj,
   wcal_kvj.bonkcard AS mdm_bon_kcard_kvj,
    wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) AS mdm_kcard_ist,
    wcal_kvj.bonkcard / IF(wcal_kvj.bonanz = 0, NULL, wcal_kvj.bonanz) AS mdm_kcard_kvj,
     wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) - wcal_kvj.bonkcard / IF(wcal_kvj.bonanz = 0, NULL, wcal_kvj
      .bonanz) AS mdm_kcard_delta,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) - wcal_kvj.bonkcard / IF(wcal_kvj.bonanz = 0,
          NULL, wcal_kvj.bonanz)) IS NULL, wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) - wcal_kvj.bonkcard /
        IF(wcal_kvj.bonanz = 0, NULL, wcal_kvj.bonanz)) AS mdm_kcard_delta_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) - wcal_kvj.bonkcard / IF(wcal_kvj.bonanz = 0,
          NULL, wcal_kvj.bonanz)) IS NULL, wcal.bonkcard / IF(wcal.bonanz = 0, NULL, wcal.bonanz) - wcal_kvj.bonkcard /
        IF(wcal_kvj.bonanz = 0, NULL, wcal_kvj.bonanz)) AS mdm_kcard_delta_dense,
   ggl.sum_review_rating AS mdm_google_sum,
   ggl.anz_review_rating AS mdm_google_anz,
    ggl.sum_review_rating / IF(ggl.anz_review_rating = 0, NULL, ggl.anz_review_rating) AS mdm_google,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (ggl.sum_review_rating / IF(ggl.anz_review_rating = 0, NULL, ggl.anz_review_rating)) IS NULL, ggl.sum_review_rating
        / IF(ggl.anz_review_rating = 0, NULL, ggl.anz_review_rating)) AS mdm_google_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (ggl.sum_review_rating / IF(ggl.anz_review_rating = 0, NULL, ggl.anz_review_rating)) IS NULL, ggl.sum_review_rating
        / IF(ggl.anz_review_rating = 0, NULL, ggl.anz_review_rating)) AS mdm_google_dense,
   kcg.kcg_anz AS mdm_kcg_anz,
   kcg.kcg_nok_anz AS mdm_kcg_nok_anz,
    kcg.kcg_nok_anz / IF(kcg.kcg_anz = 0, NULL, kcg.kcg_anz) AS mdm_kcg_nok,
   RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (kcg.kcg_nok_anz / IF(kcg.kcg_anz = 0, NULL, kcg.kcg_anz)) IS NULL, kcg.kcg_nok_anz / IF(kcg.kcg_anz = 0
        , NULL, kcg.kcg_anz)) AS mdm_kcg_nok_rank,
   DENSE_RANK() OVER (PARTITION BY CAST(vis.mandant_id AS STRING), CAST(vis.vs_id AS STRING), vis.wrg_id, CAST(vis.kjmo AS STRING)
      ORDER BY (kcg.kcg_nok_anz / IF(kcg.kcg_anz = 0, NULL, kcg.kcg_anz)) IS NULL, kcg.kcg_nok_anz / IF(kcg.kcg_anz = 0
        , NULL, kcg.kcg_anz)) AS mdm_kcg_nok_dense,
   NULL AS mdm_kc_feststell,
   NULL AS mdm_kc_gesamt,
   NULL AS mdm_kc_nok,
   NULL AS mdm_kc_nok_rank,
   NULL AS mdm_kc_nok_dense,
   NULL AS mdm_kfb_feststell,
   NULL AS mdm_kfb_gesamt,
   NULL AS mdm_kfb_nok,
   NULL AS mdm_kfb_nok_rank,
   NULL AS mdm_kfb_nok_dense
  FROM (SELECT VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     VIS0.wrg_id,
     t4.aktuell_wup_id AS wup_id,
     VIS0.gj,
     VIS0.kjmo,
     SUM(VIS0.anz_offen) AS offen_ist,
     SUM(VIS0.ums_netto) AS ums_netto_ist,
     SUM(VIS0.ums_netto_plan) AS ums_netto_plan,
     SUM(VIS0.pers_std) AS nettostd_ist,
     SUM(VIS0.pers_std_plan) AS nettostd_plan
    FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS0
     INNER JOIN ZEIT_1 AS t1_1 ON VIS0.kjmo = t1.kjmo
     INNER JOIN WUP_1 AS t4 ON VIS0.wup_id = t4.wup_id AND VIS0.mandant_id = t4.mandant_id
    WHERE t4.neo_gj < t1.gj - 1
     AND CAST(t4.stl_dat AS DATE) > t1.max_dat /* ohne Schließungsmonat */
     AND t4.aus_fg <> 1 /* ohne Ausschluss */
     AND (t4.aus_fg <> 2 OR NOT t1.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS0.mandant_id,
     VIS0.nb_id,
     t4.vs_id,
     VIS0.wrg_id,
     wup_id,
     VIS0.gj,
     VIS0.kjmo) AS vis
   INNER JOIN (SELECT VIS00.mandant_id,
     VIS00.wrg_id,
     t14.aktuell_wup_id AS wup_id,
     t11.kjmo,
     SUM(VIS00.ums_netto) AS ums_tag_ist,
     SUM(VIS00.ums_netto_kvj) AS ums_tag_kvj
    FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS00
     INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT0 ON VIS00.dat = ZEIT0.dat
     INNER JOIN ZEIT_1 AS t11 ON ZEIT0.kjmo = t11.kjmo
     INNER JOIN WUP_1 AS t14 ON VIS00.wup_id = t14.wup_id AND VIS00.mandant_id = t14.mandant_id
    WHERE t14.neo_gj < t11.gj - 1
     AND CAST(t14.stl_dat AS DATE) > t11.max_dat /* ohne Schließungsmonat */
     AND t14.aus_fg <> 1 /* ohne Ausschluss */
     AND (t14.aus_fg <> 2 OR NOT t11.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS00.mandant_id,
     VIS00.wrg_id,
     wup_id,
     t11.kjmo) AS vistag ON vis.wup_id = vistag.wup_id AND vis.mandant_id = vistag.mandant_id AND vis.wrg_id = vistag.wrg_id
       AND vis.kjmo /* vis_wg : HWG Umsatz für Backshop und Obst & Gemüse */ = vistag.kjmo
   LEFT JOIN (SELECT VIS01.mandant_id,
     VIS01.wrg_id,
     t24.aktuell_wup_id AS wup_id,
     VIS01.kjmo,
     SUM(CASE
       WHEN OWG.hwg_id = 62
       THEN VIS01.ums_netto
       ELSE 0
       END) AS ums_bs_ist,
     SUM(CASE
       WHEN OWG.hwg_id = 64
       THEN VIS01.ums_netto
       ELSE 0
       END) AS ums_og_ist,
     SUM(CASE
       WHEN OWG.hwg_id = 62
       THEN VIS01.ums_netto_kvj
       ELSE 0
       END) AS ums_bs_kvj,
     SUM(CASE
       WHEN OWG.hwg_id = 64
       THEN VIS01.ums_netto_kvj
       ELSE 0
       END) AS ums_og_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg_1 AS VIS01
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS01.wg_id = WG.wg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
     INNER JOIN ZEIT_1 AS t21 ON VIS01.kjmo = t21.kjmo
     INNER JOIN WUP_1 AS t24 ON VIS01.wup_id = t24.wup_id AND VIS01.mandant_id = t24.mandant_id
    WHERE t24.neo_gj < t21.gj - 1
     AND CAST(t24.stl_dat AS DATE) > t21.max_dat /* ohne Schließungsmonat */
     AND t24.aus_fg <> 1 /* ohne Ausschluss */
     AND (t24.aus_fg <> 2 OR NOT t21.kjmo BETWEEN 202409 AND 202602)
     AND OWG.hwg_id IN (62, 64) /* 62 Backshop + 64 Obst & Gemüse */
    GROUP BY VIS01.mandant_id,
     VIS01.wrg_id,
     wup_id,
     VIS01.kjmo) AS vishwg ON vis.wup_id = vishwg.wup_id AND vis.mandant_id = vishwg.mandant_id AND vis.wrg_id = vishwg
      .wrg_id AND vis.kjmo /* vis_abs : Abschriften_1 */ = vishwg.kjmo
   LEFT JOIN (SELECT VIS02.mandant_id,
     t34.aktuell_wup_id AS wup_id,
     VIS02.wrg_id,
     VIS02.kjmo,
     SUM(CASE
        WHEN VIS02.mandant_id IN (6) AND VIS02.abschriftart_id = 2 OR VIS02.mandant_id IN (3) AND VIS02.abschriftart_id
              = 11 OR VIS02.mandant_id IN (2, 4, 5, 7, 8) AND VIS02.abschriftart_id = 7 OR VIS02.mandant_id IN (2, 5)
           AND VIS02.abschriftart_id = 10 OR VIS02.abschriftart_id = 20 AND VIS02.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS02.abschrift_netto) AS abs_op_ist
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg_1 AS VIS02
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_1 AS ABS_ART ON VIS02.abschriftart_id = ABS_ART.abschriftart_id
        AND VIS02.mandant_id = ABS_ART.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_1 AS ABS_THEMA ON ABS_ART.abschriftart_int_id
       = ABS_THEMA.abschriftart_int_id
     INNER JOIN ZEIT_1 AS t31 ON VIS02.kjmo = t31.kjmo
     INNER JOIN WUP_1 AS t34 ON VIS02.wup_id = t34.wup_id AND VIS02.mandant_id = t34.mandant_id
    WHERE t34.neo_gj < t31.gj - 1
     AND CAST(t34.stl_dat AS DATE) > t31.max_dat /* ohne Schließungsmonat */
     AND t34.aus_fg <> 1 /* ohne Ausschluss */
     AND (t34.aus_fg <> 2 OR NOT t31.kjmo BETWEEN 202409 AND 202602)
     AND ABS_THEMA.abschriftart_thema_int_id IN (1, 4) /* 1 Totalabschriften + 4 Preisänderungen */
    GROUP BY VIS02.mandant_id,
     wup_id,
     VIS02.wrg_id,
     VIS02.kjmo) AS visabs ON vis.wup_id = visabs.wup_id AND vis.mandant_id = visabs.mandant_id AND vis.wrg_id = visabs
      .wrg_id AND vis.kjmo /* plan_owg : Plan Abschriften_1 (Währung in mv_view) */ = visabs.kjmo
   LEFT JOIN (SELECT VIS03.mandant_id,
     VIS03.wrg_id,
     t44.aktuell_wup_id AS wup_id,
     VIS03.kjmo,
     SUM(VIS03.abschriften_netto_operativ_plan) AS abs_owg_plan,
     SUM(VIS03.umsatz_netto_plan) AS ums_owg_plan
    FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS VIS03
     INNER JOIN ZEIT_1 AS t41 ON VIS03.kjmo = t41.kjmo
     INNER JOIN WUP_1 AS t44 ON VIS03.wup_id = t44.wup_id AND VIS03.mandant_id = t44.mandant_id
    WHERE t44.neo_gj < t41.gj - 1
     AND CAST(t44.stl_dat AS DATE) > t41.max_dat /* ohne Schließungsmonat */
     AND t44.aus_fg <> 1 /* ohne Ausschluss */
     AND (t44.aus_fg <> 2 OR NOT t41.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS03.mandant_id,
     VIS03.wrg_id,
     wup_id,
     VIS03.kjmo) AS planowg ON vis.wup_id = planowg.wup_id AND vis.mandant_id = planowg.mandant_id AND vis.wrg_id =
      planowg.wrg_id AND vis.kjmo /* vis_rekl : Kundengarantie Warten Kasse/Theke (Logik in mv_view) */ = planowg.kjmo
   LEFT JOIN (SELECT VIS04.mandant_id,
     VIS04.wrg_id,
     t54.aktuell_wup_id AS wup_id,
     t51.kjmo,
     SUM(CASE
       WHEN VIS04.reklamationsgrund_id = 91
       THEN VIS04.vk_menge_kuga
       ELSE 0
       END) AS wtheke,
     SUM(CASE
       WHEN VIS04.reklamationsgrund_id = 92
       THEN VIS04.vk_menge_kuga
       ELSE 0
       END) AS wkasse
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art_1 AS VIS04
     INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT00 ON VIS04.dat = ZEIT00.dat
     INNER JOIN ZEIT_1 AS t51 ON ZEIT00.kjmo = t51.kjmo
     INNER JOIN WUP_1 AS t54 ON VIS04.wup_id = t54.wup_id AND VIS04.mandant_id = t54.mandant_id
    WHERE t54.neo_gj < t51.gj - 1
     AND CAST(t54.stl_dat AS DATE) > t51.max_dat /* ohne Schließungsmonat */
     AND t54.aus_fg <> 1 /* ohne Ausschluss */
     AND (t54.aus_fg <> 2 OR NOT t51.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS04.mandant_id,
     VIS04.wrg_id,
     wup_id,
     t51.kjmo) AS rekl_1 ON vis.mandant_id = rekl.mandant_id AND vis.wup_id = rekl.wup_id AND vis.wrg_id = rekl.wrg_id AND
     vis.kjmo /* wupcal_1 : Kunden/Kundenkarte IST (ohne WRG_1) */ = rekl.kjmo
   LEFT JOIN (SELECT VIS05.mandant_id,
     t64.aktuell_wup_id AS wup_id,
     t61.kjmo,
     SUM(VIS05.bonanzahl_sug) AS bonanz,
     SUM(VIS05.bonanzahl_kundenkarte) AS kundenkarte,
     SUM(VIS05.bonanzahl_kundenkarte_payback) AS payback,
      SUM(VIS05.bonanzahl_kundenkarte) - IFNULL(SUM(VIS05.bonanzahl_kundenkarte_payback), 0) AS bonkcard
    FROM kfl_production_dbp_data.wupcal_1 AS VIS05
     INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT01 ON VIS05.dat = ZEIT01.dat
     INNER JOIN ZEIT_1 AS t61 ON ZEIT01.kjmo = t61.kjmo
     INNER JOIN WUP_1 AS t64 ON VIS05.wup_id = t64.wup_id AND VIS05.mandant_id = t64.mandant_id
    WHERE t64.neo_gj < t61.gj - 1
     AND CAST(t64.stl_dat AS DATE) > t61.max_dat /* ohne Schließungsmonat */
     AND t64.aus_fg <> 1 /* ohne Ausschluss */
     AND (t64.aus_fg <> 2 OR NOT t61.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS05.mandant_id,
     wup_id,
     t61.kjmo) AS wcal ON vis.mandant_id = wcal.mandant_id AND vis.wup_id = wcal.wup_id AND vis.kjmo
     /* wupcal_1 : Kunden/Kundenkarte KVJ (ohne WRG_1) */ = wcal.kjmo
   LEFT JOIN (SELECT VIS06.mandant_id,
     t74.aktuell_wup_id AS wup_id,
     t71.kjmo,
     SUM(VIS06.bonanzahl_sug) AS bonanz,
     SUM(VIS06.bonanzahl_kundenkarte) AS kundenkarte,
     SUM(VIS06.bonanzahl_kundenkarte_payback) AS payback,
      SUM(VIS06.bonanzahl_kundenkarte) - IFNULL(SUM(VIS06.bonanzahl_kundenkarte_payback), 0) AS bonkcard
    FROM kfl_production_dbp_data.wupcal_1 AS VIS06
     INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT02 ON VIS06.dat = ZEIT02.dat
     INNER JOIN ZEIT_1 AS t71 ON ZEIT02.kjmo /* Transformation Mapping KVJ */ = t71.kjmo_vj
     INNER JOIN WUP_1 AS t74 ON VIS06.wup_id = t74.wup_id AND VIS06.mandant_id = t74.mandant_id
    WHERE t74.neo_gj < t71.gj - 1
     AND CAST(t74.stl_dat AS DATE) > t71.max_dat /* ohne Schließungsmonat */
     AND t74.aus_fg <> 1 /* ohne Ausschluss */
     AND (t74.aus_fg <> 2 OR NOT t71.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS06.mandant_id,
     wup_id,
     t71.kjmo) AS wcal_kvj ON vis.mandant_id = wcal_kvj.mandant_id AND vis.wup_id = wcal_kvj.wup_id AND vis.kjmo
     /* kfl_retail_store_mo_sum_1 - Google Reviews historisiert > Daten ab Jan 2024 (ohne WRG_1) */ = wcal_kvj.kjmo
   LEFT JOIN (SELECT VIS07.mandant_id,
     t84.aktuell_wup_id AS wup_id,
     VIS07.kjmo,
     SUM(VIS07.sum_review_rating) AS sum_review_rating,
     SUM(VIS07.anz_review_rating) AS anz_review_rating
    FROM kfl_production_dbp_msi_data.kfl_retail_store_mo_sum_1 AS VIS07
     INNER JOIN ZEIT_1 AS t81 ON VIS07.kjmo = t81.kjmo
     INNER JOIN WUP_1 AS t84 ON VIS07.wup_id = t84.wup_id AND VIS07.mandant_id = t84.mandant_id
    WHERE t84.neo_gj < t81.gj - 1
     AND CAST(t84.stl_dat AS DATE) > t81.max_dat /* ohne Schließungsmonat */
     AND t84.aus_fg <> 1 /* ohne Ausschluss */
     AND (t84.aus_fg <> 2 OR NOT t81.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS07.mandant_id,
     wup_id,
     VIS07.kjmo) AS ggl ON vis.wup_id = ggl.wup_id AND vis.mandant_id = ggl.mandant_id AND vis.kjmo
     /* kmr_kurzcheck NEU : Filialbewertung Gesamt (alt/NEU) kcg (mv_view / ohne WRG_1) */ = ggl.kjmo
   LEFT JOIN (SELECT VIS08.mandant_id,
     VIS08.wup_id,
     VIS08.kjmo,
     SUM(VIS08.kmr_gesamt_nok) AS kcg_nok_anz,
     SUM(VIS08.kmr_gesamt_ges) AS kcg_anz
    FROM kfl_production_dbp_msi_view_vis.mv_kmr_filialbewertung_gesamt_1 AS VIS08
     INNER JOIN ZEIT_1 AS t91 ON VIS08.kjmo = t91.kjmo
     INNER JOIN WUP_1 AS t94 ON VIS08.wup_id = t94.wup_id AND VIS08.mandant_id = t94.mandant_id
    WHERE t94.neo_gj < t91.gj - 1
     AND CAST(t94.stl_dat AS DATE) > t91.max_dat /* ohne Schließungsmonat */
     AND t94.aus_fg <> 1 /* ohne Ausschluss */
     AND (t94.aus_fg <> 2 OR NOT t91.kjmo BETWEEN 202409 AND 202602)
    GROUP BY VIS08.mandant_id,
     VIS08.wup_id,
     VIS08.kjmo) AS kcg ON vis.mandant_id = kcg.mandant_id AND vis.wup_id = kcg.wup_id AND vis.kjmo = kcg.kjmo);