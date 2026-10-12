CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_KUMULATION_MONAT_1
(
gj
, kjmo
, kjmo_kum
, kjmo_vj_kum
)
AS
   SELECT
   a.gj, a.kjmo, b.kjmo kjmo_kum, b.kjmo_vj kjmo_vj_kum
   FROM dbp_view.v_monat_1 a
   INNER JOIN dbp_view.v_monat_1 b
   ON  a.kjmo >= b.kjmo
   AND a.gj = b.gj;