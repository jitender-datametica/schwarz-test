CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_ZUSATZINFO
(
geku_ticket_id
,artikelbez
,artikelinfo
,preis_wettbewerber
,preis_kaufland
,name_wettbewerber
,standort_wettbewerber
,datum_einkauf
,datum_handzettel
,artikelbez_kaufland
,kaufland_nr
,artikelbez_uebers
,qualimangel
,charge
,datum_schadensfall
,ean
,flw_bestellung_id
,flw_etikett_id
,flw_frische_id
,flw_gewicht_id
,flw_herkunft_id
,flw_preis_id
,flw_qualitaet_id
,flw_sonstiges_id
,flw_sortiment_id
,flw_verpackung_id
,flw_warenpraesenz_id
,flw_zuschnitt_id
,fremdkoerper
,fremdkoerper_uebers
,herstellerinfo
,kaufdatum
,kaufpreis
,marktbestand
,mhd
,produktionsdatum
,status_fremdkoerper_id
,vico_id
,vico_nickname
,vico_plattform
,vico_treffergrund
,vico_url
,kundenalter
,datum_angewendet
,datum_aufgetreten
,symptome
,fuellmenge
,artikelgruppe_og_id
,geschlecht_id
,produktfrage_id
,beschwerdebuch
,hersteller_id
,hersteller_food_id
,hersteller_purland_id
,hersteller_food_fleisch_id
,schaedlingsart_id
,zauberwort_id
)
AS
-- 31.01.2014 twie: Tabelle mit Zusatzinfos zu Tickets
-- In der Tabelle l_geku_zusatzinfo ist der Datentyp pro Zusatzinfo hinterlegt
-- hierbei ist 1 = zusatzinfo_sel_id, 2 = zusatzinfo_text und 3 = zusatzinfo_date. zusatzinfo_ganzzahl und zusatzinfo_NUMBER(38,5) ist noch nicht definiert, da es hierauf noch keine Zusatzinfos gibt
-- Da sich die zusatzinfo_id bei jeder Beladung ändern kann, werden die einzelnen Zusatzinfos anhand der deutschen Bezeichnung aus der spr_zu identifiziert. Die zusatzinfo_bez darf sich deshalb nicht ändern
-- Die View liefert jedes Ticket aus der Tickettabelle, auch wenn es keine Zusatzinfo gibt, damit keine Daten rausfallen. Bei Typ 3 mit eigener Lookup ist die -1 der Dummywert.
-- Bei den anderen ohne eigene Lookup wird dann NULL ausgegeben. Somit kann in MSI gefiltert werden auf IS (NOT) NULL um alle Ticket mit bzw. ohne eine bestimmte Zusatzinfo zu selektieren.
-- Wenn Filterungen auf Zusatzinfos gespeichert werden, darf dies immer nur auf die bez sein, nie auf die id, weil sich diese ja ändern kann und dann der Filter nicht mehr passt.
-- Die sel_id ist aber notwendig, da die sel_bez sprachabhängig ist und deshalb nicht als Schlüssel verwendet werden kann.
-- 04.06.2014 twie: 9 neue Zusatzinfos hinzugefügt
-- 05.08.2014 twie: eine neue Zusatzinfo Beschwerdebuch
-- 21.11.2014 twie: eine neue Zusatzinfo Hersteller
-- 18.02.2015 twie: Bez Zusatzinfo Herstellerinformation umbenannt in Herstellerinformation / LFN
-- 13.03.2015 twie: 2 neue Zusatzinfos hinzugefügt, Hersteller umbenannt
-- 31.08.2015 twie: Umbenennung von 'Hersteller KLM-Food' auf 'Hersteller Food', von 'Hersteller KLM-Non-Food' auf 'Hersteller Non-Food', von 'Hersteller Purland-Fleisch/Wurst' auf 'Hersteller Fleischwaren/Handelswaren'
-- 30.10.2015 twie: 3 neue Zusatzinfos Hersteller Food/Fleischwaren, Schädlingsart, Zauberwort

SELECT
    v01.geku_ticket_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '01_Artikelbezeichnung' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS artikelbez,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '02_Artikelinformation' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS artikelinfo,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '03_Preisangaben_Wettbewerber' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS preis_wettbewerber,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '04_Preisangaben_Kaufland' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS preis_kaufland,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '05_Name_Wettbewerber' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS name_wettbewerber,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '06_Standort_Wettbewerber' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS standort_wettbewerber,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '07_Datum_Einkauf' THEN v02.zusatzinfo_date
        END
    ) AS datum_einkauf,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '08_Datum_Handzettel' THEN v02.zusatzinfo_date
        END
    ) AS datum_handzettel,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '09_Artikelbezeichnung_Kaufland' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS artikelbez_kaufland,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = '10_Kaufland_Nummer' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS kaufland_nr,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Artikelbezeichnung - übersetzt' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS artikelbez_uebers,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Beeinträchtigung durch sonstigen Qualitätsmangel' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS qualimangel,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Charge / Losnummer' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS charge,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Datum Schadensfall' THEN v02.zusatzinfo_date
        END
    ) AS datum_schadensfall,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'EAN' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS ean,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Bestellung (Fleisch)' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_bestellung_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Etikettangaben' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_etikett_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Frische' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_frische_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Gewichtsverlust /-abweichungen' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_gewicht_id,

    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Herkunft' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_herkunft_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Preis' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_preis_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Qualität' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_qualitaet_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Sonstiges' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_sonstiges_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Sortiment / Listung' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_sortiment_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Verpackung' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_verpackung_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Warenpräsenz' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_warenpraesenz_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'FLW Zuschnitt (Fleisch)' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS flw_zuschnitt_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Fremdkörper' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS fremdkoerper,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Fremdkörper - übersetzt' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS fremdkoerper_uebers,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Herstellerinformation / LFN' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS herstellerinfo,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Kaufdatum' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS kaufdatum,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Kaufpreis' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS kaufpreis,

    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Marktbestand SAP' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS marktbestand,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'MHD' THEN v02.zusatzinfo_date
        END
    ) AS mhd,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Produktionsdatum' THEN v02.zusatzinfo_date
        END
    ) AS produktionsdatum,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Status Fremdkörper' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS status_fremdkoerper_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'VICO ID' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS vico_id,

    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'VICO Nickname' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS vico_nickname,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'VICO Plattform' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS vico_plattform,

    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'VICO Treffergrund' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS vico_treffergrund,

    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'VICO URL' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS vico_url,

    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Alter' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS kundenalter,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Angewendet wann' THEN v02.zusatzinfo_date
        END
    ) AS datum_angewendet,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Aufgetreten wann' THEN v02.zusatzinfo_date
        END
    ) AS datum_aufgetreten,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Beschreibung der Symptome' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS symptome,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Füllmenge' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS fuellmenge,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Artikelgruppen O&G' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS artikelgruppe_og_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Geschlecht' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS geschlecht_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Liegt das Produkt vor?' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS produktfrage_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Beschwerdebuch Nummer' THEN CAST(v02.zusatzinfo_text AS VARCHAR (5000))
        END
    ) AS beschwerdebuch,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Hersteller Non-Food' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS hersteller_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Hersteller Food' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS hersteller_food_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Hersteller Fleischwaren/Handelswaren' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS hersteller_purland_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Hersteller Food/Fleischwaren' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS hersteller_food_fleisch_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Schädlingsart' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS schaedlingsart_id,
    MAX(
        CASE
            WHEN v03.zusatzinfo_bez = 'Zauberwort' THEN v02.zusatzinfo_sel_id
            ELSE -1
        END
    ) AS zauberwort_id
FROM
    dbp_view.v_geku_ticket v01

    LEFT OUTER JOIN dbp_view.v_geku_ticket_zusatzinfo_zu v02 
    ON v01.geku_ticket_id = v02.geku_ticket_id

    LEFT OUTER JOIN dbp_view.v_geku_zusatzinfo_spr_zu v03 
    ON v02.zusatzinfo_id = v03.zusatzinfo_id
    AND v03.spr_id = 22

GROUP BY
    v01.geku_ticket_id;