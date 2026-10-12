CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_FLAECHE_PER_1 as
            -- 2009-06-18
            -- FAKTVIEW flaeche_per + flaeche_std_per (akt. Datenstand)
            -- Erweiterungen: CASE flaeche_typ, flaeche_kategorie, flaecheart_leerstand
            -- 2009KW17 Review; EUR + LW über waehrungstyp
            -- 2009KW27 Historisierung Kurs_1, Optimierung flaeche_typ_id
            -- 2011KW33 Anpassung nutzung_id von GF_1, HF, WO auf 310,300,320, flaecheart_id (A=T, Ö entfällt, Z=A)
            -- 2011KW33 std_vertragart_id umgestellt von 007 auf 300 HINWEIS ggf. falsch da vertragart_id >< std_vertragart_id
            -- 2011KW34 fl.flaeche_typ_id existiert nun in flaeche_per --> case when gelöscht
            -- 2011KW35 flaeche_bez hinzugefügt
            --2011KW37: flaech_status_id aus ivs_miet_fl_stat_zu_per_1
            --2011KW38: identifizierung "SB-Warenhaus" durch flaeche_typ_id = 30 anstelle von std_vertragart_id = 300
            --2011KW40: 901 in 70 "Freiflaechen" + Logic umgedreht -- alle gebäude_id 70 ger --> Freiflächen. Dann CASE flaeche_typ_id etc
            --20160127 KKaiser: WHEN fl.flaecheart_id IN ('I')           THEN 'zu vermarktende Flächen, nur mit Investitionsaufwand' in  'nicht wirtschaftlicher Invest' umbenennen.


            SELECT
            fl.mandant_id,
            fl.flaeche_id,
            fl.dat_von,
            fl.dat_bis,
            mfszp.flaeche_status_id_ AS flaeche_status_id,
            fl.immo_objekt_id,
            fl.gebaeude_id,
            fl.etage,
            fl.nutzung_id,
            fl.flaeche_groesse,
            fl.flaecheart_id,
            fl.dat_existiert_seit,
            fl.dat_existiert_bis,
            fl.flaeche_typ_id,
            CASE
            WHEN fl.flaecheart_id IN ('I')           THEN 4
            WHEN fl.flaecheart_id IN ('V')           THEN 5
            --WHEN fl.flaecheart_id IN ('Ö', 'O')      THEN 6 --entfällt laut Konzept
            WHEN fl.flaecheart_id IN ('T')           THEN 7
            WHEN fl.flaecheart_id IN ('U')           THEN 8
            WHEN fl.flaecheart_id IN ('A')           THEN 9
            WHEN fl.nutzung_id IN (300)             THEN 1
            WHEN fl.nutzung_id IN (310)             THEN 2
            WHEN fl.nutzung_id IN (320)             THEN 3
            ELSE 0
            END  flaecheart_leerstand_id,
            CASE
            WHEN fl.flaecheart_id IN ('I')           THEN 'nicht wirtschaftlicher Invest'
            WHEN fl.flaecheart_id IN ('V')           THEN 'Vermietungsflächen an Vertrieb'
            /*WHEN fl.flaecheart_id IN ('Ö', 'O')      THEN 'nur örtlich zu nutzen'*/
            WHEN fl.flaecheart_id IN ('T')           THEN 'Vetriebsflächen an Vermietung'
            WHEN fl.flaecheart_id IN ('U')           THEN 'Umbauflächen'
            WHEN fl.flaecheart_id IN ('A')           THEN 'zu vermietende Allgemeinflächen'
            WHEN fl.nutzung_id IN (300)             THEN 'Handelsflächen'
            WHEN fl.nutzung_id IN (310)             THEN 'Sonderflächen'
            WHEN fl.nutzung_id IN (320)             THEN 'Wohnungen'
            ELSE 'nicht definiert'
            END  flaecheart_leerstand_bez,
            CASE
            WHEN fl.gebaeude_id IN ('070')                                THEN 6
            WHEN fl.flaeche_typ_id  = '30'                            THEN 5
            WHEN fl.nutzung_id IN (310)                                  THEN 1
            WHEN fl.nutzung_id IN (300) AND fl.flaeche_groesse < 200      THEN 2
            WHEN fl.nutzung_id IN (300) AND fl.flaeche_groesse >= 200     THEN 3
            WHEN fl.nutzung_id IN (320)                                  THEN 4
            ELSE 0
            END  flaeche_kategorie_id,
            CASE
            WHEN fl.gebaeude_id IN ('070')                                THEN 'Freiflaechen'
            WHEN fl.flaeche_typ_id  = '30'                            THEN 'SB-Warenhaus'
            WHEN fl.nutzung_id IN (310)                                  THEN 'Gewerbeflaechen'
            WHEN fl.nutzung_id IN (300) AND fl.flaeche_groesse < 200      THEN 'Handelsflaechen < 200m²'
            WHEN fl.nutzung_id IN (300) AND fl.flaeche_groesse >= 200     THEN 'Handelsflaechen >= 200m²'
            WHEN fl.nutzung_id IN (320)                                  THEN 'Wohnungen'
            ELSE 'nicht definiert'
            END  flaeche_kategorie_bez,
            fs.std_branche_id,
            fs.std_vertragart_id           std_vertragart_id,
            fs.std_miete_betrag    * kurs_1  std_miete_betrag,
            fs.std_miete_qm_betrag * kurs_1  std_miete_qm_betrag,
            fs.std_miete_prozent,
            kurs.wrg_id,
            kurs.wrg_typ_id,
            fl.flaeche_bez

           FROM dbp_view.v_ivs_flaeche_per_1 fl
            INNER JOIN dbp_view.v_ivs_flaeche_standard_per_1 fs
            ON fl.mandant_id = fs.mandant_id
            AND fl.flaeche_id = fs.flaeche_id
            AND fl.dat_bis = fs.dat_bis
            INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1  kurs_1
            ON kurs.mandant_id = fl.mandant_id
            AND CURRENT_DATE BETWEEN kurs_dat_von AND kurs_dat_bis
            INNER JOIN
            (
            SELECT
            mandant_id,
            flaeche_id,
            MAX(flaeche_status_id) AS flaeche_status_id_
            FROM dbp_view.v_ivs_miet_fl_stat_zu_per_1
            WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
            GROUP BY 1,2
            ) mfszp
            ON mfszp.mandant_id = fl.mandant_id
            AND mfszp.flaeche_id = fl.flaeche_id

            WHERE fl.dat_bis = '9999-12-31';