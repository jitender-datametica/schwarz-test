CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LADUNGSTRAEGER
-- -09.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
(
  anz_ladtraeger
, anz_ladtraeger_orig
, anz_ladtraeger_defekt
, art_id
, dat_erstellung
, handling_unit_id_ext
, lagernummer_id
, lief_beleg_id
, mandant_id
, nb_id
, status_ladtraeger
, system_id
, tour_id
, wup_id
, kj_lief_beleg

)
AS
   SELECT

     anz_ladtraeger, anz_ladtraeger_orig, anz_ladtraeger_defekt, art_id, dat_erstellung, handling_unit_id_ext, lagernummer_id, lief_beleg_id, mandant_id, nb_id, status_ladtraeger, system_id, tour_id, wup_id, kj_lief_beleg

   FROM dbp_view.v_ladungstraeger
   WHERE extract(year from dat_erstellung) >= year(current_timestamp) - 2
;