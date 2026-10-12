CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_werbeaenderung_zum_vortag_1 (
MANDANT_ID BIGNUMERIC(38,0),
AKTION_ID STRING(10),
OFFER_ID BIGNUMERIC(38,0),
DAT_AB DATE,
DAT_BIS DATE,
ART_ID BIGNUMERIC(38,0),
DAT_BELADUNG DATE,
WBS_COMPOUND_FG STRING(375),
WBS_COMPOUND_FG_DE STRING(375),
WBS_COMPOUND_FG_PL STRING(357),
WBS_COMPOUND_FG_BG STRING(424),
WBS_COMPOUND_FG_SK STRING(295),
WBS_COMPOUND_FG_RO STRING(411),
WBS_COMPOUND_FG_CZ STRING(358),
WBS_COMPOUND_FG_HR STRING(440)
) AS
SELECT V01.mandant_id,
 V01.aktion_id,
 V01.offer_id,
 V01.dat_ab,
 V01.dat_bis,
 V01.art_id,
 V01.dat_beladung,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Werbethema'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Sonstiges'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Radio TV Billboard'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Normalpreisreduktion'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Normalpreiserhöhung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Marktanzahlreduktion'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Marktanzahlerhöhung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Kolliinhaltsänderung'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Artikelneuanlage'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Artikelentfernung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Angebotspreisreduktion'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Angebotspreiserhöhung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Abbildungsänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Prognosesteuerung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Rabattänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Werbelistungsänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Aktionsreihenfolgeänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Postenänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| KDN/KDP Änderung'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Werbethema'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Sonstiges'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Radio TV Billboard'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Normalpreisreduktion'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Normalpreiserhöhung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Marktanzahlreduktion'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Marktanzahlerhöhung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Kolliinhaltsänderung'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Artikelneuanlage'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Artikelentfernung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Angebotspreisreduktion'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Angebotspreiserhöhung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Abbildungsänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Prognosesteuerung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Rabattänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Werbelistungsänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Aktionsreihenfolgeänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Postenänderung'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| KDN/KDP Änderung'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_de,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Temat promocji'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Inne'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Radio TV billboard'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Obniżka ceny standardowej'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Wzrost ceny standardowej'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Redukcja liczby sklepów'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Wzrost liczby sklepów'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Koli zmiana'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Artykuł in'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Artykuł out'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Obniżka ceny promocyjnej'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Wzrost ceny promocyjnej'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Pano zmiana'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Kontrola prognozy'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Zmiana rabatu'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Zmiana zalistowania promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 90
     THEN '| Zmiana rangi promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Zmiana Posten'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Zmiana KDN/KDP'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_pl,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Промо тема'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Други'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Radio TV билборд'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Намаление на стандартна цена'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Увеличение на стандартна цена'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Намаляване броя на магазините'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Увеличаване броя на магазините'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Промяна на Колифактор'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Артикул добавен'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Артикул OUT'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Намаление на акционна цена'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Увеличение на акционна цена'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Промяна на пано'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Контрол на прогнозата'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Промяна на отстъпката'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Промяна в промо листинга'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 18
     THEN '| Промяна в промоционалния ранк'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Posten промяна'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| KDN/KDP промяна'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_bg,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Téma akcie'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Iné'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Rádio TV Billboard'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zníženie PC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zvýšenie PC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zníženie počtu filiálok'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zvýšenie počtu filiálok'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zmena Kolli'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Artikel_1 IN'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Artikel_1 OUT'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zníženie APC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zvýšenie APC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zmena pano'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Kontrola FC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zmena zľavy'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zmena listovania  do akcie'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 108
     THEN '| Zmena obdobia akcie'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Posten zmena'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| KDN/KDP zmena'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_sk,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Tema promotie'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Altele'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Panou publicitar Radio TV'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Reducere normala de pret'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Crestere normala de pret'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Reducerea numarului de filiale'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Cresterea numarului de filiale'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Modificare Kolli'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Articol IN'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Articol OUT'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Reducerea pretului de promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Cresterea pretrului de promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Pano schimbare'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Forecast control'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Modificare discount'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Modificare listare promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 95
     THEN '| Modificare rang promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Modificare Posten'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Modificare KDN/KDP'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_ro,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Téma akce'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Jiné'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Rádio TV billboard'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Snížení normální ceny'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Zvýšení normální ceny'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Snížení počtu filiálek'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Zvýšení počtu filiálek'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Změna kolli'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Zadání nového artiklu'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '|Odebrání artiklu'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Snížení akční ceny de promo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Zvýšení akční ceny'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Ilustrační změna'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Kontrola prognózy'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Změna slevy'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Změna listování do akce'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 124
     THEN '| Změna pořadí akce'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Posten Change'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| KDN/KDP Change'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_cz,
 CONCAT(MAX(CASE
    WHEN V01.werbeaenderung_werbethema_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| tema akcije'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_sonstiges_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| ostalo'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_radio_tv_billboard_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| Radio, TV, ostala oglašavanja'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| sniženje normalne MPC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_normalpreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| povećanje normalne MPC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| smanjenje broja poslovnica'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_marktanzahlerhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| povećanje broja poslovnica'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kolliinhaltsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| promjena pakiranja kolija'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelneuanlage_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| artikl ulazi'
     ELSE NULL
     END
    ELSE ''
    END), MIN(CASE
    WHEN V01.werbeaenderung_artikelentfernung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| artikl izlazi'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreisreduktion_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| sniženje akcijske MPC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_angebotspreiserhoehung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| povećanje akcijske MPC'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_abbildungsaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| promjena pozicije u akciji'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.gesteuerte_prognose_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| kontrola prognoze'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.rabattaenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| promjena % sniženja cijene'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbelistung_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| promjena broja poslovnica u akciji'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.aktion_reihenfolge_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 65
     THEN '| promjena redoslijeda akcije u nizu'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.posten_kz_sap_aenderung_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| Posten promjena'
     ELSE NULL
     END
    ELSE ''
    END), MAX(CASE
    WHEN V01.werbeaenderung_kundenkarte_personalisiert_fg <> 0
    THEN CASE
     WHEN SPR.spr_id = 22
     THEN '| KDN/KDP promjena'
     ELSE NULL
     END
    ELSE ''
    END)) AS wbs_compound_fg_hr
FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_spr_1 AS SPR_1 ON SPR.spr_id IN (22, 124, 108, 65, 90, 95, 18)
WHERE V01.dat_beladung = CURRENT_DATE
GROUP BY V01.mandant_id,
 V01.aktion_id,
 V01.offer_id,
 V01.dat_ab,
 V01.dat_bis,
 V01.art_id,
 V01.dat_beladung;