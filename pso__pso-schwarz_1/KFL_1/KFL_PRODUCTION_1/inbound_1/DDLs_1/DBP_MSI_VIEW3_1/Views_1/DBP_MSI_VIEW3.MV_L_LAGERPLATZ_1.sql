CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGERPLATZ_1
(
-- srom0404, 08.07.2014, ANF 589985 - Artikelbezogener Bestand analog Lagerspiegel
-- srom0404, 28.11.2014, ANF 578343 - skipped Items
-- jszc2108, 03.05.2018, AP0029248 - SPEC0037170, updated definition of column komm_bereich + added column gang_id
-- 2022-03-28, AP0124145, SPEC0149178, adding sperrgrund_id, dknop
lagerplatz_id
,lagernummer_id
,mandant_id
,lagertyp_id
,wup_id
,nb_id
,lagerbereich_id
,dat_bis
,dat_von
,einlager_sperr_fg
,auslager_sperr_fg
,anzahl_quant
,komm_bereich
,gang_id
,brand_abschnitt_id
,lagerplatz_typ_id
,lagerplatz_gewicht_max
,lagerplatz_ebene
,sperrgrund_id
)
AS
   SELECT

    lagerplatz_id
   ,lagernummer_id
   ,mandant_id
   ,lagertyp_id
   ,wup_id, nb_id
   ,lagerbereich_id
   ,dat_bis
   ,dat_von
   ,einlager_sperr_fg
   ,auslager_sperr_fg
   ,anzahl_quant
   ,CASE WHEN TRIM(COALESCE(komm_bereich,'')) <> '' THEN komm_bereich ELSE 'kein Kommbereich' END AS komm_bereich
   ,CASE WHEN SUBSTR(lagerplatz_id,4,1) = '-' THEN LEFT(lagerplatz_id,3) ELSE 'kein Gang' END AS gang_id
   ,CAST(COALESCE(brand_abschnitt_id,'-1') AS CHAR(2) ) AS brand_abschnitt_id
   ,lagerplatz_typ_id
   ,lagerplatz_gewicht_max
   ,lagerplatz_ebene
   ,sperrgrund_id
   FROM dbp_view.v_l_lagerplatz_1
    WHERE EXTRACT(YEAR FROM dat_bis) >= YEAR(CURRENT_TIMESTAMP) - 2;