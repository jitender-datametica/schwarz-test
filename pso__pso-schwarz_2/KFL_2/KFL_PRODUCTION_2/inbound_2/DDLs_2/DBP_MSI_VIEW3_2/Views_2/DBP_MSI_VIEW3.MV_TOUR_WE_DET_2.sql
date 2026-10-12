CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_WE_DET_2
-- 03.12.2018, mkub1811, AP0027269, neue View
-- 23.01.2019, aszu1204, AP0027269 adding anzahl_paletten_kalkuliert
--22.03.2019, mcie1607, AP0027269 change view def to add OG data, right outer join to tour_2 view
-- 09.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
-- 23.09.2024 nwag2310, INC9434162, add O&G tours
(
mandant_id
,wup_id
,nb_id
,lagernummer_id
,tour_id
,wgvgrp_id
,lief_beleg_id
,seq_nummer
,art_id
,kj_lief_beleg
,gruppenzone_id
,ausschluss_manuell_fg
,ausschluss_regel_fg
,blockartikel_fg
,lagerplatz_id
,anzahl_paletten_kalkuliert
)
AS
   SELECT
   V02.mandant_id, v02.wup_id, v02.nb_id, v02.lagernummer_id, v02.tour_id, v01.wgvgrp_id, v03.lief_beleg_id, v01.seq_nummer, v01.art_id, v03.kj_lief_beleg, v01.gruppenzone_id, v01.ausschluss_manuell_fg, v01.ausschluss_regel_fg, v01.blockartikel_fg, v01.lagerplatz_id, 1
   FROM dbp_view.v_tour_2 v02
   LEFT JOIN dbp_view.v_tour_det_2 v03
   ON (v02.mandant_id=v03.mandant_id AND v02.tour_id=v03.tour_id )
   LEFT JOIN dbp_view.v_tour_we_det_2 v01
   ON (v01.mandant_id=v02.mandant_id AND v01.tour_id=v02.tour_id AND v01.lief_beleg_id=v03.lief_beleg_id)
   JOIN dbp_view.v_tag_2 t ON v02.dat_tour = t.dat AND t.akt_kj BETWEEN -2 AND 0
   ;