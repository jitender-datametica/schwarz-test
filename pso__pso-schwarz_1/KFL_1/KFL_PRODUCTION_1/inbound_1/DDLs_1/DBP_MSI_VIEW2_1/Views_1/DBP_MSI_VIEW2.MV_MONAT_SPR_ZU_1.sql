CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_MONAT_SPR_ZU_1
(
mo_gj,
mo_kj,
spr_id,
mo_bez,
kjmo,
kj,
gj,
gjmo,
mo_bez_lang
)
AS
   SELECT
  m.mo_gj,
   s.mo_id,
   s.spr_id,
   s.mo_bez,
   m.kjmo,
   m.kj,
   m.gj,
   gjmo,
   TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj)
   FROM dbp_view.v_monat_spr_zu_1 s, dbp_view.v_monat_1 m
   WHERE s.mo_id=m.mo_kj
   AND spr_id=22;