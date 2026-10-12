CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_KATEGORIE_1
-- 20180528 twie: SPEC0038139 Neuanlage Lookup übergreifende Kategorie in KMR
--                           Kategorie wird in DWH generiert, existiert nicht im Quellsystem
-- 20181026 AP0034666 - KMR added kat_sw


(
kmr_kategorie_id
,kmr_bereich_id
,kmr_cockpit_fg
,kat_sw
)
AS
   SELECT

   kmr_kategorie_id, kmr_bereich_id, kmr_cockpit_fg, kat_sw

   FROM dbp_view.v_kmr_l_kategorie_1;