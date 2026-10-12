CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_VOLUMEN_GEDECKELT_1
-- 06.02.2018 HMue2308:
-- AP0012522, SPEC0027715 DWH Decklung Volumina je HU
-- Die View gilt als Verbindungstabelle und wurde speziell für die Verknüpfung zwischen den MSTR-Objekten 'Tournummer, Tourdatum, Lagernummer, Markt ,(VZ) ---> Brutto Volumen HU (gedeckelt) - implementiert
-- 13.08.2018 srom0404, belos_vorgang_id aufgenommen, damit JOIN in den 08er Berichten korrekt läuft
-- 04.09.2018 srom0404, Email N.Wagner: wegen Doppelzuordnungen in VTTP (tour_det_1) auf belos_vorgang_1 umgestellt
-- 27.11.2019, AP0041558, nwag2310, added KJ in join (LIKP/LIPS)
-- 04.03.2020, nwag2310, quick-fix aufgrund Wiederverwendung belos_vorgang_id's muss wg. Performance über PRB umgestellt werden
-- 2022-08-05, dknop, AP0129706_SPEC0158100 adding distribution_abr_fg
-- 10.01.2024, nwag2310, limit to akt_kj > -2
-- 2025-03-14, nwag, Filialumgliederung
-- 2025-05-08, nwag, removed filter on kj-1 
(
	TOUR_ID,
	DISTRIBUTION_ABR_FG,
	BELOS_VORGANG_ID,
	WUP_ID,
	MARKT_ID,
	MANDANT_ID_KUNDE,
	MANDANT_ID,
	DAT_TOUR,
	LAGERNUMMER_ID,
	SUM_NETTO_VOL,
	SUM_BRUTTO_VOL,
	SUM_BRTVOL_GEDECKELT,
	SUM_NETVOL_GEDECKELT
) AS
   SELECT
   t1.tour_id
   , t1.distribution_abr_fg
   , t1.belos_vorgang_id
   , t1.wup_id
   , t1.kunde_id AS markt_id
   , t1.mandant_id_kunde
   , t1.mandant_id
   , t1.dat_tour
   , t1.lagernummer_id
   , SUM(t1.vol_ladung) AS sum_netto_vol
   , SUM(t1.brtvol_ladung) AS sum_brutto_vol
   , SUM(t1.brtvol_ladung_gedeckelt)  AS sum_brtvol_gedeckelt
   , SUM(CASE WHEN t1.vol_ladung > 2304 THEN 2304 ELSE t1.vol_ladung END) AS sum_netvol_gedeckelt
   FROM
   (
   SELECT DISTINCT 
   v01.tour_id
   , v01.distribution_abr_fg
   , v03.belos_vorgang_id
   , v02.wup_id
   --, v03.kunde_id
    , CASE WHEN CAST(TRY_TO_NUMBER(SUBSTR(v03.kunde_id,7,4)) AS INTEGER) IS NULL THEN 0 ELSE COALESCE( v05.aktuell_wup_id ,  CAST(TO_NUMBER(SUBSTR(v03.kunde_id,7,4)) AS INTEGER)) END AS kunde_id
   , v03.mandant_id_kunde
   , v02.mandant_id
   , v02.dat_tour
   , v01.lagernummer_id
   , v04.handling_unit_id
   , v04.vol_ladung
   , v04.brtvol_ladung
   , v04.brtvol_ladung_gedeckelt
   FROM dbp_view.v_belos_vorgang_1 v01
   JOIN dbp_view.v_tag_1 t
   ON v01.dat_leistung = t.dat
   AND t.akt_kj >= -3
   INNER JOIN dbp_view.v_tour_1 v02
   ON v01.tour_id = v02.tour_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_view.v_besch_lief_1 v03
   ON v01.belos_vorgang_id = v03.belos_vorgang_id
   AND v01.mandant_id = v03.mandant_id
   --AND EXTRACT(YEAR FROM v01.dat_leistung) BETWEEN v03.kj-1 AND v03.kj+1
   INNER JOIN dbp_view.v_handling_unit_1 v04
   ON v03.lief_beleg_id = v04.lief_beleg_id
   AND v03.kj = v04.kj_lief_beleg
   AND v03.mandant_id = v04.mandant_id
   LEFT JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = CASE WHEN v03.mandant_id_kunde IS NULL OR v03.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v03.mandant_id_kunde END
   AND v05.wup_id = CASE WHEN TRY_CAST(v03.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v03.kunde_id AS INTEGER) END
   AND v05.nb_id = 0
   ) t1_1

   GROUP BY t1.tour_id
   ,t1.distribution_abr_fg
   ,t1.belos_vorgang_id
   ,t1.wup_id
   ,t1.kunde_id
   ,t1.mandant_id_kunde
   ,t1.mandant_id
   ,t1.dat_tour
   ,t1.lagernummer_id
   ,t1.handling_unit_id
   ,t1.brtvol_ladung_gedeckelt
   ;
 