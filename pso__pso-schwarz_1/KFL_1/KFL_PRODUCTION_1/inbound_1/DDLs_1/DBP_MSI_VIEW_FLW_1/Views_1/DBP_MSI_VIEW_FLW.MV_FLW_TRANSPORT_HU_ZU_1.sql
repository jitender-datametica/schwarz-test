CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_TRANSPORT_HU_ZU_1
--14.09.2018 mmzy2302: Neuanlegen der View mit explizitem Ausweis aller Felder
-- 24.09.2018 naku2305: verlade_lief_beleg_id wegen SPEC0039809 dazu aufgenommen
(
mandant_id
, tour_id
, handling_unit_id_ext
, verlade_lief_beleg_id
)
AS
   SELECT
  mandant_id, tour_id, handling_unit_id_ext, verlade_lief_beleg_id
   FROM dbp_view.v_flw_transport_hu_zu_1;