CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_F_SCHWELLWERTE_1 as
   SELECT
   mandant_id, teku_berichts_objekt_id, teku_hierarchie_objekt_id, teku_spalte_bez, sw_gruen_bis, sw_rot_ab, CASE teku_spalte_bez
   WHEN 'Abwicklung_Bedienung_Theke' THEN CASE WHEN teku_berichts_objekt_id = 'TEK1' THEN 325 ELSE 331 END
   WHEN 'Abwicklung_Kasse_Info_Leergut' THEN 326
   WHEN 'DS_Note' THEN 9999
   WHEN 'Freundlichkeit_Freundlichkeit' THEN 310
   WHEN 'Freundlichkeit_Garantien' THEN 311
   WHEN 'Freundlichkeit_Service' THEN 312
   WHEN 'Hygiene_Sauberkeit_Markt_Aussenanlage' THEN 327
   WHEN 'Hygiene_Sauberkeit_Toilette' THEN 328
   WHEN 'Verkaufsbereitschaft_Bedienung_Fleisch' THEN 320
   WHEN 'Verkaufsbereitschaft_Bedienung_Theke' THEN 319
   WHEN 'Verkaufsbereitschaft_Food_Frische' THEN 322
   WHEN 'Verkaufsbereitschaft_Food_trocken' THEN 323
   WHEN 'Verkaufsbereitschaft_NonFood_Textil' THEN 324
   WHEN 'Verkaufsbereitschaft_OG_Pflanzen' THEN 318
   WHEN 'Verkaufsbereitschaft_SBWurst_Geflügel_Fisch' THEN CASE WHEN teku_berichts_objekt_id = 'TEK1' THEN 321 ELSE 349 END
   WHEN 'Warenfrische_Bedienung_Theke' THEN 314
   WHEN 'Warenfrische_Fleisch' THEN 315
   WHEN 'Warenfrische_Food_Frische' THEN 317
   WHEN 'Warenfrische_OG_Pflanzen' THEN 313
   WHEN 'Warenfrische_SBWurst_Geflügel_Fisch' THEN CASE WHEN  teku_berichts_objekt_id = 'TEK1' THEN 316 ELSE 340 END
   WHEN 'Artikelerfassung_Mengen_Tippfehler' THEN 479
   WHEN 'Artikelerfassung_Obere_Ablage' THEN 477
   WHEN 'Artikelerfassung_Untere_Ablage' THEN 476
   WHEN 'Artikelerfassung_Verwechslungsartikel' THEN 478
   WHEN 'Kontrollen_Hohlkörperkontrolle' THEN 482
   WHEN 'Kontrollen_Nachkauf' THEN 480
   WHEN 'Kontrollen_WagenNr_Erfassung' THEN 481
   WHEN 'Kontrollen_Ware_Verpackung_identisch' THEN 485
   WHEN 'Kontrollen_Zeitungskontrolle' THEN 483
   WHEN 'mv_Bedienungs_SBWare_Bedienungs_SBWare' THEN 9996   -- DS-BWZ Frische Bed. und SB-Ware
   WHEN 'mv_Bedienungs_SBWare_Feinkosttheke' THEN 870
   WHEN 'mv_Bedienungs_SBWare_FischSB' THEN 860
   WHEN 'mv_Bedienungs_SBWare_Fischtheke' THEN 850
   WHEN 'mv_Bedienungs_SBWare_FleischSB' THEN 810
   WHEN 'mv_Bedienungs_SBWare_Fleischtheke' THEN 800
   WHEN 'mv_Bedienungs_SBWare_Frischebäckerei_Backshop' THEN 894
   WHEN 'mv_Bedienungs_SBWare_FrischgeflügelSB' THEN 820
   WHEN 'mv_Bedienungs_SBWare_Geflügeltheke' THEN 892
   WHEN 'mv_Bedienungs_SBWare_Käsetheke' THEN 840
   WHEN 'mv_Bedienungs_SBWare_Salatpackungen' THEN 880
   WHEN 'mv_Bedienungs_SBWare_Schnittblumen_Pflanzen' THEN 890
   WHEN 'mv_Bedienungs_SBWare_Wursttheke' THEN 830
   WHEN 'mv_DS_Note' THEN 9999   --  DS-BWZ Gesamt (marktverursacht)
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Feinkosttheke' THEN 871
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Fischtheke' THEN 851
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Fleischtheke' THEN 801
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Geflügeltheke' THEN 893
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Käsetheke' THEN 841
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Qualität_Zuschnitt_Verpackung_Bedienung' THEN 9997   -- DS-BWZ Qualität/Zuschnitt (marktverursacht)
   WHEN 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Wursttheke' THEN 831
   WHEN 'pv_Qualität_Zuschnitt_Verpackung_Frischebäckerei_Backshop' THEN 895
   WHEN 'pv_DS_Note' THEN 9998     -- DS-BWZ Qualität/Zuschnitt (produktionsverursacht)
   WHEN 'pv_Qualität_Zuschnitt_Verpackung_FischSB' THEN 861
   WHEN 'pv_Qualität_Zuschnitt_Verpackung_FleischSB' THEN 811
   WHEN 'pv_Qualität_Zuschnitt_Verpackung_FrischgeflügelSB' THEN 821
   WHEN 'pv_Qualität_Zuschnitt_Verpackung_Salatpackungen' THEN 881
   WHEN 'pv_Qualität_Zuschnitt_Verpackung_Schnittblumen_Pflanzen' THEN 891
   WHEN 'Anzahl_Frische_Qualitäts_Zuschnittmängel' THEN 330
   WHEN 'Hygiene_Sauberkeit_Backshop' THEN 356
   WHEN 'Hygiene_Sauberkeit_Feinkosttheke' THEN 355
   WHEN 'Hygiene_Sauberkeit_Fischtheke' THEN 353
   WHEN 'Hygiene_Sauberkeit_Fleischtheke' THEN 350
   WHEN 'Hygiene_Sauberkeit_Geflügeltheke' THEN 354
   WHEN 'Hygiene_Sauberkeit_Käsetheke' THEN 352
   WHEN 'Hygiene_Sauberkeit_SBFleisch' THEN 357
   WHEN 'Hygiene_Sauberkeit_SBWurst_Geflügel_Fisch' THEN 358
   WHEN 'Hygiene_Sauberkeit_Wursttheke' THEN 351
   WHEN 'Verkaufsbereitschaft_Backshop' THEN 347
   WHEN 'Verkaufsbereitschaft_Feinkosttheke' THEN 346
   WHEN 'Verkaufsbereitschaft_Fischtheke' THEN 344
   WHEN 'Verkaufsbereitschaft_Fleischtheke' THEN 341
   WHEN 'Verkaufsbereitschaft_Geflügeltheke' THEN 345
   WHEN 'Verkaufsbereitschaft_Käsetheke' THEN 343
   WHEN 'Verkaufsbereitschaft_SBFleisch' THEN 348
   WHEN 'Verkaufsbereitschaft_Wursttheke' THEN 342
   WHEN 'Warenfrische_Backshop' THEN 338
   WHEN 'Warenfrische_Feinkosttheke' THEN 337
   WHEN 'Warenfrische_Fischtheke' THEN 335
   WHEN 'Warenfrische_Fleischtheke' THEN 332
   WHEN 'Warenfrische_Geflügeltheke' THEN 336
   WHEN 'Warenfrische_Käsetheke' THEN 334
   WHEN 'Warenfrische_SBFleisch' THEN 339
   WHEN 'Warenfrische_Wursttheke' THEN 333
   WHEN 'Abwicklung_Wartezeit' THEN 375
   WHEN 'Freundlichkeit_Garantie_Service_Freundlichkeit' THEN 360
   WHEN 'Freundlichkeit_Garantie_Service_Garantien' THEN 361
   WHEN 'Freundlichkeit_Garantie_Service_Service' THEN 362
   WHEN 'Hygiene_Sauberkeit_Abfalleimer' THEN 373
   WHEN 'Hygiene_Sauberkeit_Besteck_Teller_Gläser_Tassen' THEN 370
   WHEN 'Hygiene_Sauberkeit_Gastraum' THEN 371
   WHEN 'Hygiene_Sauberkeit_Geschirrwagen' THEN 372
   WHEN 'Hygiene_Sauberkeit_Theken' THEN 369
   WHEN 'Hygiene_Sauberkeit_Toiletten' THEN 374
   WHEN 'Speisen_Getränke_appetitlich_ansprechend_angerichtet' THEN 366
   WHEN 'Speisen_Getränke_Preisauszeichnung' THEN 367
   WHEN 'Speisen_Getränke_Qualität' THEN 364
   WHEN 'Speisen_Getränke_Quantität' THEN 365
   WHEN 'Speisen_Getränke_Temperatur' THEN 368
   WHEN 'Speisen_Getränke_Warenangebot_Auswahl' THEN 363
   ELSE -1
   END         AS teku_kategorie_nr
   FROM dbp_view.v_teku_schwellwert_per_1
   WHERE dat_bis = '9999-12-31'
;