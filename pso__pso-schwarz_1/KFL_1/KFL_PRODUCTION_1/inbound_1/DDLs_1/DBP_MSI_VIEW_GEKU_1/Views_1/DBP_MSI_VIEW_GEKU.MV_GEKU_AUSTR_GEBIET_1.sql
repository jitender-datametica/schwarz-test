CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_AUSTR_GEBIET_1
(
wmd_austraeger_gebiet_uid
,gebiets_bereich_uid
,auflage
,solo_fg
,wmd_austr_gebiet_bez
,austr_gebiet_lfd_nr
)
AS
   SELECT
   wmd_austraeger_gebiet_uid
   , gebiets_bereich_uid
   , auflage
   , solo_fg
   , wmd_austr_gebiet_bez
   , austr_gebiet_lfd_nr
   FROM dbp_view.v_geku_austr_gebiet_1;