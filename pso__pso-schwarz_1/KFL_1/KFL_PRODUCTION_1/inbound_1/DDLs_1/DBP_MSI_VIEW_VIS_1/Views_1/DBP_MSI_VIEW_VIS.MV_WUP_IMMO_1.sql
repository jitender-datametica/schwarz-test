CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_IMMO_1
AS
    -- LOOKUP - Stammdaten Filiale + Immo Massnahmen
    -- 2019.0924 ssch0611 : Review based on wup_1
    -- 2019.0925 ssch0611 : Added IMS data (schliessung, massnahme etc.)
    -- 2020.0401 ssch0611 : Update

   SELECT
     v01.mandant_id, v01.nb_id, CASE WHEN v01.nb_id = -1 THEN CASE v01.vs_id
   WHEN 1 THEN  43 -- 4. Luebbenau/O
   WHEN 2 THEN  22 -- 2. Geissenfeld/SO
   WHEN 3 THEN  46 -- 3. Osterfeld/M
   WHEN 6 THEN 124 -- 6. Dortmund/W
   WHEN 7 THEN   2 -- 1. Moeckmuehl/SW
   WHEN 8 THEN  28 -- 5. Barsinghausen/N
   ELSE 0          -- 9. DE/NN
   END
 ELSE Coalesce(v01.haupt_wup_id, v01.wup_id) END AS haupt_wup_id, v01.land_id, v01.wup_id, v01.wup_standort, Coalesce(v01.dat_von_alt, v01.dat_von)                                          AS dat_von         -- erster Abverkaufstag
   , v01.dat_bis                                                                     AS dat_bis         -- letzter Abverkaufstag
   , Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)                            AS dat_eroeffnung  -- Eroeffnungsdatum (Masterdata)
   , v01.umzugsfiliale_fg                                                            AS umzug_fg    -- nur bei Umzug (bisherige Logik)
   , CASE WHEN v01.wup_id_alt > 1 THEN v01.dat_eroeffnung END                        AS dat_umzug   -- 
   , v01.wup_id_alt                                                                  AS wup_id_alt  --      
   , v01.dat_wiedereroeffnung                                                        AS dat_wiedereroeffnung -- Wiedereroeffnung (Masterdata)
   , Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung)  AS dat_steckbrief       -- Offizielles Wieder-/Eroeffnungsdatum
   , CASE WHEN v01.dat_bis < (CURRENT_DATE + 1) THEN v01.dat_bis ELSE NULL END               AS dat_geschlossen      -- nur wenn auch geschlossen
   , v01.dat_letzte_modernisierung_von                                               AS dat_letzte_modernisierung_von, v01.dat_letzte_modernisierung_bis                                               AS dat_letzte_modernisierung_bis, v01.dat_letzter__facelift_von                                                   AS dat_letzter_facelift_von -- 2020.04
   , v01.dat_letzter_facelift                                                        AS dat_letzter_facelift_bis -- 2020.04
   , v01.dat_letzter_facelift                                                        AS dat_letzter_facelift, v022.modernisierung_art                                                         AS moderniserung_art, v022.hinweis_massnahme                                                          AS modernisierung_hinweis, v022.gj                                                                         AS modernisierung_gj, Coalesce(v022.immo_fg, 0)                                                       AS modernisierung_immo_fg  -- Relevanz fuer Reporting
   , v022.dat_massnahme_von, v022.dat_massnahme_bis, CASE
   WHEN v022.modernisierung_art = 'Expansion'            AND v022.hinweis_massnahme = 'A/N' THEN 'A/N'
   WHEN v022.modernisierung_art = 'Expansion'            AND v01.wup_id_alt > 0 THEN 'U'
   WHEN v022.modernisierung_art = 'Expansion'            AND v022.hinweis_massnahme IS NULL THEN 'X'
   WHEN v022.modernisierung_art = 'Modernisierung'       AND v022.hinweis_massnahme IS NULL THEN 'MOD'
   WHEN v022.modernisierung_art = 'Facelift'             AND v022.hinweis_massnahme IS NULL THEN 'FCL'
   WHEN v022.modernisierung_art = 'Sonstige Baumaßnahme' AND v022.hinweis_massnahme IS NULL THEN 'SON'

   ELSE ''
 END                                                                                                                 AS massnahme_kbez, Add_Months (v022.dat_massnahme_von - 1,  1) - (Extract(DAY From Add_Months (v022.dat_massnahme_von - 1,  1)) - 1)   AS massnahme_mo_von, 
 
 v022.dat_massnahme_bis - (Extract(DAY From (v022.dat_massnahme_bis + 1)) - 1)                                       AS massnahme_mo_bis, massnahme_mo_bis - massnahme_mo_von                                                                                 AS massnahme_mo_count, 
 CASE WHEN massnahme_mo_count > 0 THEN massnahme_kbez ELSE '' END                                                    AS massnahme_mo_kbez, 
 CASE WHEN massnahme_mo_count > 0 THEN Extract(YEAR From massnahme_mo_von) * 100 + Extract(MONTH From massnahme_mo_von) ELSE 0 End::INTEGER AS massnahme_kjmo_von, 
 CASE WHEN massnahme_mo_count > 0 THEN Extract(YEAR From massnahme_mo_bis) * 100 + Extract(MONTH From massnahme_mo_bis) ELSE 0 End::INTEGER AS massnahme_kjmo_bis, 
 v02.dat_schliessung_von, v02.dat_schliessung_bis, CASE WHEN dat_schliessung_von > '1900-01-01' THEN 'STL' ELSE '' END                                                          AS schliessung_kbez, 
 Add_Months (v02.dat_schliessung_von - 1,  1) - (Extract(DAY From Add_Months (v02.dat_schliessung_von - 1,  1)) - 1) AS schliessung_mo_von, 
 v02.dat_schliessung_bis - (Extract(DAY From (v02.dat_schliessung_bis + 1)) - 1)                                     AS schliessung_mo_bis, schliessung_mo_bis - schliessung_mo_von                                                                             AS schliessung_mo_count, 
 CASE WHEN schliessung_mo_count > 0 THEN schliessung_kbez ELSE '' END                                                AS schliessung_mo_kbez, 
 CASE WHEN schliessung_mo_count > 0 THEN Extract(YEAR From schliessung_mo_von) * 100 + Extract(MONTH From schliessung_mo_von) ELSE 0 End::INTEGER AS schliessung_kjmo_von, 
 CASE WHEN schliessung_mo_count > 0 THEN Extract(YEAR From schliessung_mo_bis) * 100 + Extract(MONTH From schliessung_mo_bis) ELSE 0 End::INTEGER AS schliessung_kjmo_bis, 
 CASE WHEN v01.vs_id >= 0 THEN v01.vs_id  ELSE 0     END       AS vs_id -- Vertriebsregion
   , CASE WHEN v01.gf_id >  0 THEN v01.gf_id  ELSE (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1::INTEGER END       AS gf_id, 
   CASE WHEN v01.vkl_id > 0 THEN v01.vkl_id ELSE (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1::INTEGER END       AS vkl_id, CASE WHEN v01.wm_id >  0 THEN v01.wm_id  ELSE (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1::INTEGER END       AS wm_id, 
   CASE WHEN v01.hl_id >  0 THEN v01.hl_id  ELSE (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1::INTEGER END       AS hl_id, Coalesce(v01.region_id, -v01.mandant_id)                      AS region_id -- geografisch
   , Coalesce(dbp_process.Transcriptc(v01.wup_str), '')            AS wup_str, Coalesce(v01.wup_plz, '')                                     AS wup_plz, 
   Coalesce(dbp_process.Transcriptc(v01.wup_stadt), '')          AS wup_stadt, Coalesce(v01.eigentum_miete_kz, '')                           AS eigentum_miete_kz, 
   CASE WHEN v01.kundenfaktor < 1.00 THEN 1 ELSE 0 END::BYTEINT AS getraenke_markt_fg, 
   v01.verkaufsflaeche, 
   v01.betriebsflaeche, 
   v01.uebernahme_von, 
   v01.umsatz_ea_eur         -- EUR
   , v01.umsatz_ea_land        -- LandesWRG
   , v01.umsatz_erwartung_eur  -- 2020.04
   , v01.einwohner_anzahl      -- 2020.04
   , v01.breitengrad         -- Latitude (Breitengrad)
   , v01.laengengrad         -- Longitude (Laengengrad)
   , v01.gis_quali_id        -- Quali (not used)
   , CASE WHEN Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) <= CURRENT_DATE THEN Extract(YEAR From Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) * 100 + Extract(MONTH From Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) ELSE 0
   End::INTEGER AS kjmo_eroeffnung, CASE WHEN v01.wup_id_alt > 1 THEN Extract(YEAR From v01.dat_eroeffnung) * 100 + Extract(MONTH From v01.dat_eroeffnung) ELSE 0
   End::INTEGER AS kjmo_umzug, CASE WHEN Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung) <= CURRENT_DATE THEN Extract(YEAR From Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) * 100 + Extract(MONTH From Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) ELSE 0
   End::INTEGER AS kjmo_wiedereroeffnung, CASE WHEN v01.dat_bis <= CURRENT_DATE THEN Extract(YEAR From v01.dat_bis) * 100 + Extract(MONTH From v01.dat_bis) ELSE 0
   End::INTEGER AS kjschliessung_mo, CASE WHEN Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) <= CURRENT_DATE THEN Extract(YEAR From Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) + CASE WHEN Extract(MONTH From Coalesce(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) < 3 THEN -1 ELSE 0 END ELSE 0
   END AS gj_eroeffnung, CASE WHEN Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung) <= CURRENT_DATE THEN Extract(YEAR From Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) + CASE WHEN Extract(MONTH From Coalesce(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) < 3 THEN -1 ELSE 0 END ELSE 0
   END AS gj_wiedereroeffnung, CASE WHEN v01.dat_bis <= CURRENT_DATE THEN Extract(YEAR From v01.dat_bis) + CASE WHEN Extract(MONTH From v01.dat_bis) < 3 THEN -1 ELSE 0 END ELSE 0
   END AS gj_schliessung, (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1::INTEGER AS DUMMY_1
   FROM dbp_data.wup_1  v01
   LEFT JOIN dbp_data.ims_mamo_wup_schliessung_per_1  v02
   ON v01.wup_id = v02.wup_id
   AND v01.mandant_id = v02.mandant_id
   LEFT JOIN dbp_data.ims_mamo_wup_massnahme_per_1  v022
   ON v01.wup_id = v022.wup_id
   AND v01.mandant_id = v022.mandant_id

    -- Filterung ZF/Filiale/Gastro/TKS, wup_1 Sumpf
   WHERE v01.nb_id IN (-2, -1, 0, 2, 7)
   AND (v01.dat_von > '1900-01-01' AND v01.dat_eroeffnung > '1900-01-01')
   -- ohne Altfilialen Umzug (bisherige Logik)
   AND v01.umzugsfiliale_fg = 0;