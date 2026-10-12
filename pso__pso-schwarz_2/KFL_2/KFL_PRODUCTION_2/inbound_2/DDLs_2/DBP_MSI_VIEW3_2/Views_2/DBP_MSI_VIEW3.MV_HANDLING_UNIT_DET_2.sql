CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_HANDLING_UNIT_DET_2
-- 05.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
( mandant_id
, system_id
, nb_id
, handling_unit_pos_id
, wup_id
, handling_unit_id
, hu_typ_id
, anz_pack_hilfsmittel
, de_egalisiert_fg
, verp_menge_einh_id
, art_id
, lagerort_id
, lief_beleg_id
, lief_beleg_pos_id
, menge_handling_kolli
, kj_lief_beleg
)
AS
   SELECT
  mandant_id, system_id, nb_id, handling_unit_pos_id, wup_id, handling_unit_id, hu_typ_id, anz_pack_hilfsmittel, de_egalisiert_fg, verp_menge_einh_id, art_id, lagerort_id, lief_beleg_id, lief_beleg_pos_id, menge_handling_kolli, kj_lief_beleg

   FROM dbp_view.v_handling_unit_det_2
   WHERE kj_lief_beleg = -1 OR kj_lief_beleg >= year(current_timestamp) - 2;