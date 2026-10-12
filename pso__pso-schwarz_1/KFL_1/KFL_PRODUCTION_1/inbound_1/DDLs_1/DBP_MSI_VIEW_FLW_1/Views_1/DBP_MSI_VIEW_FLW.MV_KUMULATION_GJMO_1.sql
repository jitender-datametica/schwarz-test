CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_KUMULATION_GJMO_1
(
gj
,mo_gj
, gjmo
, gjmo_kum
)
AS
   SELECT
   a.gj, a.mo_gj, a.gjmo, b.gjmo gjmo_kum
   FROM dbp_view.v_monat_1 a
   INNER JOIN dbp_view.v_monat_1 b
   ON  a.gjmo >= b.gjmo
   AND a.gj = b.gj;