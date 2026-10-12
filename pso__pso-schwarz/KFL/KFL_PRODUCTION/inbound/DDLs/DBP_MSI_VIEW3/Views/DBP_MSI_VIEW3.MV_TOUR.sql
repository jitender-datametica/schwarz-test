CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR(
	MANDANT_ID,
	SYSTEM_ID,
	NB_ID,
	WUP_ID,
	TOUR_ID,
	VERTR_BELEG_TYP_ID,
	MENGE_TOUR_KOLLI,
	MENGE_TOUR_PALETTE,
	VERSANDART_ID,
	GEW_EINH_ID,
	VOL_EINH_ID,
	DAT_TOUR,
	TRANSPORTART_ID,
	TRANSPORT_DISPO_STELLE,
	GP_ID,
	TOUR_ID_EXT,
	ANZAHL_TOUR,
	ANZAHL_GEKUEHLTE_TOUR,
	ANZAHL_RUNDLAUF_TOUR,
	RUNDLAUF_TRANSPORT_FG,
	BELOS_TOURART_ID,
	BELOS_TOURSTATUS_ID,
	SONDERABWICKLUNG_ID,
	BELOS_ADRESSE_SPEDITION_ID,
	FLEISCHWERK_FG,
	DISTRIBUTION_ABR_FG,
	SUMME_GEFAHRGUT,
	INDUSTRIE_ABH_FG,
	DAT_DISPO,
	ZEIT_DISPO,
	DAT_REGISTRIERUNG,
	ZEIT_REGISTRIERUNG,
	DAT_LADEN_BEGINN,
	ZEIT_LADEN_BEGINN,
	DAT_LADEN_ENDE,
	ZEIT_LADEN_ENDE,
	DAT_TRANSPORT_ENDE,
	ZEIT_TRANSPORT_ENDE,
	DAT_PLAN_REGISTRIERUNG,
	ZEIT_PLAN_REGISTRIERUNG,
	DAT_PLAN_TRANSPORT_ENDE,
	ZEIT_PLAN_TRANSPORT_ENDE,
	ANKUNFTSZEIT_ZEITSTEMPEL_IST,
	TRANSPORTENDE_ZEITSTEMPEL_IST,
	ANKUNFTSZEIT_PLAN_ZEITSTEMPEL,
	TRANSPORTENDE_PLAN_ZEITSTEMPEL_SAP,
	TRANSPORTENDE_PLAN_ZEITSTEMPEL_DWH,
	PUNKTLICHKEIT_ANKUNFT_VZ_FG,
	PUNKTLICHKEIT_ABFAHRT_VZ_SAP_FG,
	PUNKTLICHKEIT_ABFAHRT_VZ_DWH_FG,
	AUSLASTUNGSGRUND_ID,
	TOURART_SUBTYP_ID,
	BELOS_TEUERST_MARKT_WUP_ID,
	BELOS_TEUERST_MARKT_NB_ID,
	BELOS_TEUERST_MARKT_MANDANT_ID,
	DISPO_DT,
	REGISTRIERUNG_DT,
	LADEN_BEGINN_DT,
	LADEN_ENDE_DT,
	TRANSPORT_ENDE_DT,
	PLAN_REGISTRIERUNG_DT,
	PLAN_TRANSPORT_ENDE_DT,
	TRAILER_FG,
	DAUER_TRANSPORTABWICKLUNG,
	DAUER_BIS_BEGINN_VERLADUNG,
	DAUER_VERLADEZEIT,
	DAUER_BIS_TRANSPORTABSCHLUSS,
	DIFF_ANKUNFTZEIT_IST_ZU_PLAN,
	DIFF_TRANSPORTENDE_IST_ZU_PLAN,
	DIFF_VERLADUNG_TRANSPORTENDE,
	UNSAUBERE_ABMELDUNG_SCAN,
	NACHDRUCK_VERLADELISTE,
	DAUER_PFORTE_TRANSPORTENDE,
	DAUER_PFORTE_DISPO,
	DAUER_VERPLANUNG,
	VERWEILDAUER_IM_GELANDE,
	BELOS_ADRESSE_NUM_ID,
	LAGERNUMMER_ID,
	ANLIEFERUNG_ID,
	DAT_ANKUNFT_VZ,
	ZEIT_ANKUNFT_VZ,
	DAT_EINFAHRT_PFORTE,
	ZEIT_EINFAHRT_PFORTE,
	DAT_AUSFAHRT_PFORTE,
	ZEIT_AUSFAHRT_PFORTE,
	ANZ_WE_PAL_ABGELADEN,
	QUEUE_ID,
	MISCH_LKW_NUMMER,
	MISCH_LKW_POSITION,
	TRANSPORTSTATUS_ID,
	ANZ_SORT,
	TEXT_1,
	TEXT_2,
	TEXT_3,
	TEXT_4,
    TMS
) AS
    -- 19.04.2010 AL Ergänzt um die Spalten aus BeLos System
    -- GROUP BY Statement rausgenommen
    -- 09.08.2011 srom Ergänzt um CASE Logik für rundlauf_transport_fg
    -- 07.03.2013 srom Korrektur transport_ende_dt, im coalesce war eine falsches Feld
    -- 26.03.2013 Anfo 582769 neues Feld Dauer Beginn Verladung bis Transportabschluss
    -- 06.08.2013 Anfo 584963 neues Feld auslastungsgrund_id
    -- 17.02.2014 Anfo 589416 neues Feld tourart_subtyp_id
    -- 13.02.2014 Anfo 591162 neue Felder , diff_pforte_transportende, diff_pforte_dispo
    -- 13.02.2014 Anfo 591162: Alternativ lagert man das in eine eigene View aus und hakt alle Attribute und Fakten entsprechend ein
    -- 13.02.2014 Anfo 591162: siehe View mv_tour_plombe_transp_abwickl
    -- 11.03.2014 Anfo 591162: neues Feld, teuerster Markt
    -- 13.05.2013 srom, 589416, belos_adresse_num_id
    -- 10.03.2017 srom, transportart_id ZF03 aufgenommen (lt. Mail N. Wagner vom 09.03.2017)
    -- 03.12.2018 mkub1811, AP0027269, Erweiterung um lagernummer_id, anlieferung_id, dat_ankunft_vz, zeit_ankunft_vz, dat_einfahrt_pforte, zeit_einfahrt_pforte, dat_ausfahrt_pforte, zeit_ausfahrt_pforte, anz_we_pal_abgeladen, queue_id, misch_lkw_nummer, misch_lkw_position, transportstatus_id, text_1, text_2, text_3, text_4
    -- 07.01.2019 srom, Abfangen von ungültigen/großen Datumswerten innerhalb der Berechnng Zeitdifferenzen
    -- 17.01.2019 aszu1204, AP0027269 additional time differences calculations
    -- 2022-04-27, dknop, AP0119377_SPEC0152763, adding ANKUNFTSZEIT_ZEITSTEMPEL_IST,TRANSPORTENDE_ZEITSTEMPEL_IST, ANKUNFTSZEIT_PLAN_ZEITSTEMPEL,TRANSPORTENDE_PLAN_ZEITSTEMPEL_SAP,TRANSPORTENDE_PLAN_ZEITSTEMPEL_DWH,PUNKTLICHKEIT_ANKUNFT_VZ_FG,PUNKTLICHKEIT_ABFAHRT_VZ_SAP_FG,PUNKTLICHKEIT_ABFAHRT_VZ_DWH_FG,
    -- 2022-05-23, dknop, updates based on P : Berechnungen der Datumsdifferenzen wurden für Snowflake stark gekürzt
    -- 2022-07-08, dknop, adding anz_sort, updating logic for transportende_plan_zeitstempel_DWH
    -- 2022-08-09, dknop, AP0119377_SPEC0152763, adding -1 for flags punktlichkeit_ankunft_VZ_fg, punktlichkeit_abfahrt_VZ_SAP_fg, punktlichkeit_abfahrt_VZ_DWH_fg
    -- 2022-10-14, dknop, adding join to plantour for trailer_fg
-- 2022-04-27, dknop, AP0119377_SPEC0152763, adding ANKUNFTSZEIT_ZEITSTEMPEL_IST,TRANSPORTENDE_ZEITSTEMPEL_IST, ANKUNFTSZEIT_PLAN_ZEITSTEMPEL,TRANSPORTENDE_PLAN_ZEITSTEMPEL_SAP,TRANSPORTENDE_PLAN_ZEITSTEMPEL_DWH,PUNKTLICHKEIT_ANKUNFT_VZ_FG,PUNKTLICHKEIT_ABFAHRT_VZ_SAP_FG,PUNKTLICHKEIT_ABFAHRT_VZ_DWH_FG,
-- 2022-05-23, dknop, updates based on P : Berechnungen der Datumsdifferenzen wurden für Snowflake stark gekürzt
-- 2022-07-08, dknop, adding anz_sort, updating logic for transportende_plan_zeitstempel_DWH
-- 2022-08-09, dknop, AP0119377_SPEC0152763, adding -1 for flags punktlichkeit_ankunft_VZ_fg, punktlichkeit_abfahrt_VZ_SAP_fg, punktlichkeit_abfahrt_VZ_DWH_fg
-- 2022-10-14, dknop, adding join to plantour for trailer_fg
--2024-07-24,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic for t01.belos_teuerst_markt_wup_id
--2025-02-26, nwag. adding WANKO
--2025-09-30, nwag. fix because of BELOS disconnect
SELECT t01.mandant_id,
    t01.system_id,
    t01.nb_id,
    t01.wup_id,
    t01.tour_id,
    t01.vertr_beleg_typ_id,
    t01.menge_tour_kolli,
    t01.menge_tour_palette,
    t01.versandart_id,
    t01.gew_einh_id,
    t01.vol_einh_id,
    t01.dat_tour,
    t01.transportart_id,
    t01.transport_dispo_stelle,
    t01.gp_id,
    t01.tour_id_ext,
    t01.anzahl_tour,
    t01.anzahl_gekuehlte_tour,
    t01.anzahl_rundlauf_tour,
    t01.rundlauf_transport_fg,
    t01.belos_tourart_id,
    t01.belos_tourstatus_id,
    t01.sonderabwicklung_id,
    t01.belos_adresse_spedition_id,
    t01.fleischwerk_fg,
    t01.distribution_abr_fg,
    t01.summe_gefahrgut,
    t01.industrie_abh_fg,
    t01.dat_dispo,
    t01.zeit_dispo,
    t01.dat_registrierung,
    t01.zeit_registrierung,
    t01.dat_laden_beginn,
    t01.zeit_laden_beginn,
    t01.dat_laden_ende,
    t01.zeit_laden_ende,
    t01.dat_transport_ende,
    t01.zeit_transport_ende,
    t01.dat_plan_registrierung,
    t01.zeit_plan_registrierung,
    t01.dat_plan_transport_ende,
    t01.zeit_plan_transport_ende,
    TIMESTAMP_FROM_PARTS(t01.dat_registrierung,COALESCE(t01.zeit_registrierung,'00:00:00')) AS ankunftszeit_zeitstempel_ist,
    TIMESTAMP_FROM_PARTS(t01.dat_transport_ende,COALESCE(t01.zeit_transport_ende,'00:00:00')) AS transportende_zeitstempel_ist,
    TIMESTAMP_FROM_PARTS(t01.dat_plan_registrierung,COALESCE(t01.zeit_plan_registrierung,'00:00:00')) AS  ankunftszeit_plan_zeitstempel,
    TIMESTAMP_FROM_PARTS(t01.dat_plan_transport_ende,COALESCE(t01.zeit_plan_transport_ende,'00:00:00')) AS transportende_plan_zeitstempel_SAP,     
    --DATEADD(HOUR,2,TIMESTAMP_FROM_PARTS(dat_plan_registrierung,COALESCE(t01.zeit_plan_registrierung,'00:00:00'))) AS transportende_plan_zeitstempel_DWH,
    CASE WHEN anz_sort IN (1,2) THEN DATEADD(HOUR,2,TIMESTAMP_FROM_PARTS(dat_plan_registrierung,COALESCE(t01.zeit_plan_registrierung,'00:00:00')))
         WHEN anz_sort=3 THEN DATEADD(MINUTE,150,TIMESTAMP_FROM_PARTS(dat_plan_registrierung,COALESCE(t01.zeit_plan_registrierung,'00:00:00')))
         WHEN anz_sort>=4 THEN DATEADD(HOUR,3,TIMESTAMP_FROM_PARTS(dat_plan_registrierung,COALESCE(t01.zeit_plan_registrierung,'00:00:00')))
         ELSE NULL END AS transportende_plan_zeitstempel_DWH,
    CASE WHEN TIMESTAMPDIFF('second',ankunftszeit_zeitstempel_ist,ankunftszeit_plan_zeitstempel)>=0 THEN 1
              WHEN TIMESTAMPDIFF('second',ankunftszeit_zeitstempel_ist,ankunftszeit_plan_zeitstempel)IS NULL THEN -1 ELSE 0 END AS punktlichkeit_ankunft_VZ_fg,
    CASE WHEN TIMESTAMPDIFF('second',transportende_zeitstempel_ist,transportende_plan_zeitstempel_SAP)>=0 THEN 1 
              WHEN TIMESTAMPDIFF('second',transportende_zeitstempel_ist,transportende_plan_zeitstempel_SAP)>=0 THEN -1 ELSE 0 END AS punktlichkeit_abfahrt_VZ_SAP_fg, 
    CASE WHEN TIMESTAMPDIFF('second',transportende_zeitstempel_ist,transportende_plan_zeitstempel_DWH)>=0 THEN 1
               WHEN TIMESTAMPDIFF('second',transportende_zeitstempel_ist,transportende_plan_zeitstempel_DWH)>=0 THEN -1 ELSE 0 END AS punktlichkeit_abfahrt_VZ_DWH_fg,
    t01.auslastungsgrund_id,
    t01.tourart_subtyp_id,
    --t01.belos_teuerst_markt_wup_id,
    aktuell_wup_id AS belos_teuerst_markt_wup_id, --
   -- CASE WHEN TRY_CAST(t01.belos_teuerst_markt_wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END belos_teuerst_markt_wup_id,
    t01.belos_teuerst_markt_nb_id, --
    t01.belos_teuerst_markt_mandant_id, --
    t01.dispo_dt,
    t01.registrierung_dt,
    t01.laden_beginn_dt,
    t01.laden_ende_dt,
    t01.transport_ende_dt,
    t01.plan_registrierung_dt,
    t01.plan_transport_ende_dt,
    COALESCE(t03.trailer_fg,-1),
   -- Achtung: Berechnungen der Datumsdifferenzen wurden für Snowflake stark gekürzt
   
   CAST( CASE
        WHEN dat_transport_ende < ADD_MONTHS(CURRENT_DATE, 48)
        AND dat_dispo < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', dispo_dt, transport_ende_dt)
        ELSE NULL
    END AS NUMBER(38,5)) AS dauer_transportabwicklung,
    CAST(CASE
        WHEN dat_laden_beginn < ADD_MONTHS(CURRENT_DATE, 48)
        AND dat_dispo < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', dispo_dt, laden_beginn_dt)
        
        ELSE NULL
    END AS NUMBER(38,5)) AS dauer_bis_beginn_verladung,
    CAST(CASE
        WHEN dat_laden_ende < ADD_MONTHS(CURRENT_DATE, 48)
        AND dat_laden_beginn < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', laden_beginn_dt, laden_ende_dt)
        ELSE NULL
    END AS NUMBER(38,5)) AS dauer_verladezeit,
    CAST(CASE
        WHEN dat_transport_ende < ADD_MONTHS(CURRENT_DATE, 48)
        AND dat_laden_ende < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', laden_ende_dt, transport_ende_dt)
        ELSE NULL
    END AS NUMBER(38,5)) AS dauer_bis_transportabschluss,
    CAST(CASE
        WHEN dat_dispo < ADD_MONTHS(CURRENT_DATE, 48)
        AND dat_plan_registrierung < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', plan_registrierung_dt, dispo_dt)
         ELSE NULL
    END AS NUMBER(38,5)) AS diff_ankunftzeit_ist_zu_plan,
    CAST(CASE
        WHEN dat_transport_ende < ADD_MONTHS(CURRENT_DATE, 48)
       AND dat_plan_transport_ende < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', plan_transport_ende_dt, transport_ende_dt) 
         ELSE NULL
    END AS NUMBER(38,5)) AS diff_transportende_ist_zu_plan,
    CAST(CASE
        WHEN dat_transport_ende < ADD_MONTHS(CURRENT_DATE, 48)
        AND dat_laden_beginn < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', laden_beginn_dt, transport_ende_dt)
        ELSE NULL
    END AS NUMBER(38,5)) AS diff_verladung_transportende,
    CASE
        WHEN dat_laden_ende IS NULL
        AND zeit_laden_ende = '00:00:00' THEN 1
        ELSE 0
    END AS unsaubere_abmeldung_scan,
    CASE
        WHEN dispo_dt <> registrierung_dt THEN 1
        ELSE 0
    END AS nachdruck_verladeliste,
    CAST(CASE
        WHEN dat_transport_ende < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', transport_ende_dt, ausfahrt_pforte_dt)
         ELSE NULL
    END AS NUMBER(38,5)) AS dauer_pforte_transportende,
    CAST(CASE
        WHEN dat_dispo < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', dispo_dt, ausfahrt_pforte_dt)
        ELSE NULL
    END AS NUMBER(38,5)) AS dauer_pforte_dispo,
    CAST(CASE
        WHEN dat_registrierung < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', registrierung_dt, laden_beginn_dt)
        ELSE NULL
    END AS NUMBER(38,5)) AS dauer_verplanung,
    CAST(CASE
        WHEN dat_einfahrt_pforte < ADD_MONTHS(CURRENT_DATE, 48) THEN 
            datediff('second', einfahrt_pforte_dt, ausfahrt_pforte_dt2)
        ELSE NULL
    END AS NUMBER(38,5)) AS verweildauer_im_gelande,
    belos_adresse_num_id,
    lagernummer_id,
    anlieferung_id,
    dat_ankunft_vz,
    zeit_ankunft_vz,
    dat_einfahrt_pforte,
    zeit_einfahrt_pforte,
    dat_ausfahrt_pforte,
    zeit_ausfahrt_pforte,
    anz_we_pal_abgeladen,
    queue_id,
    misch_lkw_nummer,
    misch_lkw_position,
    transportstatus_id,
    anz_sort,
    text_1,
    text_2,
    text_3,
    text_4,
    tms
FROM (
        SELECT v01.mandant_id,
            v01.system_id,
            v01.nb_id,
            v01.wup_id,
            v01.tour_id,
            CASE WHEN v01.dat_tour < COALESCE(dw.dat_tms_wanko, DATE'9999-12-31')  THEN 'BELOS' ELSE 'WANKO' END AS tms,
            v01.vertr_beleg_typ_id,
            v01.menge_tour_kolli,
            v01.menge_tour_palette,
            v01.versandart_id,
            v01.gew_einh_id,
            v01.vol_einh_id,
            v01.dat_tour,
            v01.transportart_id,
            v01.transport_dispo_stelle,
            v01.gp_id,
            v01.tour_id_ext,
            CAST(1 AS DECIMAL(18, 0)) AS anzahl_tour,
            v01.gekuehlt_transport_fg AS anzahl_gekuehlte_tour,
            v01.rundlauf_transport_fg AS anzahl_rundlauf_tour,
            CASE
                WHEN v01.industrie_abh_fg = 1 THEN 10
                ELSE v01.rundlauf_transport_fg
            END AS rundlauf_transport_fg,
            --v01.belos_tourart_id,
            CASE WHEN tms = 'WANKO' THEN v021.tms_tourart_detail_id ELSE COALESCE(v01.belos_tourart_id, '-1') END AS belos_tourart_id,
            CASE WHEN tms = 'WANKO' THEN v021.tms_tourstatus_id ELSE COALESCE(v01.belos_tourstatus_id, -1) END AS belos_tourstatus_id, 
            v01.sonderabwicklung_id, -- 
            CASE WHEN tms = 'WANKO' THEN v021.spedition_tms_gp_id ELSE v01.belos_adresse_spedition_id END AS belos_adresse_spedition_id, 
            COALESCE(v01.fleischwerk_fg,0) AS fleischwerk_fg, 
            CASE WHEN tms = 'WANKO' THEN v021.distribution_abr_fg ELSE v01.distribution_abr_fg END AS distribution_abr_fg,
            v01.summe_gefahrgut,
            v01.industrie_abh_fg,
            v01.dat_dispo,
            v01.zeit_dispo,
            v01.dat_registrierung,
            v01.zeit_registrierung,
            v01.dat_laden_beginn,
            v01.zeit_laden_beginn,
            v01.dat_laden_ende,
            v01.zeit_laden_ende,
            v01.dat_transport_ende,
            v01.zeit_transport_ende,
            v01.dat_plan_registrierung,
            v01.zeit_plan_registrierung,
            v01.dat_plan_transport_ende,
            v01.zeit_plan_transport_ende,
            v01.auslastungsgrund_id,
            v01.tourart_subtyp_id, --
            v01.belos_teuerst_markt_wup_id,
            v01.belos_teuerst_markt_nb_id,
            v01.belos_teuerst_markt_mandant_id,
            CASE
                WHEN v01.dat_dispo IS NOT NULL
                AND v01.zeit_dispo IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_dispo AS CHAR(11)) || ' ' || v01.zeit_dispo AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS dispo_dt,
            CASE
                WHEN v01.dat_registrierung IS NOT NULL
                AND v01.zeit_registrierung IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_registrierung AS CHAR(11)) || ' ' || v01.zeit_registrierung AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS registrierung_dt,
            CASE
                WHEN v01.dat_laden_beginn IS NOT NULL
                AND v01.zeit_laden_beginn IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_laden_beginn AS CHAR(11)) || ' ' || v01.zeit_laden_beginn AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS laden_beginn_dt,
            CASE
                WHEN v01.dat_laden_ende IS NOT NULL
                AND v01.zeit_laden_ende IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_laden_ende AS CHAR(11)) || ' ' || v01.zeit_laden_ende AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS laden_ende_dt,
            CASE
                WHEN v01.dat_transport_ende IS NOT NULL
                AND v01.zeit_transport_ende IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_transport_ende AS CHAR(11)) || ' ' || v01.zeit_transport_ende AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS transport_ende_dt,
            CASE
                WHEN v01.dat_plan_registrierung IS NOT NULL
                AND v01.zeit_plan_registrierung IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_plan_registrierung AS CHAR(11)) || ' ' || v01.zeit_plan_registrierung AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS plan_registrierung_dt,
            CASE
                WHEN v01.dat_plan_transport_ende IS NOT NULL
                AND v01.zeit_plan_transport_ende IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_plan_transport_ende AS CHAR(11)) || ' ' || v01.zeit_plan_transport_ende AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS plan_transport_ende_dt,
            CASE
                WHEN v01.dat_einfahrt_pforte IS NOT NULL
                AND v01.zeit_einfahrt_pforte IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_einfahrt_pforte AS CHAR(11)) || ' ' || v01.zeit_einfahrt_pforte  AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS einfahrt_pforte_dt,
            CASE
                WHEN v01.dat_ausfahrt_pforte IS NOT NULL
                AND v01.zeit_ausfahrt_pforte IS NOT NULL THEN (
                    CAST(
                        CAST(v01.dat_ausfahrt_pforte AS CHAR(11)) || ' ' || v01.zeit_ausfahrt_pforte AS TIMESTAMP
                    )
                )
                ELSE NULL
            END AS ausfahrt_pforte_dt2,
            v02.ausfahrt_pforte_dt,
            COALESCE(v01.belos_adresse_num_id,v021.wup_id) AS belos_adresse_num_id,
            v01.lagernummer_id,
            v01.anlieferung_id,
            v01.dat_ankunft_vz,
            v01.zeit_ankunft_vz,
            v01.dat_einfahrt_pforte,
            v01.zeit_einfahrt_pforte,
            v01.dat_ausfahrt_pforte,
            v01.zeit_ausfahrt_pforte,
            v01.anz_we_pal_abgeladen,
            v01.queue_id,
            v01.misch_lkw_nummer,
            v01.misch_lkw_position,
            v01.transportstatus_id,
            v01.text_1,
            v01.text_2,
            v01.text_3,
            v01.text_4
        FROM dbp_view.v_tour v01

        LEFT JOIN (
            SELECT DISTINCT tms_tour.mandant_id , TRY_CAST(tms_tour.startlager_tms_gp_id AS NUMBER) AS wup_id, 
            TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) AS tour_id
            , tms_tour.dat_tour, CASE WHEN tms_tour.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg ,tms_tour.tms_tourart_detail_id, TMS_TOURSTATUS_ID, tms_tour.spedition_tms_gp_id 
            FROM dbp_data.tms_tour tms_tour
            WHERE LEFT(tms_tour.transportation_unit_id_ext,3) = 'SAP' AND YEAR(tms_tour.DAT_TOUR) >= YEAR(CURRENT_DATE) -2
            AND EXISTS (SELECT 1 FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM v022 WHERE  tms_tour.dat_tour >= v022.dat_tms_wanko AND  tms_tour.mandant_id=v022.mandant_id 
            AND   TRY_CAST(tms_tour.startlager_tms_gp_id AS NUMBER) = v022.wup_id  ) ) v021 
            ON v01.mandant_id  = v021.mandant_id
            AND v01.wup_id     = v021.wup_id
            AND v01.tour_id    = v021.tour_id 

        LEFT JOIN   ( SELECT mandant_id, wup_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, wup_id ) dw ON v01.mandant_id  = dw.mandant_id
            AND v01.wup_id     = dw.wup_id


            LEFT JOIN (
                -- v02
                SELECT mandant_id,
                    tour_id,
                    MIN(
                        (
                            CAST(
                                CAST(dat_erfasst AS CHAR(11)) || ' ' || zeit_erfasst AS TIMESTAMP
                            )
                        )
                    ) AS ausfahrt_pforte_dt
                FROM dbp_view.v_tour_plombe_start
                WHERE plombe_vorgang_id = 'B'
                    AND storno_fg = 0
                    AND nb_id = -111
                GROUP BY mandant_id,
                    tour_id
            ) v02 ON v01.mandant_id = v02.mandant_id
            AND v01.tour_id = v02.tour_id --20.01.15 Awol2209. Mail Hr. Wilhelm vom 14.01.15: Tourarten ZF01, ZF02 (Fleischwerk) mit aufgenommen.
        WHERE transportart_id IN ('Z001', 'ZF01', 'ZF02', 'ZF03')
    ) t01
 LEFT JOIN 
 (SELECT  tour_id
         ,mandant_id
		 ,COUNT (DISTINCT lagernummer_id) AS anz_sort
		 FROM dbp_view.v_protokoll_verladung
		WHERE pruef_id = '334'
     GROUP BY tour_id
         ,mandant_id
 ) t02
		ON  t01.tour_id=t02.tour_id
		AND t01.mandant_id=t02.mandant_id


LEFT JOIN dbp_view.v_wup v05
   ON v05.mandant_id = CASE WHEN t01.belos_teuerst_markt_mandant_id IS NULL OR t01.belos_teuerst_markt_mandant_id = 0 THEN t01.mandant_id ELSE t01.belos_teuerst_markt_mandant_id END
  -- AND v05.wup_id = CASE WHEN TRY_CAST(belos_teuerst_markt_wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(belos_teuerst_markt_wup_id AS INTEGER) END
   AND v05.wup_id = belos_teuerst_markt_wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN 	dbp_view.v_plantour t03
        ON  t01.tour_id=t03.tour_id
		AND t01.mandant_id=t03.mandant_id  	
		AND t01.wup_id=t03.wup_id 
;