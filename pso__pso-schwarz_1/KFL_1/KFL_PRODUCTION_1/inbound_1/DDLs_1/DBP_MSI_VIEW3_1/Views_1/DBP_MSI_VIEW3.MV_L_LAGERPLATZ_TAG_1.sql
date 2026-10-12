CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGERPLATZ_TAG_1
(
-- srom0404, 08.07.2014, ANF 589985 - Artikelbezogener BEstand analog Lagerspiegel
-- jszc2108, 03.05.2018, AP0029248 - SPEC0037170, updated definition of column komm_bereich
lagerplatz_id
,lagernummer_id
,mandant_id
,lagertyp_id
,wup_id
,nb_id
,lagerbereich_id
--,dat_bis
--,dat_von
,einlager_sperr_fg
,auslager_sperr_fg
,anzahl_quant
,komm_bereich
,brand_abschnitt_id
,lagerplatz_typ_id
,lagerplatz_gewicht_max
,dat

)
AS
   SELECT

   v01.lagerplatz_id, v01.lagernummer_id, v01.mandant_id, v01.lagertyp_id, v01.wup_id, v01.nb_id, v01.lagerbereich_id, v01.einlager_sperr_fg, v01.auslager_sperr_fg, v01.anzahl_quant, CASE WHEN TRIM(COALESCE(v01.komm_bereich,'')) <> '' THEN v01.komm_bereich ELSE 'kein Kommbereich' END AS komm_bereich, CAST(COALESCE(v01.brand_abschnitt_id,'-1') AS CHAR(2) ) AS brand_abschnitt_id, v01.lagerplatz_typ_id, lagerplatz_gewicht_max, v02.dat
   FROM dbp_view.v_l_lagerplatz_1 v01
   INNER JOIN dbp_view.v_tag_1 v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
   WHERE v02.dat >= '2014-01-01';