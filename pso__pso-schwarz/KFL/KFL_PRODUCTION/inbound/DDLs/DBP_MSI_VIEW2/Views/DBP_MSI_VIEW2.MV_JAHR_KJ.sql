CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_JAHR_KJ
(
kj,
akt_kj,
akt_kj_komplett
)
AS
   SELECT
  kj,
   akt_kj,
   akt_kj_komplett
   FROM dbp_view.v_jahr_kj
   WHERE kj>2001;