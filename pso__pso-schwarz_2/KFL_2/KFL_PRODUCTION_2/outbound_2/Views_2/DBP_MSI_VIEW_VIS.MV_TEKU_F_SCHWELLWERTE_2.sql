CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_f_schwellwerte_2 AS SELECT mandant_id,
 teku_berichts_objekt_id,
 teku_hierarchie_objekt_id,
 teku_spalte_bez,
 sw_gruen_bis,
 sw_rot_ab,
  CASE
  WHEN teku_spalte_bez = 'Abwicklung_Bedienung_Theke'
  THEN CASE
   WHEN teku_berichts_objekt_id = 'TEK1'
   THEN 325
   ELSE 331
   END
  WHEN teku_spalte_bez = 'Abwicklung_Kasse_Info_Leergut'
  THEN 326
  WHEN teku_spalte_bez = 'DS_Note'
  THEN 9999
  WHEN teku_spalte_bez = 'Freundlichkeit_Freundlichkeit'
  THEN 310
  WHEN teku_spalte_bez = 'Freundlichkeit_Garantien'
  THEN 311
  WHEN teku_spalte_bez = 'Freundlichkeit_Service'
  THEN 312
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Markt_Aussenanlage'
  THEN 327
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Toilette'
  THEN 328
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Bedienung_Fleisch'
  THEN 320
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Bedienung_Theke'
  THEN 319
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Food_Frische'
  THEN 322
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Food_trocken'
  THEN 323
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_NonFood_Textil'
  THEN 324
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_OG_Pflanzen'
  THEN 318
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_SBWurst_Geflügel_Fisch'
  THEN CASE
   WHEN teku_berichts_objekt_id = 'TEK1'
   THEN 321
   ELSE 349
   END
  WHEN teku_spalte_bez = 'Warenfrische_Bedienung_Theke'
  THEN 314
  WHEN teku_spalte_bez = 'Warenfrische_Fleisch'
  THEN 315
  WHEN teku_spalte_bez = 'Warenfrische_Food_Frische'
  THEN 317
  WHEN teku_spalte_bez = 'Warenfrische_OG_Pflanzen'
  THEN 313
  WHEN teku_spalte_bez = 'Warenfrische_SBWurst_Geflügel_Fisch'
  THEN CASE
   WHEN teku_berichts_objekt_id = 'TEK1'
   THEN 316
   ELSE 340
   END
  WHEN teku_spalte_bez = 'Artikelerfassung_Mengen_Tippfehler'
  THEN 479
  WHEN teku_spalte_bez = 'Artikelerfassung_Obere_Ablage'
  THEN 477
  WHEN teku_spalte_bez = 'Artikelerfassung_Untere_Ablage'
  THEN 476
  WHEN teku_spalte_bez = 'Artikelerfassung_Verwechslungsartikel'
  THEN 478
  WHEN teku_spalte_bez = 'Kontrollen_Hohlkörperkontrolle'
  THEN 482
  WHEN teku_spalte_bez = 'Kontrollen_Nachkauf'
  THEN 480
  WHEN teku_spalte_bez = 'Kontrollen_WagenNr_Erfassung'
  THEN 481
  WHEN teku_spalte_bez = 'Kontrollen_Ware_Verpackung_identisch'
  THEN 485
  WHEN teku_spalte_bez = 'Kontrollen_Zeitungskontrolle'
  THEN 483
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Bedienungs_SBWare'
  THEN 9996
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Feinkosttheke'
  THEN 870
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_FischSB'
  THEN 860
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Fischtheke'
  THEN 850
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_FleischSB'
  THEN 810
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Fleischtheke'
  THEN 800
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Frischebäckerei_Backshop'
  THEN 894
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_FrischgeflügelSB'
  THEN 820
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Geflügeltheke'
  THEN 892
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Käsetheke'
  THEN 840
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Salatpackungen'
  THEN 880
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Schnittblumen_Pflanzen'
  THEN 890
  WHEN teku_spalte_bez = 'mv_Bedienungs_SBWare_Wursttheke'
  THEN 830
  WHEN teku_spalte_bez = 'mv_DS_Note'
  THEN 9999
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Feinkosttheke'
  THEN 871
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Fischtheke'
  THEN 851
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Fleischtheke'
  THEN 801
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Geflügeltheke'
  THEN 893
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Käsetheke'
  THEN 841
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Qualität_Zuschnitt_Verpackung_Bedienung'
  THEN 9997
  WHEN teku_spalte_bez = 'mv_Qualität_Zuschnitt_Verpackung_Bedienung_Wursttheke'
  THEN 831
  WHEN teku_spalte_bez = 'pv_Qualität_Zuschnitt_Verpackung_Frischebäckerei_Backshop'
  THEN 895
  WHEN teku_spalte_bez = 'pv_DS_Note'
  THEN 9998
  WHEN teku_spalte_bez = 'pv_Qualität_Zuschnitt_Verpackung_FischSB'
  THEN 861
  WHEN teku_spalte_bez = 'pv_Qualität_Zuschnitt_Verpackung_FleischSB'
  THEN 811
  WHEN teku_spalte_bez = 'pv_Qualität_Zuschnitt_Verpackung_FrischgeflügelSB'
  THEN 821
  WHEN teku_spalte_bez = 'pv_Qualität_Zuschnitt_Verpackung_Salatpackungen'
  THEN 881
  WHEN teku_spalte_bez = 'pv_Qualität_Zuschnitt_Verpackung_Schnittblumen_Pflanzen'
  THEN 891
  WHEN teku_spalte_bez = 'Anzahl_Frische_Qualitäts_Zuschnittmängel'
  THEN 330
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Backshop'
  THEN 356
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Feinkosttheke'
  THEN 355
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Fischtheke'
  THEN 353
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Fleischtheke'
  THEN 350
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Geflügeltheke'
  THEN 354
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Käsetheke'
  THEN 352
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_SBFleisch'
  THEN 357
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_SBWurst_Geflügel_Fisch'
  THEN 358
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Wursttheke'
  THEN 351
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Backshop'
  THEN 347
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Feinkosttheke'
  THEN 346
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Fischtheke'
  THEN 344
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Fleischtheke'
  THEN 341
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Geflügeltheke'
  THEN 345
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Käsetheke'
  THEN 343
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_SBFleisch'
  THEN 348
  WHEN teku_spalte_bez = 'Verkaufsbereitschaft_Wursttheke'
  THEN 342
  WHEN teku_spalte_bez = 'Warenfrische_Backshop'
  THEN 338
  WHEN teku_spalte_bez = 'Warenfrische_Feinkosttheke'
  THEN 337
  WHEN teku_spalte_bez = 'Warenfrische_Fischtheke'
  THEN 335
  WHEN teku_spalte_bez = 'Warenfrische_Fleischtheke'
  THEN 332
  WHEN teku_spalte_bez = 'Warenfrische_Geflügeltheke'
  THEN 336
  WHEN teku_spalte_bez = 'Warenfrische_Käsetheke'
  THEN 334
  WHEN teku_spalte_bez = 'Warenfrische_SBFleisch'
  THEN 339
  WHEN teku_spalte_bez = 'Warenfrische_Wursttheke'
  THEN 333
  WHEN teku_spalte_bez = 'Abwicklung_Wartezeit'
  THEN 375
  WHEN teku_spalte_bez = 'Freundlichkeit_Garantie_Service_Freundlichkeit'
  THEN 360
  WHEN teku_spalte_bez = 'Freundlichkeit_Garantie_Service_Garantien'
  THEN 361
  WHEN teku_spalte_bez = 'Freundlichkeit_Garantie_Service_Service'
  THEN 362
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Abfalleimer'
  THEN 373
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Besteck_Teller_Gläser_Tassen'
  THEN 370
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Gastraum'
  THEN 371
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Geschirrwagen'
  THEN 372
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Theken'
  THEN 369
  WHEN teku_spalte_bez = 'Hygiene_Sauberkeit_Toiletten'
  THEN 374
  WHEN teku_spalte_bez = 'Speisen_Getränke_appetitlich_ansprechend_angerichtet'
  THEN 366
  WHEN teku_spalte_bez = 'Speisen_Getränke_Preisauszeichnung'
  THEN 367
  WHEN teku_spalte_bez = 'Speisen_Getränke_Qualität'
  THEN 364
  WHEN teku_spalte_bez = 'Speisen_Getränke_Quantität'
  THEN 365
  WHEN teku_spalte_bez = 'Speisen_Getränke_Temperatur'
  THEN 368
  WHEN teku_spalte_bez = 'Speisen_Getränke_Warenangebot_Auswahl'
  THEN 363
  ELSE - 1
  END AS teku_kategorie_nr
FROM kfl_production_dbp_view.v_teku_schwellwert_per_2
WHERE dat_bis = DATE '9999-12-31';